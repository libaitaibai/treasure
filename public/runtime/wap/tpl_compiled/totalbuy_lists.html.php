<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/totalbuy_lists.css";

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

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/duoobao_item_num.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/duoobao_item_num.js";
?>
<?php echo $this->fetch('inc/header_title_home.html'); ?>

<script type="text/javascript">
var totalbuy_cart_url='<?php
echo parse_url_tag("u:index|totalbuy#index|"."".""); 
?>';

  //减少移动端触发"Click"事件时300毫秒的时间差
window.addEventListener('load', function() {
    FastClick.attach(document.body);
}, false);
</script>

<div class="totalbuy-lists content">
	 <?php if ($this->_var['list']): ?>
	<ul class="flex-box scroll_bottom_list">
		<?php $_from = $this->_var['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
		<li>
			<div class="list-info">
				<div class="goods-img"> <a href="<?php
echo parse_url_tag("u:index|duobao|"."data_id=".$this->_var['item']['id']."".""); 
?>"><img src="<?php echo $this->_var['item']['icon']; ?>" alt=""></a></div>
				<p class="goods-name"><?php echo $this->_var['item']['name']; ?></p>
				<a href="javascript:;" data_id="<?php echo $this->_var['item']['id']; ?>" onclick="add_total_buy_cart_item(this)" class="buy-btn zg-btn">立即购买</a>
			</div>
		</li>
		<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	</ul>
	
	
	<?php if ($this->_var['pages']): ?>
	<div class="fy scroll_bottom_page">
		<?php echo $this->_var['pages']; ?>
	</div>
	<?php endif; ?>
	<?php else: ?>
	<!-- 无数据↓ -->
    <div class="null_data">
      <p class="icon"><i class="iconfont">&#xe6e8;</i></p>
      <p class="message">暂无数据</p>
    </div>
	<?php endif; ?>
	
	
</div>
<?php echo $this->fetch('inc/footer_menu.html'); ?>
<?php echo $this->fetch('inc/footer_index.html'); ?>