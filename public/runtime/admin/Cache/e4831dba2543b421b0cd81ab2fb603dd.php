<?php if (!defined('THINK_PATH')) exit();?>

<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/style.css" />
<style type="text/css">
	
/**
 * 自定义的font-face
 */
@font-face {font-family: "diyfont";
  src: url('<?php echo APP_ROOT; ?>/public/iconfont/iconfont.eot?r=<?php echo time(); ?>'); /* IE9*/
  src: url('<?php echo APP_ROOT; ?>/public/iconfont/iconfont.eot?#iefix&r=<?php echo time(); ?>') format('embedded-opentype'), /* IE6-IE8 */
  url('<?php echo APP_ROOT; ?>/public/iconfont/iconfont.woff?r=<?php echo time(); ?>') format('woff'), /* chrome、firefox */
  url('<?php echo APP_ROOT; ?>/public/iconfont/iconfont.ttf?r=<?php echo time(); ?>') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/
  url('<?php echo APP_ROOT; ?>/public/iconfont/iconfont.svg#iconfont&r=<?php echo time(); ?>') format('svg'); /* iOS 4.1- */}
.diyfont {
  font-family:"diyfont" !important;
  font-size:20px;
  font-style:normal;
  -webkit-font-smoothing: antialiased;
  -webkit-text-stroke-width: 0.2px;
  -moz-osx-font-smoothing: grayscale;
}

</style>
<script type="text/javascript">
 	var VAR_MODULE = "<?php echo conf("VAR_MODULE");?>";
	var VAR_ACTION = "<?php echo conf("VAR_ACTION");?>";
	var MODULE_NAME	=	'<?php echo MODULE_NAME; ?>';
	var ACTION_NAME	=	'<?php echo ACTION_NAME; ?>';
	var ROOT = '__APP__';
	var ROOT_PATH = '<?php echo APP_ROOT; ?>';
	var CURRENT_URL = '<?php echo btrim($_SERVER['REQUEST_URI']);?>';
	var INPUT_KEY_PLEASE = "<?php echo L("INPUT_KEY_PLEASE");?>";
	var TMPL = '__TMPL__';
	var APP_ROOT = '<?php echo APP_ROOT; ?>';
	
	//关于图片上传的定义
	var UPLOAD_SWF = '__TMPL__Common/js/Moxie.swf';
	var UPLOAD_XAP = '__TMPL__Common/js/Moxie.xap';
	var MAX_IMAGE_SIZE = '1000000';
	var ALLOW_IMAGE_EXT = 'zip';
	var UPLOAD_URL = '<?php echo u("File/do_upload_icon");?>';
	var ICON_FETCH_URL = '<?php echo u("File/fetch_icon");?>';
	var ofc_swf = '__TMPL__Common/js/open-flash-chart.swf';
</script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.timer.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.ui.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/jquery.ui.css" />
<script type="text/javascript" src="__TMPL__Common/js/plupload.full.min.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/ui_upload.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.weebox.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weebox.css" />
<script type="text/javascript" src="__TMPL__Common/js/swfobject.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/script.js"></script>

<script type="text/javascript" src="__ROOT__/public/runtime/admin/lang.js"></script>
<script type='text/javascript'  src='__ROOT__/admin/public/kindeditor/kindeditor.js'></script>
</head>
<body>
<div id="info"></div>

<script type="text/javascript" src="__TMPL__Common/js/calendar/calendar.php?lang=zh-cn" ></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/js/calendar/calendar.css" />
<script type="text/javascript" src="__TMPL__Common/js/calendar/calendar.js"></script>
<div class="main">
<div class="main_title"><?php echo ($main_title); ?></div>
<div class="blank5"></div>
<div class="search_row">
	<form name="search" action="__APP__" method="get">	
		<?php echo L("KEYWORD");?>：<input type="text" class="textbox" name="log_info" value="<?php echo strim($_REQUEST['log_info']);?>" />		
		<?php echo L("LOG_TIME");?>：
		<input type="text" class="textbox" name="log_begin_time" id="log_begin_time" value="<?php echo strim($_REQUEST['log_begin_time']);?>" onfocus="return showCalendar('log_begin_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_log_begin_time');" />
		<input type="button" class="button" id="btn_log_begin_time" value="<?php echo L("SELECT_TIME");?>" onclick="return showCalendar('log_begin_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_log_begin_time');" />	
		-
		<input type="text" class="textbox" name="log_end_time" id="log_end_time" value="<?php echo strim($_REQUEST['log_end_time']);?>" onfocus="return showCalendar('log_end_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_log_end_time');" />
		<input type="button" class="button" id="btn_log_end_time" value="<?php echo L("SELECT_TIME");?>" onclick="return showCalendar('log_end_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_log_end_time');" />	
		
			
		<input type="hidden" value="Log" name="m" />
		<input type="hidden" value="index" name="a" />
		<input type="submit" class="button" value="<?php echo L("SEARCH");?>" />
		<input type="button" class="button" value="<?php echo L("DEL");?>" onclick="foreverdel();" />
	</form>
</div>
<div class="blank5"></div>
<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="10" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="8"><input type="checkbox" id="check" onclick="CheckAll('dataTable')"></th><th width="50px"><a href="javascript:sortBy('id','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("ID");?><?php echo ($sortType); ?> "><?php echo L("ID");?><?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('log_info','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("LOG_INFO");?><?php echo ($sortType); ?> "><?php echo L("LOG_INFO");?><?php if(($order)  ==  "log_info"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('log_time','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("LOG_TIME");?><?php echo ($sortType); ?> "><?php echo L("LOG_TIME");?><?php if(($order)  ==  "log_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('log_ip','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("LOG_IP");?><?php echo ($sortType); ?> "><?php echo L("LOG_IP");?><?php if(($order)  ==  "log_ip"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('log_admin','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("LOG_ADMIN");?><?php echo ($sortType); ?> "><?php echo L("LOG_ADMIN");?><?php if(($order)  ==  "log_admin"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('log_status','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("LOG_STATUS");?><?php echo ($sortType); ?> "><?php echo L("LOG_STATUS");?><?php if(($order)  ==  "log_status"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('module','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("MODULE");?><?php echo ($sortType); ?> "><?php echo L("MODULE");?><?php if(($order)  ==  "module"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('action','<?php echo ($sort); ?>','Log','index')" title="按照<?php echo L("ACTION");?><?php echo ($sortType); ?> "><?php echo L("ACTION");?><?php if(($order)  ==  "action"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$log): ++$i;$mod = ($i % 2 )?><tr class="row" ><td><input type="checkbox" name="key" class="key" value="<?php echo ($log["id"]); ?>"></td><td>&nbsp;<?php echo ($log["id"]); ?></td><td>&nbsp;<?php echo ($log["log_info"]); ?></td><td>&nbsp;<?php echo (to_date($log["log_time"])); ?></td><td>&nbsp;<?php echo ($log["log_ip"]); ?></td><td>&nbsp;<?php echo (get_admin_name($log["log_admin"])); ?></td><td>&nbsp;<?php echo (get_log_status($log["log_status"])); ?></td><td>&nbsp;<?php echo ($log["module"]); ?></td><td>&nbsp;<?php echo ($log["action"]); ?></td><td><a href="javascript:foreverdel('<?php echo ($log["id"]); ?>')"><?php echo L("FOREVERDEL");?></a>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="10" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->
 

<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>