#!/bin/sh

# 引用环境变量等

source /koolshare/scripts/base.sh
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
eval `dbus export smartdns_upx_set`

# 更新smartdns二进制

get_latest_release() {
	curl --silent https://api.github.com/repos/pymumu/smartdns/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/Release//'
}
check_update_smartdns(){
	local lastver oldver
	echo_date 开始检查 smartdns 最新版本。。。
	lastver=$(get_latest_release)
	oldver="$(echo `/koolshare/smartdns/smartdns -v`|awk -FRelease '{print $2}'|awk -F")" '{print $1}')"
	if [ "$oldver" != "`cat /koolshare/smartdns/binversion`" ]; then
		echo `/koolshare/smartdns/smartdns -v`|awk -FRelease '{print $2}'|awk -F")" '{print $1}' > /koolshare/smartdns/binversion
		dbus set smartdns_bin_version=`cat /koolshare/smartdns/binversion`
	fi
	if [ -n "$lastver" ]; then
		echo_date 当前版本：$oldver
		echo_date 最新版本：$lastver
		if [ "$lastver" == "$oldver" ]; then
			echo_date 当前已经是最新版本！
			sleep 3
			echo XU6J03M6
		else
			if [ -e  "/tmp/smartdns-arm" ] ; then
				rm -rf /tmp/smartdns-arm
			fi
			echo_date "准备升级到最新版本，开始下载" 
			curl  --retry 2  -o /tmp/smartdns-arm -L  https://github.com/pymumu/smartdns/releases/download/Release${lastver}/smartdns-arm
			if [ -e  "/tmp/smartdns-arm" ] ; then
				echo_date "最新版本已下载，准备安装"
				chmod a+x /tmp/smartdns-arm
				if [ "$smartdns_upx_set" == "1" ] ;then
					echo_date "正在使用upx压缩smartdns程序"
					/koolshare/smartdns/upx /tmp/smartdns-arm
					echo_date "已完成压缩smartdns程序"
				fi
				if [  $(/tmp/smartdns-arm -v | grep "Release" |wc -l) == 1 ];then
					/koolshare/smartdns/smartdns.sh stop
					echo_date "正在安装smartdns程序"
					cp -rf /tmp/smartdns-arm /koolshare/smartdns/smartdns
					chmod a+x /koolshare/smartdns/smartdns
					echo `/koolshare/smartdns/smartdns -v`|awk -FRelease '{print $2}'|awk -F")" '{print $1}' > /koolshare/smartdns/binversion
					rm -rf /tmp/smartdns-arm
					echo_date "最新版本已安装，准备重启插件"
					dbus set smartdns_bin_version=$lastver
					/koolshare/smartdns/smartdns.sh restart
				else
					echo_date "压缩smartdns程序错误,无法更新"
				fi
			else
				echo_date "最新版本下载失败，请检查网络到github的连通后再试！"
				sleep 3
				echo XU6J03M6
			fi
		fi
	else
		echo_date 最新版本号检查失败，请检查网络到github的连通后再试！
		sleep 3
		echo XU6J03M6
	fi
}

echo_date "==================================================================="
echo_date "                     smartdns程序更新                           "
echo_date "==================================================================="
check_update_smartdns
echo_date "==================================================================="
