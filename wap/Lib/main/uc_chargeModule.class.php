<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class uc_chargeModule extends MainBaseModule
{

	public function index()
	{
		global_run();		
		init_app_page();

		
		$param=array();	
		$data = call_api_core("uc_charge","index",$param);
		
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}
		
		$GLOBALS['tmpl']->assign("data",$data);	
		$GLOBALS['tmpl']->display("uc_charge.html");
	}
	
	public function done()
	{
		global_run();
		init_app_page();		
		$param=array();	
		$param['money'] = floatval($_REQUEST['money']);	
		$param['payment_id'] = intval($_REQUEST['payment_id']);	
		$data = call_api_core("uc_charge","done",$param);
		$ajaxobj['is_app'] = $data['is_app'];
		if($data['status']==-1)
		{
			$ajaxobj['status'] = 1;
			$ajaxobj['jump'] = wap_url("index","user#login");
			ajax_return($ajaxobj);
		}
		elseif($data['status']==1)
		{
			$ajaxobj['status'] = 1;
			$ajaxobj['jump'] = $data['payment_code']['pay_action'];
			ajax_return($ajaxobj);
		}
		elseif($data['status']==2) //sdk
		{
			$ajaxobj['status'] = 2;
			$ajaxobj['sdk_code'] = $data['sdk_code'];
			ajax_return($ajaxobj);
		}
		else
		{
			$ajaxobj['status'] = $data['status'];
			$ajaxobj['info'] = $data['info'];
			ajax_return($ajaxobj);
		}
	}


}
?>