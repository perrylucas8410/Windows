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
    curl -L -o /tmp/windows/data.vhdx "https://my.microsoftpersonalcontent.com/personal/e633715ed8e8b835/_layouts/15/download.aspx?UniqueId=5e2ea8d8-7db3-4dc6-90bb-ce1408b1ef31&Translate=false&tempauth=v1e.eyJzaXRlaWQiOiI1MTAwNDFmZS1lYTQyLTQ1ZGQtYjFjMC02ZjhhYTMxMWQzODIiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvbXkubWljcm9zb2Z0cGVyc29uYWxjb250ZW50LmNvbUA5MTg4MDQwZC02YzY3LTRjNWItYjExMi0zNmEzMDRiNjZkYWQiLCJleHAiOiIxNzc1MzkwMjQyIn0.BZ9bFj4gfvj6o6XAf8PQ-XuzmbOpN4wvyCGOad7lBrSPyuRuD9A3ZJJIDx7Cqg6jpzx_rN0q2HSRL-PLsCd9axZIjFUpygy-R4PWNI2kVnYlytq0EILCiSAq5LzTrOm-txX6VIhaxRU5iX-LhjlkSyzWbk1FVkQ3Vbjyke0vlxwtlCbwe4Ivd4Jx-gEJYfeWXGhJYcBvtC7Y6BC2KBOg9vIXaxa7D4_7ETl3OK5a2BWkB2m-mVmsvCk3jV-k_ayOqwjkBQuYAjFqnWhfn96B_dB8Zfo7j5-XyJYS0AccRfdnx1gdApqMB7YDHJxQHwNTvmmxKwIsitZAnKcg3T7byJIqwfpYAgjXok1Ovskzf6kEJkWnfz1lUgZZzpnZEBx-AGwgjwK1u9_JO851T2aBwfK3Iz5pAqg4zdgHN7MSJbi1SDAjZmNJij8KRYxtZtFS9xnsXTqdtIfKdGlF5AGVZ9whA9j0W0BC9n2TGK9TFwmwFEV06rO2xv2j46f9EvoHfaZrUhq3subRWSXU-Mm1Qg.qvkVnNrr2HEFV7Srb6WN2xZS_VlTrkYbueCVyTsH5YQ"

    sudo chmod -R 777 /tmp/windows
fi
echo '[SUCCESS] Setup finished. Type start.'
