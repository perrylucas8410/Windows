package main

import (
    "encoding/json"
    "flag"
    "log"
    "net"
    "net/url"
    "time"

    "github.com/gorilla/websocket"
)

var (
    serverURL = flag.String("server", "wss://172.30.160.1/tunnel", "Tunnel server URL")
    localAddr = flag.String("local", "127.0.0.1:5008", "Local address to forward to")
)

type registerResponse struct {
    IPv6 string `json:"ipv6"`
}

type startMsg struct {
    Type string `json:"type"`
}

func main() {
    flag.Parse()

    for {
        if err := runOnce(); err != nil {
            log.Println("tunnel error:", err)
        }
        time.Sleep(3 * time.Second)
    }
}

func runOnce() error {
    u, err := url.Parse(*serverURL)
    if err != nil {
        return err
    }

    log.Printf("Connecting to %s", u.String())
    ws, _, err := websocket.DefaultDialer.Dial(u.String(), nil)
    if err != nil {
        return err
    }
    defer ws.Close()

    // Read assigned IPv6
    _, msg, err := ws.ReadMessage()
    if err != nil {
        return err
    }
    var resp registerResponse
    if err := json.Unmarshal(msg, &resp); err != nil {
        return err
    }
    log.Printf("Assigned IPv6: [%s]", resp.IPv6)

    for {
        // Wait for "start" from server
        _, msg, err := ws.ReadMessage()
        if err != nil {
            return err
        }
        var s startMsg
        if err := json.Unmarshal(msg, &s); err != nil {
            continue
        }
        if s.Type != "start" {
            continue
        }

        log.Printf("Incoming connection, proxying to %s", *localAddr)
        if err := handleSession(ws, *localAddr); err != nil {
            log.Println("session error:", err)
        }
    }
}

func handleSession(ws *websocket.Conn, local string) error {
    conn, err := net.Dial("tcp", local)
    if err != nil {
        return err
    }
    defer conn.Close()

    errCh := make(chan error, 2)

    // ws -> local
    go func() {
        for {
            mt, data, err := ws.ReadMessage()
            if err != nil {
                errCh <- err
                return
            }
            if mt != websocket.BinaryMessage {
                continue
            }
            if _, err := conn.Write(data); err != nil {
                errCh <- err
                return
            }
        }
    }()

    // local -> ws
    go func() {
        buf := make([]byte, 32*1024)
        for {
            n, err := conn.Read(buf)
            if n > 0 {
                if err := ws.WriteMessage(websocket.BinaryMessage, buf[:n]); err != nil {
                    errCh <- err
                    return
                }
            }
            if err != nil {
                errCh <- err
                return
            }
        }
    }()

    return <-errCh
}
