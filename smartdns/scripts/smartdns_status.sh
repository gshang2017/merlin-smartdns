#! /bin/sh

status=`pidof smartdns | wc -w`

if [ "$status" == "0" ];then
	echo 【警告】：smartdns进程未运行！ > /tmp/smartdns.log
else
	echo smartdns进程运行正常！共计"$status"个进程！ > /tmp/smartdns.log
fi
echo XU6J03M6 >> /tmp/smartdns.log
sleep 2
rm -rf /tmp/smartdns.log
