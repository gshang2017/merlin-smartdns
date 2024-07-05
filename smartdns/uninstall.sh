#!/bin/sh

sh /koolshare/smartdns/smartdns.sh stop

rm -rf /koolshare/smartdns
rm -rf /koolshare/perp/smartdns
rm -rf /koolshare/scripts/smartdns_config.sh
rm -rf /koolshare/scripts/smartdns_bin_update.sh
rm -rf /koolshare/scripts/smartdns_status.sh
rm -rf /koolshare/scripts/smartdns_update.sh
rm -rf /koolshare/webs/Module_smartdns.asp
rm -rf /koolshare/res/icon-smartdns.png
rm -rf /koolshare/res/smartdns_check.htm
rm -rf /koolshare/init.d/S99smartdns.sh

dbus remove smartdns_enable
dbus remove smartdns_version
dbus remove smartdns_bin_version
dbus remove smartdns_dns_port
dbus remove smartdns_dnsmasq_set
dbus remove smartdns_bin_auto_update
dbus remove smartdns_perp_set
dbus remove smartdns_upx_set
dbus remove smartdns_shadowsocks_patch_set
dbus remove softcenter_module_smartdns_name
dbus remove smartdns_server_1
dbus remove smartdns_server_2
dbus remove smartdns_user_conf_set
dbus remove smartdns_config
dbus remove smartdns_config_show

# remove start up command
sed -i '/smartdns_config.sh/d' /jffs/scripts/wan-start >/dev/null 2>&1
sed -i '/smartdns.sh/d' /jffs/scripts/nat-start >/dev/null 2>&1

rm -rf /koolshare/scripts/uninstall_smartdns.sh
