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
<?php function get_handle($id, $duobao)
	{
		$str = "<a href='".u("Duobao/edit",array("id"=>$id))."'>编辑</a>";
		$str.="&nbsp;&nbsp;<a href='javascript:foreverdel(".$id.");'>".l("DEL")."</a>";
		return $str;
	}
	
	function get_current_schedule($schedule, $duobao_id){
		$str = "<a href='".u("DuobaoItem/index",array("duobao_id"=>$duobao_id))."'>".$schedule."</a>";
		return $str;
	} ?>
<script type="text/javascript" src="__TMPL__Common/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.weebox.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weebox.css" />
<div class="main">
<div class="main_title">夺宝列表</div>
<div class="blank5"></div>
<form name="search" action="__APP__" method="get">	
<div class="button_row">
	<input type="button" class="button" value="新增" onclick="add();" />
	<input type="button" class="button" value="删除" onclick="foreverdel();" />
</div>
<div class="blank5"></div>
<div class="search_row">

		编号：<input type="text" class="textbox" name="id" value="<?php echo strim($_REQUEST['id']);?>" style="width:100px;" />
		商品名称：<input type="text" class="textbox" name="duobao_name" value="<?php echo strim($_REQUEST['duobao_name']);?>" style="width:100px;" />
		分类名称：<input type="text" class="textbox" name="cate_name" value="<?php echo strim($_REQUEST['cate_name']);?>" style="width:100px;" />
		品牌名称：<input type="text" class="textbox" name="brand_name" value="<?php echo strim($_REQUEST['brand_name']);?>" style="width:100px;" />
		
		专区：
		<select name="classify">
			<option value="-1" <?php if(intval($_REQUEST['classify']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="1" <?php if(intval($_REQUEST['classify']) == 1): ?>selected="selected"<?php endif; ?>>一元</option>
			<option value="10" <?php if(intval($_REQUEST['classify']) == 10): ?>selected="selected"<?php endif; ?>>十元</option>
			<option value="100" <?php if(intval($_REQUEST['classify']) == 100): ?>selected="selected"<?php endif; ?>>百元</option>
		</select>
		
		特殊专区
		<select name="special_classify">
			<option value="-1" <?php if(intval($_REQUEST['special_classify']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="1" <?php if(intval($_REQUEST['special_classify']) == 1): ?>selected="selected"<?php endif; ?>>免费购</option>
			<option value="2" <?php if(intval($_REQUEST['special_classify']) == 2): ?>selected="selected"<?php endif; ?>>选号</option>
			<option value="3" <?php if(intval($_REQUEST['special_classify']) == 3): ?>selected="selected"<?php endif; ?>>PK</option>
		</select>
		
		<input type="hidden" value="Duobao" name="m" />
		<input type="hidden" value="index" name="a" />
		
		<input type="submit" class="button" value="<?php echo L("SEARCH");?>" />
</div>
</form>
<div class="blank5"></div>
<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="12" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="8"><input type="checkbox" id="check" onclick="CheckAll('dataTable')"></th><th width="50px    "><a href="javascript:sortBy('id','<?php echo ($sort); ?>','Duobao','index')" title="按照<?php echo L("ID");?><?php echo ($sortType); ?> "><?php echo L("ID");?><?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('duobao_name','<?php echo ($sort); ?>','Duobao','index')" title="按照商品名称    <?php echo ($sortType); ?> ">商品名称    <?php if(($order)  ==  "duobao_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('cate_name','<?php echo ($sort); ?>','Duobao','index')" title="按照分类名称    <?php echo ($sortType); ?> ">分类名称    <?php if(($order)  ==  "cate_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('brand_name','<?php echo ($sort); ?>','Duobao','index')" title="按照品牌名称    <?php echo ($sortType); ?> ">品牌名称    <?php if(($order)  ==  "brand_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('max_buy','<?php echo ($sort); ?>','Duobao','index')" title="按照总需人次     <?php echo ($sortType); ?> ">总需人次     <?php if(($order)  ==  "max_buy"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('min_buy','<?php echo ($sort); ?>','Duobao','index')" title="按照最小投单量     <?php echo ($sortType); ?> ">最小投单量     <?php if(($order)  ==  "min_buy"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('max_schedule','<?php echo ($sort); ?>','Duobao','index')" title="按照最大举办期数     <?php echo ($sortType); ?> ">最大举办期数     <?php if(($order)  ==  "max_schedule"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('current_schedule','<?php echo ($sort); ?>','Duobao','index')" title="按照已开期数     <?php echo ($sortType); ?> ">已开期数     <?php if(($order)  ==  "current_schedule"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('robot_is_db','<?php echo ($sort); ?>','Duobao','index')" title="按照夺宝机器人     <?php echo ($sortType); ?> ">夺宝机器人     <?php if(($order)  ==  "robot_is_db"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('is_effect','<?php echo ($sort); ?>','Duobao','index')" title="按照有效<?php echo ($sortType); ?> ">有效<?php if(($order)  ==  "is_effect"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$duobao): ++$i;$mod = ($i % 2 )?><tr class="row" ><td><input type="checkbox" name="key" class="key" value="<?php echo ($duobao["id"]); ?>"></td><td>&nbsp;<?php echo ($duobao["id"]); ?></td><td>&nbsp;<?php echo ($duobao["duobao_name"]); ?></td><td>&nbsp;<?php echo ($duobao["cate_name"]); ?></td><td>&nbsp;<?php echo ($duobao["brand_name"]); ?></td><td>&nbsp;<?php echo ($duobao["max_buy"]); ?></td><td>&nbsp;<?php echo ($duobao["min_buy"]); ?></td><td>&nbsp;<?php echo ($duobao["max_schedule"]); ?></td><td>&nbsp;<?php echo (get_current_schedule($duobao["current_schedule"],$duobao['id'])); ?></td><td>&nbsp;<?php echo (get_status($duobao["robot_is_db"])); ?></td><td>&nbsp;<?php echo (get_toogle_status($duobao["is_effect"],$duobao['id'],is_effect)); ?></td><td> <?php echo (get_handle($duobao["id"],$duobao)); ?>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="12" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->


<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>