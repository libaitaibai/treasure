<?php if (!defined('THINK_PATH')) exit();?>

<script type="text/javascript">
	function check_incharge_form()
	{

		if($("input[name='money']").val()!=''&&isNaN($("input[name='money']").val()))
		{
			alert(LANG['MONEY_FORMAT_ERROR']);
			return false;
		}

		return true;
	}
</script>
<div class="main">

<div class="main_title">修改推荐人</div>

<div class="blank5"></div>
<form name="edit" action="__APP__" method="post" enctype="multipart/form-data" >
<table class="form" cellpadding=0 cellspacing=0>
	<tr>
		<td colspan=2 class="topTd"></td>
	</tr>
	<tr>
		<td class="item_title">推荐人:</td>
		<td class="item_input"><input type="text" class="textbox require" name="referrer" value="<?php echo ($referrer_name); ?>"/>
		<span class='tip_span'></span>
		</td>
	</tr>




	<tr>
		<td class="item_title">&nbsp;</td>
		<td class="item_input">
			<!--隐藏元素-->
			<input type="hidden" name="id" value="<?php echo ($id); ?>" />

			<input type="hidden" name="<?php echo conf("VAR_MODULE");?>" value="FxUser" />
			<input type="hidden" name="<?php echo conf("VAR_ACTION");?>" value="update_referrer" />
			<!--隐藏元素-->
			<input type="submit" class="button" value="<?php echo L("OK");?>" />

		</td>
	</tr>
	<tr>
		<td colspan=2 class="bottomTd"></td>
	</tr>
</table>	 
</form>
</div>