<?php
//000000003600s:6423:"<?php exit;?>a:3:{s:8:"template";a:4:{i:0;s:51:"/www/wwwroot/gou.bs3062.top/wap/Tpl/main/helps.html";i:1;s:67:"/www/wwwroot/gou.bs3062.top/wap/Tpl/main/inc/header_title_home.html";i:2;s:58:"/www/wwwroot/gou.bs3062.top/wap/Tpl/main/inc/wx_share.html";i:3;s:62:"/www/wwwroot/gou.bs3062.top/wap/Tpl/main/inc/footer_index.html";}s:7:"expires";i:1551203087;s:8:"maketime";i:1551199487;}<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- Mobile Devices Support @begin -->
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="false" name="twcClient" id="twcClient">
<meta name="wap-font-scale" content="no">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<!--允许全屏模式-->
<meta content="yes" name="apple-mobile-web-app-capable" />
<!--指定sari的样式-->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta content="telephone=no" name="format-detection" />
<!-- Mobile Devices Support @end -->
<title>帮助</title>
<script type="text/javascript">
	var APP_ROOT = '';
	var LOADER_IMG = 'http://gou.bs3062.top/wap/Tpl/main/images/loader_img.gif';
	var LOADING_IMG = 'http://gou.bs3062.top/wap/Tpl/main/images/loading.gif';
	var AJAX_URL = '/wap/index.php?ctl=ajax&show_prog=1';
	var PAGE_TYPE = '';
	var DOMAIN_URL = '/wap/index.php?show_prog=1';
</script>
<link rel="stylesheet" type="text/css" href="http://gou.bs3062.top/public/runtime/statics/wap/4a1a4a74e36962a4b06e8930e5eea528.css?v=2.0.2800" />
<script type="text/javascript" src="http://gou.bs3062.top/public/runtime/statics/wap/429e1e4c21d5faaf6afa49f49bfb0433.js?v=2.0.2800"></script>
<script>
/*app 请求时候用到*/
$(function(){
	
	//后退
	$('#header_back_btn').click(function(){
		var Expression=/http(s)?:\/\/?/;
		var objExp=new RegExp(Expression);
		var backurl = $(this).attr('backurl');
		$(this).attr('backurl','-1');
		if(objExp.test(backurl)==true){
			location.href = backurl;
		}else{
			window.history.go(-1);
		}
	});
    function share_compleate(share_key){
        $.showSuccess("分享成功");
    }
    var share_data={};
    var share_title=$(".good-countdown > p").html();
    var share_imageUrl=$(".content").find("img").attr("src")
    share_data["share_content"]=window.location.href;
    share_data["share_url"]=window.location.href;
    share_data["key"]='';
    share_data['sina_app_api']=1;
    share_data['qq_app_api']=1;
    share_data["share_imageUrl"]=share_imageUrl?share_imageUrl:"/yydb/wap/Tpl/main/images/default_logo.png";
    share_data['share_title'] = share_title?share_title:"快快加入一元夺宝";
    share_data=JSON.stringify(share_data);
    $("#fenxiang").click(function(){
        try{
            App.sdk_share(share_data);
        }catch(e){
            $.showErr(e);
        }
    });
});
</script>
<script type="text/javascript">
	//减少移动端触发"Click"事件时300毫秒的时间差
window.addEventListener('load', function() {
    FastClick.attach(document.body);
}, false);
</script>
</head>
<body>
<div class="header">
	<div class="header-wrap">
	<div class="c-hd split-line">
        <section class="cut_city">
              <a id="header_back_btn" backurl='-1'><i class="iconfont">&#xe701;</i></a>
	    </section>
        <section class="logo_img">帮助</section>
        <section style="width:2rem !important;" class="cut_city hd-right">
                      <a id="hd-drop" href="javascript:void(0)"><i class="iconfont home">&#xe657;</i></a>
        </section>
        <div class="hd-drop-mask"></div>
        <ul class="hd-drop">
        	<li>
        		<a class="flex-box split-line" href="/wap/index.php?show_prog=1">
        			<i class="iconfont">&#xe6ee;</i>
        			<p>返回首页</p>
        		</a>
        	</li>
            <li>
                <a class="flex-box split-line" href="/wap/index.php?ctl=user_center&show_prog=1">
                <i class="iconfont">&#xe6f1;</i>
                <p>用户中心</p>
                </a>
            </li>
        	<li>
        		<a class="flex-box split-line" href="/wap/index.php?ctl=uc_duobao_record&show_prog=1">
        			<i class="iconfont">&#xe6ff;</i>
        			<p>夺宝记录</p>
        		</a>
        	</li>
                    </ul>
     </div>
	 </div>
</div>
<script>
	$("#hd-drop").bind('click', function() {
		$(".hd-drop").toggleClass('active');
		$(".hd-drop-mask").toggleClass('active');
	});
	$(".hd-drop-mask").bind('click', function() {
		$(".hd-drop").removeClass('active');
		$(".hd-drop-mask").removeClass('active');
	});
</script>
<script type="text/javascript">
	
</script>
<div class="wrap">
	<div class="content">
		<ul class="list">
						<li>
				<header>新手指南</header>
				<section>
					<ul>
					 							<li><a href="/wap/index.php?ctl=helps&act=show&data_id=52&show_prog=1">了解一元夺宝<i class="iconfont">&#xe6fa;</i></a></li>
												<li><a href="/wap/index.php?ctl=helps&act=show&data_id=53&show_prog=1">一元夺宝平台服务协议<i class="iconfont">&#xe6fa;</i></a></li>
												<li><a href="/wap/index.php?ctl=helps&act=show&data_id=54&show_prog=1">常见问题<i class="iconfont">&#xe6fa;</i></a></li>
											</ul>
				</section>
			</li>
						<li>
				<header>夺宝保障</header>
				<section>
					<ul>
					 							<li><a href="/wap/index.php?ctl=helps&act=show&data_id=55&show_prog=1">公平保障<i class="iconfont">&#xe6fa;</i></a></li>
												<li><a href="/wap/index.php?ctl=helps&act=show&data_id=58&show_prog=1">公正保障<i class="iconfont">&#xe6fa;</i></a></li>
											</ul>
				</section>
			</li>
						<li>
				<header>商品配送</header>
				<section>
					<ul>
					 							<li><a href="/wap/index.php?ctl=helps&act=show&data_id=56&show_prog=1">商品配送<i class="iconfont">&#xe6fa;</i></a></li>
												<li><a href="/wap/index.php?ctl=helps&act=show&data_id=57&show_prog=1">配送费用<i class="iconfont">&#xe6fa;</i></a></li>
											</ul>
				</section>
			</li>
					</ul>
	</div>
</div>
           <div class="gotop" data-com="gotop">
				<a href="#">
					<i class="iconfont"></i>
				</a>
			</div>
						
	</body>
<html>
";
?>