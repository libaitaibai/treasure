<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------


class uc_chargeApiModule extends MainBaseApiModule
{
	
	/**
	 * 	 会员中心充值页面接口
	 * 
	 * 	  输入：
	 *  
	 *  
	 *  输出：
	 * user_login_status:int   0表示未登录   1表示已登录  2表示临时登录
	 * login_info:string 未登录状态的提示信息，已登录时无此项
	 * page_title:string 页面标题

	 */
	public function index()
	{
		$root = array();		
			
		$user_data = $GLOBALS['user_info'];		
		$user_id = intval($user_data['id']);
		
		
		$user_login_status = check_login();
		if($user_login_status!=LOGIN_STATUS_LOGINED){			
			$root['user_login_status'] = $user_login_status;	
		}else{
			$root['user_login_status'] = 1;
			    //输出支付方式
			
			//输出支付方式
			global $is_app;
			if (!$is_app)
			{
				//支付列表
				$sql = "select id, class_name as code, logo from ".DB_PREFIX."payment where (online_pay = 2 or online_pay = 4 or online_pay = 6 or online_pay = 7) and is_effect = 1";
				
			}
			else
			{
				//支付列表
				$sql = "select id, class_name as code, logo from ".DB_PREFIX."payment where (online_pay = 3 or online_pay = 4 or online_pay = 6) and is_effect = 1";
			}
			if(allow_show_api())
			{
				$payment_list = $GLOBALS['db']->getAll($sql);
			}
			//输出支付方式
	        foreach($payment_list as $k=>$v)
	        {
	                $directory = APP_ROOT_PATH."system/payment/";
	                $file = $directory. '/' .$v['code']."_payment.php";
	                if(file_exists($file))
	                {
	                        require_once($file);
	                        $payment_class = $v['code']."_payment";
	                        $payment_object = new $payment_class();
	                        $payment_list[$k]['name'] = $payment_object->get_display_code();
	                }
	
	                if($v['logo']!="")
	                $payment_list[$k]['logo'] = get_abs_img_root(get_spec_image($v['logo'],40,40,1));
	        }
			
	        sort($payment_list);


			$root['payment_list']=$payment_list?$payment_list:array();

			

			$root['page_title'].="会员充值";
		}	
		return output($root);	

	}


	/**
	 * 	 会员中心充值操作接口
	 * 
	 * 	  输入：
	 *  payment_id:int 支付方式id
	 *  money: float  支付金额
	 *  
	 *  输出：
	 * user_login_status:int   0表示未登录   1表示已登录  2表示临时登录
	 * login_info:string 未登录状态的提示信息，已登录时无此项
	 * page_title:string 页面标题

	 */	
	public function done()
	{
		$root = array();		
			
		$user_data = $GLOBALS['user_info'];		
		$user_id = intval($user_data['id']);
		$payment_id = intval($GLOBALS['request']['payment_id']);
		$money = floatval($GLOBALS['request']['money']);
		
		$user_login_status = check_login();
		if($user_login_status!=LOGIN_STATUS_LOGINED){			
			$root['user_login_status'] = $user_login_status;	
		}else{
			$root['user_login_status'] = 1;

			if($money<=0)
			{
				return output("",0,"请输入正确的金额");
			}
			
			$payment_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."payment where id = ".$payment_id);
			if(!$payment_info)
			{
				return output("",0,"支付方式不存在");
			}


			
			//开始生成订单
			$now = NOW_TIME;
			$order['type'] = 1; //充值单
			$order['user_id'] = $GLOBALS['user_info']['id'];
			$order['create_time'] = $now;
			$order['update_time'] = $now;
			$order['total_price'] = $money;
			$order['deal_total_price'] = $money;
			$order['pay_amount'] = 0;  
			$order['pay_status'] = 0;  
			$order['delivery_status'] = 5;  
			$order['order_status'] = 0; 
			$order['payment_id'] = $payment_id;			
		
			do
			{
				$order['order_sn'] = to_date(get_gmtime(),"Ymdhis").rand(100,999);
				$GLOBALS['db']->autoExecute(DB_PREFIX."deal_order",$order,'INSERT','','SILENT'); 
				$order_id = intval($GLOBALS['db']->insert_id());
			}while($order_id==0);
			
			require_once APP_ROOT_PATH."system/model/cart.php";
			$payment_notice_id = make_payment_notice($order['total_price'],'',$order_id,$payment_info['id']);
			//创建支付接口的付款单
		
			$rs = order_paid($order_id);  
			if($rs)
			{
					$root['pay_status'] = 1;
					$root['order_id'] = $order_id;
			}
			else
			{
				if($payment_info['online_pay']==3) //sdk在线支付
				{
					require_once APP_ROOT_PATH."system/payment/".$payment_info['class_name']."_payment.php";
					$payment_class = $payment_info['class_name']."_payment";
					$payment_object = new $payment_class();
					$payment_code = $payment_object->get_payment_code($payment_notice_id);
					$root['pay_status'] = 0;
					$root['order_id'] = $order_id;
					$root['sdk_code'] = $payment_code['sdk_code'];
					return output($root,2); //sdk支付
				}
				else
				{
				
					require_once APP_ROOT_PATH."system/payment/".$payment_info['class_name']."_payment.php";
					$payment_class = $payment_info['class_name']."_payment";
					$payment_object = new $payment_class();
					$payment_code = $payment_object->get_payment_code($payment_notice_id);			
					
					$root['pay_status'] = 0;
					$root['payment_code'] = $payment_code;
								
					$root['page_title'].="充值中……";	
					$root['order_id'] = $order_id;	
				}
			}
	
			
			

		}	
		$root ['is_app'] = intval ( $GLOBALS ['is_app'] );
		return output($root);	

	}
	
	
}
?>