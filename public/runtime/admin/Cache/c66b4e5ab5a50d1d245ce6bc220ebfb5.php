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

<script type="text/javascript" src="__TMPL__Common/js/duobao.js"></script>
<div class="main">
<div class="main_title">编辑夺宝计划 <a href="<?php echo u("Duobao/index");?>" class="back_list"> 返回列表</a></div>
<div class="blank5"></div>
<form name="edit" action="__APP__" method="post" enctype="multipart/form-data">
<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=2 class="topTd"></td>
	</tr>
	<tr>
		<td class="item_title">商品名称:</td>
		<td class="item_input">
			<select class="require" name="deal_id">
				<option value="0">==未选取商品==</option>
				<?php if($result): ?><option value="<?php echo ($result["deal_id"]); ?>" selected="selected" price="<?php echo ($result["origin_price"]); ?>"><?php echo ($result["duobao_name"]); ?></option><?php endif; ?>
			</select>
			<input type="text" class="textbox" name="deal_key" /> 
			<input type="button" name="deal_key_btn" class="button" value="搜索" />
		</td>
	</tr>
	
	
	 
	<tr>
		<td class="item_title">专区:</td>
		<td class="item_input">
			<select class="require" name="buy_type">
				<option <?php if($result['buy_type'] == 1): ?>selected="selected"<?php endif; ?> value="1">一元购</option>
				<option <?php if($result['buy_type'] == 10): ?>selected="selected"<?php endif; ?> value="10">十元区</option>
				<option <?php if($result['buy_type'] == 100): ?>selected="selected"<?php endif; ?> value="100">百元区</option>
			</select><!-- 新字段，数据库不存在，一元购：min_buy为1，unit_price为1,  十元区：min_buy为10，unit_price为1,  百元区：min_buy为1，unit_price为100 -->
			<span class="tip_span">[ 总次数  / 专区数 = 总需人次 ]</span>
		</td>
	</tr>
	<!--<tr>-->
		<!--<td class="item_title">免费购专区:</td>-->
		<!--<td class="item_input">-->
			<!--<lable>是<input type="radio" name="is_coupons" value="1" <?php if($result['is_coupons']==1): ?>checked='checked'<?php endif; ?> /></lable>-->
			<!--<lable>否<input type="radio" name="is_coupons" value="0" <?php if($result['is_coupons'] == 0): ?>checked="checked"<?php endif; ?> /></lable>-->
		<!--</td>-->
	<!--</tr>-->
	<tr id="tr_totalbuy">
		<td class="item_title">参与直购:</td>
		<td class="item_input">
			<lable>是<input type="radio" name="is_total_buy" value="1" <?php if($result['is_total_buy'] == 1): ?>checked="checked"<?php endif; ?> /></lable>
			<lable>否<input type="radio" name="is_total_buy" value="0" <?php if($result['is_total_buy'] == 0): ?>checked="checked"<?php endif; ?> /></lable>
			<span class="tip_span">参与直购的活动，需要在“商品管理”设置库存</span>
		</td>
	</tr>
	
	<tr id="total_buy_price">
		<td class="item_title">直购价格:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="total_buy_price" value="<?php echo ($result["total_buy_price"]); ?>" />
			<span class="tip_span">直购一次性购买的价格</span>
		</td>
	</tr>
	
	<tr id="tr_limit_buy">
		<td class="item_title">限购:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="user_max_buy" value="<?php echo ($result["user_max_buy"]); ?>" />
			<span class="tip_span">非直购商品，每人可购人次，0表示不限购</span>
		</td>
	</tr>
	
	<tr>
		<td class="item_title">总需人次:</td>
		<td class="item_input">
			<input type="text" class="textbox require" name="max_buy" value="<?php echo ($result["real_max_buy"]); ?>" />
			<span class="tip_span">[ × <span class="set_min_buy"><?php echo ($result['min_buy']); ?></span> ]</span>
		</td>
	</tr>
	 
	<tr>
		<td class="item_title">最大举办期数:</td>
		<td class="item_input">
			<input type="text" class="textbox require" name="max_schedule" value="<?php echo ($result["max_schedule"]); ?>" />
		</td>
	</tr>
	
	<tr>
		<td class="item_title">夺宝返还积分:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="duobao_score" value="<?php echo ($result["duobao_score"]); ?>" />
		</td>
	</tr>
	
	<tr>
		<td class="item_title">推荐人积分:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="invite_score" value="<?php echo ($result["invite_score"]); ?>" />
		</td>
	</tr>

    <tr>
        <td class="item_title">极速专区:</td>
        <td class="item_input">
            <lable>是<input type="radio" name="is_topspeed" value="1" <?php if($result['is_topspeed']==1): ?>checked='checked'<?php endif; ?> /></lable>
            <lable>否<input type="radio" name="is_topspeed" value="0" <?php if($result['is_topspeed']==0): ?>checked='checked'<?php endif; ?>/></lable>
        </td>
    </tr>
    <tr>
        <td class="item_title">特殊专区:</td>
        <td class="item_input">
            <select name="spectial_area">
                <option value="0" <?php if($result['is_number_choose']==0&&$result['is_pk']==0&&$result['is_coupons']==0): ?>selected="selected"<?php endif; ?> >==不选择==</option>
                <option value="1" <?php if($result['is_number_choose']==1): ?>selected="selected"<?php endif; ?> >选号专区</option>
                <option value="2" <?php if($result['is_pk']==1): ?>selected="selected"<?php endif; ?> >pk专区</option>
                <option value="3" <?php if($result['is_coupons']==1): ?>selected="selected"<?php endif; ?> >免费云购</option>
            </select>
            <span class="tip_span">开启极速专区之后,该专区的活动不显示在极速专区</span>
        </td>
    </tr>
    <tr id="tr_pk_min_number" style="display:none;">
        <td class="item_title">pk专区最小购买人数:</td>
        <td class="item_input">
            <input type="text" class="textbox" size=5 min="1" name="pk_min_number" value="<?php echo ($result['pk_min_number']); ?>" />
            <span class="tip_span">最小购买人数为总人次的约数,否则最小购买人数会偏大</span>
        </td>
    </tr>
	<tr id="fair_type">
		<td class="item_title">数值B开奖方式:</td>
		<td class="item_input">
			<select name="fair_type">
				<option value="wy" <?php if($result['fair_type'] == 'wy'): ?>selected<?php endif; ?>>时时彩</option>
				<option value="yydb" <?php if($result['fair_type'] == 'yydb'): ?>selected<?php endif; ?>>站内开奖（可人工指定）</option>
			</select>
		</td>
	</tr>
	
	<tr id="tr_is_robot">
		<td class="item_title">开启机器人:</td>
		<td class="item_input">
			<lable>是<input type="radio" name="robot_is_db" value="1" <?php if($result['robot_is_db'] == 1): ?>checked="checked"<?php endif; ?> /></lable>
			<lable>否<input type="radio" name="robot_is_db" value="0" <?php if($result['robot_is_db'] == 0): ?>checked="checked"<?php endif; ?> /></lable>
			
			<label id="robot_is_lottery"> 机器人必中 <input type="checkbox" name="robot_is_lottery" value="1" <?php if($result['robot_is_lottery'] == 1): ?>checked="checked"<?php endif; ?> /></label>
		</td>
	</tr>
	
	<tr id="robot_type">
		<td class="item_title">机器人夺宝方式:</td>
		<td class="item_input">
			<select name="robot_type">
				<option value="0" <?php if($result['robot_type'] == '0'): ?>selected<?php endif; ?>>按截止时间</option>
				<option value="1" <?php if($result['robot_type'] == '1'): ?>selected<?php endif; ?>>按指定频率</option>
			</select>
		</td>
	</tr>
	
	<tr id="robot_buy_time">
		<td class="item_title">机器人每次下单间隔:</td>
		<td class="item_input">
			<input type="text" class="textbox" size=5 value="<?php echo ($result["robot_buy_min_time"]); ?>" name="robot_buy_min_time"  />
			-
			<input type="text" class="textbox" size=5 value="<?php echo ($result["robot_buy_max_time"]); ?>" name="robot_buy_max_time" /> 秒
		</td>
	</tr>
	
	<tr id="robot_buy">
		<td class="item_title">机器人每次下单数量:</td>
		<td class="item_input">
			<input type="text" class="textbox" size=5 value="<?php echo ($result["robot_buy_min"]); ?>" name="robot_buy_min" />
			-
			<input type="text" class="textbox" size=5 value="<?php echo ($result["robot_buy_max"]); ?>" name="robot_buy_max" /> 次
		</td>
	</tr>
	<tr id="tr_is_recomend">
		<td class="item_title">前台推荐:</td>
		<td class="item_input">
			<lable>是<input type="radio" name="is_recomend" value="1" <?php if($result['is_recomend'] == 1): ?>checked="checked"<?php endif; ?> /></lable>
			<lable>否<input type="radio" name="is_recomend" value="0" <?php if($result['is_recomend'] == 0): ?>checked="checked"<?php endif; ?> /></lable>
		</td>
	</tr>
	
	<tr id="robot_is_db_box">
		<td class="item_title">夺宝时长:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="robot_end_time" value="<?php echo ($result["robot_end_time"]); ?>" />
			<span class="tip_span">[单位：分钟]</span>
		</td>
	</tr>
	
	 
	
	
	 
	<tr>
		<td class="item_title"></td>
		<td class="item_input">
			<!--隐藏元素-->			
			<input type="hidden" name="<?php echo conf("VAR_MODULE");?>" value="Duobao" />
			<input type="hidden" name="<?php echo conf("VAR_ACTION");?>" value="update" />
			<input type="hidden" name="id" value="<?php echo ($result['id']); ?>" />
			<input type="hidden" name="is_effect" value="1" />
            <input type="hidden" name="min_buy" value="<?php echo ($result['min_buy']); ?>" />
            <input type="hidden" name="unit_price" value="<?php echo ($result['unit_price']); ?>"/>
			<!--隐藏元素-->
			<input type="submit" class="button" value="编辑" />
			<input type="reset" class="button" value="重置" />
		</td>
	</tr>
	<tr>
		<td colspan=2 class="bottomTd"></td>
	</tr>
</table>	 
</form>
</div>
</body>
</html>