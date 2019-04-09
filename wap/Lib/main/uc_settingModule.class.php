<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class uc_settingModule extends MainBaseModule
{

	public function index()
	{
		global_run();
		init_app_page();

		$param=array();
		$data = call_api_core("uc_setting","index",$param);
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}

		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->display("uc_setting.html");
	}


}
?>
