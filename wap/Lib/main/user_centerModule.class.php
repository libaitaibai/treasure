<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class user_centerModule extends MainBaseModule
{

	public function index()
	{
	    global_run();
		init_app_page();

		$param=array();
		$data = call_api_core("user_center","index",$param);
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}

		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->display("user_center.html");
	}
	
	public function qrcode(){
	    global_run();
	    init_app_page();
	    $data['page_title'] ="渠道二维码";
	    $data['user_id'] = intval($_REQUEST['data_id']);
	    
	    $user_id = $data['user_id'];
	    include_once APP_ROOT_PATH."system/model/weixin_jssdk.php";
	    $img_url = getQrCode($user_id);
	    
	    $share_url = $img_url;
	    $GLOBALS['tmpl']->assign("wx_share_url", $share_url);
	    $GLOBALS['tmpl']->assign("img_url",$img_url);
	    $GLOBALS['tmpl']->assign("data",$data);
        $GLOBALS['tmpl']->display("qrcode.html");
	}
	
	 
	
	


}
?>
