<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class indexModule extends MainBaseModule
{
	public function index()
	{
		global_run();

		init_app_page();

		$param['page'] = intval($_REQUEST['page']);
		$param['order'] = strim($_REQUEST['order']);
		$param['order_dir']=intval($_REQUEST['order_dir']);

		$data = call_api_core("index","wap",$param);
 
		foreach($data['advs'] as $k=>$v)
		{

			$data['advs'][$k]['url'] =  getWebAdsUrl($v);
		}

		foreach($data['indexs'] as $k=>$v)
		{
			foreach($data['indexs'][$k] as $kk=>$vv){
				$data['indexs'][$k][$kk]['url'] =  getWebAdsUrl($vv);
			}
		}

		foreach($data['index_duobao_list'] as $k=>$v)
		{
			$data['index_duobao_list'][$k]['url'] =  wap_url("index","duobao",array("data_id"=>$v['id']));

		}

		if(isset($data['page']) && is_array($data['page'])){

			//感觉这个分页有问题,查询条件处理;分页数10,需要与sjmpai同步,是否要将分页处理移到sjmapi中?或换成下拉加载的方式,这样就不要用到分页了
			$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
			//$page->parameter
			$p  =  $page->show();
			//print_r($p);exit;
			$GLOBALS['tmpl']->assign('pages',$p);
		}
		
		 
		
	    //注册送红包弹窗
		if ( es_session::get("is_send_reg_ecv") == 1 ){
		    $GLOBALS['tmpl']->assign('reg_ecv_money', es_session::get("reg_ecv_money"));
		    $GLOBALS['tmpl']->assign('is_send_reg_ecv', 1);
		    
		    es_session::set("is_send_reg_ecv", '');
		    es_session::set("reg_ecv_money", '');
		}
		 
		$GLOBALS['tmpl']->assign("data",$data);
		
		$m_config = getMConfig();//初始化手机端配置
		
		if (es_cookie::get('is_app_down')||(!$m_config['ios_down_url']&&!$m_config['android_filename'])){
			$GLOBALS['tmpl']->assign('is_show_down',0);//用户已下载
		}else{
			$GLOBALS['tmpl']->assign('is_show_down',1);//用户未下载
		}
        $GLOBALS['tmpl']->display("index.html");
	}

	 

}
?>
