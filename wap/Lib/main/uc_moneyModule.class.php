<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------


class uc_moneyModule extends MainBaseModule
{
        /**
         * 资金记录
         */
        public function index(){
            global_run();
            init_app_page();
            $param['page'] = intval($_REQUEST['page']);
			$data = call_api_core("uc_money","index",$param);
			if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
				app_redirect(wap_url("index","user#login"));
			}
	  		if(isset($data['page']) && is_array($data['page'])){
				$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
				$p  =  $page->show();
				$GLOBALS['tmpl']->assign('pages',$p);
			}


			$GLOBALS['tmpl']->assign("data",$data);

            $GLOBALS['tmpl']->display("uc_money_index.html");
        }



		  public function setting(){
			     global_run();
			     init_app_page();
				$param=array();

				$data = call_api_core("uc_money","setting",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}


		      $GLOBALS['tmpl']->assign("data",$data);
		      $GLOBALS['tmpl']->display("uc_money_setting.html");
		  }

		  public function withdraw_bank_list(){
			    global_run();
			    init_app_page();
				$param=array();

				$data = call_api_core("uc_money","withdraw_bank_list",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}


		   		$GLOBALS['tmpl']->assign("data",$data);
			    $GLOBALS['tmpl']->display("uc_money_withdraw.html");
		  }

		  public function add_card(){
			    global_run();
			    init_app_page();
				$param=array();

				$data = call_api_core("uc_money","add_card",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
				$data['step']=2;
				$data['page_title']="添加提现账户";
				$GLOBALS['tmpl']->assign("data",$data);
				$GLOBALS['tmpl']->assign("sms_lesstime",load_sms_lesstime());
			    $GLOBALS['tmpl']->display("uc_money_withdraw.html");
		  }

		 public function do_bind_bank(){
			    global_run();
				$param=array();
                $param['bank_name'] = strim($_REQUEST['bank_name']);
                $param['bank_account']= strim($_REQUEST['bank_account']);
                $param['bank_user'] = strim($_REQUEST['bank_user']);
                $param['sms_verify'] = strim($_REQUEST['sms_verify']);
				$data = call_api_core("uc_money","do_bind_bank",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
		 		if($data['status']==1){
					$result['status'] = 1;
					$result['url'] = wap_url("index","uc_money#withdraw_bank_list");
					ajax_return($result);
				}else{
					$result['status'] =0;
					$result['info'] =$data['info'];
					ajax_return($result);
				}
		 }

		 public function do_withdraw(){
		 		global_run();
				$param=array();
                $param['bank_id'] = intval($_REQUEST['bank_id']);
                $param['money']= floatval($_REQUEST['money']);
                $param['pwd_check'] = strim($_REQUEST['pwd']);
				$data = call_api_core("uc_money","do_withdraw",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
		 		if($data['status']==1){
					$result['status'] = 1;
					$result['url'] = wap_url("index","uc_money#withdraw_log");
					ajax_return($result);
				}else{
					$result['status'] =0;
					$result['info'] =$data['info'];
					ajax_return($result);
				}
		 }
		 public function withdraw_log(){
		 		global_run();
		 		init_app_page();
				$param=array();
				$param['page'] = intval($_REQUEST['page']);
				$data = call_api_core("uc_money","withdraw_log",$param);
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
		 		if(isset($data['page']) && is_array($data['page'])){
					$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
					$p  =  $page->show();

					$GLOBALS['tmpl']->assign('pages',$p);
				}
				$GLOBALS['tmpl']->assign("data",$data);
				$GLOBALS['tmpl']->display("uc_withdraw_log.html");
		 }
}
?>
