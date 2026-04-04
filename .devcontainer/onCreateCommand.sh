#!/bin/bash
# 1. Directory Setup
mkdir -p /tmp/windows
cp /workspaces/Windows/.devcontainer/helpers/* /usr/local/bin/ 2>/dev/null
chmod +x /usr/local/bin/*

# 2. MEGA NUKE (Freeing space)
sudo rm -rf /usr/local/share/dotnet /usr/local/lib/node_modules /usr/local/go /opt/ghc

# 3. Minimal Install
echo "[SYSTEM] Installing tools..."
sudo apt-get update && sudo apt-get install -y --no-install-recommends qemu-system-x86 qemu-utils wget curl novnc websockify net-tools ovmf
sudo apt-get clean

# 4. DIRECT VHDX DOWNLOAD (No extraction!)
if [ ! -f "/tmp/windows/data.vhdx" ]; then
    echo '[SYSTEM] Downloading 21GB VHDX directly to 40GB Drive...'
    curl -L -o /tmp/windows/data.vhdx "https://my.microsoftpersonalcontent.com/personal/e633715ed8e8b835/_layouts/15/download.aspx?UniqueId=e4b8f49a-15b8-41df-860a-030347a2e50a&Translate=false&tempauth=v1e.eyJzaXRlaWQiOiI1MTAwNDFmZS1lYTQyLTQ1ZGQtYjFjMC02ZjhhYTMxMWQzODIiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvbXkubWljcm9zb2Z0cGVyc29uYWxjb250ZW50LmNvbUA5MTg4MDQwZC02YzY3LTRjNWItYjExMi0zNmEzMDRiNjZkYWQiLCJleHAiOiIxNzc1Mjg4MzM5In0.I3hcva9reuO2FeC5G1o8PTxmGeZ-AzzNPnSLCEgcoT7vMn6cfk8tuPNgcramXpoVhnFfQVNj_XFjbXKXNowerIKnE_BHG9ySE8D1ynLQiOemZ63TkfRbp2H3s3jjjdZmhzzuEynCvpzNYV4-fYD20DltW_tRUpErJMtihnbHFBnDeITqRqP6Xd4Q4fHomeImFyCZAUHM5j8q7vaBsvvp7de6P5QodK5hcS1wVedTOAPAH_Mknz6WH-Z4mYTN-kuD70PgVTbxUg0Wxtytqnn-2asmLKHf11as0qonOi0g3A9Ey8bopxEEztPvef0YKDVOS9CU12zwbkzLgHB9ivgHc4yNbiwoJXGDoTCboXGKGoV6Fnri15eCiNtewQosFwTLTp5b6E8xbJ2u5N_0BuNK5m5njrocw-iZqaOLzK34zUZn3KyaRjql5m0OkH86R-28sGQ3oeaEkkCbYXk4nVQFRkvQtcij75YVY8SOmLEvQunIsNL7BtOWTrOJOExwmRWPaZdBfffhnk5ofSpqPLcIuA.u_YRA0dThKNbqhWQvf_OJ5gPNAFMkVdoMDBeDm-LoEM"
    
    # Check if we got a real file
    SIZE=
    if [ "" -lt 1000000000 ]; then
        echo "[ERROR] Download failed or link expired. File size:  bytes."
        exit 1
    fi
    
    sudo chmod -R 777 /tmp/windows
fi

echo '[SUCCESS] Setup finished. Type start.'