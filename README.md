# Run these commands in the router
```
opkg update && opkg install unzip
wget https://github.com/PacketCipher/openwrt-passwall/archive/refs/heads/main.zip -O main.zip && unzip main.zip
cd openwrt-passwall-main && chmod +x installer.sh
./installer.sh
```