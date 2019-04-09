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

<script type="text/javascript" src="__TMPL__Common/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.weebox.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/user.js"></script>

<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weebox.css" />
<script type="text/javascript">
function del(id)
{

	if(confirm(LANG['CONFIRM_DELETE']))
	$.ajax({ 
			url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=del_withdrawal&id="+id, 
			data: "ajax=1",
			dataType: "json",
			success: function(obj){
				$("#info").html(obj.info);
				if(obj.status==1)
				location.href=location.href;
			}
	});
}

function edit(id)
{
	var is_can = true;
	$.ajax({ 
		url: ROOT+'?m=FxUser&a=edit_referrer&id='+id, 
		data: "ajax=1",
		dataType: "json",
		async: true,
		success: function(obj){

			if(data.status==0)
			{
				is_can = false;
				alert('无法修改推荐人');
				
			}
		}
	});
	
	if(is_can){
		$.weeboxs.open(ROOT+'?m=FxUser&a=edit_referrer&id='+id, {contentType:'ajax',showButton:false,title:"修改推荐人",width:600,height:150});
	}
	
}

function edit_remark(id)
{
	$.weeboxs.open(ROOT+'?m=FxUser&a=edit_remark&id='+id, {contentType:'ajax',showButton:false,title:"渠道标注",width:600,height:150});
}

function toogle_status(id,domobj,field)
{
	$.ajax({ 
		url: ROOT+"?"+VAR_MODULE+"="+'User'+"&"+VAR_ACTION+"=toogle_status&field="+field+"&id="+id, 
		data: "ajax=1",
		dataType: "json",
		success: function(obj){

			if(obj.data=='1')
			{
				$(domobj).html(LANG['YES']);
			}
			else if(obj.data=='0')
			{
				$(domobj).html(LANG['NO']);
			}
			else if(obj.data=='')
			{
				
			}
			$("#info").html(obj.info);
		}
	});
}

function close_fx_all(){
	if(!confirm("确定“关闭”所有用户渠道二维码功能？")){
		return false;
	}
	 
	$.ajax({ 
		url: ROOT+"?"+VAR_MODULE+"="+'FxUser'+"&"+VAR_ACTION+"=close_fx_all", 
		data: "ajax=1",
		dataType: "json",
		success: function(obj){
			if(obj.status == 1){
				location.reload();
			}else{
				alert('设置失败');
			}
			 
		}
	});
}

function open_fx_all(){
	if(!confirm("确定“开启”所有用户渠道二维码功能？")){
		return false;
	}
 
	$.ajax({ 
		url: ROOT+"?"+VAR_MODULE+"="+'FxUser'+"&"+VAR_ACTION+"=open_fx_all", 
		data: "ajax=1",
		dataType: "json",
		success: function(obj){
			if(obj.status == 1){
				location.reload();
			}else{
				alert('设置失败');
			}
		}
	});
}

</script>
<?php function get_referrals_name($user_id)
	{
		$user_name = M("User")->where("id=".$user_id)->getField("user_name");
		if($user_name)
		return $user_name;
		else
		return l("NO_REFERRALS");
	}
	
	function get_money($user_id, $pid)
	{
		$m = new Model();
		$result = $m->query("select  round(ifnull(sum(money),0), 2)  total_money from ".DB_PREFIX."fx_user_reward where user_id=".$user_id." and  pid = ".$pid);
		return $result[0]['total_money'];
	}
	
	function subordinate($id, $is_open_scan)
	{
		$str= "&nbsp;<a href='".u("FxUser/index",array("user_id"=>$id))."'>查看下线会员</a>&nbsp;";
		$str.= "&nbsp;<a href='".u("FxUser/money_log",array("user_id"=>$id))."'>查看分销资金日志</a>&nbsp;";
		if($is_open_scan){
			$str.= "&nbsp;<a href='".u("FxUser/get_scan",array("user_id"=>$id))."'>渠道二维码</a>&nbsp;";
		}
		$str.= '&nbsp;<a href=javascript:edit_remark("'.$id.'")>渠道标注</a>&nbsp;'; 
		$str.= "&nbsp;<a href='".u("DuobaoOrder/index",array("user_id"=>$id))."'>查看订单</a>&nbsp;";
		
		return $str;
	} ?>
<div class="main">
<div class="main_title">分销会员</div>
<div class="blank5"></div>
<div class="button_row">
	
	
</div>

<div class="blank5"></div>
<?php if(intval($_REQUEST['user_id']) ): ?>给上级用户（<?php echo ($user_name); ?>）的佣金统计:<br /><br />

累积营业额：<?php echo ($money_data["fx_total_money"]); ?>， 累积利润：<?php echo ($money_data["fx_total_balance"]); ?><br /><br />

一级分销佣金：<?php echo ($money_data["one_info"]["total_money"]); ?>， 
一级分销订单金额：<?php echo ($money_data["one_info"]["total_order_money"]); ?>
<br /><br />
二级分销佣金：<?php echo ($money_data["two_info"]["total_money"]); ?>， 
二级分销订单金额：<?php echo ($money_data["two_info"]["total_order_money"]); ?>
<br /><br />
三级分销佣金：<?php echo ($money_data["three_info"]["total_money"]); ?>， 
三级分销订单金额：<?php echo ($money_data["three_info"]["total_order_money"]); ?><br /><br /><?php endif; ?>
<div class="blank5"></div>
<div class="search_row">
	<form name="search" action="__APP__" method="get">	
		用户ID：<input type="text" class="textbox" name="id" value="<?php echo strim($_REQUEST['id']);?>" style="width:100px;" />
		<?php echo L("USER_NAME");?>：<input type="text" class="textbox" name="user_name" value="<?php echo strim($_REQUEST['user_name']);?>" style="width:100px;" />
		<?php echo L("USER_EMAIL");?>：<input type="text" class="textbox" name="email" value="<?php echo strim($_REQUEST['email']);?>" style="width:100px;" />
		<?php echo L("USER_MOBILE");?>：<input type="text" class="textbox" name="mobile" value="<?php echo strim($_REQUEST['mobile']);?>" style="width:100px;" />
		<?php echo L("REFERRALS_NAME");?>：<input type="text" class="textbox" name="pid_name" value="<?php echo strim($_REQUEST['pid_name']);?>" style="width:100px;" />
		渠道标注：<input type="text" class="textbox" name="remark_name" value="<?php echo strim($_REQUEST['remark_name']);?>" style="width:100px;" />  
<!-- 		<?php echo L("USER_GROUP");?>:  -->
<!-- 		<select name="group_id"> -->
<!-- 				<option value="0" <?php if(intval($_REQUEST['group_id']) == 0): ?>selected="selected"<?php endif; ?>><?php echo L("ALL");?></option> -->
<!-- 				<?php if(is_array($group_list)): foreach($group_list as $key=>$group_item): ?>-->
<!-- 					<option value="<?php echo ($group_item["id"]); ?>" <?php if(intval($_REQUEST['group_id']) == $group_item['id']): ?>selected="selected"<?php endif; ?>><?php echo ($group_item["name"]); ?></option> -->
<!--<?php endforeach; endif; ?> -->
<!-- 		</select> -->
		
		<input type="hidden" value="FxUser" name="m" />
		<input type="hidden" value="index" name="a" />
		<input type="submit" class="button" value="<?php echo L("SEARCH");?>" />
	</form>
	<br />
	 
		渠道： 
		<span style="color:black;font-size:12px; font-weight:normal">全部</span>
		<button onclick="open_fx_all();">开启</button>
		<button onclick="close_fx_all();" >关闭</button>
	 
</div>

<div class="blank5"></div>

<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="10" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="50px"><a href="javascript:sortBy('id','<?php echo ($sort); ?>','FxUser','index')" title="按照<?php echo L("ID");?><?php echo ($sortType); ?> "><?php echo L("ID");?><?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('user_name','<?php echo ($sort); ?>','FxUser','index')" title="按照<?php echo L("USER_NAME");?><?php echo ($sortType); ?> "><?php echo L("USER_NAME");?><?php if(($order)  ==  "user_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('fx_total_money','<?php echo ($sort); ?>','FxUser','index')" title="按照分销历史总营业额<?php echo ($sortType); ?> ">分销历史总营业额<?php if(($order)  ==  "fx_total_money"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('fx_total_balance','<?php echo ($sort); ?>','FxUser','index')" title="按照分销历史累计利润<?php echo ($sortType); ?> ">分销历史累计利润<?php if(($order)  ==  "fx_total_balance"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('id','<?php echo ($sort); ?>','FxUser','index')" title="按照给上级的利润<?php echo ($sortType); ?> ">给上级的利润<?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('pid','<?php echo ($sort); ?>','FxUser','index')" title="按照<?php echo L("REFERRALS_NAME");?><?php echo ($sortType); ?> "><?php echo L("REFERRALS_NAME");?><?php if(($order)  ==  "pid"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('remark_name','<?php echo ($sort); ?>','FxUser','index')" title="按照渠道标注<?php echo ($sortType); ?> ">渠道标注<?php if(($order)  ==  "remark_name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('is_fx','<?php echo ($sort); ?>','FxUser','index')" title="按照分销状态<?php echo ($sortType); ?> ">分销状态<?php if(($order)  ==  "is_fx"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('is_open_scan','<?php echo ($sort); ?>','FxUser','index')" title="按照渠道开启<?php echo ($sortType); ?> ">渠道开启<?php if(($order)  ==  "is_open_scan"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$user): ++$i;$mod = ($i % 2 )?><tr class="row" ><td>&nbsp;<?php echo ($user["id"]); ?></td><td>&nbsp;<?php echo ($user["user_name"]); ?></td><td>&nbsp;<?php echo (format_price($user["fx_total_money"])); ?></td><td>&nbsp;<?php echo (format_price($user["fx_total_balance"])); ?></td><td>&nbsp;<?php echo (get_money($user["id"],$user['pid'])); ?></td><td>&nbsp;<?php echo (get_referrals_name($user["pid"])); ?></td><td>&nbsp;<?php echo ($user["remark_name"]); ?></td><td>&nbsp;<?php echo (get_is_effect($user["is_fx"],$user['id'])); ?></td><td>&nbsp;<?php echo (get_toogle_status($user["is_open_scan"],$user['id'],is_open_scan)); ?></td><td><a href="javascript:edit('<?php echo ($user["id"]); ?>')">修改推荐人</a>&nbsp; <?php echo (subordinate($user["id"],$user['is_open_scan'])); ?>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="10" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->
 

<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>