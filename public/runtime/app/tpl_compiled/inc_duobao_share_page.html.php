<script>
var max_page=<?php echo $this->_var['max_page']; ?>;
var new_p=<?php echo $this->_var['p']; ?>;
</script>
<div class="share-list-wrap">
	<?php if (! $this->_var['duobao_share_data']): ?>
	<!-- 没有数据 -->
	<div class="empty">
		<div class="empty-info">
			<i class="littleU littleU-cry"></i>
			&nbsp;&nbsp;暂时还没有任何晒单
		</div>
	</div>
	<?php else: ?>
	<!-- 列表 -->
	<ul class="share-list">
		<?php $_from = $this->_var['duobao_share_data']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'share_data');if (count($_from)):
    foreach ($_from AS $this->_var['share_data']):
?>
		<li>
		<!-- 用户 -->
			<div class="share-author f_l">
			<!-- 用户头像 -->
				<a href="<?php
echo parse_url_tag("u:index|home|"."id=".$this->_var['share_data']['user_id']."".""); 
?>" class="user-pic" target="_blank">
					<img src="<?php 
$k = array (
  'name' => 'get_user_avatar',
  'uid' => $this->_var['share_data']['user_id'],
  'type' => 'big',
);
echo $k['name']($k['uid'],$k['type']);
?>" width="90" height="90">
				</a>
				<!-- 用户名 -->
				<a href="<?php
echo parse_url_tag("u:index|home|"."id=".$this->_var['share_data']['user_id']."".""); 
?>" class="user-name txt-over" target="_blank"><?php echo $this->_var['share_data']['user_name']; ?></a>
			</div>
			<!-- 晒单内容 -->
			<div class="share-detail">
			<!-- 标题 -->
				<div class="share-title">
					<span class="date f_r"><?php echo $this->_var['share_data']['create_time']; ?></span>
					<span class="title"><a href="<?php
echo parse_url_tag("u:index|share#detail|"."id=".$this->_var['share_data']['id']."".""); 
?>" target="_blank"><b><?php echo $this->_var['share_data']['title']; ?></b></a></span>
				</div>
			<!-- 文字内容 -->
				<div class="txt-info">
					<a href="<?php
echo parse_url_tag("u:index|share#detail|"."id=".$this->_var['share_data']['id']."".""); 
?>" target="_blank"><?php echo $this->_var['share_data']['content']; ?></a>
				</div>
			<!-- 晒单图片 -->
				<div class="share-pic">
					<?php $_from = $this->_var['share_data']['image_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'image');if (count($_from)):
    foreach ($_from AS $this->_var['image']):
?>
					<a href="<?php
echo parse_url_tag("u:index|share#detail|"."id=".$this->_var['share_data']['id']."".""); 
?>" class="f_l" target="_blank">
						<img src="<?php echo $this->_var['image']['path']; ?>" width="140" height="140" style="display:block;writing-mode:tb-rl;vertical-align:middle">
					</a>
					<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
				</div>
			</div>
		</li>
		<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	</ul>
	<div class="pages"><?php echo $this->_var['pages']; ?></div>
	<?php endif; ?>
</div>