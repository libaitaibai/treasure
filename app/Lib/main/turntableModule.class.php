<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class turntableModule extends MainBaseModule
{
    public function index()
    {
        global_run();
        init_app_page();
        $web_article_id = intval($_REQUEST['id']);
        $is_agreement = strim($_REQUEST['t']);
        $shptel = app_conf("SHOP_TEL");
        $page =intval($_REQUEST['p']);
        $page_size =app_conf("PAGE_SIZE");

        $GLOBALS['tmpl']->assign("is_agreement",$is_agreement);
        $GLOBALS['tmpl']->assign("web_article_id",$web_article_id);
        $GLOBALS['tmpl']->assign("shptel",$shptel);

        $GLOBALS['tmpl']->display("turntable.html");
    }
}