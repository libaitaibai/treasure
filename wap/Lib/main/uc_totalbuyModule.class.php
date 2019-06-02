<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class uc_totalbuyModule extends MainBaseModule
{

	public function index()
	{
		global_run();
		init_app_page();
		
		$param=array();
		$param['page'] = intval($_REQUEST['page']);
		$param['data_id'] = intval($_REQUEST['data_id']);
		$param['log_type'] = intval($_REQUEST['log_type']);
		$data = call_api_core("uc_totalbuy","index",$param);
		
		if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
		    app_redirect(wap_url("index","user#login"));
		}
		
		foreach($data['list'] as $k=>$v){
		    	
		    $data['list'][$k]['url']=wap_url("index","duobao",array("data_id"=>$v['duobao_item_id']));
		}

		$page = new Page($data['page']['data_total'], $data['page']['page_size']); // 初始化分页对象
		$p = $page->show();
		
		$GLOBALS['tmpl']->assign('pages', $p);
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->display("uc_totalbuy.html");
	}
	
	public function detail()
	{
	    global_run();
	    init_app_page();
	    $param['id'] = intval($_REQUEST['id']);
	    $data = call_api_core("uc_totalbuy","detail",$param);
	    
	    
	
	    $GLOBALS['tmpl']->assign("data",$data);
	    $GLOBALS['tmpl']->display("uc_totalbuy_detail.html");
	}
	
	
	
	
	public function verify_delivery()
	{
	    global_run();
	    init_app_page();
	    $param['id'] = intval($_REQUEST['id']);
	    $data = call_api_core("uc_totalbuy","verify_delivery",$param);
	    
	    if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
	        app_redirect(wap_url("index","user#login"));
	    }
	    ajax_return($data);
	}
	
	public function close()
	{
	    global_run();
	    init_app_page();
	    $param['id'] = intval($_REQUEST['id']);
	    $data = call_api_core("uc_totalbuy","close",$param);
	     
	    if($data['user_login_status']!=LOGIN_STATUS_LOGINED){
	        app_redirect(wap_url("index","user#login"));
	    }
	    ajax_return($data);
	}

	public function show_address(){

        global_run();
        init_app_page();
        // 避免重复提交
        require_once APP_ROOT_PATH."system/model/user.php";
        $user_login_status = check_save_login();
        if($user_login_status != LOGIN_STATUS_LOGINED){
            app_redirect(wap_url("index","user#login"));
        }
        $user_id = $GLOBALS['user_info']['id'];

        $data = array();
        $consignee = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user_consignee where is_default=1 and user_id = ".$user_id);

        if($consignee){
            $consignee_info            = load_auto_cache("consignee_info", array("consignee_id"=>$consignee['id']));
            $consignee['del_url']      = url('index','uc_consignee#del', array('id'=>$consignee['id']));
            $consignee['dfurl']        = url('index','uc_consignee#set_default', array('id'=>$consignee['id']));
            $consignee['region_lv2']   = $consignee_info['consignee_info']['region_lv2_name'];
            $consignee['region_lv3']   = $consignee_info['consignee_info']['region_lv3_name'];
            $consignee['region_lv4']   = $consignee_info['consignee_info']['region_lv4_name'];
        }

        $data['consignee'] = $consignee;
        $data['page_title'] = '填写地址';
        $GLOBALS['tmpl']->assign('order_id',intval($_REQUEST['order_id']));
        $GLOBALS['tmpl']->assign("data", $data);
        $GLOBALS['tmpl']->display("uc_buy_address.html");

	}


    public function orderAddress(){

        $order_id = intval($_REQUEST['order_id']);
        $address_id = intval($_REQUEST['address_id']);
        if(!$order_id){
            ajax_return(array('status'=>0,'info'=>'订单ID缺失'));
        }

        if(!$address_id){
            ajax_return(array('status'=>0,'info'=>'请选择地址'));
        }
        $sql = 'select * from '.DB_PREFIX.'user_consignee where id='.$address_id;
        $address = $GLOBALS['db']->getRow($sql);
        if(empty($address)){
            ajax_return(array('status'=>0,'info'=>'地址不存在'));
        }

        $region_conf   = load_auto_cache ( "delivery_region" );
        $region_lv1    = intval ( $address ['region_lv1'] );
        $region_lv2    = intval ( $address ['region_lv2'] );
        $region_lv3    = intval ( $address ['region_lv3'] );
        $region_lv4    = intval ( $address ['region_lv4'] );
        $region_info   = $region_conf [$region_lv1] ['name'] . " " . $region_conf [$region_lv2] ['name'] . " " . $region_conf [$region_lv3] ['name'] . " " . $region_conf [$region_lv4] ['name'];

        $data = array();
        $data ['region_info']     = $region_info;
        $data ['address']         = strim ( $address ['address'] );
        $data ['mobile']          = strim ( $address ['mobile'] );
        $data ['consignee']       = strim ( $address ['consignee'] );
        $data ['zip']             = strim ( $address ['zip'] );

        $GLOBALS['db']->autoExecute(DB_PREFIX.'deal_order',$data,'UPDATE','id='.$order_id);

        ajax_return(array('status'=>1,'info'=>'更新成功'));

    }


}
?>
