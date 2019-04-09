<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class uc_duobao_recordModule extends MainBaseModule
{

	public function index()
	{
		global_run();
		init_app_page();

		$log_type = $param['log_type'] = intval($_REQUEST['log_type']);
		$param['page']  = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
		
		
		$data = call_api_core("uc_duobao_record","index", $param);
		
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}		

		if(isset($data['page']) && is_array($data['page'])){
			$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
			$p  =  $page->show();
			$GLOBALS['tmpl']->assign('pages',$p);
		}
	 
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->assign("list",$data['list']);
		$GLOBALS['tmpl']->assign("log_type",$log_type);
		$GLOBALS['tmpl']->display("uc_duobao_record_index.html");
	}

	public function my_no(){
		global_run();
		init_app_page();
		
		$param['id'] = intval($_REQUEST['id']);
		$data = call_api_core("uc_duobao_record","my_no", $param);
		
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}
				
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->assign("list",$data['list']);		
		
		$GLOBALS['tmpl']->display("uc_duobao_record_my_no.html");
	}

	public function my_no_all(){
		
		global_run();
		init_app_page();
		
		$param['id'] = intval($_REQUEST['id']);
		$data = call_api_core("uc_duobao_record","my_no_all", $param);
		
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
			app_redirect(wap_url("index","user#login"));
		}
		
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->assign("list",$data['list']);
		
		$GLOBALS['tmpl']->display("uc_duobao_record_my_no_all.html");
	}


}
?>
