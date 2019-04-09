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
	<div class="main_title">微信公众号配置</div>
	<div class="blank5"></div>
	<form method='post' id="form" name="form" action="__APP__">
		<table cellpadding="4" cellspacing="0" border="0" class="form">
			<tr>
				<td colspan="2" class="topTd"></td>
			</tr>
			<?php if(is_array($config)): foreach($config as $key=>$cfg): ?><tr>
					<td class="item_title" style=" width:200px;"><?php echo ($cfg["title"]); ?></th>
					<td class="item_input">
						<?php if($cfg['type'] == 1): ?><script type='text/javascript'> var eid = '<?php echo ($cfg["name"]); ?>';KE.show({id : eid,skinType: 'tinymce',allowFileManager : true,resizeMode : 0,items : [
							'source','fullscreen', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
							'plainpaste', 'wordpaste', 'justifyleft', 'justifycenter', 'justifyright',
							'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
							'superscript', 'selectall', '-',
							'title', 'fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold',
							'italic', 'underline', 'strikethrough', 'removeformat', 'image',
							'flash', 'media', 'table', 'hr', 'emoticons', 'link', 'unlink'
						]});</script><div  style='margin-bottom:5px; '><textarea id='<?php echo ($cfg["name"]); ?>' name='<?php echo ($cfg["name"]); ?>' style=' height:150px;width:750px;' ><?php echo ($cfg["value"]); ?></textarea> </div><?php endif; ?>
						<?php if($cfg['type'] == 2): ?><div style='width:120px; height:40px; margin-left:10px; display:inline-block;  float:left;' class='none_border'><script type='text/javascript'>var eid = '<?php echo ($cfg["name"]); ?>';KE.show({id : eid,items : ['upload_image'],skinType: 'tinymce',allowFileManager : true,resizeMode : 0});</script><div style='font-size:0px;'><textarea id='<?php echo ($cfg["name"]); ?>' name='<?php echo ($cfg["name"]); ?>' style='width:120px; height:25px;' ><?php echo ($cfg["value"]); ?></textarea> </div></div><input type='text' id='focus_<?php echo ($cfg["name"]); ?>' style='font-size:0px; border:0px; padding:0px; margin:0px; line-height:0px; width:0px; height:0px;' /></div><img src='<?php if($cfg["value"] == ''): ?>./admin/Tpl/default/Common/images/no_pic.gif<?php else: ?><?php echo ($cfg["value"]); ?><?php endif; ?>' <?php if($cfg["value"] != ''): ?>onclick='openimg("<?php echo ($cfg["name"]); ?>")'<?php endif; ?> style='display:inline-block; float:left; cursor:pointer; margin-left:10px; border:#ccc solid 1px; width:35px; height:35px;' id='img_<?php echo ($cfg["name"]); ?>' /><img src='/admin/Tpl/default/Common/images/del.gif' style='<?php if($cfg["value"] == ''): ?>display:none;<?php else: ?>display:inline-block;<?php endif; ?> margin-left:10px; float:left; border:#ccc solid 1px; width:35px; height:35px; cursor:pointer;' id='img_del_<?php echo ($cfg["name"]); ?>' onclick='delimg("<?php echo ($cfg["name"]); ?>")' title='删除' /><?php endif; ?>
						<?php if($cfg['type'] == 0): ?><input type="text" class="textbox <?php if($cfg['is_require'] == 1): ?>require<?php endif; ?>" name="<?php echo ($cfg["name"]); ?>" value="<?php echo ($cfg["value"]); ?>"   /><?php endif; ?>
						<?php if($cfg['type'] == 3): ?><textarea class="textbox " name="<?php echo ($cfg["name"]); ?>"  style="height:100px;width:250px;"><?php echo ($cfg["value"]); ?></textarea><?php endif; ?>
						<?php if($cfg['type'] == 4): ?><select name="<?php echo ($cfg["name"]); ?>">
								<?php if(is_array($cfg["value_scope"])): foreach($cfg["value_scope"] as $key=>$preset_value): ?><option value="<?php echo ($preset_value); ?>" <?php if($cfg['value'] == $preset_value): ?>selected="selected"<?php endif; ?>>
									<?php echo l("mconf_".$cfg['name']."_".$preset_value);?>
									</option><?php endforeach; endif; ?>
							</select><?php endif; ?>
					</td>
				</tr><?php endforeach; endif; ?>





			<?php if($WEIXIN_TYPE == 'platform'): ?><tr>
				<td class="item_title">公众号接入</td>
				<td class="item_input">
					<a href="http://yun.fanwe.com" target="_blank">方维云平台公众号接入</a>
				</td>
			</tr><?php endif; ?>




			<tr>
				<td class="item_title"></td>
				<td class="item_input">
					<input type="hidden" name="<?php echo conf("VAR_MODULE");?>" value="WeixinAccount" />

					<input type="hidden" name="<?php echo conf("VAR_ACTION");?>" value="update" />
					<input type="submit" class="button" value="<?php echo L("EDIT");?>" />
					<input type="reset" class="button" value="<?php echo L("RESET");?>" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bottomTd"></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>