<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/jquery.confirm.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/uc_totalbuy.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/pull_refresh.css";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery-1.6.2.min.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.bgiframe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.timer.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.weebox.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.touchwipe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/fastclick.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.confirm.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/uc_totalbuy.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/uc_totalbuy.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/lib/touche.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";

?>
<?php echo $this->fetch('inc/header_title_only.html'); ?>
<script>
	var url='<?php
echo parse_url_tag("u:index|uc_totalbuy#close|"."".""); 
?>'
	var totalbuy_cart_url='<?php
echo parse_url_tag("u:index|totalbuy#index|"."".""); 
?>';
	

</script>
<div style="z-index:10;" class="tatalbuy-nav split-line">
	<ul class="flex-box">
		<li class="flex-1">
			<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy|"."".""); 
?>" <?php if (! $this->_var['data']['log_type']): ?>class="active"<?php endif; ?>>
				<i class="iconfont">&#xe6ea;</i>
				<p>全部</p>
			</a>
		</li>
		<li class="flex-1">
			<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy|"."log_type=1".""); 
?>" <?php if ($this->_var['data']['log_type'] == 1): ?>class="active"<?php endif; ?>>
				<i class="iconfont">&#xe649;</i>
				<p>待付款</p>
			</a>
		</li>
		<li class="flex-1">
			<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy|"."log_type=2".""); 
?>" <?php if ($this->_var['data']['log_type'] == 2): ?>class="active"<?php endif; ?>>
				<i class="iconfont">&#xe715;</i>
				<p>待发货</p>
			</a>
		</li>
		<li class="flex-1">
			<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy|"."log_type=3".""); 
?>" <?php if ($this->_var['data']['log_type'] == 3): ?>class="active"<?php endif; ?>>
				<i class="iconfont">&#xe716;</i>
				<p>待收货</p>
			</a>
		</li>
	</ul>
</div>

<?php endif; ?>

<div class="loading_container" id="loading_container">
<?php if ($this->_var['data']['list']): ?>
	<div class="totalbuy-list content">
		
		<ul class="scroll_bottom_list">
			<?php $_from = $this->_var['data']['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
			<li class="split-line split-line-top">
				<div class="status-box flex-box split-line">
					<p class="time flex-1 <?php if ($this->_var['item']['order_status'] == 3 || $this->_var['item']['order_status'] == 2): ?>is_delete_status<?php endif; ?>"><?php echo $this->_var['item']['create_time']; ?></p>
					<?php if ($this->_var['item']['order_status'] == 3): ?>
					<p class="status">已过期</p>
					<?php elseif ($this->_var['item']['order_status'] == 2): ?>
					<p class="status">已关闭</p>
					<?php elseif ($this->_var['item']['pay_status'] == 0 && $this->_var['item']['delivery_status'] == 0 && $this->_var['item']['is_arrival'] == 0 && $this->_var['item']['order_status'] == 0): ?>
					<p class="status txt-red">未付款</p>
					<?php elseif ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 0 && $this->_var['item']['is_arrival'] == 0): ?>
					<p class="status txt-red">已付款</p>&nbsp<p class="status txt-red">待发货</p>
					<?php elseif ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 1 && $this->_var['item']['is_arrival'] == 0): ?>
					<p class="status txt-red">已发货</p>&nbsp<p class="status txt-red">待收货</p>
					<?php elseif ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 1 && $this->_var['item']['is_arrival'] == 1): ?>
					<p class="status">已收货</p>
					<?php endif; ?>
				</div>
				<div class="goods-info split-line">
					<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy#detail|"."id=".$this->_var['item']['id']."".""); 
?>" class="flex-box">
						<div class="goods-img"><img src="<?php echo $this->_var['item']['deal_icon']; ?>" alt=""></div>
						<div class="flex-1 goods-detail">
							<p class="goods-name el <?php if ($this->_var['item']['order_status'] == 3 || $this->_var['item']['order_status'] == 2): ?>is_delete_status<?php endif; ?>"><?php echo $this->_var['item']['name']; ?></p>
							<p class="price <?php if ($this->_var['item']['order_status'] == 3 || $this->_var['item']['order_status'] == 2): ?>is_delete_status<?php endif; ?>">单价：&yen;<?php echo $this->_var['item']['unit_price']; ?></p>
							<p class="num <?php if ($this->_var['item']['order_status'] == 3 || $this->_var['item']['order_status'] == 2): ?>is_delete_status<?php endif; ?>">数量：<?php echo $this->_var['item']['number']; ?>件</p>
						</div>
					</a>
				</div>
				<div class="pay-info">
					<p class="pay-price">
						实付合计：<span class="txt-red">&yen;<?php echo $this->_var['item']['total_price']; ?></span>
					</p>
					<?php if ($this->_var['item']['cate_id']): ?>
					<div class="pay-btn">
						<?php if ($this->_var['item']['pay_status'] == 2): ?>
						<a href="<?php
echo parse_url_tag("u:index|duobao|"."dbid=".$this->_var['item']['duobao_id']."".""); 
?>">再次购买</a>
						<?php else: ?>
						<a href="<?php
echo parse_url_tag("u:index|duobao|"."dbid=".$this->_var['item']['duobao_id']."".""); 
?>">重新购买</a>
						<?php endif; ?>
						<?php if ($this->_var['item']['pay_status'] == 0 && $this->_var['item']['delivery_status'] == 0 && $this->_var['item']['is_arrival'] == 0 && $this->_var['item']['order_status'] == 0): ?>
						<a class="close-order" href="javascript:;" action="<?php
echo parse_url_tag("u:index|uc_totalbuy#close|"."id=".$this->_var['item']['order_id']."".""); 
?>" >关闭订单</a>
						<a class="red-btn" href="<?php
echo parse_url_tag("u:index|totalbuy#pay_check|"."id=".$this->_var['item']['order_id']."".""); 
?>">立即付款</a>
						<?php endif; ?>
						<?php if ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 1 && $this->_var['item']['is_arrival'] == 0 && $this->_var['item']['order_status'] == 0): ?>
						<a class="red-btn confirm_receipt" id="is_fictitious" href="javascript:void(0);" action="<?php
echo parse_url_tag("u:index|uc_totalbuy#verify_delivery|"."id=".$this->_var['item']['id']."".""); 
?>">确认收货</a>
						<?php endif; ?>
						<?php if ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 1 && $this->_var['item']['is_arrival'] == 1): ?>
						<a class="fictitious_info" href="javascript:;" action="<?php echo $this->_var['item']['fictitious_info']; ?>">查看信息</a>
						<?php endif; ?>
					</div>
					<?php else: ?>
					<div class="pay-btn">
						<?php if ($this->_var['item']['pay_status'] == 2): ?>
						<a href="<?php
echo parse_url_tag("u:index|duobao|"."dbid=".$this->_var['item']['duobao_id']."".""); 
?>">再次购买</a>
						<?php else: ?>
						<a href="<?php
echo parse_url_tag("u:index|duobao|"."dbid=".$this->_var['item']['duobao_id']."".""); 
?>">重新购买</a>
						<?php endif; ?>
						<?php if ($this->_var['item']['pay_status'] == 0 && $this->_var['item']['delivery_status'] == 0 && $this->_var['item']['is_arrival'] == 0 && $this->_var['item']['order_status'] == 0): ?>
						<a class="close-order" href="javascript:;" action="<?php
echo parse_url_tag("u:index|uc_totalbuy#close|"."id=".$this->_var['item']['order_id']."".""); 
?>" >关闭订单</a>
						<a class="red-btn" href="<?php
echo parse_url_tag("u:index|totalbuy#pay_check|"."id=".$this->_var['item']['order_id']."".""); 
?>">立即付款</a>
						<?php endif; ?>
						<?php if ($this->_var['item']['pay_status'] == 2 && $this->_var['item']['delivery_status'] == 1 && $this->_var['item']['is_arrival'] == 0 && $this->_var['item']['order_status'] == 0): ?>
						<a href="<?php
echo parse_url_tag("u:index|uc_order#check_delivery|"."item_id=".$this->_var['item']['id']."".""); 
?>">查看物流</a>
						<a class="red-btn confirm_receipt" href="javascript:void(0);" action="<?php
echo parse_url_tag("u:index|uc_totalbuy#verify_delivery|"."id=".$this->_var['item']['id']."".""); 
?>">确认收货</a>
						<?php endif; ?>
					</div>
					<?php endif; ?>
				</div>
			</li>
			<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
		</ul>
		<?php if ($this->_var['pages']): ?>
			<div class="fy scroll_bottom_page">
				<?php echo $this->_var['pages']; ?>
			</div>
		<?php endif; ?>
	</div>
<?php else: ?>
	<!-- 无数据↓ -->
    <div class="null_data">
		<p class="icon"><i class="iconfont"></i></p>
		<p class="message">暂无数据</p>
	</div>
<?php endif; ?>
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch('inc/footer_menu.html'); ?>
<?php echo $this->fetch('inc/footer_index.html'); ?>
<?php endif; ?>