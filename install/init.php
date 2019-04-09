<?php
set_time_limit(0);
define("IS_INIT",1);
define("FOLDER_NAME","install");
define("FILE_PATH","/".FOLDER_NAME); //文件目录，空为根目录
require_once '../system/system_init.php';

require_once APP_ROOT_PATH."system/model/duobao.php";
$duobao_list = $GLOBALS['db']->getAll("select id from ".DB_PREFIX."duobao");
foreach($duobao_list as $item)
{
	duobao::new_duobao($item['id']);
}

//生成计划任务nodejs
make_app_js();

//开启所有采集计划
//输出现有模板文件夹
$directory = APP_ROOT_PATH."system/fair_fetch/";
$dir = @opendir($directory);
$tmpls     = array();
	
while (false !== ($file = @readdir($dir)))
{
	if($file!='.'&&$file!='..')
	{
		$fair_type = str_replace("_fair_fetch.php", "", $file);
		$cname = $fair_type."_fair_fetch";
		require_once APP_ROOT_PATH."system/fair_fetch/".$cname.".php";
		$fetch_obj = new $cname;

		send_schedule_plan("fair", $fetch_obj->name."开奖采集", array("fair_type"=>$fair_type), NOW_TIME);
	}
}

@file_put_contents(APP_ROOT_PATH."public/init.lock","");
app_redirect(APP_ROOT."/m.php");

?>