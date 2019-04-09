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
<?php function get_dest($d)
	{
		if($d)
		return $d;
		else
		return "--";
	}
	function get_exec_status($s)
	{
		if($s==0)
		return "未启动";
		if($s==1)
		return "执行中";
		if($s==2)
		return "已完成";
		
	} ?>
<script type="text/javascript">
function exec(id)
{
	if(confirm("要立即执行该任务吗？"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=exec&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				
				alert(obj.info);
				location.href=location.href;
			}
	});
}
function view(id)
{
	
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=view&id="+id, 
			data: "ajax=1",
			dataType:"json",
			success: function(obj){
				
				$.weeboxs.open(obj.html, {showButton:false,title:'内容',width:600,height:200});
			

			}
	});
}
function make_script()
{
	
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=make_script", 
			data: "ajax=1",
			dataType:"json",
			success: function(obj){
				
				if(obj.status)
				{
					alert(obj.info);
				}
				else{
					alert(obj.info);
				}
			

			}
	});
}
</script>
<div class="main">
<div class="main_title">计划任务列表</div>
<div class="blank5"></div>
<div class="search_row">
	<form name="search" action="__APP__" method="get">	
		目标：<input type="text" class="textbox" name="dest" value="<?php echo strim($_REQUEST['dest']);?>" />		
		类型：
		<select name="type">
			<option value="" <?php if(strim($_REQUEST['type']) == ''): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="sms" <?php if(strim($_REQUEST['type']) == 'sms'): ?>selected="selected"<?php endif; ?>>短信发送</option>	
			<option value="mail" <?php if(strim($_REQUEST['type']) == 'mail'): ?>selected="selected"<?php endif; ?>>邮件发送</option>
			<option value="weixin" <?php if(strim($_REQUEST['type']) == 'weixin'): ?>selected="selected"<?php endif; ?>>微信发送</option>
			<option value="mass" <?php if(strim($_REQUEST['type']) == 'mass'): ?>selected="selected"<?php endif; ?>>群发任务</option>	
			<option value="fair" <?php if(strim($_REQUEST['type']) == 'fair'): ?>selected="selected"<?php endif; ?>>开奖采集</option>	
			<option value="lottery" <?php if(strim($_REQUEST['type']) == 'lottery'): ?>selected="selected"<?php endif; ?>>夺宝开奖</option>	
			<option value="logmoving" <?php if(strim($_REQUEST['type']) == 'logmoving'): ?>selected="selected"<?php endif; ?>>奖池迁移</option>	
			<option value="robot" <?php if(strim($_REQUEST['type']) == 'robot'): ?>selected="selected"<?php endif; ?>>机器人下单</option>				
			<option value="robot_cfg" <?php if(strim($_REQUEST['type']) == 'robot_cfg'): ?>selected="selected"<?php endif; ?>>机器人设定下单</option>				
			<option value="gc" <?php if(strim($_REQUEST['type']) == 'gc'): ?>selected="selected"<?php endif; ?>>定时任务</option>				
		</select>
			
		<input type="hidden" value="ScheduleList" name="m" />
		<input type="hidden" value="index" name="a" />
		<input type="submit" class="button" value="<?php echo L("SEARCH");?>" />
		<input type="button" class="button" value="<?php echo L("DEL");?>" onclick="foreverdel();" />
		<input type="button" class="button" value="生成计划任务脚本" onclick="make_script();" />
	</form>
</div>
<div class="blank5"></div>
<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="10" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="8"><input type="checkbox" id="check" onclick="CheckAll('dataTable')"></th><th width="50px"><a href="javascript:sortBy('id','<?php echo ($sort); ?>','ScheduleList','index')" title="按照<?php echo L("ID");?><?php echo ($sortType); ?> "><?php echo L("ID");?><?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('name','<?php echo ($sort); ?>','ScheduleList','index')" title="按照任务名称<?php echo ($sortType); ?> ">任务名称<?php if(($order)  ==  "name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('dest','<?php echo ($sort); ?>','ScheduleList','index')" title="按照发送目标<?php echo ($sortType); ?> ">发送目标<?php if(($order)  ==  "dest"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('schedule_time','<?php echo ($sort); ?>','ScheduleList','index')" title="按照计划时间<?php echo ($sortType); ?> ">计划时间<?php if(($order)  ==  "schedule_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('exec_status','<?php echo ($sort); ?>','ScheduleList','index')" title="按照状态<?php echo ($sortType); ?> ">状态<?php if(($order)  ==  "exec_status"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('exec_begin_time','<?php echo ($sort); ?>','ScheduleList','index')" title="按照任务开启时间<?php echo ($sortType); ?> ">任务开启时间<?php if(($order)  ==  "exec_begin_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('exec_end_time','<?php echo ($sort); ?>','ScheduleList','index')" title="按照任务完成时间<?php echo ($sortType); ?> ">任务完成时间<?php if(($order)  ==  "exec_end_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('exec_info','<?php echo ($sort); ?>','ScheduleList','index')" title="按照结果<?php echo ($sortType); ?> ">结果<?php if(($order)  ==  "exec_info"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$log): ++$i;$mod = ($i % 2 )?><tr class="row" ><td><input type="checkbox" name="key" class="key" value="<?php echo ($log["id"]); ?>"></td><td>&nbsp;<?php echo ($log["id"]); ?></td><td>&nbsp;<?php echo ($log["name"]); ?></td><td>&nbsp;<?php echo (get_dest($log["dest"])); ?></td><td>&nbsp;<?php echo (to_date($log["schedule_time"])); ?></td><td>&nbsp;<?php echo (get_exec_status($log["exec_status"])); ?></td><td>&nbsp;<?php echo (to_date($log["exec_begin_time"])); ?></td><td>&nbsp;<?php echo (to_date($log["exec_end_time"])); ?></td><td>&nbsp;<?php echo ($log["exec_info"]); ?></td><td><a href="javascript:view('<?php echo ($log["id"]); ?>')">查看详情</a>&nbsp;<a href="javascript: exec('<?php echo ($log["id"]); ?>')">人工执行</a>&nbsp;<a href="javascript:foreverdel('<?php echo ($log["id"]); ?>')"><?php echo L("FOREVERDEL");?></a>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="10" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->
 

<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>