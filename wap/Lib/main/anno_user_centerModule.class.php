<?php

class anno_user_centerModule extends MainBaseModule
{

	public function index()
	{
		global_run();
		init_app_page();

		$log_type = $param['log_type'] = intval($_REQUEST['log_type']);
		$param['page']  = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
		$param['uid']=intval($_REQUEST['lucky_user_id']);
		$data = call_api_core("anno_user_center","index", $param);
	 

		if(isset($data['page']) && is_array($data['page'])){
			$page = new Page($data['page']['data_total'],$data['page']['page_size']);   //初始化分页对象
			$p  =  $page->show();
			$GLOBALS['tmpl']->assign('pages',$p);
		}
		$GLOBALS['tmpl']->assign("data",$data);
		$GLOBALS['tmpl']->assign("user_info",$data['user_info']);
		$GLOBALS['tmpl']->assign("list",$data['list']);
		$GLOBALS['tmpl']->assign("share_list",$data['share_list']);
		$GLOBALS['tmpl']->assign("log_type",$log_type); 
		$GLOBALS['tmpl']->display("anno_user_center_index.html");
		
	}
	    

    public function my_no(){
        global_run();
        init_app_page();
        
        $param['id'] = intval($_REQUEST['id']);
        $param['uid'] = intval($_REQUEST['uid']);
        $data = call_api_core("anno_user_center","my_no", $param);
        
        

        $GLOBALS['tmpl']->assign("data",$data);
        $GLOBALS['tmpl']->assign("list",$data['list']);
        $GLOBALS['tmpl']->assign("user_info",$data['user_info']);
        $GLOBALS['tmpl']->display("anno_user_center_my_no.html");
    }
 
    public function my_no_all(){

        global_run();
        init_app_page();

        $param['uid'] = intval($_REQUEST['uid']);
        $param['id'] = intval($_REQUEST['id']);
        $data = call_api_core("anno_user_center","my_no_all", $param);
        
        

        $GLOBALS['tmpl']->assign("data",$data);
        $GLOBALS['tmpl']->assign("list",$data['list']);
        $GLOBALS['tmpl']->assign("user_info",$data['user_info']);
        $GLOBALS['tmpl']->display("anno_user_center_my_no_all.html");
    }

}
?>