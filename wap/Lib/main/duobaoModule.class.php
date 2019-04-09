<?php

class duobaoModule extends MainBaseModule
{
	public function index()
	{
		global_run();
		init_app_page();

        //获取参数
        $data_id = intval($_REQUEST['data_id']);
        $dbid = intval($_REQUEST['dbid']);
        $page = intval($_REQUEST['page']);
        //请求接口
        $data = call_api_core("duobao","index",array("data_id"=>$data_id, "dbid"=>$dbid, "page"=>$page));
        
        if(empty($data['item_data']))
        {
        	showErr($data['info']);
        }
        
        $cart_conf_json = array(
            "max_buy"=>$data['item_data']['max_buy'],
            "min_buy"=>$data['item_data']['min_buy'],
            "current_buy"=>$data['item_data']['current_buy'],
            "residue_count"=>($data['item_data']['max_buy']-$data['item_data']['current_buy'])
        );
        
        $GLOBALS['tmpl']->assign("cart_data_json",  json_encode($data['cart_data']));
        $GLOBALS['tmpl']->assign("cart_conf_json",  json_encode($cart_conf_json));
        $GLOBALS['tmpl']->assign("item_data",$data['item_data']);
        $GLOBALS['tmpl']->assign("data",$data);
        
        if(isset($data['page']) && is_array($data['page'])){
        	$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
        	$p  =  $page->show();
        	$GLOBALS['tmpl']->assign('pages',$p);
        }

        $GLOBALS['tmpl']->display("duobao.html");
	}
	
	public function get_duobao_status(){
	    $data = call_api_core("duobao","get_duobao_status",array("data_id"=>  intval($_REQUEST['data_id'])));
	    $GLOBALS['tmpl']->assign("item_data",$data['item_data']);
	    $html = $GLOBALS['tmpl']->fetch("inc/is_luck_lottery_header.html");
	    $result['html'] = $html;
	    $result['status'] = 0;
	    if($data['item_data']['duobao_status'] == 2){
	        $result['status'] = 1;
	    }
	    ajax_return($result);
	}
	
	public function more()
	{
		global_run();
		init_app_page();
		
		//获取参数
		$data_id = intval($_REQUEST['data_id']);
		$data = call_api_core("duobao","more",array("data_id"=>$data_id));
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->display("duobao_more.html");
	}
        
    public function detail(){
        global_run();
        init_app_page();

        //获取参数
        $data_id = intval($_REQUEST['data_id']);
        $data = call_api_core("duobao","detail",array("data_id"=>$data_id));
        $GLOBALS['tmpl']->assign("is_app",$GLOBALS['is_app']);
        $GLOBALS['tmpl']->assign("data",$data);
        $GLOBALS['tmpl']->display("duobao_detail.html");
    }
    public function duobao_record(){
      		
    	global_run();
    	init_app_page();
    	
    	$param['page'] = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
    	$param['data_id'] = intval($_REQUEST['data_id']);
    	$data = call_api_core("duobao","duobao_record", $param);
    		
    	foreach ($data['list'] as $key=>$value ){
    	    $data['list'][$key]['lottery_time_show'] = to_date($value['lottery_time'],"H:i");
    		if(to_date($value['lottery_time'],"Y-m-d")==to_date(NOW_TIME,"Y-m-d"))
    			$data['list'][$key]['date'] = "今天";
    		elseif(to_date($value['lottery_time']+24*3600,"Y-m-d")==to_date(NOW_TIME,"Y-m-d"))
    			$data['list'][$key]['date'] = "昨天";
    		else
    			$data['list'][$key]['date'] = to_date($value['lottery_time'],"Y-m-d");
    	}
    	
    	$page = new Page($data['page']['total'], $data['page']['page_size']); // 初始化分页对象
    	$p = $page->show();
    	
    	/* 数据 */
    	$GLOBALS['tmpl']->assign('pages', $p);
    	$GLOBALS['tmpl']->assign("now_time", NOW_TIME);
    	$GLOBALS['tmpl']->assign("list", $data['list']);
    	$GLOBALS['tmpl']->assign("data", $data);
        $GLOBALS['tmpl']->display("duobao_record.html");
    }
}
?>
