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

<script type="text/javascript" src="__TMPL__Common/js/weixin/nav_setting.js"></script>
<link rel="stylesheet" type="text/css" href="__TMPL__Common/style/weixin/data.css" />
<script type="text/javascript">
	var navs = <?php echo ($navs_json); ?>;
</script>
<div class="main">
<div class="main_title">自定义菜单</div>
<div class="blank5"></div>
  <div class="container-f">

 	<div class="box-content clearfix">
	<div class="app_auth_tip">
              <p>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!</p>
              <p>只有保存主菜单后才可以添加子菜单</p>
              <p>生成自定义菜单,必须在已经保存的基础上进行,临时勾选启用点击生成是无效的! 第一步必须先修改保存状态！第二步点击生成!</p>
              <p>当您为自定义菜单填写链接地址时请填写以"http://"开头，这样可以保证用户手机浏览的兼容性更好</p><br/>
           </div>
          <div class="blank"></div>
          <div class="control-group f_l ">
            <div class="f_l">
                <a class="btn cf" href="javascript:void(0);" id="add_weixin_main_nav" rel="<?php echo u("WeixinAccount/new_nav_row",array("row_type"=>"main"));?>"><i class="fa fa-plus"></i><span>添加主菜单</span></a>
           		<a class="btn cf" href="javascript:location.reload()"><i class="fa fa-refresh"></i>
<span>刷新</span></a>
		    </div>

        </div>
        <div class="blank"></div>
		<div class="row clearfix">
 			<form action="<?php echo u("WeixinAccount/nav_save");?>" method="post" class="form-horizontal ajax_form">
 				<div class="changeStepBox clearfix  cf">
 					<div class="clearfix cf">
 						<table id="listTable" class="table-hover dataTable" >
 		                        <tr>
		                            <th>	显示排序</th>
		                            <th>主菜单名称</th>
		                            <th>触发关键词或地址链接</th>
		                             <th>同步结果</th>
		                            <th class="norightborder" width=120>操作</th>
		                        </tr>
  		                    	<?php if(is_array($result_navs)): foreach($result_navs as $key=>$nav): ?><tr class="nav_row <?php if($nav["pid"] == 0): ?>main<?php else: ?>sub sub_<?php echo ($nav["pid"]); ?><?php endif; ?>">
									<td>
										<?php if($nav["pid"] != 0): ?><i class="board">&nbsp;&nbsp;</i><?php endif; ?>
										<input type="text" name="sort[]" class=" ipt_require" size="5" value="<?php if($nav.sort): ?><?php echo ($nav["sort"]); ?><?php else: ?>0<?php endif; ?>"  />
										<input type="hidden" name="id[]" value="<?php echo ($nav["id"]); ?>" />
										<input type="hidden" name="pid[]" value="<?php echo ($nav["pid"]); ?>" />
										<input type="hidden" name="row_type[]" value="<?php if($nav["pid"] == 0): ?>main<?php else: ?>sub<?php endif; ?>" />
									</td>
									<td>
										<?php if($nav["pid"] != 0): ?><i class="board">&nbsp;&nbsp;</i><?php endif; ?>
										
 										<input type="text" name="name[]"  class="ipt_require" value="<?php echo ($nav["name"]); ?>"  />
										<span class="maroon">*</span>
 										<?php if($nav["pid"] == 0): ?><a href="javascript:void(0);" class="add_sub_nav"  rel="<?php echo u("WeixinAccount/new_nav_row",array("row_type"=>"sub","id"=>$nav['id']));?>" pid="<?php echo ($nav["id"]); ?>">+</a><?php endif; ?>
									</td>
									<td>
										<select name="ctl[]" class="ctl">
												<?php if(is_array($navs)): foreach($navs as $key=>$nav_item): ?><option value="<?php echo ($key); ?>" <?php if($key == $nav['ctl']): ?>selected="selected"<?php endif; ?> ><?php echo ($nav_item["name"]); ?></option><?php endforeach; endif; ?>
										</select>										
										
										<span class="data" <?php if($nav['data'] == ''): ?>style="display:none;"<?php endif; ?>>				
											<span class="field_name"><?php echo ($nav["data_name"]); ?></span>&nbsp;&nbsp;<input type="text" class="textbox" name="data[]"  value="<?php echo ($nav["data"]); ?> "/>
										</span>
								
										<span class="maroon">*</span>
									</td>
									<td><?php if($nav["status"] == 0): ?>未同步<?php else: ?>已同步<?php endif; ?></td>
									<td><a href="javascript:void(0);" class="del_nav">删除</a></td>
								</tr><?php endforeach; endif; ?>
 		                </table>
 					</div>					

					<div class="cf clearfix"></div>
					<div>	                    
	                    <input type="submit" class="btn btn-primary" value="保存" />	&nbsp;
	                    <input type="button" class="btn btn-primary" value="同步到微信公众平台" id="syn_weixin" rel="<?php echo u("WeixinAccount/syn_to_weixin");?>" />	                    
	                </div>
				</div>				
				
			
            </form>
		</div>
	</div>
</div>
</div>
</body>
</html>