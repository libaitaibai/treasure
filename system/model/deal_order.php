<?php 
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

/**
 * 与订单相关的函数库
 */


/**
 * 收货操作
 * @param unknown_type $delivery_sn
 * @param unknown_type $order_item_id 订单商品ID，将会确认相关的所有订单的同序号发货号。
 */
function confirm_delivery($delivery_sn,$order_item_id)
{
	$order_id = $GLOBALS['db']->getOne("select order_id from ".DB_PREFIX."deal_order_item where id = '".$order_item_id."'");
	$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where id = ".intval($order_id));
	if($order_info)
	{
		
		$delivery_notices = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."delivery_notice where order_id = ".$order_info['id']." and notice_sn = '".$delivery_sn."'");
		$order_item_ids = array(0);
		foreach($delivery_notices as $k=>$v)
		{
			$order_item_ids[] = $v['order_item_id'];
		}		
		$sql = "update ".DB_PREFIX."deal_order_item set is_arrival = 1 where is_arrival <> 1 and id in (".implode(",", $order_item_ids).")";
		$GLOBALS['db']->query($sql);		
		if($GLOBALS['db']->affected_rows())
		{
			//更新发货单表的对应状态
			$delivery_notice_sql = "update ".DB_PREFIX."delivery_notice set is_arrival = 1,arrival_time=".NOW_TIME." where order_id=".$order_id." and notice_sn='".$delivery_sn."'";
			$GLOBALS['db']->query($delivery_notice_sql);
			
			$log = $order_info['order_sn']."订单已收货";


			
			auto_over_status($order_info['id']); //检测自动结单

			send_wx_msg("OPENTM202314085", $order_info['user_id'], array(),array("order_item_id"=>$order_item_id));
			
			return true;
		}
	}
	return false;
}




/**
 * 自动结单检测，如通过则结单
 * 自动结单规则
 * 注：自动结单条件
 * type 0. 商品全部已收货
 * type 1,2 立即结单
 * 结单后的商品不可再发货，可删除
 * @param unknown_type $order_id
 * return array("status"=>bool,"info"=>str)
 */
function auto_over_status($order_id)
{	
	$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where id = ".$order_id);
	if($order_info)
	{
		if($order_info['pay_status']<>2)
		{
			return array("status"=>false,"info"=>"订单未支付");
		}
		if($order_info['order_status']<>0)
		{
			return array("status"=>false,"info"=>"订单已结单");
		}
		
		if($order_info['type'] == 0)
		{
			//全部未收货且未退款的数量为0
			$delivery_less = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."deal_order_item where  order_id = ".$order_id." and delivery_status <> 5 and is_arrival <> 1 and refund_status <> 2");		
			if($delivery_less==0)
			{
				over_order($order_id); 
			}
		}
		else
		{
			over_order($order_id); //充值单只要支付过就结单
		}	
		return array("status"=>true,"info"=>"结单成功");
	}
	else
	{
		return array("status"=>false,"info"=>"订单不存在");
	}
}

/**
 * 结单操作，即修改订单状态为2
 * @param unknown_type $order_id
 */
function over_order($order_id)
{	
	
	$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where order_status = 0 and id = ".$order_id);
	if($order_info && $order_info['type'] != 3 && $order_info['type'] != 1)
	{
		$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set order_status = 1,update_time = ".NOW_TIME." where order_status = 0 and id = ".$order_id);
		if(!$GLOBALS['db']->affected_rows())
		{
			return;  //结单失败
		}
		 
		//订单结单成功后，开始为订单商品进行分销佣金利润计算
		if(defined("FX_LEVEL")&&$order_info['pay_status']==2)
		{
	       require_once APP_ROOT_PATH."system/model/fx.php";
	       send_fx_order_salary($order_info);
		     
		}
		
		order_log("订单完结", $order_id);	
	}
}

/**
 * 删除订单至回收站(历史订单)
 * @param unknown_type $order_id
 * 返回:true/false
 */
function del_order($order_id)
{
	$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where type!=3 and id = ".$order_id." and order_status = 1");
	if($order_info)
	{
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_order where id = ".$order_id);
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_order_item where order_id = ".$order_id);
			
			$GLOBALS['db']->query("delete from ".DB_PREFIX."deal_order_log where order_id = ".$order_id);
			$GLOBALS['db']->query("delete from ".DB_PREFIX."delivery_notice where order_id = ".$order_id);
			$GLOBALS['db']->query("delete from ".DB_PREFIX."payment_notice where order_id = ".$order_id);
	}
	else
	{
		return false;
	}
}



/**
 * 弃用
 * @param unknown_type $order_id
 */
function distribute_order($order_id)
{
	
}

/**
 * 为会员获取指定的散列订单表名
 * @param unknown_type $user_id
 */
function get_user_order_table_name($user_id)
{
	return DB_PREFIX."deal_order";
}


/**
 * 为用户获取指定的散列订单商品表名
 * @param unknown_type $user_id
 */
function get_user_order_item_table_name($user_id)
{
	return DB_PREFIX."deal_order_item";
}

/**
 * 关闭订单，将已付的金额退还用户
 * @param unknown_type $order_id
 */
function cancel_order($order_id)
{
		$order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where type != 3 and id = ".$order_id);
		if($order_info)
		{
			$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set is_delete = 1 where (order_status = 1 or pay_status = 0) and is_delete = 0 and id = ".$order_id);
			if($GLOBALS['db']->affected_rows())
			{
				require_once APP_ROOT_PATH."system/model/deal_order.php";
				//开始退已付的款
				if($order_info['pay_status']==0&&$order_info['pay_amount']>0)
				{
					$GLOBALS['db']->query("update ".DB_PREFIX."deal_order set pay_amount = 0,ecv_id = 0,ecv_money=0,account_money = 0 where id = ".$order_info['id']);
					require_once APP_ROOT_PATH."system/model/user.php";
					if($order_info['pay_amount']>$order_info['ecv_money'])
					{
						modify_account(array("money"=>($order_info['pay_amount']-$order_info['ecv_money'])), $order_info['user_id'],"退款：取消订单号为{$order_info['order_sn']}的订单，退款到余额。");
						
						// 不是代金券和余额支付的部分，退款的时候算作充值收入
						$other_money = $order_info['pay_amount'] - $order_info['ecv_money'] - $order_info['account_money'];
						if ($other_money > 0) {
						    //增加退款到会员中心的充值记录
						    modify_statements( $other_money, 2, "交易取消  订单号：{$order_info['order_sn']}，金额存入会员帐户");
						    //收入
						    modify_statements( $other_money, 0,"交易取消  订单号：{$order_info['order_sn']}，金额存入会员帐户"); //总收入
						}
						order_log("交易关闭，退回余额支付 ".format_duobao_price($order_info['account_money']), $order_info['id']);
					}
					if($order_info['ecv_id'])
					{
						$GLOBALS['db']->query("update ".DB_PREFIX."ecv set use_count = use_count - 1 where id = ".$order_info['ecv_id']);
						order_log("用户取消订单{$order_info['order_sn']}，代金券退回 ", $order_info['id']);
					}

				}
				over_order($order_info['id']);
			}
		}
	
}

/**
 * 关闭直购订单，将已付的金额退还用户, 返还库存
 * @param mixed $order_info 订单信息或者订单id
 * @param boolean $is_user_close 1为用户或者管理员关闭，0为订单过期
 */
function cancel_totalbuy_order($order_info, $is_user_close=false)
{
    // 如果不是数组，则判断为订单id
    if ( !is_array($order_info) ) {
        $order_id   = intval($order_info);
        $order_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order where type=3 and pay_status = 0  and id = ".$order_id);
    }
    
    if($order_info)
    {
        //订单关闭： 2用户或管理员关闭订单，3：订单过期
        $order_status = $is_user_close ? 2 : 3;
        
        $GLOBALS['db']->query("update ".DB_PREFIX."deal_order set order_status = {$order_status} where pay_status = 0 and type = 3 and id = ".$order_info['id']);
        if($GLOBALS['db']->affected_rows())
        {
            
            // 返还库存
            $deal_order_item = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."deal_order_item where order_id = ".$order_info['id']);
            $GLOBALS['db']->query("UPDATE `".DB_PREFIX."deal` SET `total_buy_stock`=total_buy_stock+{$deal_order_item['number']} WHERE id={$deal_order_item['deal_id']}");
            
            require_once APP_ROOT_PATH."system/model/deal_order.php";
            //开始退已付的款
            if($order_info['pay_status']==0&&$order_info['pay_amount']>0)
            {
                $GLOBALS['db']->query("update ".DB_PREFIX."deal_order set pay_amount = 0,ecv_id = 0,ecv_money=0,account_money = 0 where id = ".$order_info['id']);
                require_once APP_ROOT_PATH."system/model/user.php";
                if( $order_info['pay_amount'] > $order_info['ecv_money'])
                {
                    
                    modify_account(array("money"=>($order_info['pay_amount']-$order_info['ecv_money'])), $order_info['user_id'],"退款：取消直购订单号为{$order_info['order_sn']}的订单，退款到余额。");
                    
                    // 不是代金券和余额支付的部分，退款的时候算作充值收入
                    $other_money = $order_info['pay_amount'] - $order_info['ecv_money'] - $order_info['account_money'];
                    if ( $other_money > 0 ) {
                        //增加退款到会员中心的充值记录
                        modify_statements( $other_money, 2, "交易取消 订单号：{$order_info['order_sn']}，金额存入会员帐户");
                        //收入
                        modify_statements( $other_money, 0,"交易取消 订单号：{$order_info['order_sn']}，金额存入会员帐户"); //总收入
                    }
                    
                    order_log("直购订单{$order_info['order_sn']}关闭，退回余额支付 ".format_duobao_price($order_info['account_money']), $order_info['id']);
                }
                
                if($order_info['ecv_id'])
                {
                    $GLOBALS['db']->query("update ".DB_PREFIX."ecv set use_count = use_count - 1 where id = ".$order_info['ecv_id']);
                    order_log("用户取消直购订单{$order_info['order_sn']}，代金券退回 ", $order_info['id']);
                }
    
            }
            return true;
        }
    }
    return false;
}



/*
 *  创建订单
 *  $deal_ids = [
 *       '177'=>1, 商品ID=>商品个数
 *       '178'=>2
 *  ]
 *
 *
 * */
function createPaidOrder($deal_ids,$user_id){

    if(!is_array($deal_ids) || !$user_id){
        return false;
    }
    require_once APP_ROOT_PATH . "system/extend/ip.php";
    require_once APP_ROOT_PATH . "system/model/cart.php";
    $ids = implode(',',array_keys($deal_ids));

    //查询商品库存 库存不足不考虑
    //total_buy_stock
    $deals = array();
    $sql                = "select * from ".DB_PREFIX."deal where id in(".$ids.")";
    $tmp   = $GLOBALS['db']->getAll($sql);
    foreach($tmp as $v){
        $deals[$v['id']] = $v;
    }

    foreach($deal_ids as $deal_id=>$num){
        if(!isset($deals[$deal_id])){
            unset($deal_ids[$deal_id]);
        }
    }

    $duobao = array();
    $duo_tmp = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."duobao_item where deal_id in(".$ids.")");

    foreach($duo_tmp as $k=>$v){
        $duobao[$v['deal_id']] = $v;
    }

    // 开始生成订单
    $order = array();
    $now                       = NOW_TIME;
    $order ['type']            = 3; // 直购订单
    $order ['user_id']         = $user_id;
    $order ['create_time']     = $now;
    $order ['update_time']     = $now;
    $order ['total_price']     = 0; // 应付总额 商品价 - 会员折扣 + 运费

    // + 支付手续费
    $order ['pay_amount']          = 0;
    $order ['pay_status']          = 0; // 新单都为零， 等下面的流程同步订单状态
    $order ['delivery_status']     = 0;
    $order ['order_status']        = 0; // 新单都为零， 等下面的流程同步订单状态
    $order ['return_total_score']  = 0; // 结单后送的积分
    $order ['memo']                = '';

    // 地址待定
    $order ['region_info']     = '';
    $order ['address']         = '';
    $order ['mobile']          = '';
    $order ['consignee']       = '';
    $order ['zip']             = '';

    $order ['ecv_money']       = 0;
    $order ['account_money']   = 0;
    $order ['ecv_sn']          = '';

    $order ['payment_id']  = 1; //余额支付
    $order ['bank_id']     = "";

    // 更新来路
    $order ['referer']     = '';
    $order ['user_name']   = isset($GLOBALS['user_info']['user_name'])?isset($GLOBALS['user_info']['user_name']):'';
    $order ['duobao_ip']   = CLIENT_IP;
    $ip                    = new iplocate ();
    $area                  = $ip->getaddress ( CLIENT_IP );
    $order ['duobao_area'] = $area ['area1'];

    $order['create_date_ymd']  = to_date(NOW_TIME,"Y-m-d");
    $order['create_date_ym']   = to_date(NOW_TIME,"Y-m");
    $order['create_date_y']    = to_date(NOW_TIME,"Y");
    $order['create_date_m']    = to_date(NOW_TIME,"m");
    $order['create_date_d']    = to_date(NOW_TIME,"d");

    do {
        $order ['order_sn'] = to_date ( NOW_TIME, "Ymdhis" ) . rand ( 10, 99 );
        $GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_order", $order, 'INSERT', '', 'SILENT' );
        $order_id = intval ( $GLOBALS ['db']->insert_id () );

    } while ( $order_id == 0 );

    // 生成订单商品
    foreach($deal_ids as $deal_id=>$num){
        $goods_item = array();
        $goods_item['id']                       = '';
        $goods_item['deal_id']                  = $deal_id;
        $goods_item['duobao_id']                = 0;
        $goods_item['duobao_item_id']           = 0;
        if(isset($duobao[$deal_id])){
            $goods_item['duobao_id']     = $duobao[$deal_id]['duobao_id'];
            $goods_item['duobao_item_id']           = $duobao[$deal_id]['id'];
        }

        $goods_item['number']                   = $num;
        $goods_item['unit_price']               = $deals[$deal_id]['current_price'];
        $goods_item['total_price']              = $num*$goods_item['unit_price'];
        $goods_item['name']                     = $deals[$deal_id]['name'];
        $goods_item['delivery_status']          = 0;
        $goods_item['return_score']             = 0;
        $goods_item['return_total_score']       = 0;
        $goods_item['verify_code']              = 0;
        $goods_item['order_sn']                 = $order['order_sn'];
        $goods_item['order_id']                 = $order_id;
        $goods_item['is_arrival']               = 0;
        $goods_item['deal_icon']                = $deals[$deal_id]['icon'];
        $goods_item['user_id']                  = $user_id;
        $goods_item['duobao_ip']                = $order['duobao_ip'];
        $goods_item['duobao_area']              = $order['duobao_area'];
        $goods_item['type']                     = $order['type'];
        $goods_item['create_time']              = NOW_TIME;
        $goods_item['create_date_ymd']          = to_date(NOW_TIME,"Y-m-d");
        $goods_item['create_date_ym']           = to_date(NOW_TIME,"Y-m");
        $goods_item['create_date_y']            = to_date(NOW_TIME,"Y");
        $goods_item['create_date_m']            = to_date(NOW_TIME,"m");
        $goods_item['create_date_d']            = to_date(NOW_TIME,"d");

        $goods_item['consignee']                = '';
        $goods_item['mobile']                   = '';
        $goods_item['region_info']              = '';
        $goods_item['address']                  = '';
        $goods_item['is_set_consignee']         = 1;

        $GLOBALS ['db']->autoExecute ( DB_PREFIX . "deal_order_item", $goods_item, 'INSERT', '', 'SILENT' );
    }

    //支付完成
    $rs = order_paid($order_id);

    return $rs;
}


?>