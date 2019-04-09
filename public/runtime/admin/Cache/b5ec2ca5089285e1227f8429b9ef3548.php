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

<style type="text/css">
	.fLeft{ float:left;}
	.cBoth{clear:both}
	.hMargin{margin-left:3px; margin-right:3px}
	.vMargin{margin-top:3px; margin-bottom:3px}
	#execSql{ font-size:12px; height:198px; width:450px; font-family:verdana,arial;}
	#tableName{ font-size:12px; height:200px; font-family:verdana,arial;}
</style>
<script language="JavaScript">
<!--
	function buildTable(tableId, data){
		for (i = 0; i < data.length; i++) {
			var table = document.getElementById(tableId);
			if (table) {
				var row = table.insertRow(-1);
				if (i == 0) {
					row.className = 'over';
				}
				for (j = 0; j < data[i].length; j++) {
					var cell = document.createElement("td");
					cell.innerHTML = data[i][j];
					row.appendChild(cell);
				}
			}
		}
	}
	function deleteTable(tableId){
		var Table	=	document.getElementById(tableId);
		if (Table) {
			while (Table.rows.length > 0) {
				Table.deleteRow(0);
			}
		}
	}

	function handleSql(data){
		document.getElementById('resultNum').innerHTML=	 '';
		deleteTable('table1');
		deleteTable('table2');
		
		var time = data[0];
		var bench = data[1];
		if (bench) {
			if (bench[0]) {
				document.getElementById('benchbox').style.display = 'block';
				buildTable('table2', bench[0]);
			}
			else {
				document.getElementById('benchbox').style.display = 'none';
			}
		}
		
		var db_data = new Array();
		for(var i=2,j=0;i<data.length;i++,j++)
		{
			db_data[j] = data[i];
		}
		
		if(data.length<=1) {
			document.getElementById('resultNum').innerHTML	=	'[ 返回0条查询记录 耗时:'+time+' ] ';
		}else {
			document.getElementById('resultNum').innerHTML	=	'[ 返回'+(data.length-1)+'条查询记录 耗时:'+time+' ] ';
			buildTable('table1',db_data);
		}
	}
	function runSql(){	
		$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=execute", 
				data: 'ajax=1&sql='+encodeURIComponent(document.getElementById('execSql').value),
				dataType: "json",
				success: function(obj){
					
					$("#info").html(obj.info);
					$("#info").fadeIn();
					$("#info").oneTime(2000, function() {				    
						$(this).fadeOut(2,function(){
							$("#info").html("");
							handleSql(obj.data);
						});			    	
					});	
					
							
				}
		});	
	}

		

	function refleshDb(db){
		$("#useDb").html(db);
		$.ajax({ 
				url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"=getTables", 
				data: 'ajax=1&db='+db,
				dataType: "json",
				success: function(obj){
					data = obj.data;
					fleshTable(data,obj.status);		
				}
		});	
		
	}
	function fleshTable(data,status){
		if (status==1)
		{
			$("#tableName").html("");
			$.each(data, function(i, n){
			  	$("#tableName").append("<option>"+n+"</option>");
			});

		}

	}
//-->
</script>
<!-- 菜单区域  -->

<!-- 主页面开始 -->
<div id="main" class="main" >
<!-- 主体内容  -->
<div class="main_title">SQL语句操作 <span style="font-weight:normal;">[当前数据库:<span style="color:blue" id="useDb"><?php echo ($_SESSION['useDb']); ?></span>]</span></div>
<div class="blank5"></div>
<!--  功能操作区域  -->
<div class="cBoth">
<!-- SQL执行器 -->
<form method=post action="">
	<fieldset id="querybox" >
<legend style="color:gray">数据库查询窗口
<div class="fLeft">在数据库</div>
<select name="database" class="fLeft hMargin" onchange="refleshDb(this.options[this.options.selectedIndex].value)">
<?php if(is_array($dbs)): $i = 0; $__LIST__ = $dbs;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$db): ++$i;$mod = ($i % 2 )?><?php if(($db["Database"])  !=  "information_schema"): ?><?php if($db['Database'] == $useDb): ?><option value="<?php echo ($db["Database"]); ?>" <?php if(($db["Database"])  ==  $useDb): ?>selected<?php endif; ?>> <?php echo ($db["Database"]); ?> </option><?php endif; ?><?php endif; ?><?php endforeach; endif; else: echo "" ;endif; ?>
</select>
<div class="fLeft">中执行SQL语句（<span style="color:orange">请慎用</span>） </div></legend>
<div class="cBoth"></div>
<div id="dbSql" class="cBoth vMargin">
<div class="fLeft"><TEXTAREA id="execSql" NAME="sql" ><?php echo ($_GET['sql']); ?></TEXTAREA></div>
<div id="dbSql" >
<div class="fLeft hMargin">
<select NAME="tableName" id="tableName" class="medium" size="12" multiple >
<?php if(is_array($tables)): $i = 0; $__LIST__ = $tables;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$table): ++$i;$mod = ($i % 2 )?><option value="<?php echo ($table); ?>"><?php echo ($table); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
</select></div>
<div class="fLeft" style="width:65px">

</div>
</div>
</div>
<br class="cBoth">
<div class="cBoth vMargin" >
<div class="impBtn hMargin fLeft shadow" ><input type="button" id="" name="button" value="执行" onclick="runSql()" class="button imgButton"></div>
<div class="impBtn hMargin fLeft shadow" ><input type="reset" id="" name="button" value="重置" onclick="" class="button imgButton"></div>
</div>
</fieldset>
</form>

<!-- 表操作器 -->
<fieldset id="benchbox" style="display:none">
<legend style="color:gray">数据库性能分析 </legend>
<div id="SqlBench" style="overflow:auto;width:100%;height:100%">
<table id='table2' class="dataTable" style="width:450px"></table>
</div>
</fieldset>
<fieldset id="querybox" >
<legend style="color:gray">数据库查询结果 <span class="blue" id="resultNum"></span> </legend>
<div id="SqlResult" style="overflow:auto;width:100%;height:100%">
<table id='table1' class="dataTable" cellpadding=0 cellspacing=0 ></table>
</div>
</fieldset>
</div>
<!-- 列表显示区域结束 -->

<!-- 主体内容结束 -->
</div>
<!-- 主页面结束 -->
<script language="JavaScript">
<!--
	if (<?php echo (($_GET['run'])?($_GET['run']):0); ?>)	runSql();
//-->
</script>
</body>
</html>