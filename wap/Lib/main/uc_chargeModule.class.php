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


    public function invest(){

        global_run();
        if(check_save_login()!=LOGIN_STATUS_LOGINED)
        {
            app_redirect(url("index","user#login"));
        }
        init_app_page();

        $user_info = $GLOBALS['user_info'];
        $user_id = $user_info['id'];

        //支付方式
        $sql = 'select * from '.DB_PREFIX.'invest_way where status=1';
        $ways = $GLOBALS['db']->getAll($sql);

        $pay_list = array();
        $way_list = array();
        foreach($ways as $way){
            if(!isset($pay_list[$way['type']])){
                $pay_list[$way['type']] = [];
            }
            array_push($pay_list[$way['type']],$way);
            $way_list[$way['id']] = $way;
        }

        $page = intval($_REQUEST['page']);
        $page<1 && $page =1 ;

        $page_size = 10;
        $limit = (($page-1)*$page_size).",".$page_size;

        $count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."invest_detail where status=1 and  user_id = ".$user_id);

        $list = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."invest_detail where status=1 and  user_id = ".$user_id." order by id desc limit ".$limit);
        $page_total = ceil($count/$page_size);

        foreach($list as &$detail){
            $detail['create_time'] = date('Y.m.d H:i:s',$detail['create_time']);
             $detail['way_account'] =  isset($way_list[$detail['way_id']])?$way_list[$detail['way_id']]['account']:'';
            $detail['is_remark'] = empty($detail['remark'])?0:1;
        }

        //充值记录

        $data = array();
        $page = new Page($count,$page_size);   //初始化分页对象
        $p  =  $page->show();
        $data['data'] = $list;
        $data['page'] = array("page"=>$page,"page_total"=>$page_total,"page_size"=>$page_size,"data_total"=>$count);
        $data['page_title'] = '人工提现';

        $GLOBALS['tmpl']->assign('pages',$p);

        $GLOBALS['tmpl']->assign("data",$data);

        $GLOBALS['tmpl']->assign("pay_list",$pay_list); //title
        $GLOBALS['tmpl']->display("uc_invest.html"); //title
    }


    public function invest_done(){
        global_run();
        init_app_page();

        $user_info = $GLOBALS['user_info'];

        $money =  trim($_REQUEST['money']);
        $account = trim($_REQUEST['account']);
        $user_name =  trim($_REQUEST['bank_user']);

        $account_way = intval($_REQUEST['account_way']);
        if($account_way==2){
            $way_id = intval($_REQUEST['zhifubao_s']);
        }else{
            $way_id = intval($_REQUEST['yinhang_s']);
            $account_name = $_REQUEST['bank_account_all'];
        }

        if(empty($money)){
            ajax_return(array('code'=>201,'msg'=>'请填写金额'));
        }

        if(empty($account)){
            ajax_return(array('code'=>201,'msg'=>'请填写账号'));
        }

        $data = array(
            'way_id'=>$way_id,
            'fee_account'=>round($money,2),
            'user_id'=>$user_info['id'],
            'user_name'=>$user_name,
            'user_account'=>$account,
            'account_name'=>$account_name,
            'create_time'=>time(),
            'remark'=>''

        );

        $rst = $GLOBALS['db']->autoExecute(DB_PREFIX.'invest_detail',$data);
        if($rst){
            ajax_return(array('code'=>200,'msg'=>'申请成功'));
        }

        ajax_return(array('code'=>500,'msg'=>'申请失败'));
    }

    public function invest_del(){


        global_run();
        init_app_page();

        $id = intval($_REQUEST['id']);
        $user_info = $GLOBALS['user_info'];
        if(empty($id)){
            ajax_return(array('code'=>201,'msg'=>'参数错误'));
        }

        $sql = 'select * from '.DB_PREFIX.'invest_detail where user_id='.$user_info['id'].' and id='.$id;
        $one = $GLOBALS['db']->getRow($sql);
        if(empty($one)){
            ajax_return(array('code'=>404,'msg'=>'记录不存在'));
        }

        $sql = 'update '.DB_PREFIX.'invest_detail set status=0 where user_id='.$user_info['id'].' and id='.$id;

        $rst = $GLOBALS['db']->query($sql);
        if($rst){
            ajax_return(array('code'=>200,'msg'=>'删除成功'));
        }

        ajax_return(array('code'=>500,'msg'=>'删除失败'));

    }
}
?>