<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - smartdns</title>
<link rel="stylesheet" type="text/css" href="index_style.css"/>
<link rel="stylesheet" type="text/css" href="form_style.css"/>
<link rel="stylesheet" type="text/css" href="usp_style.css"/>
<link rel="stylesheet" type="text/css" href="ParentalControl.css">
<link rel="stylesheet" type="text/css" href="css/icon.css">
<link rel="stylesheet" type="text/css" href="css/element.css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script type="text/javascript" src="/dbconf?p=smartdns_&v=<% uptime(); %>"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<style>
.smartdns_btn {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}
.smartdns_btn:hover {
    border: 1px solid #222;
    background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
    font-size:10pt;
    color: #fff;
    padding: 5px 5px;
    border-radius: 5px 5px 5px 5px;
    width:16%;
}
.smartdns_btn_update {
    font-size:10pt;
	  color: #FC0;
}
.smartdns_btn_update:hover  {
    font-size:10pt;
	  color: #FC0;
}

input[type=button]:focus {
	outline: none;
}
.show-btn1, .show-btn2, .show-btn3 {
	border: 1px solid #222;
	border-bottom:none;
	background: linear-gradient(to bottom, #919fa4  0%, #67767d 100%); /* W3C */
	font-size:10pt;
	color: #fff;
	padding: 10px 3.75px;
	border-radius: 5px 5px 0px 0px;
	width:8.45601%;
}
.show-btn1:hover, .show-btn2:hover, .show-btn3:hover, .active {
	background: #2f3a3e;
}
.input_smartdns_table{
	margin-left:2px;
	padding-left:0.4em;
	height:21px;
	width:158.2px;
	line-height:23px \9;	/*IE*/
	font-size:13px;
	font-family: Lucida Console;
	background-image:none;
	background-color: #576d73;
	border:1px solid gray;
	color:#FFFFFF;
}
.SimpleNote { padding:5px 10px;}
.input_option{
	height:25px;
	background-color:#576D73;
	border-top-width:1px;
	border-bottom-width:1px;
	border-color:#888;
	color:#FFFFFF;
	font-family: Lucida Console;
	font-size:13px;
}
</style>

<script>
var _responseLen;
var noChange = 0;
var noChange2 = 0;
var x = 5;
var $j = jQuery.noConflict();
var params_input = ["smartdns_dns_port","smartdns_server_1","smartdns_server_2"];
function init() {
  show_menu();
  buildswitch();
  decode_show();
  toggle_func();
  auto_bin_update();
  smartdns_dnsmasq_set();
  smartdns_perp_set();
  smartdns_upx_set();
  smartdns_shadowsocks_patch_set();
  setTimeout("get_smartdns_status()", 1000);
  conf2obj();
  confshowswitch();
}

function conf2obj(){
    var rrt = document.getElementById("switch");
    if (document.form.smartdns_enable.value != "1") {
    document.getElementById('smartdns_detail').style.display = "none";
        rrt.checked = false;
    } else {
    document.getElementById('smartdns_detail').style.display = "";
        rrt.checked = true;
    }
}

function buildswitch(){
  $j("#switch").click(
  function(){
    if(document.getElementById('switch').checked){
      document.form.smartdns_enable.value = 1;
      document.getElementById('smartdns_detail').style.display = "";
    }else{
      document.form.smartdns_enable.value = 0;
      document.getElementById('smartdns_detail').style.display = "none";
    }
  });
}

function confshowswitch(){
    if (document.form.smartdns_user_conf_set.value == "1") {
        document.getElementById('smartdns_user_conf_txt').style.display = "";
        document.getElementById("smartdns_user_conf_checkbox").checked = true;
		document.getElementById('smartdns_dns_port_tr').style.display = "none";
		document.getElementById('smartdns_server_1_tr').style.display = "none";
		document.getElementById('smartdns_server_2_tr').style.display = "none";
    } else {
        document.getElementById('smartdns_user_conf_txt').style.display = "none";
        document.getElementById("smartdns_user_conf_checkbox").checked = false ;
		document.getElementById('smartdns_dns_port_tr').style.display = "";
		document.getElementById('smartdns_server_1_tr').style.display = "";
		document.getElementById('smartdns_server_2_tr').style.display = "";
    }
}

function confswitch(){
    if(document.getElementById('smartdns_user_conf_checkbox').checked ){
      E("smartdns_user_conf_txt").style.display = "";
	  E("smartdns_dns_port_tr").style.display = "none";
	  E("smartdns_server_1_tr").style.display = "none";
	  E("smartdns_server_2_tr").style.display = "none";
    }else{
      E("smartdns_user_conf_txt").style.display = "none";
	  E("smartdns_dns_port_tr").style.display = "";
	  E("smartdns_server_1_tr").style.display = "";
	  E("smartdns_server_2_tr").style.display = "";
    }
}

function smartdns_binary_update(){
  var dbus = {};
  dbus["SystemCmd"] = "smartdns_bin_update.sh";
  dbus["action_mode"] = " Refresh ";
  dbus["current_page"] = "Module_smartdns.asp";
  $j.ajax({
    type: "POST",
    url: '/applydb.cgi?p=smartdns_',
    contentType: "application/x-www-form-urlencoded",
    dataType: 'text',
    data: dbus,
    success: function(response) {
        showsmartdnsLoadingBar();
        noChange2 = 0;
        setTimeout("get_realtime_log()", 500);
    }
  });
}

function smartdns_binary_rollback(){
  var dbus = {};
  dbus["SystemCmd"] = "smartdns_bin_rollback.sh";
  dbus["action_mode"] = " Refresh ";
  dbus["current_page"] = "Module_smartdns.asp";
  $j.ajax({
    type: "POST",
    url: '/applydb.cgi?p=smartdns_',
    contentType: "application/x-www-form-urlencoded",
    dataType: 'text',
    data: dbus,
    success: function(response) {
        showsmartdnsLoadingBar();
        noChange2 = 0;
        setTimeout("get_realtime_log()", 500);
    }
  });
}

function smartdns_update(){
  var dbus = {};
  dbus["SystemCmd"] = "smartdns_update.sh";
  dbus["action_mode"] = " Refresh ";
  dbus["current_page"] = "Module_smartdns.asp";
  $j.ajax({
    type: "POST",
    url: '/applydb.cgi?p=smartdns_',
    contentType: "application/x-www-form-urlencoded",
    dataType: 'text',
    data: dbus,
    success: function(response) {
        showsmartdnsPluginLoadingBar();
        noChange2 = 0;
        setTimeout("get_realtime_log()", 500);
    }
  });
}

function onSubmitCtrl(o, s) {
  document.form.smartdns_config_show.value = btoa(E("smartdns_config_show").value);
  if (document.getElementById("smartdns_user_conf_checkbox").checked) {
	 document.form.smartdns_user_conf_set.value = 1;
  } else {
     document.form.smartdns_user_conf_set.value = 0;
  }
  document.form.action_mode.value = s;
  showLoading(5);
  document.form.submit();
  noChange = 0;
  setTimeout("get_smartdns_status()", 1000);
  setTimeout("location.reload(true);", 5000);
}

function reload_smartdns_detail_table(){
  setTimeout("get_smartdns_status()", 1000);
}

function showsmartdnsLoadingBar(seconds) {
  if (window.scrollTo)
    window.scrollTo(0, 0);
  disableCheckChangedStatus();
  htmlbodyforIE = document.getElementsByTagName("html"); //this both for IE&FF, use "html" but not "body" because <!DOCTYPE html PUBLIC.......>
  htmlbodyforIE[0].style.overflow = "hidden"; //hidden the Y-scrollbar for preventing from user scroll it.
  winW_H();
  var blockmarginTop;
  var blockmarginLeft;
  if (window.innerWidth)
    winWidth = window.innerWidth;
  else if ((document.body) && (document.body.clientWidth))
    winWidth = document.body.clientWidth;
  if (window.innerHeight)
    winHeight = window.innerHeight;
  else if ((document.body) && (document.body.clientHeight))
    winHeight = document.body.clientHeight;
  if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
    winHeight = document.documentElement.clientHeight;
    winWidth = document.documentElement.clientWidth;
  }
  if (winWidth > 1050) {
    winPadding = (winWidth - 1050) / 2;
    winWidth = 1105;
    blockmarginLeft = (winWidth * 0.3) + winPadding - 150;
  } else if (winWidth <= 1050) {
    blockmarginLeft = (winWidth) * 0.3 + document.body.scrollLeft - 160;
  }
  if (winHeight > 660)
    winHeight = 660;
  blockmarginTop = winHeight * 0.3 - 140
  document.getElementById("loadingBarBlock").style.marginTop = blockmarginTop + "px";
  document.getElementById("loadingBarBlock").style.marginLeft = blockmarginLeft + "px";
  document.getElementById("loadingBarBlock").style.width = 770 + "px";
  document.getElementById("LoadingBar").style.width = winW + "px";
  document.getElementById("LoadingBar").style.height = winH + "px";
  loadingSeconds = seconds;
  progress = 100 / loadingSeconds;
  y = 0;
  LoadingsmartdnsProgress(seconds);
}

function showsmartdnsPluginLoadingBar(seconds) {
  if (window.scrollTo)
    window.scrollTo(0, 0);
  disableCheckChangedStatus();
  htmlbodyforIE = document.getElementsByTagName("html"); //this both for IE&FF, use "html" but not "body" because <!DOCTYPE html PUBLIC.......>
  htmlbodyforIE[0].style.overflow = "hidden"; //hidden the Y-scrollbar for preventing from user scroll it.
  winW_H();
  var blockmarginTop;
  var blockmarginLeft;
  if (window.innerWidth)
    winWidth = window.innerWidth;
  else if ((document.body) && (document.body.clientWidth))
    winWidth = document.body.clientWidth;
  if (window.innerHeight)
    winHeight = window.innerHeight;
  else if ((document.body) && (document.body.clientHeight))
    winHeight = document.body.clientHeight;
  if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
    winHeight = document.documentElement.clientHeight;
    winWidth = document.documentElement.clientWidth;
  }
  if (winWidth > 1050) {
    winPadding = (winWidth - 1050) / 2;
    winWidth = 1105;
    blockmarginLeft = (winWidth * 0.3) + winPadding - 150;
  } else if (winWidth <= 1050) {
    blockmarginLeft = (winWidth) * 0.3 + document.body.scrollLeft - 160;
  }
  if (winHeight > 660)
    winHeight = 660;
  blockmarginTop = winHeight * 0.3 - 140
  document.getElementById("loadingBarBlock").style.marginTop = blockmarginTop + "px";
  document.getElementById("loadingBarBlock").style.marginLeft = blockmarginLeft + "px";
  document.getElementById("loadingBarBlock").style.width = 770 + "px";
  document.getElementById("LoadingBar").style.width = winW + "px";
  document.getElementById("LoadingBar").style.height = winH + "px";
  loadingSeconds = seconds;
  progress = 100 / loadingSeconds;
  y = 0;
  LoadingsmartdnsPluginProgress(seconds);
}

function LoadingsmartdnsProgress(seconds) {
  document.getElementById("LoadingBar").style.visibility = "visible";
  document.getElementById("loading_block3").innerHTML = "smartdns程序更新中 ..."
  document.getElementById("loading_block2").innerHTML = "<li><font color='#ffcc00'>尝试不同的DNS及拦截清单配置，可以达到最佳的效果哦...</font></li><li><font color='#ffcc00'>请等待日志显示完毕，并出现自动关闭按钮！</font></li><li><font color='#ffcc00'>在此期间请不要刷新本页面，不然可能导致问题！</font></li>"
}

function LoadingsmartdnsPluginProgress(seconds) {
  document.getElementById("LoadingBar").style.visibility = "visible";
  document.getElementById("loading_block3").innerHTML = "smartdns插件更新中 ..."
  document.getElementById("loading_block2").innerHTML = "<li><font color='#ffcc00'>请等待日志显示完毕，并出现自动关闭按钮！</font></li><li><font color='#ffcc00'>在此期间请不要刷新本页面，不然可能导致问题！</font></li>"
}

function hidesmartdnsLoadingBar() {
  x = -1;
  E("LoadingBar").style.visibility = "hidden";
  checkss = 0;
  refreshpage();
}

function count_down_close() {
  if (x == "0") {
    hidesmartdnsLoadingBar();
  }
  if (x < 0) {
    E("ok_button1").value = "手动关闭"
    return false;
  }
  E("ok_button1").value = "自动关闭（" + x + "）"
    --x;
  setTimeout("count_down_close();", 1000);
}

function E(e) {
  return (typeof(e) == 'string') ? document.getElementById(e) : e;
}

function get_realtime_log() {
  $j.ajax({
    url: '/cmdRet_check.htm',
    dataType: 'html',
    error: function(xhr) {
      setTimeout("get_realtime_log();", 1000);
    },
    success: function(response) {
      var retArea = E("log_content3");
      if (response.search("XU6J03M6") != -1) {
        retArea.value = response.replace("XU6J03M6", " ");
        E("ok_button").style.display = "";
        retArea.scrollTop = retArea.scrollHeight;
        x = 5;
        count_down_close();
        return true;
      } else {
        E("ok_button").style.display = "none";
      }
      if (_responseLen == response.length) {
        noChange2++;
      } else {
        noChange2 = 0;
      }
      if (noChange2 > 1000) {
        return false;
      } else {
        setTimeout("get_realtime_log();", 250);
      }
      retArea.value = response.replace("XU6J03M6", " ");
      retArea.scrollTop = retArea.scrollHeight;
      _responseLen = response.length;
    },
    error: function() {
      setTimeout("get_realtime_log();", 500);
    }
  });
}


function get_smartdns_status(){
  var dbus = {};
  dbus["SystemCmd"] = "smartdns_status.sh";
  dbus["action_mode"] = " Refresh ";
  dbus["current_page"] = "Module_smartdns.asp";
  $j.ajax({
    type: "POST",
    url: '/applydb.cgi?p=smartdns_',
    contentType: "application/x-www-form-urlencoded",
    dataType: 'text',
    data: dbus,
        error: function(xhr) {
          alert("error");
          },
        success: function(response) {
        checkCmdRet();
          }
  });
}


function checkCmdRet(){
  $j.ajax({
    url: '/res/smartdns_check.htm',
    dataType: 'html',
    error: function(xhr){
      setTimeout("checkCmdRet();", 100);
    },
    success: function(response){
      var _cmdBtn = document.getElementById("cmdBtn");
      if(response.search("XU6J03M6") != -1){
        smartdns_status = response.replace("XU6J03M6", " ");
        document.getElementById("status").innerHTML = smartdns_status;
        setTimeout("get_smartdns_status;", 1000);
        return true;
      }
      if(_responseLen == response.length){
        noChange++;
      }else{
        noChange = 0;
      }
      if(noChange > 100){
        noChange = 0;
        refreshpage();
      }else{
        setTimeout("checkCmdRet();", 400);
      }
      _responseLen = response.length;
    }
  });
}

function  auto_bin_update() {
      check_selected("smartdns_bin_auto_update", db_smartdns_.smartdns_bin_auto_update);
}

function  smartdns_dnsmasq_set() {
      check_selected("smartdns_dnsmasq_set", db_smartdns_.smartdns_dnsmasq_set);
}

function  smartdns_perp_set() {
      check_selected("smartdns_perp_set", db_smartdns_.smartdns_perp_set);
}

function  smartdns_upx_set() {
      check_selected("smartdns_upx_set", db_smartdns_.smartdns_upx_set);
}

function  smartdns_shadowsocks_patch_set() {
      check_selected("smartdns_shadowsocks_patch_set", db_smartdns_.smartdns_shadowsocks_patch_set);
}

function check_selected(obj, m) {
    var o = document.getElementById(obj);
    for (var c = 0; c < o.length; c++) {
        if (o.options[c].value == m) {
            o.options[c].selected = true;
            break;
        }
    }
}

function toggle_func() {
	$j('.show-btn1').addClass('active');
	$j(".show-btn1").click(
		function() {
			$j('.show-btn1').addClass('active');
			$j('.show-btn2').removeClass('active');
			$j('.show-btn3').removeClass('active');
			E("smartdns_detail_table1").style.display = "";
			E("smartdns_detail_table2").style.display = "none";
			E("smartdns_detail_table3").style.display = "none";
			E("warnnote1").style.display = "";
			E("warnnote2").style.display = "none";
			E("warnnote3").style.display = "none";
		});
	$j(".show-btn2").click(
		//dns pannel
		function() {
			$j('.show-btn1').removeClass('active');
			$j('.show-btn2').addClass('active');
			$j('.show-btn3').removeClass('active');
			E("smartdns_detail_table1").style.display = "none";
			E("smartdns_detail_table2").style.display = "";
			E("smartdns_detail_table3").style.display = "none";
			E("warnnote1").style.display = "none";
			E("warnnote2").style.display = "";
			E("warnnote3").style.display = "none";
		});
	$j(".show-btn3").click(
		//dns pannel
		function() {
			$j('.show-btn1').removeClass('active');
			$j('.show-btn2').removeClass('active');
			$j('.show-btn3').addClass('active');
			E("smartdns_detail_table1").style.display = "none";
			E("smartdns_detail_table2").style.display = "none";
			E("smartdns_detail_table3").style.display = "";
			E("warnnote1").style.display = "none";
			E("warnnote2").style.display = "none";
			E("warnnote3").style.display = "";
		});
}

function reload_Soft_Center(){
location.href = "/Main_Soft_center.asp";
}

function decode_show() {
  E("smartdns_config_show").value = atob(E("smartdns_config").value);
}

</script>
</head>
<body onload="init();">
  <div id="TopBanner"></div>
  <div id="Loading" class="popup_bg"></div>
  <div id="LoadingBar" class="popup_bar_bg">
  <table cellpadding="5" cellspacing="0" id="loadingBarBlock" class="loadingBarBlock"  align="center">
    <tr>
      <td height="100">
      <div id="loading_block3" style="margin:10px auto;margin-left:10px;width:85%; font-size:12pt;"></div>
      <div id="loading_block2" style="margin:10px auto;width:95%;"></div>
      <div id="log_content2" style="margin-left:15px;margin-right:15px;margin-top:10px;overflow:hidden">
        <textarea cols="63" rows="21" wrap="on" readonly="readonly" id="log_content3" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="border:1px solid #000;width:99%; font-family:'Lucida Console'; font-size:11px;background:#000;color:#FFFFFF;outline: none;padding-left:3px;padding-right:22px;overflow-x:hidden"></textarea>
      </div>
      <div id="ok_button" class="apply_gen" style="background: #000;display: none;">
        <input id="ok_button1" class="button_gen" type="button" onclick="hidesmartdnsLoadingBar()" value="确定">
      </div>
      </td>
    </tr>
  </table>
  </div>
  <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
  <form method="POST" name="form" action="/applydb.cgi?p=smartdns_" target="hidden_frame">
  <input type="hidden" name="current_page" value="Module_smartdns_.asp"/>
  <input type="hidden" name="next_page" value="Module_smartdns_.asp"/>
  <input type="hidden" name="group_id" value=""/>
  <input type="hidden" name="modified" value="0"/>
  <input type="hidden" name="action_mode" value=""/>
  <input type="hidden" name="action_script" value=""/>
  <input type="hidden" name="action_wait" value=""/>
  <input type="hidden" name="first_time" value=""/>
  <input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>"/>
  <input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="smartdns_config.sh"/>
  <input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>"/>
  <input type="hidden" id="smartdns_enable" name="smartdns_enable" value='<% dbus_get_def("smartdns_enable", "0"); %>'/>
  <input type="hidden" id="smartdns_user_conf_set" name="smartdns_user_conf_set" value='<% dbus_get_def("smartdns_user_conf_set", "0"); %>'/>
  <input type="hidden" id="smartdns_config" name="smartdns_config" value='<% dbus_get_def("smartdns_config", ""); %>'/>

  <table class="content" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="17">&nbsp;</td>
      <td valign="top" width="202">
        <div id="mainMenu"></div>
        <div id="subMenu"></div>
      </td>
      <td valign="top">
        <div id="tabMenu" class="submenuBlock"></div>
        <table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
          <tr>
            <td align="left" valign="top">
              <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle">
                <tr>
                  <td bgcolor="#4D595D" colspan="3" valign="top">
                    <div>&nbsp;</div>
                    <div style="float:left;" class="formfonttitle">smartdns</div>
                    <div style="float:right; width:15px; height:25px;margin-top:10px"><img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img></div>
                    <div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
                    <div class="SimpleNote">
                         <li>SmartDNS 是一个运行在本地的 DNS 服务器，它接受来自本地客户端的 DNS 查询请求，然后从多个上游 DNS 服务器获取 DNS 查询结果，并将访问速度最快的结果返回给客户端，以此提高网络访问速度。 SmartDNS 同时支持指定特定域名 IP 地址，并高性匹配，可达到过滤广告的效果; 支持DOT(DNS over TLS)和DOH(DNS over HTTPS)，更好的保护隐私。</li>
                    </div>
                    <div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
                    <div class="formfontdesc" id="cmdDesc"><i>当前插件版本：<% dbus_get_def("smartdns_version", "0"); %></i>  <i><a type="button"  target="_blank" href="https://github.com/gshang2017/merlin-smartdns"><em>【<u>插件主页</u>】</em></a></i> &nbsp;&nbsp;<a id="smartdns_update" type="button" class="smartdns_btn" style="cursor:pointer" onclick="smartdns_update()">检查并更新</a> &nbsp;&nbsp;&nbsp;&nbsp;<i>当前smartdns版本：<% dbus_get_def("smartdns_bin_version", "0"); %></i> <i><a type="button"  target="_blank" href="https://github.com/pymumu/smartdns"><em>【<u>smartdns程序主页</u>】</em></a> </i>  </div>
                    <table style="margin:10px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="routing_table">
                      <thead>
                      <tr>
                        <td colspan="2">开关设置</td>
                      </tr>
                      </thead>
                      <tr id="switch_tr">
                        <th>
                          <label>开关</label>
                        </th>
                        <td colspan="2">
                          <div class="switch_field" style="display:table-cell">
                            <label for="switch">
                              <input id="switch" class="switch" type="checkbox" onclick="reload_smartdns_detail_table();" style="display: none;">
                              <div class="switch_container" >
                                <div class="switch_bar"></div>
                                <div class="switch_circle transition_style">
                                  <div></div>
                                </div>
                              </div>
                            </label>
                          </div>
                          <div id="smartdns_install_show" style="padding-top:5px;margin-left:80px;margin-top:-30px;float: left;"></div>
                        </td>
                      </tr>
                    </table>
					<div id="smartdns_detail">
					  <div id="tablets">
						<table style="margin:10px 0px 0px 0px;border-collapse:collapse" width="100%" height="37px"  id="smartdns_detail_table">
							<tr width="235px">
								<td colspan="4" cellpadding="0" cellspacing="0" style="padding:0" border="1" bordercolor="#000">
									<input id="show-btn1" class="show-btn1" style="cursor:pointer"   type="button" value="基本设置" />
									<input id="show-btn2" class="show-btn2"  style="cursor:pointer"    type="button" value="DNS设置" />
									<input id="show-btn3" class="show-btn3"  style="cursor:pointer"    type="button" value="其它设置" />
								</td>
							</tr>
						</table>
					  </div>
					  <table id="smartdns_detail_table1"  style="margin:-1px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable"   >
						  <tr id="smartdns_status">
                            <th>运行状态</th>
                            <td><span id="status">检测运行状态中 - Waiting..</span></td>
                          </tr>
                          <tr id="smartdns_dns_port_tr" >
                            <th>DNS端口</th>
                            <td>
                                <input type="text" class="input_smartdns_table" style="width:auto;" size="30" id="smartdns_dns_port" name="smartdns_dns_port" maxlength="" value="<% dbus_get_def("smartdns_dns_port", "253"); %>" >
                                <small>&nbsp;&nbsp;默认: 253 </small>
                            </td>
                          </tr>
                          <tr id="smartdns_server_1_tr" >
                            <th>DNS服务器1</th>
                            <td>
                                <input type="text" class="input_smartdns_table" style="width:auto;" size="30" id="smartdns_server_1" name="smartdns_server_1" maxlength="" value="<% dbus_get_def("smartdns_server_1", "https://223.6.6.6/dns-query"); %>" >
                                <small>&nbsp;&nbsp;默认: https://223.6.6.6/dns-query </small>
                            </td>
                          </tr>
                          <tr id="smartdns_server_2_tr" >
                            <th>DNS服务器2</th>
                            <td>
                                <input type="text" class="input_smartdns_table" style="width:auto;" size="30" id="smartdns_server_2" name="smartdns_server_2" maxlength="" value="<% dbus_get_def("smartdns_server_2", ""); %>" >
                                <small>&nbsp;&nbsp;可不填写</small>
                            </td>
                          </tr>
						<tr  id="smartdns_user_conf_tr"  >
							<th width="35%">
								使用自定义配置&nbsp;&nbsp;<a href="javascript:void(0);"</a>
							</th>
							<td>
								<input type="checkbox" id="smartdns_user_conf_checkbox" onclick="confswitch();">
							</td>
						</tr>
						<tr id="smartdns_user_conf_txt" style="display: none;">
							<th width="20%"><a >自定义配置</a></th>
								<td>
									<textarea placeholder="# 填入自定义设置" rows="12" style="width:99%; font-family:'Lucida Console'; font-size:12px;background:#475A5F;color:#FFFFFF;" id="smartdns_config_show" name="smartdns_config_show" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" title=""></textarea><br>
								</td>
						</tr>

                          <tr id="smartdns_bin_update_tr">
                                                    <th>程序更新</th>
                                                    <td>
                                                        <a type="button" id="smartdns_binary_update" class="smartdns_btn" style="cursor:pointer" onclick="smartdns_binary_update()" >更新程序</a>
						    							<a class="smartdns_btn_update">自动更新</a>
 						    							<a><select id="smartdns_bin_auto_update" name="smartdns_bin_auto_update" class="input_option"  >  <option value="0">否</option>  <option value="1">是</option> </select></a>
						    					   </td>
                         </tr>
					  </table>
					  <table  id="smartdns_detail_table2"  style="display:none;margin:-1px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable"   >
                          <tr id="smartdns_dnsmasq_set_tr"  >
                            <th>选项</th>
                            <td>
                                <select   id="smartdns_dnsmasq_set" name="smartdns_dnsmasq_set" class="input_option"  >
       								<option value="0">【0】关闭</option>
									<option value="1">【1】ipv4-将dnsmasq的server地址设为smartdns监听地址</option>
									<option value="2">【2】ipv4-将dnsmasq的server地址设为smartdns监听地址并禁用dnsmasq缓存</option>
									<option value="3">【3】ipv4-劫持53端口至smartdns监听地址</option>
									<option value="4">【4】ipv4,6-将dnsmasq的server地址设为smartdns监听地址</option>
									<option value="5">【5】ipv4,6-将dnsmasq的server地址设为smartdns监听地址并禁用dnsmasq缓存</option>
								</select>
                            </td>
                          </tr>
					  </table>
					  <table  id="smartdns_detail_table3"  style="display:none;margin:-1px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable"   >
                          <tr id="smartdns_perp_set_tr"  >
                            <th>守护进程</th>
                            <td>
                                <select   id="smartdns_perp_set" name="smartdns_perp_set" class="input_option"  >
       								<option value="0">关闭</option>
									<option value="1">每分钟</option>
									<option value="2">每10分钟</option>
									<option value="3">每30分钟</option>
									<option value="4">每1小时</option>
								</select>
                            </td>
                          </tr>
                          <tr id="smartdns_upx_set_tr"  >
                            <th>UPX压缩</th>
                            <td>
                                <select   id="smartdns_upx_set" name="smartdns_upx_set" class="input_option"  >
       								<option value="0">关闭</option>
									<option value="1">开启</option>
								</select>
                            </td>
                          </tr>
                          <tr id="smartdns_shadowsocks_patch_set_tr"  >
                            <th>科学上网中国DNS自定义端口补丁</th>
                            <td>
                                <select   id="smartdns_shadowsocks_patch_set" name="smartdns_shadowsocks_patch_set" class="input_option"  >
       								<option value="0">关闭</option>
									<option value="1">开启</option>
								</select>
                            </td>
                          </tr>
					  </table>
					  <div id="warnnote1">
						  <div id="smartdns_note1"class="SimpleNote">
							  <i><li>DNS端口仅支持非53端口，默认［253］。</li></i>
							  <i><li>设置自动更新后会定时在05:00自动更新smartdns程序。</li></li>
						  </div>
					  </div>
					  <div id="warnnote2" style="display: none;">
						  <div id="smartdns_note2" class="SimpleNote" >
							  <i><li>与科学上网的DNS冲突。使用科学上网请勿同时开启此选项。可在其它设置里开启科学上网（4.2.2）中国DNS自定义端口补丁。中国DNS自定义设置为smartdns监听地址，例如192.168.1.1#153</li></li>
							  <i><li>选项【1】仅设置ipv4，将dnsmasq的server地址设为smartdns监听地址。</li></li>
							  <i><li>选项【2】仅设置ipv4，将dnsmasq的server地址设为smartdns监听地址并禁用dnsmasq缓存。</li></li>
							  <i><li>选项【3】仅设置ipv4，将劫持53端口至smartdns监听地址。</li></li>
						  	  <i><li>选项【4】设置ipv4和ipv6，将dnsmasq的server地址设为smartdns监听地址。</li></li>
						  	  <i><li>选项【5】设置ipv4和ipv6，将dnsmasq的server地址设为smartdns监听地址并禁用dnsmasq缓存。</li></li>
						  </div>
					  </div>
					  <div id="warnnote3" style="display: none;">
						  <div id="smartdns_note3" class="SimpleNote" >
							  <i><li>开启守护进程后根据设置时间检测cron任务以及软件中心守护进程状态，防止cron任务丢失以及因软件中心挂掉导致smartdns程序无法启动。</li></li>
							  <i><li>开启UPX压缩后，更新程序时会用UPX压缩smartdns程序。</li></li>
							  <i><li>开启科学上网中国DNS自定义端口补丁后，科学上网(4.2.2)中国DNS支持自定义端口。例如192.168.1.1#153。若同时使用AdGuardHome，也需要同时开启AdGuardHome补丁。</li></li>
						  </div>
					  </div>
					</div>
                    <div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
                    <div class="apply_gen">
                      <button id="cmdBtn" class="button_gen" onclick="onSubmitCtrl(this, ' Refresh ')">保存&应用</button>
                    </div>
                  </td>
                </tr>
              </table>
            </td>
            <td width="10" align="center" valign="top"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </form>
  </td>
  <div id="footer"></div>
</body>
</html>
