<!--用户信息部分-->
<div class="goods_abbr">
	<div class="person_account">
		<div class="account_info">
			<div class="file_img">
				<div class="item-add" style="width:100%;height:100%;border: 1px solid #ddd;float:left">
					<img id="fileimg" src="<?php echo $this->_var['data']['user_logo']; ?>">
					<input class="file-btn" id="file-btn" type="file" capture="camera">
				</div>
			</div>
			<div class="name">
				<a href="<?php
echo parse_url_tag("u:index|uc_account#index|"."".""); 
?>">
				<h1 style="color:#ffffff;"><?php echo $this->_var['data']['user_name']; ?></h1>
				</a>
				<p>ID：<span><?php echo $this->_var['data']['uid']; ?></span>&nbsp;&nbsp;积分：<span><?php echo $this->_var['data']['user_score']; ?><?php echo $this->_var['signin_result']; ?></span>&nbsp;&nbsp;优惠币：<span><?php echo $this->_var['data']['user_coupons']; ?></span><a class="uc_explain">说明</a></p>
			</div>
		</div>
	</div>
	
	<div class="uc-money-box">
		<div class="uc-money-item">夺宝币：<font class="money-font"><?php echo $this->_var['data']['user_money_int']; ?></font></div>
		<div class="uc-incharge-box">
			<button class="incharge-btn" style="margin-right:8px;"><a href="<?php
echo parse_url_tag("u:index|uc_charge#index|"."".""); 
?>" >充值</a></botton>
			<button class="incharge-btn"><a href="<?php
echo parse_url_tag("u:index|uc_money_cash#index|"."".""); 
?>" >提现</a></botton>
		</div>
	</div>
	
	<!-- 优惠币获取说明-start -->
	<div class="explain_items" id="coupons_explain" style="display:none;">
		<ul>
			<li class="ui_clr">1.免费购专区只能用优惠币进行夺宝；</li>
			<li class="ui_clr">2.“上传头像”即可获得优惠币(每个用户仅限一次)；</li>
			<li class="ui_clr">3.“邀请好友”每推荐一位好友注册可获优惠币。</li>
		</ul>
	</div>
	<!-- 优惠币获取说明-end -->
	
</div>
<!--end 用户信息部分-->