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
	var SITE_URL = '<?php echo get_domain().APP_ROOT; ?>'+"/";
	var SITE_PATH = ROOT_PATH+'/';
</script>
<script type="text/javascript" src="__TMPL__Common/js/weixin/jquery.js"></script>
<script type="text/javascript" src="__TMPL__Common/js/jquery.ui.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/jquery.ui.css" />
<script type="text/javascript" src="__TMPL__Common/js/jquery.timer.js"></script>
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

<script type="text/javascript" src="__TMPL__Common/js/weixin/nav_setting.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weixin/data.css" />
<link rel="stylesheet" href="__ROOT__/system/weixin/kindeditor/themes/default/default.css" />
<script type="text/javascript" src="__ROOT__/system/weixin/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="__ROOT__/system/weixin/kindeditor/plugins/wxemoticons/wxemoticons.js"></script>
<script type="text/javascript" src="__ROOT__/system/weixin/kindeditor/plugins/wxlink/wxlink.js"></script>
<script charset="utf-8" src="__ROOT__/system/weixin/kindeditor/lang/zh_CN.js"></script>
 
<div class="container-f">
	<div class="box-title clearfix">
		<h3>
			默认回复(文本)
		</h3>
	</div>
</div>
<div class="box-content clearfix">
	<div class="row clearfix">
		<form action="<?php echo u("WeixinReplyAccount/save_dtext");?>" method="post" class="form-horizontal ajax_form">
			<div class="changeStepBox clearfix  cf">
				<div class="control-group-left clearfix cf f_l">
					<div class="control-group cf clearfix">
						<label class="control-label" for="name">
							回复内容：
						</label>
						<div class="controls">
							<textarea  id="reply_content" name="reply_content"><?php echo ($reply["reply_content"]); ?></textarea>
						</div>
					</div>
					
					<div class="control-group cf clearfix">
						<label class="control-label" for="default_close">
							是否关闭默认回复：
						</label>
						<div class="controls">
							<label>
								<input type="checkbox" name="default_close" id="default_close" <?php if($reply["default_close"] == 1): ?>checked="checked"<?php endif; ?> value="1"  />
							</label>
						</div>
					</div>
				</div>
				<div class="cf clearfix"></div>
				<div class="form-actions">	                    
					<input type="hidden" name="id" value="<?php echo ($reply["id"]); ?>" />
					<input type="submit" class="btn btn-primary" value="保存" />
					<input type="button" class="btn" value="切换到图文模式" onclick="location.href='<?php echo u("WeixinReplyAccount/dnews",array("t"=>1));?>'" / >
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
var seting = {
        themeType: "simple",
        resizeType: 1,
        syncType:"",
        allowPreviewEmoticons: true,
        items: ['wxemoticons','wxlink','unlink'],
        allowFileManager: false,
        useContextmenu:false,
        minWidth: 500,
        width: 500,
		minHeight:150,
		newlineTag:"br",
		height:150,
        afterCreate: function () {
            this.sync();
        },
        afterBlur: function () {
            this.sync();
        }
    }
	KindEditor.ready(function(K) {
		K.create('#reply_content', seting);
	});

</script>

</body>
</html>