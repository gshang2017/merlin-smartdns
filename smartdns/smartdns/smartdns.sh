#!/bin/sh

# 版本号定义
version="1.0"

# 引用环境变量等

source /koolshare/scripts/base.sh
export PERP_BASE=/koolshare/perp
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
eval `dbus export smartdns_enable`
eval `dbus export smartdns_bin_auto_update`
eval `dbus export smartdns_dnsmasq_set`
eval `dbus export smartdns_dns_port`
eval `dbus export smartdns_perp_set`
eval `dbus export smartdns_shadowsocks_patch_set`
eval `dbus export smartdns_config`
eval `dbus export smartdns_config_show`
eval `dbus export smartdns_user_conf_set`

# ====================================函数定义====================================

# 写入版本号
write_smartdns_version(){
	dbus set smartdns_version="$version"
}

# 写入程序版本号
write_smartdns_bin_version(){
	if [ ! -e /koolshare/smartdns/binversion ] || [ $(echo `cat /koolshare/smartdns/binversion`|wc -w) -eq 0 ]; then
		echo `/koolshare/smartdns/smartdns -v`|awk -FRelease '{print $2}'|awk -F")" '{print $1}' > /koolshare/smartdns/binversion
	fi
	dbus set smartdns_bin_version=`cat /koolshare/smartdns/binversion`
}


# 启动smartdns主程序
start_smartdns(){
	# creat start_up file
	if [ ! -L "/koolshare/init.d/S99smartdns.sh" ]; then
		if [ `ls /koolshare/init.d|grep "smartdns.sh"|wc -l` -gt 0 ]; then
			rm /koolshare/init.d/*smartdns.sh
		fi
		ln -sf /koolshare/smartdns/smartdns.sh /koolshare/init.d/S99smartdns.sh
	fi
	#kill smartdns 主程序
	kill -9 `pidof smartdns` >/dev/null 2>&1 &
	#启动守护程序
	perpctl A smartdns  >/dev/null 2>&1
}

# smartdns主程序自动更新设定
smartdns_cru_set(){
	if  [ "$smartdns_enable" == "1" ] && [ "$smartdns_bin_auto_update" == "1" ];then
		cru a smartdnsUpdate "0 5 * * * /koolshare/scripts/smartdns_bin_update.sh"
	else
		cru d smartdnsUpdate
	fi
}

# dnsmasq设置
dnsmasq_set(){
	if [ "$smartdns_enable" == "1" ] && [ -e /koolshare/smartdns/smartdns.conf ];then
		if [ "$smartdns_dnsmasq_set" == "1" ] && [ "$smartdns_dns_port" != "53" ];then
			# 创建dnsmasq.postconf软连接到/jffs/scripts/文件夹.
			[ ! -L "/jffs/scripts/dnsmasq.postconf" ] && ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			if [ -z "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			fi
			service restart_dnsmasq >/dev/null 2>&1
		elif [ "$smartdns_dnsmasq_set" == "2" ] && [ "$smartdns_dns_port" != "53" ];then
			# 创建dnsmasq.postconf软连接到/jffs/scripts/文件夹.
			[ ! -L "/jffs/scripts/dnsmasq.postconf" ] && ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			if [ -z "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			fi
			service restart_dnsmasq >/dev/null 2>&1
		elif [ "$smartdns_dnsmasq_set" == "3" ] && [ "$smartdns_dns_port" != "53" ];then
			# 删除dnsmasq设置
			if [ -n "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				service restart_dnsmasq >/dev/null 2>&1
			fi
		elif [ "$smartdns_dnsmasq_set" == "4" ] && [ "$smartdns_dns_port" != "53" ];then
			# 创建dnsmasq.postconf软连接到/jffs/scripts/文件夹.
			[ ! -L "/jffs/scripts/dnsmasq.postconf" ] && ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			if [ -z "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			fi
			service restart_dnsmasq >/dev/null 2>&1
		elif [ "$smartdns_dnsmasq_set" == "5" ] && [ "$smartdns_dns_port" != "53" ];then
			# 创建dnsmasq.postconf软连接到/jffs/scripts/文件夹.
			[ ! -L "/jffs/scripts/dnsmasq.postconf" ] && ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			if [ -z "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				ln -sf /koolshare/smartdns/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			fi
			service restart_dnsmasq >/dev/null 2>&1
		else
			# 删除dnsmasq设置
			if [ -n "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
				rm -rf /jffs/scripts/dnsmasq.postconf
				service restart_dnsmasq >/dev/null 2>&1
			fi
		fi
	else
		# 删除dnsmasq设置
		if [ -n "`ls -l  /jffs/scripts/dnsmasq.postconf|grep "smartdns"`" ];then
			rm -rf /jffs/scripts/dnsmasq.postconf
			service restart_dnsmasq >/dev/null 2>&1
		fi
	fi
}

# nat规则
nat_set(){
	if [ "$smartdns_enable" == "1" ] && [ -e /koolshare/smartdns/smartdns.conf ];then
		if [ "$smartdns_dnsmasq_set" == "1" ] && [ "$smartdns_dns_port" != "53" ];then
			# 删除iptables设置
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			done
		elif [ "$smartdns_dnsmasq_set" == "2" ] && [ "$smartdns_dns_port" != "53" ];then
			# 删除iptables设置
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			done
		elif [ "$smartdns_dnsmasq_set" == "3" ] && [ "$smartdns_dns_port" != "53" ];then
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			done
			iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports $smartdns_dns_port
			iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports $smartdns_dns_port
		elif [ "$smartdns_dnsmasq_set" == "4" ] && [ "$smartdns_dns_port" != "53" ];then
			# 删除iptables设置
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			done
		elif [ "$smartdns_dnsmasq_set" == "5" ] && [ "$smartdns_dns_port" != "53" ];then
			# 删除iptables设置
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53"|head -n 1|awk '{print $1}'`
			done
		else
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53 redir ports"|head -n 1|awk '{print $1}'`
			while [ -n "$iptables_nu" ]
			do
				iptables -t nat -D PREROUTING $iptables_nu
				iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53 redir ports"|head -n 1|awk '{print $1}'`
			done
		fi
	else
		iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53 redir ports"|head -n 1|awk '{print $1}'`
		while [ -n "$iptables_nu" ]
		do
			iptables -t nat -D PREROUTING $iptables_nu
			iptables_nu=`iptables -t nat -L PREROUTING -v -n --line-numbers|grep "dpt:53 redir ports"|head -n 1|awk '{print $1}'`
		done
	fi
}

# 加载nat
load_nat(){
	nat_ready=$(iptables -t nat -L PREROUTING -v -n --line-numbers|grep -v PREROUTING|grep -v destination)
	i=120
	until [ -n "$nat_ready" ]
	do
		i=$(($i-1))
		if [ "$i" -lt 1 ];then
			#错误：不能正确加载nat规则!
			exit
		fi
		sleep 1
		nat_ready=$(iptables -t nat -L PREROUTING -v -n --line-numbers|grep -v PREROUTING|grep -v destination)
	done
	#加载nat规则!
	nat_set
}

#设置perp
perp_set(){
	if [ "$smartdns_enable" == "1" ] && [ "$smartdns_perp_set" == "1" ] ;then
		cru d smartdnsperp
		cru a smartdnsperp "*/1 * * * *   /koolshare/smartdns/smartdns.sh perp_restart"
	elif [ "$smartdns_enable" == "1" ] && [ "$smartdns_perp_set" == "2" ] ;then
		cru d smartdnsperp
		cru a smartdnsperp "*/10 * * * *   /koolshare/smartdns/smartdns.sh perp_restart"
	elif [ "$smartdns_enable" == "1" ] && [ "$smartdns_perp_set" == "3" ] ;then
		cru d smartdnsperp
		cru a smartdnsperp "*/30 * * * *   /koolshare/smartdns/smartdns.sh perp_restart"
	elif [ "$smartdns_enable" == "1" ] && [ "$smartdns_perp_set" == "4" ] ;then
		cru d smartdnsperp
		cru a smartdnsperp "* */1 * * *   /koolshare/smartdns/smartdns.sh perp_restart"
	else
		cru d smartdnsperp
  fi
}

#设置shadowsocks_patch
shadowsocks_patch_set(){
	if [ "$smartdns_enable" == "1" ];then
		if [ "$smartdns_shadowsocks_patch_set" == "1" ];then
			if [ -f /koolshare/ss/rules/dnsmasq.postconf ] && [ ! -f /koolshare/ss/rules/dnsmasq.postconf.smartdns.bak ] ;then
				cp /koolshare/ss/rules/dnsmasq.postconf  /koolshare/ss/rules/dnsmasq.postconf.smartdns.bak
			fi
			if [ -f /koolshare/ss/ssconfig.sh ] && [ ! -f /koolshare/ss/ssconfig.sh.smartdns.bak ] ;then
				cp /koolshare/ss/ssconfig.sh /koolshare/ss/ssconfig.sh.smartdns.bak
			fi
			if [ `grep "smartdns-1" /koolshare/ss/rules/dnsmasq.postconf | wc -l` -eq 0 ] && [ `grep "adguardhome-1" /koolshare/ss/rules/dnsmasq.postconf | wc -l` -eq 0 ] ;then
				h1=$(grep -n "all-servers" /koolshare/ss/rules/dnsmasq.postconf | awk -F: '{print $1}')
				sed -i "${h1} a \ \ \ \ \ \ \ \ pc_replace \"cache-size=9999\" \"cache-size=0\" \$CONFIG" /koolshare/ss/rules/dnsmasq.postconf
				sed -i "${h1} a \ \ \ \ \ \ \ \ pc_insert \"no-poll\" \"server=\$CDN\" \"/etc/dnsmasq.conf\"" /koolshare/ss/rules/dnsmasq.postconf
				sed -i "${h1} a \ \ \ \ \ \ \ \ \# 选择自定义DNS端口时候" /koolshare/ss/rules/dnsmasq.postconf
				sed -i "${h1} a \ \ \ \ elif [ \"\$ss_dns_china\" == \"12\" ];then" /koolshare/ss/rules/dnsmasq.postconf
				sed -i "${h1} a \ \ \ \ \# smartdns-1 adguardhome-1" /koolshare/ss/rules/dnsmasq.postconf
			fi
			if [ `grep "smartdns-2" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ] && [ `grep "adguardhome-2" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ] ;then
				h2=$(grep -n "wan_white_domain\"" /koolshare/ss/ssconfig.sh |grep "CDN#53" | awk -F: '{print $1}')
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fi" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_white_domain\" \| sed \"s\/\^\/server=\&\\\/.\/g\" | sed \"s\/\$\/\\\/\$CDN\#53\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# 选择其它国内DNS时候" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ else" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_white_domain\" \| sed \"s\/\^\/server=\&\\\/.\/g\" \| sed \"s\/\$\/\\\/\$CDN\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# 选择自定义DNS端口时候" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ if [ \"\$ss_dns_china\" == \"12\" ];then" /koolshare/ss/ssconfig.sh
				sed -i "${h2} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# smartdns-2 adguardhome-2" /koolshare/ss/ssconfig.sh
				sed -i "${h2} d" /koolshare/ss/ssconfig.sh
			fi
			if [ `grep "smartdns-3" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ] && [ `grep "adguardhome-3" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ] ;then
				h3=$(grep -n "wan_white_domain2\"" /koolshare/ss/ssconfig.sh |grep "CDN#53" | awk -F: '{print $1}')
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ fi" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_white_domain2\" \| sed \"s\/\^\/server=\&\\\/.\/g\" | sed \"s\/\$\/\\\/\$CDN\#53\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # 选择其它国内DNS时候" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ else" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_white_domain2\" \| sed \"s\/\^\/server=\&\\\/.\/g\" \| sed \"s\/\$\/\\\/\$CDN\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# 选择自定义DNS端口时候" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ if [ \"\$ss_dns_china\" == \"12\" ];then" /koolshare/ss/ssconfig.sh
				sed -i "${h3} a \ \ \ \ \ \ \ \ \ \ \ \ \# smartdns-3 adguardhome-2" /koolshare/ss/ssconfig.sh
				sed -i "${h3} d" /koolshare/ss/ssconfig.sh
			fi
			if [ `grep "smartdns-4" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ] && [ `grep "adguardhome-4" /koolshare/ss/ssconfig.sh | wc -l` -eq 0 ];then
				h4=$(grep -n "wan_black_domain\"" /koolshare/ss/ssconfig.sh |grep "CDN#53" | awk -F: '{print $1}')
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ fi" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_black_domain\" \| sed \"s\/\^\/server=\&\\\/.\/g\" | sed \"s\/\$\/\\\/\$CDN\#53\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# 选择其它国内DNS时候" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ else" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ echo \"\$wan_black_domain\" \| sed \"s\/\^\/server=\&\\\/.\/g\" \| sed \"s\/\$\/\\\/\$CDN\/g\" >> /tmp/wblist.conf" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# 选择自定义DNS端口时候" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ if [ \"\$ss_dns_china\" == \"12\" ];then" /koolshare/ss/ssconfig.sh
				sed -i "${h4} a \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \# smartdns-4 adguardhome-4" /koolshare/ss/ssconfig.sh
				sed -i "${h4} d" /koolshare/ss/ssconfig.sh
			fi
			ln -sf /koolshare/ss/rules/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
		else
			if [ -f /koolshare/ss/rules/dnsmasq.postconf.smartdns.bak ] ;then
				mv /koolshare/ss/rules/dnsmasq.postconf.smartdns.bak  /koolshare/ss/rules/dnsmasq.postconf
				ln -sf /koolshare/ss/rules/dnsmasq.postconf /jffs/scripts/dnsmasq.postconf
			fi
			if [ -f /koolshare/ss/ssconfig.sh.smartdns.bak ] ;then
				mv /koolshare/ss/ssconfig.sh.smartdns.bak  /koolshare/ss/ssconfig.sh
			fi
		fi
	fi
}

#重启软件中心perp
smartdns_perp(){
	if ! pidof perpboot > /dev/null; then
		sh /koolshare/perp/perp.sh stop
		sh /koolshare/perp/perp.sh start

	fi
	sleep 5
	if  [ -z "`cru l|grep smartdnsUpdate`" ] || [ -z "`cru l|grep smartdnsperp`" ];then
		smartdns_cru_set
		perp_set
	fi
}

# 停止smartdns主程序
stop_smartdns(){
	#停止守护程序
	perpctl X smartdns  >/dev/null 2>&1
	#kill smartdns 主程序
	kill -9 `pidof smartdns` >/dev/null 2>&1 &
	# 删除smartdns主程序自动更新设定
	cru d smartdnsUpdate
}

# 自动触发程序
auto_start(){
	# nat_auto_start
	mkdir -p /jffs/scripts
	# creating iptables rules to nat-start
	if [ ! -f /jffs/scripts/nat-start ]; then
	cat > /jffs/scripts/nat-start <<-EOF
		#!/bin/sh
		/usr/bin/onnatstart.sh

		EOF
	chmod +x /jffs/scripts/nat-start
	fi

	writenat=$(cat /jffs/scripts/nat-start | grep "smartdns")
	if [ -z "$writenat" ];then
		#添加nat-start触发事件...用于smartdns的nat规则重启后或网络恢复后的加载...
		sed -i '2a sh /koolshare/smartdns/smartdns.sh' /jffs/scripts/nat-start
		chmod +x /jffs/scripts/nat-start
	fi

	# wan_auto_start
	# Add service to auto start
	if [ ! -f /jffs/scripts/wan-start ]; then
		cat > /jffs/scripts/wan-start <<-EOF
			#!/bin/sh
			/usr/bin/onwanstart.sh

			EOF
		chmod +x /jffs/scripts/wan-start
	fi

	startsmartdns=$(cat /jffs/scripts/wan-start | grep "/koolshare/scripts/smartdns_config.sh")
	if [ -z "$startsmartdns" ];then
		#添加wan-start触发事件...
		sed -i '2a sh /koolshare/scripts/smartdns_config.sh' /jffs/scripts/wan-start
    chmod +x /jffs/scripts/wan-start
	fi
}


# 写入程序配置文件
smartdns_config_set(){
	if [ "$smartdns_config" != `cat /koolshare/smartdns/smartdns.conf|base64_encode` ];then
	   dbus set smartdns_config=`cat /koolshare/smartdns/smartdns.conf|base64_encode`
	fi
	if [ "$smartdns_user_conf_set" == "1" ] && [ "$smartdns_config_show" != "$smartdns_config" ] && [ "$smartdns_config_show" != "" ];then
		echo $smartdns_config_show|base64_decode > /koolshare/smartdns/smartdns.conf
		dbus set smartdns_config=`cat /koolshare/smartdns/smartdns.conf|base64_encode`
	fi
	dbus remove smartdns_config_show
}



case $ACTION in
start)
	#此处为开机自启动设计，只有软件中心smartdns开启，才会启动smartdns
	if [ "$smartdns_enable" == "1" ];then
		write_smartdns_version
		write_smartdns_bin_version
		start_smartdns
		smartdns_cru_set
		auto_start
		dnsmasq_set
		load_nat
		perp_set
		shadowsocks_patch_set
		smartdns_config_set
	else
		logger "[软件中心]: smartdns未设置开机启动，跳过！"
	fi
  ;;
stop | kill )
	stop_smartdns
	smartdns_cru_set
	write_smartdns_version
	write_smartdns_bin_version
	dnsmasq_set
	load_nat
	perp_set
	shadowsocks_patch_set
	smartdns_config_set
  ;;
restart)
	write_smartdns_version
	write_smartdns_bin_version
	stop_smartdns
	smartdns_config_set
	start_smartdns
	smartdns_cru_set
	auto_start
	dnsmasq_set
	load_nat
	perp_set
	shadowsocks_patch_set
  ;;
#设置dns端口网页显示状态、插件版本号、smartdns程序版本号
show)
	write_smartdns_version
	echo_date “已设定插件版本号”
	write_smartdns_bin_version
	echo_date “已设定smartdns程序版本号”
  ;;
perp_restart)
	smartdns_perp
  ;;
*)
  if [ "$smartdns_enable" == "1" ];then
		dnsmasq_set
		load_nat
		shadowsocks_patch_set
		smartdns_cru_set
		perp_set
		smartdns_config_set
  fi
  #echo "Usage: $0 (start|stop|restart|kill|show)"
  #exit 1
  ;;
esac
