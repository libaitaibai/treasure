<?php
class topspeedModule extends MainBaseModule{
    public function index()
    {
        global_run();
        init_app_page();
        $param['page']         = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
        $param['data_id'] = intval($_REQUEST['data_id']);
//        $param['min_buy'] = intval($_REQUEST['min_buy']);
        $data = call_api_core("topspeed","index", $param);

        $page = new Page($data['page']['total'], $data['page']['page_size']); // 初始化分页对象
        $p = $page->show();

        /* 数据 */
        $GLOBALS['tmpl']->assign('pages', $p);
        $GLOBALS['tmpl']->assign("list", $data['list']);
        $GLOBALS['tmpl']->assign("data", $data);
        $GLOBALS['tmpl']->display("topspeed.html");
    }
}