<?php

class annoModule extends MainBaseModule
{
	public function index()
	{
		global_run();
		init_app_page();

	    $param['page']         = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
		$param['duobao_id'] = intval($_REQUEST['duobao_id']);
	    $data = call_api_core("anno","index", $param);

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
// 		   var_dump($data['list']);exit;
		/* 数据 */
		$GLOBALS['tmpl']->assign('pages', $p);
		$GLOBALS['tmpl']->assign("now_time", NOW_TIME);
		$GLOBALS['tmpl']->assign("list", $data['list']);
		$GLOBALS['tmpl']->assign("data", $data);
		$GLOBALS['tmpl']->display("anno.html");
	}
}
?>
