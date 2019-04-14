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
<?php function get_handle($id, $duobaoItem)
	{
		$str.="<a href='javascript:del_duobao(".$id.");'>".l("DEL")."</a>";
		if($duobaoItem['success_time']==0)
		{
			$str.="&nbsp;<a href='javascript:prepare_lottery(".$id.");'>机器人限时凑单</a>";
			
			if($GLOBALS['db']->getOne("select robot_type from ".DB_PREFIX."duobao where id = ".$duobaoItem['duobao_id'])==1)
			{
				$str.="&nbsp;<a href='javascript:prepare_lottery_1(".$id.");'>机器人设定凑单</a>";
			}
		}
		if($duobaoItem['success_time']>0&&$duobaoItem['has_lottery']==0)
		{
			if($duobaoItem['fair_type']=="yydb")
			$str.="&nbsp;<a href='javascript:draw_lottery_yydb(".$id.",".$duobaoItem['max_buy'].");'>人工开奖</a>";
			else
			$str.="&nbsp;<a href='javascript:draw_lottery(".$id.");'>人工开奖</a>";
		}
		if($duobaoItem['user_is_robot']==1&&$duobaoItem['has_lottery']==1){
			if($duobaoItem['is_send_share']==1){
			$str.="&nbsp;<a href='".u("DuobaoItem/robot_share_view",array("id"=>$id))."'>查看晒单</a>";
			}else{
			$str.="&nbsp;<a href='".u("DuobaoItem/robot_share_add",array("id"=>$id))."'>机器人晒单</a>";
			}
		}
		return $str;
	}
	
	function get_has_lottery($has_lottery){
		if($has_lottery == 1){
			$str = '已开奖';
		}else{
			$str = '未开奖';
		}
		return $str;
	}
	
	function get_current_buy($current_id, $duobao_id){
		$str = "<a href='".u("DuobaoItemLog/index",array("duobao_item_id"=>$duobao_id))."'>".$current_id."</a>";
		return $str;
	}
	function get_is_robot($is)
	{
		if($is==="1")
			return "是";
		if($is==="0")
			return "否";
		else
			return ;
	} ?>
<script type="text/javascript">
//完全删除
function del_duobao(id)
{
	if(!id)
	{
		idBox = $(".key:checked");
		if(idBox.length == 0)
		{
			alert(LANG['DELETE_EMPTY_WARNING']);
			return;
		}
		idArray = new Array();
		$.each( idBox, function(i, n){
			idArray.push($(n).val());
		});
		id = idArray.join(",");
	}
	if(confirm(LANG['CONFIRM_DELETE']+"此删除属于强制删除无法恢复，同时会删除开奖号，活动订单关联数据及晒单，并无法自动退款。删除量大时，请勿刷新页面，避免删除失败。"))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=foreverdelete&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				
				if(obj.status==1)
				{
					$("#info").html(obj.info);
					location.href=location.href;
				}
				else
				{
					if(confirm("确定要删除正在进行中的夺活活动数据吗？"))
					{
						$.ajax({ 
								url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=foreverdelete&force=1&id="+id, 
								data: "ajax=1",
								dataType: "json",
								success: function(obj){
									$("#info").html(obj.info);
									if(obj.status==1)
									{										
										location.href=location.href;
									}
								}
						});
					}
				}
			}
	});
}
	function prepare_lottery(id)
	{
		if(confirm("如人数未满将被机器人补全,5分钟左右将进入开奖等待，确定吗？"))
		$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=prepare_lottery&id="+id, 
				data: "ajax=1",
				dataType: "json",
				success: function(obj){
					alert(obj.info);
					if(obj.status==1)
					location.href=location.href;
				}
		});
	}
	
	function prepare_lottery_1(id)
	{
		if(confirm("重新开启一条已设定的机器人凑单，确定吗？"))
		$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=prepare_lottery_1&id="+id, 
				data: "ajax=1",
				dataType: "json",
				success: function(obj){
					alert(obj.info);
					if(obj.status==1)
					location.href=location.href;
				}
		});
	}
	
	function draw_lottery(id)
	{
		if(confirm("是否立即人工开奖，如未到开奖时间，则将使用默认开奖数值B")) 
		$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=draw_lottery&id="+id, 
				data: "ajax=1",
				dataType: "json",
				success: function(obj){
					alert(obj.info);
					if(obj.status==1)
					location.href=location.href;
				}
		});
	}
	
	function draw_lottery_yydb(id,max)
	{
		var lottery_sn = prompt("请输入中奖号，如输入的中奖号非法，系统将随机开奖","请输入1-"+max+"之间的任一整数");
		if(lottery_sn!=null)
		{
			var draw_lottery = true;
			if(isNaN(lottery_sn)||lottery_sn<1||lottery_sn>max)
			{
				if(confirm("非法的中奖号，是否要随机开奖？"))
					draw_lottery = true;
				else 
					draw_lottery = false;
			}

			if(draw_lottery)
			$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=draw_lottery&id="+id+"&lottery_sn="+lottery_sn, 
				data: "ajax=1",
				dataType: "json",
				success: function(obj){
					alert(obj.info);
					if(obj.status==1)
					location.href=location.href;
				}
			});
		}
		
		
	}
	
	
</script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.weebox.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weebox.css" />
<div class="main">
<div class="main_title">夺宝活动列表</div>
<div class="blank5"></div>
<form name="search" action="__APP__" method="get">	
<div class="search_row">

		期号：<input type="text" class="textbox" name="id" value="<?php echo strim($_REQUEST['id']);?>" style="width:100px;" />
		商品名称：<input type="text" class="textbox" name="duobaoitem_name" value="<?php echo strim($_REQUEST['duobaoitem_name']);?>" style="width:100px;" />
		人需已满:
		<select name="is_success">
			<option value="-1" <?php if(intval($_REQUEST['is_success']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="0" <?php if(intval($_REQUEST['is_success']) == '0'): ?>selected="selected"<?php endif; ?>>否</option>
			<option value="1" <?php if(intval($_REQUEST['is_success']) == '1'): ?>selected="selected"<?php endif; ?>>是</option>
		</select>
		
		
		开奖等待：
		<select name="prepare_lottery">
			<option value="-1" <?php if(intval($_REQUEST['prepare_lottery']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="0" <?php if(intval($_REQUEST['prepare_lottery']) == '0'): ?>selected="selected"<?php endif; ?>>否</option>
			<option value="1" <?php if(intval($_REQUEST['prepare_lottery']) == '1'): ?>selected="selected"<?php endif; ?>>是</option>
		</select>
		
		已开奖：
		<select name="has_lottery">
			<option value="-1" <?php if(intval($_REQUEST['has_lottery']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="0" <?php if(intval($_REQUEST['has_lottery']) == '0'): ?>selected="selected"<?php endif; ?>>否</option>
			<option value="1" <?php if(intval($_REQUEST['has_lottery']) == '1'): ?>selected="selected"<?php endif; ?>>是</option>
		</select>
		
		机器人：
		<select name="user_is_robot">
			<option value="-1" <?php if(intval($_REQUEST['user_is_robot']) == '-1'): ?>selected="selected"<?php endif; ?>>全部</option>
			<option value="0" <?php if(intval($_REQUEST['user_is_robot']) == '0'): ?>selected="selected"<?php endif; ?>>否</option>
			<option value="1" <?php if(intval($_REQUEST['user_is_robot']) == '1'): ?>selected="selected"<?php endif; ?>>是</option>
		</select>
		
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
		
		<input type="hidden" value="DuobaoItem" name="m" />
		<input type="hidden" value="index" name="a" />
		
		<input type="submit" class="button" value="<?php echo L("SEARCH");?>" />
		<input type="button" class="button" value="删除" onclick="del_duobao();" />
</div>
</form>
<div class="blank5"></div>
<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="19" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="8"><input type="checkbox" id="check" onclick="CheckAll('dataTable')"></th><th width="50px    "><a href="javascript:sortBy('id','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照期号<?php echo ($sortType); ?> ">期号<?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('duobao_id','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照夺宝编号    <?php echo ($sortType); ?> ">夺宝编号    <?php if(($order)  ==  "duobao_id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('duobaoitem_name','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照商品名称    <?php echo ($sortType); ?> ">商品名称    <?php if(($order)  ==  "duobaoitem_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('user_name','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照中奖人    <?php echo ($sortType); ?> ">中奖人    <?php if(($order)  ==  "user_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('user_is_robot','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照机器人    <?php echo ($sortType); ?> ">机器人    <?php if(($order)  ==  "user_is_robot"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('lottery_sn','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照中奖号码    <?php echo ($sortType); ?> ">中奖号码    <?php if(($order)  ==  "lottery_sn"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('has_lottery','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照开奖状态     <?php echo ($sortType); ?> ">开奖状态     <?php if(($order)  ==  "has_lottery"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('success_time','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照成功时间    <?php echo ($sortType); ?> ">成功时间    <?php if(($order)  ==  "success_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('lottery_time','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照开奖时间      <?php echo ($sortType); ?> ">开奖时间      <?php if(($order)  ==  "lottery_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('fair_sn_local','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照数值A    <?php echo ($sortType); ?> ">数值A    <?php if(($order)  ==  "fair_sn_local"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('fair_sn','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照数值B(第三方公证号)    <?php echo ($sortType); ?> ">数值B(第三方公证号)    <?php if(($order)  ==  "fair_sn"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('fair_period','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照开奖期号    <?php echo ($sortType); ?> ">开奖期号    <?php if(($order)  ==  "fair_period"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('max_buy','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照总需人次    <?php echo ($sortType); ?> ">总需人次    <?php if(($order)  ==  "max_buy"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('current_buy','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照已购人次    <?php echo ($sortType); ?> ">已购人次    <?php if(($order)  ==  "current_buy"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('progress','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照进度    <?php echo ($sortType); ?> ">进度    <?php if(($order)  ==  "progress"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('sort','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照<?php echo L("SORT");?>     <?php echo ($sortType); ?> "><?php echo L("SORT");?>     <?php if(($order)  ==  "sort"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('is_effect','<?php echo ($sort); ?>','DuobaoItem','index')" title="按照有效<?php echo ($sortType); ?> ">有效<?php if(($order)  ==  "is_effect"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$duobaoItem): ++$i;$mod = ($i % 2 )?><tr class="row" ><td><input type="checkbox" name="key" class="key" value="<?php echo ($duobaoItem["id"]); ?>"></td><td>&nbsp;<?php echo ($duobaoItem["id"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["duobao_id"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["duobaoitem_name"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["user_name"]); ?></td><td>&nbsp;<?php echo (get_is_robot($duobaoItem["user_is_robot"])); ?></td><td>&nbsp;<?php echo ($duobaoItem["lottery_sn"]); ?></td><td>&nbsp;<?php echo (get_has_lottery($duobaoItem["has_lottery"])); ?></td><td>&nbsp;<?php echo (to_date($duobaoItem["success_time"])); ?></td><td>&nbsp;<?php echo (to_date($duobaoItem["lottery_time"])); ?></td><td>&nbsp;<?php echo ($duobaoItem["fair_sn_local"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["fair_sn"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["fair_period"]); ?></td><td>&nbsp;<?php echo ($duobaoItem["max_buy"]); ?></td><td>&nbsp;<?php echo (get_current_buy($duobaoItem["current_buy"],$duobaoItem['id'])); ?></td><td>&nbsp;<?php echo ($duobaoItem["progress"]); ?></td><td>&nbsp;<?php echo (get_sort($duobaoItem["sort"],$duobaoItem['id'])); ?></td><td>&nbsp;<?php echo (get_toogle_status($duobaoItem["is_effect"],$duobaoItem['id'],is_effect)); ?></td><td> <?php echo (get_handle($duobaoItem["id"],$duobaoItem)); ?>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="19" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->


<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>