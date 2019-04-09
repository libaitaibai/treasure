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
<script type="text/javascript" src="__TMPL__Common/js/deal_order.js"></script>

<div class="main">
<div class="main_title"><?php if($order_info['order_status'] == 0): ?><?php echo L("DEAL_ORDER_HANDLE");?><?php else: ?><?php echo L("DEAL_ORDER_VIEW");?><?php endif; ?><?php echo ($order_info["order_sn"]); ?>

</div>
<div class="blank5"></div>

<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=4 class="topTd"></td>
	</tr>
	<tr>
		<td class="item_title"><?php echo L("ORDER_USER");?>:</td>
		<td class="item_input">
			<?php echo (get_user_name_js($order_info["user_id"])); ?>
		</td>
		<td class="item_title">订单状态:</td>
		<td class="item_input">
			<?php echo (get_order_status($order_info["order_status"],$order_info)); ?>
		</td>
	</tr>
	<tr>
		<td class="item_title"><?php echo L("ORDER_SN");?>:</td>
		<td class="item_input"><?php echo ($order_info["order_sn"]); ?></td>
		<td class="item_title"><?php echo L("ORDER_CREATE_TIME");?>:</td>
		<td class="item_input"><?php echo (to_date($order_info["create_time"])); ?></td>
	</tr>	
	<tr>
		<td class="item_title"><?php echo L("ORDER_PAY_STATUS");?>:</td>
		<td class="item_input"><?php echo (get_pay_status($order_info["pay_status"])); ?>

		</td>
		<td class="item_title"> </td>
		<td class="item_input"> </td>
	</tr>
	<tr>
		<th colspan=4><?php echo L("PAYMENT_INFORMATION");?></th>
	</tr>
	<tr>
		<td class="item_title"><?php echo L("ORDER_TOTAL_PRICE");?>:</td>
		<td class="item_input"><?php echo (format_price($order_info["total_price"])); ?></td>
		<td class="item_title"><?php echo L("INCHARGE_AMOUNT");?>:</td>
		<td class="item_input"><?php echo (format_price($order_info["pay_amount"])); ?></td>
	</tr>
	<tr>
		<td class="item_title"><?php echo L("ACCOUNT_PAYMENT");?>:</td>
		<td class="item_input"><?php echo (format_price($order_info["account_money"])); ?></td>
		<td class="item_title">红包支付:</td>
		<td class="item_input"><?php echo (format_price($order_info["ecv_money"])); ?></td>
	</tr>
	<tr>
		<!-- <td class="item_title"><?php echo L("ORDER_DEAL_TOTAL_PRICE");?>:</td>
		<td class="item_input"><?php echo (format_price($order_info["deal_total_price"])); ?></td> -->
		<td class="item_title">积分返还:</td>
		<td class="item_input"><?php echo (abs($order_info["return_total_score"])); ?>积分</td>
		<td class="item_title">退款总额:</td>
		<td class="item_input"><?php echo (format_price($order_info["refund_amount"])); ?></td>		
	</tr>
	<?php if($order_info['payment_id'] > 0): ?><tr>
		<td class="item_title"><?php echo L("PAYMENT_METHOD");?>:</td>
		<td class="item_input"><?php echo (get_payment_name($order_info["payment_id"])); ?></td>
		<td class="item_title"><?php echo L("FEE_AMOUNT");?>:</td>
		<td class="item_input"><?php echo (format_price($order_info["payment_fee"])); ?></td>
	</tr><?php endif; ?>
	
	<tr>
		<td colspan=4 class="bottomTd"></td>
	</tr>
</table>
<div class="blank5"></div>

<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=2 class="topTd"></td>
	</tr>
	<tr>
		<th colspan=2>夺宝活动列表</th>
	</tr>
	<tr>
		<th>活动名称</th>
		<th width=150>购买人次</th>		
	</tr>
	<?php if(is_array($order_deals)): foreach($order_deals as $key=>$deal_item): ?><tr>
		<td><?php echo ($deal_item["name"]); ?></td>
		<td><?php echo ($deal_item["number"]); ?></td>		
	</tr><?php endforeach; endif; ?>
	<tr>
		<td colspan=2 class="bottomTd"></td>
	</tr>
</table>

<?php if($payment_notice): ?><div class="blank5"></div>

<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=6 class="topTd"></td>
	</tr>
	<tr>
		<th colspan=6><?php echo L("PAYMENT_NOTICE");?></th>
	</tr>
	<tr>
		<th><?php echo L("PAYMENT_NOTICE_SN");?></th>
		<th><?php echo L("OUTER_NOTICE_SN");?></th>
		<th><?php echo L("PAY_TIME");?></th>
		<th><?php echo L("PAYMENT_AMOUNT");?></th>
		<th><?php echo L("PAYMENT_METHOD");?></th>
		<th><?php echo L("PAYMENT_MEMO");?></th>
	</tr>
	<?php if(is_array($payment_notice)): foreach($payment_notice as $key=>$notice_item): ?><tr>
		<td><?php echo ($notice_item["notice_sn"]); ?></td>
		<td><?php echo ($notice_item["outer_notice_sn"]); ?></td>
		<td><?php echo (to_date($notice_item["pay_time"])); ?></td>
		<td><?php echo (format_price($notice_item["money"])); ?></td>
		<td><?php echo (get_payment_name($notice_item["payment_id"])); ?></td>
		<td><?php echo ($notice_item["memo"]); ?></td>
		
	</tr><?php endforeach; endif; ?>
	<tr>
		<td colspan=6 class="bottomTd"></td>
	</tr>
</table><?php endif; ?>

<?php if($log_list): ?><div class="blank5"></div>
	<table class="form" cellpadding=0 cellspacing=0>
		<tr>
		<td colspan=2 class="topTd"></td>
		</tr>
		<tr><th colspan=2><?php echo L("ORDER_LOG");?></th></tr>
			<?php if(is_array($log_list)): foreach($log_list as $key=>$log_item): ?><tr>
				<td><?php echo ($log_item["log_info"]); ?></td>
				<td><?php echo (to_date($log_item["log_time"])); ?></td>
			</tr><?php endforeach; endif; ?>
		<tr>
		<td colspan=2 class="bottomTd"></td>
		</tr>
	</table><?php endif; ?>

</div>
</body>
</html>