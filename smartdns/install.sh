#! /bin/sh

cd /tmp

if [ -e /koolshare/smartdns/smartdns.conf ]; then
  rm -rf /tmp/smartdns/smartdns/smartdns.conf
fi

cp -rf /tmp/smartdns/smartdns /koolshare/
cp -rf /tmp/smartdns/scripts/* /koolshare/scripts/
cp -rf /tmp/smartdns/webs/* /koolshare/webs/
cp -rf /tmp/smartdns/res/* /koolshare/res/
cp -rf /tmp/smartdns/perp/* /koolshare/perp/
cp -rf /tmp/smartdns/uninstall.sh /koolshare/scripts/uninstall_smartdns.sh
cd /
rm -rf /tmp/smartdns/ >/dev/null 2>&1
rm -rf /tmp/smartdns.tar.gz >/dev/null 2>&1

if [ `ls /koolshare/init.d|grep "smartdns.sh"|wc -l` -gt 0 ]; then
  rm -rf /koolshare/init.d/*smartdns.sh
fi

chmod 755 /koolshare/smartdns/*
chmod 755 /koolshare/init.d/*
chmod 755 /koolshare/scripts/*
chmod 755 /koolshare/perp/smartdns/*

#设置插件版本号、smartdns程序版本号
/koolshare/smartdns/smartdns.sh show
