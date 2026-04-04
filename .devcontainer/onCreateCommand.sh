#!/bin/bash
# 1. NUKE DOCKER (Freeing ~8GB of hidden space)
echo "[SYSTEM] Removing Docker to free up 8GB..."
sudo systemctl stop docker.socket 2>/dev/null
sudo systemctl stop docker 2>/dev/null
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# 2. NUKE LANGUAGES (Freeing ~12GB)
echo "[SYSTEM] Removing pre-installed languages..."
sudo rm -rf /usr/local/share/dotnet /usr/local/lib/node_modules /usr/local/go /opt/ghc /usr/local/share/powershell /opt/microsoft /usr/share/rust

# 3. CLEANUP
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# 4. Install essential VM tools
echo "[SYSTEM] Installing QEMU..."
sudo apt-get update && sudo apt-get install -y --no-install-recommends qemu-system-x86 qemu-utils wget curl
sudo apt-get clean

# 5. Directory Setup
mkdir -p /workspaces/Windows/windows
cp /workspaces/Windows/.devcontainer/helpers/* /usr/local/bin/ 2>/dev/null
chmod +x /usr/local/bin/* 2>/dev/null

# 6. Direct VHDX Download (21GB)
# Using your Direct VHDX link (it is safer than unzipping on a full disk)
URL="https://my.microsoftpersonalcontent.com/personal/e633715ed8e8b835/_layouts/15/download.aspx?UniqueId=e4b8f49a-15b8-41df-860a-030347a2e50a&Translate=false&tempauth=v1e.eyJzaXRlaWQiOiI1MTAwNDFmZS1lYTQyLTQ1ZGQtYjFjMC02ZjhhYTMxMWQzODIiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvbXkubWljcm9zb2Z0cGVyc29uYWxjb250ZW50LmNvbUA5MTg4MDQwZC02YzY3LTRjNWItYjExMi0zNmEzMDRiNjZkYWQiLCJleHAiOiIxNzc1MjU2NDE5In0.wMOgzT1moAjrb3byv-JdEa15xHazJDJ-vE6r2qBByKSyj4q5GXUpOeIXZRuKKw0vuO7-zn7rD2RA7-JnB4prbdflAIkD2eKCrWncRwKr0kPUhiZnF7KubchArSD6q4f1IXP0xJKBgin9PtUX8ORkLzP2R8ZxT_rwReUDEt9I72sAwhyihWXoydITGJueLWiW4cLCQoEmkuvnlfg5f4IvJlshPYziPcYLEgbAPTkuR2CVPf8DCKUSf7iAMMtSfkLLEpAVbq1jjuPvk17mS0ZsclMLPnFZ7k-ylgzEFeF5fVfTm7SWGH3bpO-V_WsCMtx8N-6jD99stFfXB1XPXkEzt5oorjhnRGs90ygJQz8UU_ONd2QQip5ejWHxakB-DHnse64m78Vu6Up5XdRmdxrj4nGih2C9srOt-qgy6F-Qhr9WIVF-yOx-Q251XT-nFiqiYpK8dPN1HpJgbzT-5I_vNEC5T8g9D7ACaPWak39nkUBOnRh21108w2WC4tIEl4rhFgS8gVRuvIQO7-OKHSKZOQ.hLTbBsOL1A5E0o_vRxlg4UYzWMmHZb7W8W_jnUR7Tl8"

if [ ! -f "/workspaces/Windows/windows/data.vhdx" ]; then
    echo '[SYSTEM] Downloading 21GB VHDX directly (No extraction needed)...'
    curl -L -o /workspaces/Windows/windows/data.vhdx "$URL"
fi

echo '[SUCCESS] Setup finished. Type start to boot Windows.'