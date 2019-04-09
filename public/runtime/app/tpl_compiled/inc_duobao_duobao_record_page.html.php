<script>
var max_page=<?php echo $this->_var['max_page']; ?>;
var new_p=<?php echo $this->_var['new_page']; ?>;
</script>
<?php if ($this->_var['duobao_records']): ?>
<div class="record-content">
<!-- 顶部时钟 -->
	<?php if ($this->_var['new_page'] == 1): ?>
	<div class="content-hd">
		<i class="ico ico-clock"></i>
	</div>
	<?php endif; ?>
<!-- 列表 -->
	<?php $_from = $this->_var['duobao_records']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('key', 'duobao_record');if (count($_from)):
    foreach ($_from AS $this->_var['key'] => $this->_var['duobao_record']):
?>
	<div class="content-bd">
		<div class="time-today"><?php echo $this->_var['key']; ?>
		<!-- 实心点 -->
			<i class="ico ico-dot ico-dot-solid"></i>
		</div>
		<ul class="record-list">
		<!-- （循环50个后翻页） -->
			<?php $_from = $this->_var['duobao_record']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'duobao_record_one');if (count($_from)):
    foreach ($_from AS $this->_var['duobao_record_one']):
?>
			<li class="clearfix">
				<span class="time f_l"><?php echo $this->_var['duobao_record_one']['create_time_date']; ?></span>
				<!-- 空心点 -->
				<i class="ico ico-dot ico-dot-hollow"></i>
				<div class="record-user-info f_l">
					<div class="inner">
					<p>
					<!-- 用户头像 -->
						<span class="user-pic">
							<img src="<?php 
$k = array (
  'name' => 'get_user_avatar',
  'uid' => $this->_var['duobao_record_one']['user_id'],
  'type' => 'big',
);
echo $k['name']($k['uid'],$k['type']);
?>" width="20" height="20">
						</span>
					<!-- 用户名 -->
						<a href="<?php
echo parse_url_tag("u:index|home|"."id=".$this->_var['duobao_record_one']['user_id']."".""); 
?>" target="_blank" title="<?php echo $this->_var['duobao_record_one']['user_name']; ?>(ID:<?php echo $this->_var['duobao_record_one']['user_id']; ?>)"><?php echo $this->_var['duobao_record_one']['user_name']; ?></a>
						(<?php echo $this->_var['duobao_record_one']['duobao_area']; ?> IP：<?php echo $this->_var['duobao_record_one']['duobao_ip']; ?>) 参与了<b class="times txt-red"><?php echo $this->_var['duobao_record_one']['number']; ?>人次</b>
					<!-- 点击查看号码 -->
						<a class="btn btn-sim btn-checkcode">所有云号码
						<i class="ico ico-arrow-gray ico-arrow-gray-down"></i></a>
					</p>
					<!-- 关闭查看号码 -->
					<a class="btn-close">x</a>
					<!-- 号码 -->
					<p class="codes">
						<?php $_from = $this->_var['duobao_record_one']['duobao_item_log']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'duobao_item_log');if (count($_from)):
    foreach ($_from AS $this->_var['duobao_item_log']):
?>
						<span><?php echo $this->_var['duobao_item_log']['lottery_sn']; ?></span>
						<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
					</p>
					<!-- 号码超过一定数量需要点击展开 -->
					<p class="folder-btn" style="padding: 0">
					<!-- 展开 -->
						<a class="btn-unfold">
							展开查看全部
							<i class="ico ico-arrow-blue ico-arrow-blue-down"></i></a>
					<!-- 关闭 -->
						<a class="btn-fold">
							收起
							<i class="ico ico-arrow-blue ico-arrow-blue-up"></i>
						</a>
					</p>
					</div>
				</div>
			</li>
			<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
		</ul>
	</div>
	<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	<?php if ($this->_var['max_page'] == $this->_var['new_page']): ?>
	<div class="content-hd">
		<i class="ico ico-clock"></i>
	</div>
	<?php endif; ?>
</div>
<!-- 翻页 -->
<div class="pages"><?php echo $this->_var['pages']; ?></div>
<?php else: ?>
<div class="empty">
	<div class="empty-info">
		<i class="littleU littleU-cry"></i>
		&nbsp;&nbsp;暂时还没有参与记录
	</div>
</div>
<?php endif; ?>
				