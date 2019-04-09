<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------


class uc_money_cashModule extends MainBaseModule
{
        /**
         * 资金记录
         */
        public function index(){
            global_run();
            init_app_page();
            $param['page'] = intval($_REQUEST['page']);			
			$data = call_api_core("uc_money_cash","index",$param);	
				
			if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
				app_redirect(wap_url("index","user#login"));
			}	
	  		if(isset($data['page']) && is_array($data['page'])){			
				$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象			
				$p  =  $page->show();					
				$GLOBALS['tmpl']->assign('pages',$p);
			}				
		

			$GLOBALS['tmpl']->assign("data",$data);
            
            $GLOBALS['tmpl']->display("uc_money_cash.html");
        }

			
		
		  public function withdraw_bank_list(){
			    global_run();
			    init_app_page();
				$param=array();

				$data = call_api_core("uc_money_cash","withdraw_bank_list",$param);				
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

				$data = call_api_core("uc_money_cash","add_card",$param);				
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
				$data['step']=2;
				$data['page_title']="添加提现账户";
				$GLOBALS['tmpl']->assign("sms_lesstime",load_sms_lesstime());
				$GLOBALS['tmpl']->assign("data",$data);		      
			    $GLOBALS['tmpl']->display("uc_money_withdraw.html");
		  }		  

		 public function do_bind_bank(){
			    global_run();
				$param=array();
                $param['bank_name'] = strim($_REQUEST['bank_name']);
                $param['bank_account']= strim($_REQUEST['bank_account']);
                $param['bank_user'] = strim($_REQUEST['bank_user']);
                $param['sms_verify'] = strim($_REQUEST['sms_verify']);
				$data = call_api_core("uc_money_cash","do_bind_bank",$param);				
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
		 		if($data['status']==1){
					$result['status'] = 1;
					$result['url'] = wap_url("index","uc_money_cash#withdraw_bank_list");
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
                $param['user_bank_id'] = intval($_REQUEST['bank_id']);
                $param['money']= floatval($_REQUEST['money']);
                $param['check_pwd'] = strim($_REQUEST['pwd']);
   
				$data = call_api_core("uc_money_cash","do_withdraw",$param);				
				if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
					app_redirect(wap_url("index","user#login"));
				}
		 		if($data['status']==1){
					$result['status'] = 1;
					$result['url'] = wap_url("index","uc_money_cash#withdraw_log");
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
				$data = call_api_core("uc_money_cash","withdraw_log",$param);				
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
		 public function del_withdraw(){
		     global_run();
		     if(check_save_login()!=LOGIN_STATUS_LOGINED)
		     {
		         $data['status'] = 1000;
		         ajax_return($data);
		     }
		     else
		     {
		         $id = intval($_REQUEST['id']);
		         $order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."withdraw where id = ".$id." and is_delete = 0 and user_id = ".$GLOBALS['user_info']['id']);
		         if($order_info)
		         {
		             $GLOBALS['db']->query("update ".DB_PREFIX."withdraw set is_delete = 1 where is_delete = 0 and user_id = ".$GLOBALS['user_info']['id']." and id = ".$id);
		             if($GLOBALS['db']->affected_rows())
		             {
		                 $data['status'] = 1;
		                 $data['info'] = "删除成功";
		                 ajax_return($data);
		             }
		             else
		             {
		                 $data['status'] = 0;
		                 $data['info'] = "删除失败";
		                 ajax_return($data);
		             }
		         }
		         else
		         {
		             $data['status'] = 0;
		             $data['info'] = "提现单不存在";
		             ajax_return($data);
		         }
		     }
		 }
		 
		 public function del_user_bank(){
		     global_run();
		     $user_bank_id = intval($_REQUEST['user_bank_id']);
		     $GLOBALS['db']->query("delete from ".DB_PREFIX."user_bank where id = ".$user_bank_id." and user_id = ".$GLOBALS['user_info']['id']);
		 
		     if($GLOBALS['db']->affected_rows()){
		         $data['status'] = 1;
		         $data['info'] = "删除成功";
		     }else{
		         $data['status'] = 0;
		         $data['info'] = "删除失败";
		     }
		     ajax_return($data);
		 }
}
?>
