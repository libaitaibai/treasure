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

<?php function get_send_types($type)
	{
		if($type==0)
		{
			return l("ADMIN_SEND");
		}
		elseif($type==2)
		{
			return "序列号领取";
		}
		elseif($type==3){
			return "拆分红包";
		}
		elseif($type==4){
			return "注册送红包";
		}
		elseif($type==5){
			return "充值送红包";
		}
		elseif($type==6){
			return "满返红包";
		}
		elseif($type==7){
			return "分享红包";
		}
		else
		{
			return l("SCORE_EXCHANGE");
		}
	}
	function get_send($id)
	{
		if(M("EcvType")->where("id=".$id)->getField("send_type")==0)
		{
			return "<a href='".u("EcvType/send",array("id"=>$id))."'>".l("SEND_VOUCHER")."</a>";
		}
	}
	
	function get_money($money, $data)
	{
		if($data['sm_way'] == 1){
			$d = json_decode($data['data'], 1);
			return '随机'.$d['rand_value1'].'到'.$d['rand_value2'];
		}else if($data['sm_way'] == 2){
			return round($money, 2).'%';
		}else{
			return round($money, 2);
		}
	} ?>
<script type="text/javascript">
	function view(id)
	{
		location.href = ROOT+"?"+VAR_MODULE+"=Ecv&"+VAR_ACTION+"=index&ecv_type_id="+id+"&";
	}
</script>
<div class="main">
<div class="main_title"><?php echo ($main_title); ?></div>
<div class="blank5"></div>
<div class="button_row">
	<input type="button" class="button" value="<?php echo L("ADD");?>" onclick="add();" />
	<input type="button" class="button" value="<?php echo L("FOREVERDEL");?>" onclick="foreverdel();" />
</div>
<div class="blank5"></div>
<!-- Think 系统列表组件开始 -->
<table id="dataTable" class="dataTable" cellpadding=0 cellspacing=0 ><tr><td colspan="10" class="topTd" >&nbsp; </td></tr><tr class="row" ><th width="8"><input type="checkbox" id="check" onclick="CheckAll('dataTable')"></th><th width="50px  "><a href="javascript:sortBy('id','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("ID");?><?php echo ($sortType); ?> "><?php echo L("ID");?><?php if(($order)  ==  "id"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('name','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_NAME");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_NAME");?>  <?php if(($order)  ==  "name"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('money','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_MONEY");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_MONEY");?>  <?php if(($order)  ==  "money"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('use_limit','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_LIMIT");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_LIMIT");?>  <?php if(($order)  ==  "use_limit"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('begin_time','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_BEGIN_TIME");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_BEGIN_TIME");?>  <?php if(($order)  ==  "begin_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('end_time','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_END_TIME");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_END_TIME");?>  <?php if(($order)  ==  "end_time"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('gen_count','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_GEN_COUNT");?>  <?php echo ($sortType); ?> "><?php echo L("VOUCHER_GEN_COUNT");?>  <?php if(($order)  ==  "gen_count"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th><a href="javascript:sortBy('send_type','<?php echo ($sort); ?>','EcvType','index')" title="按照<?php echo L("VOUCHER_SEND_TYPE");?><?php echo ($sortType); ?> "><?php echo L("VOUCHER_SEND_TYPE");?><?php if(($order)  ==  "send_type"): ?><img src="__TMPL__Common/images/<?php echo ($sortImg); ?>.gif" width="12" height="17" border="0" align="absmiddle"><?php endif; ?></a></th><th >操作</th></tr><?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$article): ++$i;$mod = ($i % 2 )?><tr class="row" ><td><input type="checkbox" name="key" class="key" value="<?php echo ($article["id"]); ?>"></td><td>&nbsp;<?php echo ($article["id"]); ?></td><td>&nbsp;<?php echo ($article["name"]); ?></td><td>&nbsp;<?php echo (get_money($article["money"],$article)); ?></td><td>&nbsp;<?php echo ($article["use_limit"]); ?></td><td>&nbsp;<?php echo (to_date($article["begin_time"])); ?></td><td>&nbsp;<?php echo (to_date($article["end_time"])); ?></td><td>&nbsp;<?php echo ($article["gen_count"]); ?></td><td>&nbsp;<?php echo (get_send_types($article["send_type"])); ?></td><td><a href="javascript:edit('<?php echo ($article["id"]); ?>')"><?php echo L("EDIT");?></a>&nbsp;<a href="javascript:foreverdel('<?php echo ($article["id"]); ?>')"><?php echo L("FOREVERDEL");?></a>&nbsp; <?php echo (get_send($article["id"])); ?>&nbsp;<a href="javascript:view('<?php echo ($article["id"]); ?>')"><?php echo L("VIEW");?></a>&nbsp;</td></tr><?php endforeach; endif; else: echo "" ;endif; ?><tr><td colspan="10" class="bottomTd"> &nbsp;</td></tr></table>
<!-- Think 系统列表组件结束 -->
 

<div class="blank5"></div>
<div class="page"><?php echo ($page); ?></div>
</div>
</body>
</html>