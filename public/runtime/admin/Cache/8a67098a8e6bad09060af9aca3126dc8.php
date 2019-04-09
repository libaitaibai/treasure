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
<script type="text/javascript" src="__TMPL__Common/js/ecvtype.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#is_all").bind("change",function(){
		var is_all = $(this).find("input[name='is_all']").attr('checked');
		if(is_all==true){
			for(i=0;i<$("#use_range").find("input").length;i++){
				$("#use_range").find("input")[i].checked=true
			} 
		}else{
			for(i=0;i<$("#use_range").find("input").length;i++){
				$("#use_range").find("input")[i].checked=false
			}
		}
		   
	});
	$(".not_all").bind("change",function(){
		var not_all = $(this).find("input").attr('checked');
		if(not_all==false){
			$("#use_range").find("input[name='is_all']").get(0).checked=false; 
		}
			
	});
});
</script>
<div class="main">
<div class="main_title">拆分红包设置</div>
<div class="blank5"></div>
<div class="button_row">

<div class="blank5"></div>
<form name="edit" action="__APP__" method="post" enctype="multipart/form-data">
<table class="form" cellpadding=0 cellspacing=0 >
<tr>
		<td colspan=2 class="topTd"></td>
</tr>
<tr>
	<td class="item_title">是否开启拆分红包:</td>
	<td class="item_input">
	<select name="is_effect">
			<option value="0" >关闭</option>
			<option value="1" <?php if($conf_res['value'] == 1): ?>selected="selected"<?php endif; ?>>开启</option>
	</select>
	</td>
</tr>
<tr>
	<td class="item_title">最小购买金额:</td>
	<td class ="item_input"><input type="text" class="textbox" name="minchange_money" value="<?php echo ($ecvtype_res["minchange_money"]); ?>" />&nbsp;元
	</td>
</tr>
<tr>
	<td class="item_title">总红包的额度:</td>
	<td class ="item_input"><input type="text" class="textbox require" name="money" value="<?php echo ($ecvtype_res["money"]); ?>" />&nbsp;元&nbsp;
	<select name="sm_way">
			<option name="equal" value="0" >等额</option>
			<option name="interval" value="1" <?php if($ecvtype_res['sm_way'] == 1): ?>selected="selected"<?php endif; ?>>随机</option>
	</select>
	</td>
</tr>
<tr>
	<td class="item_title">将红包拆分为:</td>
	<td><input type="text" class="textbox require" name="total_limit" value="<?php echo ($ecvtype_res["total_limit"]); ?>" />&nbsp;个 
	</td>
</tr>
<tr>
	<td class="item_title">每个用户每天能领个数:</td>
	<td><input type="text" class="textbox" name="draw_count" value="<?php echo ($ecvtype_res["draw_count"]); ?>" />&nbsp;个 
	</td>
</tr>
<tr>
	<td class="item_title">订单金额满多少可以该红包用:</td>
	<td class ="item_input"><input type="text" class="textbox" name="meet_amount" value="<?php echo ($ecvtype_res["meet_amount"]); ?>" />&nbsp;元
	</td>
</tr>
<tr id="use_range">
		<td class="item_title">指定使用范围:</td>
		<td class="item_input">
			<label id="range_value1" class="not_all"> PK区 <input type="checkbox" name="range_value1" value="1" <?php if($ecvtype_res['domain']['range_value1'] == 1): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value7" class="not_all"> 一元区 <input type="checkbox" name="range_value7" value="7" <?php if($ecvtype_res['domain']['range_value7'] == 7): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value2" class="not_all"> 十元区 <input type="checkbox" name="range_value2" value="2" <?php if($ecvtype_res['domain']['range_value2'] == 2): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value3" class="not_all"> 百元区 <input type="checkbox" name="range_value3" value="3" <?php if($ecvtype_res['domain']['range_value3'] == 3): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value4" class="not_all"> 直购区 <input type="checkbox" name="range_value4" value="4" <?php if($ecvtype_res['domain']['range_value4'] == 4): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value5" class="not_all"> 极速区 <input type="checkbox" name="range_value5" value="5" <?php if($ecvtype_res['domain']['range_value5'] == 5): ?>checked="checked"<?php endif; ?> /></label>
			<label id="range_value6" class="not_all"> 选号区 <input type="checkbox" name="range_value6" value="6" <?php if($ecvtype_res['domain']['range_value6'] == 6): ?>checked="checked"<?php endif; ?> /></label>
			<label id="is_all"> 全部 <input type="checkbox" name="is_all" value="1" <?php if($ecvtype_res['is_all'] == 1): ?>checked="checked"<?php endif; ?> /></label>
		</td>
	</tr>
<tr>
		<td class="item_title"><?php echo L("VOUCHER_BEGIN_TIME");?>:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="begin_time" id="begin_time" value="<?php echo (to_date($ecvtype_res["begin_time"])); ?>" onfocus="this.blur(); return showCalendar('begin_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_begin_time');" />
			<input type="button" class="button" id="btn_begin_time" value="<?php echo L("SELECT_TIME");?>" onclick="return showCalendar('begin_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_begin_time');" />	
			<input type="button" class="button" value="<?php echo L("CLEAR_TIME");?>" onclick="$('#begin_time').val('');" />				
			<span class="tip_span"><?php echo L("VOUCHER_BEGIN_TIME_TIP");?></span>
		</td>
	</tr>
	<tr>
		<td class="item_title"><?php echo L("VOUCHER_END_TIME");?>:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="end_time" id="end_time" value="<?php echo (to_date($ecvtype_res["end_time"])); ?>" onfocus="this.blur(); return showCalendar('end_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_end_time');" />
			<input type="button" class="button" id="btn_end_time" value="<?php echo L("SELECT_TIME");?>" onclick="return showCalendar('end_time', '%Y-%m-%d %H:%M:%S', false, false, 'btn_end_time');" />	
			<input type="button" class="button" value="<?php echo L("CLEAR_TIME");?>" onclick="$('#end_time').val('');" />
			<span class="tip_span"><?php echo L("VOUCHER_END_TIME_TIP");?></span>
		</td>
	</tr>
	<tr>
		<td class="item_title"></td>
		<td class="item_input">
			<!--隐藏元素-->
			<input type="hidden" name="id" value="<?php echo ($vo["id"]); ?>" />
			<input type="hidden" name="<?php echo conf("VAR_MODULE");?>" value="RedSet" />
			<input type="hidden" name="<?php echo conf("VAR_ACTION");?>" value="update" />
			<!--隐藏元素-->
			<input type="submit" class="button" value="<?php echo L("EDIT");?>" />
			<input type="reset" class="button" value="<?php echo L("RESET");?>" />
		</td>
	</tr>
	<tr>
		<td colspan=2 class="bottomTd"></td>
	</tr>


<div class="blank5"></div>
</table>
</form>
</div>
</div>
</body>
</html>