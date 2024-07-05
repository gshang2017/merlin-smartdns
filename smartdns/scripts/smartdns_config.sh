#!/bin/sh

eval `dbus export smartdns_enable`

if [ "$smartdns_enable" == "1" ];then
	/koolshare/smartdns/smartdns.sh restart
else
	/koolshare/smartdns/smartdns.sh stop
fi
