<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/weebox.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/fanweUI.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";		
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/uc_fxwithdraw.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/uc_invite.css";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery-1.6.2.min.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.bgiframe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.timer.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.weebox.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.touchwipe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/fastclick.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";


?>
<?php echo $this->fetch('inc/header.html'); ?>


<div class="wrap">
	<div class="content">
		<div style="padding:15px;">
			<div class="money_box">
				总返利：
				<span style="font-weight:bold;color:#dd344f;"><?php echo $this->_var['data']['total_score']; ?>积分</span>
				<span style="font-weight:bold;color:#dd344f;"><?php echo $this->_var['data']['total_coupons']; ?>优惠币</span>
			</div>	
			<div>
				<div>
					<h4 style="margin-bottom:10px;">这是您的专用邀请链接，请通过社交软件发送给好友：</h4>
					<input type="text" class="ui-textbox"  value="<?php echo $this->_var['data']['share_register_url']; ?>" style=" width:95%; padding: 0px 10px;height: 46px;border-radius: 5px;font-size: 16px;border: 1px solid #CCC;">	
				</div>
			</div>
			<div style="text-align:center;margin-top:10px;"><img src="<?php echo $this->_var['data']['share_register_qrcode']; ?>"   /></div>
		</div>
	
		<h2 class="add" style="text-align:center;line-height:2rem">我的推荐人：<?php echo $this->_var['data']['pname']; ?></h2>
	 	<div class="blank"></div>
	 	
	 	<div class="info_table">
			<table class="split-line-top">
				<tbody>
					<tr>
						<th class="split-line">我推荐的人</th>
						<th class="split-line">返利总积分</th>
						<th class="split-line">返利总优惠币</th>
					</tr>
					
					<?php $_from = $this->_var['data']['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'row');if (count($_from)):
    foreach ($_from AS $this->_var['row']):
?>
					<tr class="alt">
						<td class="split-line">
						<?php echo $this->_var['row']['user_name']; ?>
						</td>
                        <td class="split-line">
                        	<h1><?php echo $this->_var['row']['score']; ?></h1>
                        </td>
                        <td class="split-line">
                        	<h1><?php echo $this->_var['row']['coupons']; ?></h1>
                        </td>
                     </tr>
                    <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
                         
                    <tr>
                    	<?php if ($this->_var['data']['list']): ?>
                    	<?php if ($this->_var['pages']): ?>
                        <td colspan="4"><div class="pages"><?php echo $this->_var['pages']; ?></div></td>
                        <?php endif; ?>
                        <?php else: ?>
                        <td colspan="4"><span>暂时没有下线会员</span></td>
                        <?php endif; ?>
                    </tr>
				</tbody>
			</table>
	 	</div>
	 	
	 	<div class="blank50"></div>

	</div>
</div>
<?php echo $this->fetch('inc/footer_index.html'); ?>