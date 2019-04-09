<script>
var max_page=<?php echo $this->_var['max_page']; ?>;
var new_p=<?php echo $this->_var['p']; ?>;
</script>
<?php if ($this->_var['used_item_data_page']): ?>
<ul class="history-list">
	<?php $_from = $this->_var['used_item_data_page']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'used_item_data');if (count($_from)):
    foreach ($_from AS $this->_var['used_item_data']):
?>
	<?php if ($this->_var['used_item_data']['has_lottery'] == 0): ?>
	<li class="history-item history-countdown">
		<!-- 期号 -->
		<div class="history-code f_l">
			期号 <?php echo $this->_var['used_item_data']['id']; ?>
		</div>
		<!-- 中奖信息 -->
		<div class="f_l history-info">
			<div class="countdown">
				<span class="countdown-title">揭晓倒计时</span>
				<?php if ($this->_var['used_item_data']['lottery_time'] > $this->_var['now_time']): ?>
				<time class="countdown-nums" nowtime="<?php echo $this->_var['now_time']; ?>" endtime="<?php echo $this->_var['used_item_data']['lottery_time']; ?>" id="<?php echo $this->_var['used_item_data']['id']; ?>">
					<b>0</b><b>0</b>:<b>0</b><b>0</b>:<b>0</b><b>0</b>
				</time>
				<?php else: ?>
					正在揭晓中
					<?php endif; ?>
				</div>
		</div>
		<!-- 幸运号码信息 -->
		<div class="f_l history-result">
		</div>
		<!-- 查看详情 -->
		<div class="f_r history-check">
		<a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['used_item_data']['id']."".""); 
?>" target="_blank">查看详情</a>
		</div>
	</li>
	<?php else: ?>
	<!-- 循环10次 -->
	<li class="history-item history-published">
		<!-- 期号 -->
		<div class="history-code f_l">
			期号 <?php echo $this->_var['used_item_data']['id']; ?>
		</div>
		<!-- 中奖信息 -->
		<div class="f_l history-info">
			<img src="<?php 
$k = array (
  'name' => 'get_user_avatar',
  'uid' => $this->_var['used_item_data']['luck_user_id'],
  'type' => 'big',
);
echo $k['name']($k['uid'],$k['type']);
?>" width="70" height="70" class="f_l">
			<div class="f_l history-info-txt">
				<p>恭喜
					<a href="<?php
echo parse_url_tag("u:index|home|"."id=".$this->_var['used_item_data']['luck_user_id']."".""); 
?>" target="_blank"><?php echo $this->_var['used_item_data']['luck_user_name']; ?></span></a>（<span class="history-info-add"><?php echo $this->_var['used_item_data']['duobao_area']; ?></span>）获得了本期商品
					</a>
				</p>
				<p>用户ID：<?php echo $this->_var['used_item_data']['luck_user_id']; ?>（ID为用户唯一不变标识）</p>
				<p>本期参与：<b class="txt-red"><?php echo $this->_var['used_item_data']['user_duobao_count']; ?>人次</b></p>
			</div>
		</div>
		<!-- 幸运号码信息 -->
		<div class="f_l history-result">
			<p>幸运号码：<b class="txt-red"><?php echo $this->_var['used_item_data']['lottery_sn']; ?></b></p>
			<p>揭晓时间：<?php echo $this->_var['used_item_data']['lottery_time_data']; ?></p>
			<p>购买时间：<?php echo $this->_var['used_item_data']['create_time']; ?></p>
		</div>
		<!-- 查看详情 -->
		<div class="f_r history-check">
			<a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['used_item_data']['id']."".""); 
?>" target="_blank">查看详情</a>
		</div>
	</li>
	<?php endif; ?>
	<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
</ul>
<div class="pages"><?php echo $this->_var['pages']; ?></div>
<?php else: ?>
<div class="empty">
	<div class="empty-info">
		<i class="littleU littleU-cry"></i>
		&nbsp;&nbsp;暂时还没有往期购买
	</div>
</div>
<?php endif; ?>