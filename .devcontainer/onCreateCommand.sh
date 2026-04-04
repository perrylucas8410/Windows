#!/bin/bash
mkdir -p /tmp/windows
cp /workspaces/Windows/.devcontainer/helpers/* /usr/local/bin/ 2>/dev/null
chmod +x /usr/local/bin/*
sudo rm -rf /usr/local/share/dotnet /usr/local/lib/node_modules /usr/local/go /opt/ghc
echo "[SYSTEM] Installing tools..."
sudo apt-get update && sudo apt-get install -y --no-install-recommends qemu-system-x86 qemu-utils 7zip wget curl novnc websockify net-tools
sudo apt-get clean
URL="https://my.microsoftpersonalcontent.com/personal/e633715ed8e8b835/_layouts/15/download.aspx?UniqueId=31984a96-101e-4304-a231-96356ed22d29&Translate=false&tempauth=v1e.eyJzaXRlaWQiOiI1MTAwNDFmZS1lYTQyLTQ1ZGQtYjFjMC02ZjhhYTMxMWQzODIiLCJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvbXkubWljcm9zb2Z0cGVyc29uYWxjb250ZW50LmNvbUA5MTg4MDQwZC02YzY3LTRjNWItYjExMi0zNmEzMDRiNjZkYWQiLCJleHAiOiIxNzc1Mjc4MDI0In0.WZDEfOVF2bxyZmRVbP6cUqGuLWSIBirpvDujSa7pbRMdsY1AHfqB-vg1asChpfRTaoVmXpgSysQJ0VVWRYW6MHboUSzTXO4w22yFgZCjDkRPXv1cnBzy7eYfKkpU19REmmBQRMxNpkoTz1QeWi_FcwdLcqsAzbDYkn_JFtxkvtSaKeWhhj02V92rUtjdOMw4FNA4FebbcfQqWSXvjmkTqx0rFypmSeH1M_-VTqMYpe6BexiHD4-WDt_tfCGhyESVoNp77Q-fT9Yz_wjHf-xXaFkE7iR71-69QQ9RoXBX5WV6Ie2NSGzLZYt4oTq1ZQbugdo1i_hot2zEiZluTzlZZtR9kvmvyrHj_2mfydTgq2kVDvy5thifZtUHXpS_M8byBpQ_mQRQrlRBcCBP6iqqDwU_8BEoGjKxQE3J0sl0HmIVJ_ieelteFwTiKEQg7iDXvohAaUJS7rCewETdvyA8j7fDIWquSGGfL0fuZ2yvRjqN_a562IZPbCeGi720D_bIx0r3ERjBi31c2K_r5pYGnA.6Ic5JZgHuQgTcd8I0Q4lMIoou5m8M21texQJ6AUNf-0"
if [ ! -f "/tmp/windows/data.vhdx" ]; then
    echo '[SYSTEM] Downloading Zip...'
    curl -L -o /tmp/windows/sunshine.zip "$URL"
    echo '[SYSTEM] Extracting...'
    7z e /tmp/windows/sunshine.zip -o/tmp/windows/ -y
    rm /tmp/windows/sunshine.zip
    mv /tmp/windows/*.vhdx /tmp/windows/data.vhdx 2>/dev/null
    sudo chmod -R 777 /tmp/windows
fi
echo '[SUCCESS] Setup finished. Type start.'