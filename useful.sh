# Change Lan Default Subnet to 192.168.27.x
uci set network.lan.proto='static'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.ipaddr='192.168.27.1'
uci set network.lan.delegate='0'

uci commit network

/sbin/reload_config