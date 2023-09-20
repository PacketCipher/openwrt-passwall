#!/bin/ash

### Add Repositories & Update ###
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
echo "src/gz custom_arch https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/$(grep "OPENWRT_ARCH" /etc/os-release | awk -F '"' '{print $2}')" >> /etc/opkg/customfeeds.conf
# Unbloated Packages
echo "src/gz custom_minimal https://raw.githubusercontent.com/PacketCipher/opkg-repo/main/minimal" >> /etc/opkg/customfeeds.conf
opkg update

# Install Dnsmasq-Full
opkg remove dnsmasq && opkg install dnsmasq-full

# Install Passwall and Dependencies
opkg install ipset ipt2socks iptables iptables-legacy iptables-mod-iprange \
             iptables-mod-socket iptables-mod-tproxy kmod-ipt-nat coreutils coreutils-base64 \
             coreutils-nohup curl dns2socks ip-full libuci-lua lua luci-compat luci-lib-jsonc \
             microsocks resolveip tcping unzip

opkg install luci-app-passwall

## Iran IP Bypass ##
wget -O /usr/share/passwall/rules/direct_ip https://raw.githubusercontent.com/PacketCipher/iran-iplist/main/direct_ip
wget -O /usr/share/passwall/rules/direct_host https://raw.githubusercontent.com/PacketCipher/iran-iplist/main/direct_host

### Install Services ###
mkdir -p /usr/local/sbin
# xray-installer service #
cp services/xray-installer /etc/init.d/xray-installer
chmod +x /etc/init.d/xray-installer
/etc/init.d/xray-installer enable
# xray-monitor service #
cp services/xray-monitor /etc/init.d/xray-monitor
chmod +x /etc/init.d/xray-monitor
cp scripts/xray-monitor.sh /usr/local/sbin/xray-monitor.sh
chmod +x /usr/local/sbin/xray-monitor.sh
/etc/init.d/xray-monitor enable

# Finalizing
reboot &
echo "Done. Rebooting..."
