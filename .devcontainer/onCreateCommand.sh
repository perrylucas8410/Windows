#!/bin/bash
mkdir -p /tmp/windows
cp /workspaces/Windows/.devcontainer/helpers/* /usr/local/bin/ 2>/dev/null
chmod +x /usr/local/bin/*
sudo rm -rf /usr/local/share/dotnet /usr/local/lib/node_modules /usr/local/go
echo "[SYSTEM] Installing tools..."
sudo apt-get update && sudo apt-get install -y --no-install-recommends qemu-system-x86 qemu-utils wget curl novnc websockify net-tools ovmf
sudo apt-get clean

if [ ! -f "/tmp/windows/data.vhdx" ]; then
    echo '[SYSTEM] Downloading VHDX directly...'
    curl -L -o /tmp/windows/data.vhdx "https://my.microsoftpersonalcontent.com/personal/e633715ed8e8b835/_layouts/15/download.aspx?UniqueId=5e2ea8d8-7db3-4dc6-90bb-ce1408b1ef31&Translate=false&tempauth=v1e.eyJzaXRlaWQiOiI1MTAwNDFmZS1lYTQyLTQ1ZGQtYjFjMC02ZjhhYTMxMWQzODIiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvbXkubWljcm9zb2Z0cGVyc29uYWxjb250ZW50LmNvbUA5MTg4MDQwZC02YzY3LTRjNWItYjExMi0zNmEzMDRiNjZkYWQiLCJleHAiOiIxNzc1NDEyNTUxIn0.Fc8_Iy_ahaEAXnrzrOyqxMsxra-_3VGTclXXJtjpRwpwlHTz8h1plPWEU_01Bul5-UTXmLWXUTAdAuZZelxVqQNW5IdKReN6DrzEfDYtmKEwFRKw-ax3B8emH1-FmsJFMRf_KwYgmzh5DhRr6VR-YQZGH5dZyUzmZC9yEOjx97Vj1a9Qyw9BxS-A-nu8tZPRfv_KO_xE4BJZOeOuhgfVmlVXG2mC7eliJ6EZpGV3JapjSabRSA7JcaKPld7aFxehzEw9ke4DXcL2bPBniyQ7AJ4TqHAnpnI4kEAvaL49Su_W0XBDv2s3kCxL4lhxbSxQt1g3BYWPtm5Nls07bNXGijeEaStHv1IHSsx11x4w3m29G9h1Qa0Y41eU4gSFPsbr7sksLv3l8Lo3hKjFoDagQ0FH8uoFwCDKMS7_REIVvKvuRsNty27zMO47Fbn_u7rl7iCcM4Mb-Py0IA-CUXPYvB-EQELk3UDhCRddQ4540EaSgEqejkLQ0EAo_gfZvjUESzpAdrRKc-C-xP4tuhIdUg.UGLp6tPuvJzR8SAnjgvTxO3gA85Z6Oj3zkyt1qYy0Eg"
    
    sudo chmod -R 777 /tmp/windows
fi
echo '[SUCCESS] Setup finished. Type start.'
