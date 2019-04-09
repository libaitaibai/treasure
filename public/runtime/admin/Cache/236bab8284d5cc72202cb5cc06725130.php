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

<div class="main">
<div class="main_title">编辑商品 <a href="<?php echo u("Deal/index");?>" class="back_list"> 返回列表</a></div>
<div class="blank5"></div>
<form name="edit" action="__APP__" method="post" enctype="multipart/form-data">
<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=2 class="topTd"></td>
	</tr>
	<tr>
		<td class="item_title">商品名称:</td>
		<td class="item_input"><input type="text" class="textbox require" name="name" value="<?php echo ($result['deal_name']); ?>" /></td>
	</tr>
	
	<tr>
		<td class="item_title">成本价:</td>
		<td class="item_input"><input type="text" class="textbox require" name="origin_price" value="<?php echo ($result['origin_price']); ?>" /></td>
	</tr>
	
	<tr>
		<td class="item_title">当前价:</td>
		<td class="item_input"><input type="text" class="textbox require" name="current_price" value="<?php echo ($result['current_price']); ?>" /></td>
	</tr>
	
	<tr>
		<td class="item_title">直购库存:</td>
		<td class="item_input">
			<input type="text" class="textbox" name="total_buy_stock" value="<?php echo ($result["total_buy_stock"]); ?>" />
			<span class="tip_span">注意： 所有夺宝活动的直购，共用这个库存！</span>
		</td>
	</tr>
	 
	<tr>
		<td class="item_title">商品分类:</td>
		<td class="item_input">
		<select class="require" name="cate_id">
			<option value="0">==未选取分类==</option>
			<?php if(is_array($cate_result)): foreach($cate_result as $key=>$cate_item): ?><option value="<?php echo ($cate_item["id"]); ?>" <?php if($result['cate_id'] == $cate_item['id']): ?>selected="selected"<?php endif; ?> ><?php echo ($cate_item["name"]); ?></option><?php endforeach; endif; ?>
		</select>
		</td>
	</tr>
	
	<tr>
		<td class="item_title">商品品牌:</td>
		<td class="item_input">
		<select name="brand_id">
			<option value="0">==未选取品牌==</option>
			<?php if(is_array($brand_result)): foreach($brand_result as $key=>$item): ?><option value="<?php echo ($item["id"]); ?>" <?php if($result['brand_id'] == $item['id']): ?>selected="selected"<?php endif; ?> ><?php echo ($item["name"]); ?></option><?php endforeach; endif; ?>
		</select>
		</td>
	</tr>
	 
	
	<tr>
		<td class="item_title">状态:</td>
		<td class="item_input">
			<lable>有效<input type="radio" name="is_effect" value="1" <?php if($result['is_effect'] == 1): ?>checked="checked"<?php endif; ?> /></lable>
			<?php if($result['is_has_duobao'] != 1): ?><lable>无效<input type="radio" name="is_effect" value="0" <?php if($result['is_effect'] == 0): ?>checked="checked"<?php endif; ?> /></lable><?php endif; ?>
		</td>
	</tr>
	 
	<tr>
		<td class="item_title">商品简介:</td>
		<td class="item_input"><textarea class="textarea" name="brief"><?php echo ($result['brief']); ?></textarea></td>
	</tr>
	
	<tr>
		<td class="item_title">商品详情:</td>
		<td class="item_input">
		 <script type='text/javascript'> var eid = 'brief';KE.show({id : eid,skinType: 'tinymce',allowFileManager : true,resizeMode : 0,items : [
							'source','fullscreen', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
							'plainpaste', 'wordpaste', 'justifyleft', 'justifycenter', 'justifyright',
							'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
							'superscript', 'selectall', '-',
							'title', 'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold',
							'italic', 'underline', 'strikethrough', 'removeformat', 'image',
							'flash', 'media', 'table', 'hr', 'emoticons', 'link', 'unlink'
						]});</script><div  style='margin-bottom:5px; '><textarea id='brief' name='description' style='width:750px; height:350px;' ><?php echo ($result["description"]); ?></textarea> </div>
		</td>
	</tr>
	 
	<tr>
		<td class="item_title">缩略图:</td>
		<td class="item_input">
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'icon';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='icon' name='icon' style='width:120px; height:25px;' ><?php echo ($result["icon"]); ?></textarea> </div></div><input type='text' id='focus_icon' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($result["icon"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($result["icon"]); ?><?php endif; ?>' <?php if($result["icon"] != ''): ?>onclick='openimg("icon")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_icon' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($result["icon"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_icon' onclick='delimg("icon")' title='删除' />
		</td>
	</tr>
	<tr>
		<td class="item_title">图集:</td>
		<td class="item_input">
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img0';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img0' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["0"]); ?></textarea> </div></div><input type='text' id='focus_img0' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["0"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["0"]); ?><?php endif; ?>' <?php if($img_list["0"] != ''): ?>onclick='openimg("img0")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img0' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["0"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img0' onclick='delimg("img0")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img1';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img1' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["1"]); ?></textarea> </div></div><input type='text' id='focus_img1' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["1"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["1"]); ?><?php endif; ?>' <?php if($img_list["1"] != ''): ?>onclick='openimg("img1")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img1' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["1"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img1' onclick='delimg("img1")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img2';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img2' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["2"]); ?></textarea> </div></div><input type='text' id='focus_img2' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["2"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["2"]); ?><?php endif; ?>' <?php if($img_list["2"] != ''): ?>onclick='openimg("img2")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img2' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["2"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img2' onclick='delimg("img2")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img3';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img3' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["3"]); ?></textarea> </div></div><input type='text' id='focus_img3' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["3"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["3"]); ?><?php endif; ?>' <?php if($img_list["3"] != ''): ?>onclick='openimg("img3")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img3' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["3"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img3' onclick='delimg("img3")' title='删除' />
			<div class="blank5"></div>			
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img4';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img4' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["4"]); ?></textarea> </div></div><input type='text' id='focus_img4' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["4"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["4"]); ?><?php endif; ?>' <?php if($img_list["4"] != ''): ?>onclick='openimg("img4")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img4' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["4"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img4' onclick='delimg("img4")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img5';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img5' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["5"]); ?></textarea> </div></div><input type='text' id='focus_img5' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["5"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["5"]); ?><?php endif; ?>' <?php if($img_list["5"] != ''): ?>onclick='openimg("img5")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img5' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["5"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img5' onclick='delimg("img5")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img6';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img6' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["6"]); ?></textarea> </div></div><input type='text' id='focus_img6' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["6"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["6"]); ?><?php endif; ?>' <?php if($img_list["6"] != ''): ?>onclick='openimg("img6")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img6' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["6"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img6' onclick='delimg("img6")' title='删除' />
			<div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = 'img7';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='img7' name='img[]' style='width:120px; height:25px;' ><?php echo ($img_list["7"]); ?></textarea> </div></div><input type='text' id='focus_img7' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($img_list["7"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($img_list["7"]); ?><?php endif; ?>' <?php if($img_list["7"] != ''): ?>onclick='openimg("img7")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_img7' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($img_list["7"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_img7' onclick='delimg("img7")' title='删除' />
		</td>
	</tr>
	
	 
	 
	<tr>
		<td class="item_title"></td>
		<td class="item_input">
			<!--隐藏元素-->			
			<input type="hidden" name="<?php echo conf("VAR_MODULE");?>" value="Deal" />
			<input type="hidden" name="<?php echo conf("VAR_ACTION");?>" value="update" />
			<input type="hidden" name="id" value="<?php echo ($result['id']); ?>" />
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