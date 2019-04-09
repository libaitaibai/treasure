<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------


require_once APP_ROOT_PATH.'system/model/user.php';
class uc_money_cashModule extends MainBaseModule
{
	
	/**
	 * 提现
	 */
	public function withdraw()
	{
		global_run();
		if(check_save_login()!=LOGIN_STATUS_LOGINED)
		{
			app_redirect(url("index","user#login"));
		}
		init_app_page();
		$user_info = $GLOBALS['user_info'];
		//取出等级信息
		$level_data = load_auto_cache("cache_user_level");
		$cur_level = $level_data[$user_info['level_id']];
		 
		//游标移动获取下一个等级
		reset($level_data);
		do{
			$current_data = current($level_data);
			 
			if($current_data['id']==$cur_level['id'])
			{
			  
				$next_data = next($level_data);
				break;
			}
		}while(next($level_data));
		$uc_query_data = array();
		$uc_query_data['cur_level'] = $cur_level['level']; //当前等级
		$uc_query_data['cur_point'] = $user_info['point'];
		$uc_query_data['cur_level_name'] = $cur_level['name'];
		if($next_data){
			$uc_query_data['next_level'] = $next_data['id'];
			$uc_query_data['next_point'] =$next_data['point'] - $user_info['point']; //我再增加：100 经验值，就可以升级为：青铜五
			$uc_query_data['next_level_name'] = $next_data['name'];
		}
		 
		 
		$uc_query_data['cur_score'] = $user_info['score'];

		$uc_query_data['cur_gourp'] = $cur_group['id'];
		$uc_query_data['cur_gourp_name'] = $cur_group['name'];
		$uc_query_data['cur_discount'] = floatval(sprintf('%.2f', $cur_group['discount']*10));
		
		//可提现余额
		$user_money = $GLOBALS['db']->getOne("select money from ".DB_PREFIX."user where id = ".$user_info['id']);
		$withdraw_money = $GLOBALS['db']->getOne("select sum(money) from ".DB_PREFIX."withdraw where is_delete = 0 and is_paid = 0 and user_id = ".$user_info['id']);
		$money = round(($user_money-$withdraw_money),2);
		
		$GLOBALS['tmpl']->assign("uc_query_data",$uc_query_data);
		$GLOBALS['tmpl']->assign("money",$money);
		
		$GLOBALS['tmpl']->assign("sms_lesstime",load_sms_lesstime());
		$GLOBALS['tmpl']->assign("sms_ipcount",load_sms_ipcount());
		
                
		//取出已绑定的银行卡
		$user_bank_list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."user_bank where user_id = ".$user_info['id']);
                $f_bank_list = array();

                if($user_bank_list){
                    foreach ($user_bank_list as $k=>$v){
                        $tmp_bank_name = strripos($v['bank_name'], "银行")?substr($v['bank_name'],  0,strripos($v['bank_name'], "银行")+6):$v['bank_name'];
                        $user_bank_list[$k]['show_bank_name'] = $tmp_bank_name." （...".  substr($v['bank_account'], -4)."）";
                        $user_bank_list[$k]['bank_account'] = substr($v['bank_account'], 0,4)."****".substr($v['bank_account'], -4);
                    }
                }
                $GLOBALS['tmpl']->assign("user_bank_list",$user_bank_list);
                //用户真实名称
                $GLOBALS['tmpl']->assign("real_name",$user_info['real_name']);
                
                
		require_once APP_ROOT_PATH."system/model/user_center.php";
		require_once APP_ROOT_PATH."app/Lib/page.php";
		//输出充值订单
		$page = intval($_REQUEST['p']);
		if($page==0)
			$page = 1;
		$limit = (($page-1)*app_conf("PAGE_SIZE")).",".app_conf("PAGE_SIZE");
		
		$result = get_user_withdraw($limit,$GLOBALS['user_info']['id']);
		
		$GLOBALS['tmpl']->assign("list",$result['list']);
		$page = new Page($result['count'],app_conf("PAGE_SIZE"));   //初始化分页对象
		$p  =  $page->show();
		$GLOBALS['tmpl']->assign('pages',$p);
		
		//通用模版参数定义
		assign_uc_nav_list();//左侧导航菜单
		$GLOBALS['tmpl']->assign("no_nav",true); //无分类下拉
		$GLOBALS['tmpl']->assign("page_title","会员提现"); //title
		$GLOBALS['tmpl']->display("uc/uc_money_cash_withdraw.html"); //title
	} 
	
	public function del_withdraw()
	{
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
	
	
	public function withdraw_done()
	{
		global_run();
		if(check_save_login()!=LOGIN_STATUS_LOGINED)
		{
			$data['status'] = 1000;
			ajax_return($data);
		}
		
		$is_bind = intval($_REQUEST['is_bind']);
		$money = floatval($_REQUEST['money']);
		$mobile = $GLOBALS['user_info']['mobile'];
        $user_bank_id = intval($_REQUEST['user_bank_id']);
		
		$sms_verify = strim($_REQUEST['sms_verify']);
 
                if($user_bank_id){//数据库中查询银行信息
                    $bank_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user_bank where id=".$user_bank_id." and user_id =".$GLOBALS['user_info']['id']);
                    if($bank_info){
                        $bank_name = $bank_info['bank_name'];
                        $bank_account = $bank_info['bank_account'];;
                        $bank_user = $bank_info['bank_user'];
                    }else{
                        $data['status'] = 0;
                        $data['info'] = "银行数据错误，请选择其他银行或新卡提现";
                        ajax_return($data);
                    }
                    
                }else{//表单数据
                    $bank_name = strim($_REQUEST['bank_name']);
                    $bank_account = strim($_REQUEST['bank_account']);
                    $bank_user = strim($_REQUEST['bank_user']);
                    
                    if($bank_name=="")
                    {
                            $data['status'] = 0;
                            $data['info'] = "请输入开户行全称";
                            ajax_return($data);
                    }
                    if($bank_account=="")
                    {
                            $data['status'] = 0;
                            $data['info'] = "请输入开户行账号";
                            ajax_return($data);
                    }
                    if($bank_user=="")
                    {
                            $data['status'] = 0;
                            $data['info'] = "请输入开户人真实姓名";
                            ajax_return($data);
                    }
                }
		
		if($money<=0)
		{
			$data['status'] = 0;
			$data['info'] = "请输入正确的提现金额";
			ajax_return($data);
		}
		
		if(app_conf("SMS_ON")==1)
		{
			if($mobile=="")
			{
				$data['status'] = 0;
				$data['info'] = "请先完善会员的手机号码";
				$data['jump'] = url("index","uc_account");
				ajax_return($data);
			}
			
			
			
		
			if($sms_verify=="")
			{
				$data['status'] = 0;
				$data['info']	=	"请输入收到的验证码";
				ajax_return($data);
			}
		
			//短信码验证
			$sql = "DELETE FROM ".DB_PREFIX."sms_mobile_verify WHERE add_time <=".(NOW_TIME-SMS_EXPIRESPAN);
			$GLOBALS['db']->query($sql);
		
			$mobile_data = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."sms_mobile_verify where mobile_phone = '".$mobile."'");
		
			if($mobile_data['code']!=$sms_verify)
			{
				$data['status'] = 1;
				$data['info']	=  "验证码错误";
				ajax_return($data);
			}
		
			
		}
		
		$submitted_money = floatval($GLOBALS['db']->getOne("select sum(money) from ".DB_PREFIX."withdraw where user_id = ".$GLOBALS['user_info']['id']." and is_delete = 0 and is_paid = 0"));
		if($submitted_money+$money>$GLOBALS['user_info']['money'])
		{
			$data['status'] = 0;
			$data['info'] = "提现超额";
			ajax_return($data);
		}
		
		$withdraw_data = array();
		$withdraw_data['user_id'] = $GLOBALS['user_info']['id'];
		$withdraw_data['money'] = $money;
		$withdraw_data['create_time'] = NOW_TIME;
		$withdraw_data['bank_name'] = $bank_name;
		$withdraw_data['bank_account'] = $bank_account;
		$withdraw_data['bank_user'] = $bank_user;
                $withdraw_data['is_bind'] = $is_bind;
                $withdraw_data['bank_mobile'] = $mobile;
		$GLOBALS['db']->autoExecute(DB_PREFIX."withdraw",$withdraw_data);
		
		if($is_bind == 1){
		    $user_bank = array();
		    $user_bank['user_id'] = $GLOBALS['user_info']['id'];
		    $user_bank['bank_name'] = strim($_REQUEST['bank_name']);
		    $user_bank['bank_account'] = $bank_account;
		    $user_bank['bank_user'] = strim($_REQUEST['bank_user']);
		    $user_bank['bank_mobile'] = $mobile;
		    $GLOBALS['db']->autoExecute(DB_PREFIX."user_bank",$user_bank);
		}
		
		$GLOBALS['db']->query("delete from ".DB_PREFIX."sms_mobile_verify where mobile_phone = '".$mobile."'");
		$data['status'] = 1;
		$data['info'] = "提现申请提交成功，请等待审核";
		ajax_return($data);
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