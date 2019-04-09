<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/cart_index.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/pull_refresh.css";

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
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/sms_verify.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/sms_verify.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/cart_index.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/cart_index.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/lib/touche.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";


?>

<?php echo $this->fetch('inc/header_title_only.html'); ?>

<script type="text/javascript">
	//减少移动端触发"Click"事件时300毫秒的时间差
window.addEventListener('load', function() {
    FastClick.attach(document.body);
}, false);
var jsondata = <?php echo $this->_var['jsondata']; ?>;
var cart_index = 1;
</script>

<?php endif; ?>


<div class="loading_container" id="loading_container">
	<form name="buy_form" id="buy_form" action="<?php
echo parse_url_tag("u:index|cart#check_cart|"."".""); 
?>" method="post">
	<input type="hidden" value="<?php echo $this->_var['type']; ?>" name="type"/>
	<div class="wrap">
	    <?php if ($this->_var['data']['cart_list']): ?>
			<ul class="cart-list">
		<?php $_from = $this->_var['data']['cart_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
				<li class="split-line" data-id="<?php echo $this->_var['item']['id']; ?>">
				  <div class="goods-img">
	          <?php if ($this->_var['item']['min_buy'] == 10 || $this->_var['item']['unit_price'] == 10): ?>
	            <div class="tenyen"></div>
	          <?php elseif ($this->_var['item']['unit_price'] == 100): ?>
	            <div class="hundredyen"></div>
	          <?php endif; ?>
				    <img src="<?php echo $this->_var['item']['deal_icon']; ?>" alt="<?php echo $this->_var['item']['deal_icon']; ?>">
				  </div>
				  <div class="txtbox">
						<div class="flex-box">
							<h2> <?php if ($this->_var['item']['is_topspeed']): ?>
                                <em style="background-color:#ff2300;padding: 1px 3px;color: #fff;font-size: 12px;">极速</em>
                                <?php endif; ?><?php echo $this->_var['item']['name']; ?></h2>
						</div>
						<p>总需:<span><?php echo $this->_var['item']['max_buy']; ?></span>人次，剩余<span class="rest"><?php echo $this->_var['item']['residue_count']; ?></span>人次</p>
					    <div class="select-bar">
					  	<p>参与人次</p>
						  	<div class="select-wrap">
							  	<div class="select">
                                    <?php if ($this->_var['item']['is_number_choose']): ?>
                                    <a href="javascript:void(0);" class="iconfont split-line-right" data-id="<?php echo $this->_var['item']['id']; ?>">&#xe6d3;</a>
                                    <input name="num[<?php echo $this->_var['item']['id']; ?>]" readonly="readonly" class="buy_number buy-num-<?php echo $this->_var['item']['id']; ?> buy_number_js" type="tel" value="<?php echo $this->_var['item']['number']; ?>" data-id="<?php echo $this->_var['item']['id']; ?>" />
                                    <a href="javascript:void(0);" class="iconfont split-line-left" data-id="<?php echo $this->_var['item']['id']; ?>">&#xe6d1;</a>
                                    <em>选号区的物品无法在购物区改变数量</em>
                                    <?php else: ?>
                                    <a href="javascript:void(0);" class="iconfont split-line-right minus" data-id="<?php echo $this->_var['item']['id']; ?>">&#xe6d3;</a>
                                    <input name="num[<?php echo $this->_var['item']['id']; ?>]" class="buy_number buy-num-<?php echo $this->_var['item']['id']; ?> buy_number_js" type="tel" value="<?php echo $this->_var['item']['number']; ?>" data-id="<?php echo $this->_var['item']['id']; ?>" />
                                    <a href="javascript:void(0);" class="iconfont split-line-left plus" data-id="<?php echo $this->_var['item']['id']; ?>">&#xe6d1;</a>
                                    <em>参与人次需是<?php echo $this->_var['item']['min_buy']; ?>的倍数</em>
                                    <?php endif; ?>
							  	</div>
						  	</div>
					  	<i class="iconfont del-item-btn" data-id="<?php echo $this->_var['item']['id']; ?>">&#xe68d;</i>
					    </div>
				  </div>
				  <div class="clear"></div>
				</li>
		<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	
			</ul>
	    <?php else: ?>
			<div class="null_data">
			<p class="icon"><i class="iconfont">&#xe6e8;</i></p>
			<p class="message">购物车暂无数据</p>
			</div>
	
	    <?php endif; ?>
	
	    </div>
	    
	<div class="cart-floot">
	    <div class="cart-count-box split-line-top">
	    <?php if ($this->_var['type'] == 'free'): ?>
	        <div  class="cart-item-number">共<span class="cart-num-set"><?php echo $this->_var['data']['total_data']['cart_item_number']; ?></span>商品，总计: <span><?php echo $this->_var['data']['total_data']['total_price']; ?></span>优惠币</div>
	        <?php if ($this->_var['is_new_member'] == 0): ?>
		    	<input class="check-btn" style="background-color: #ddd;color:#fff; width:7rem" type="button" value="新用户才能参与免费购" />
		    <?php else: ?>
	    		<input class="check-btn" type="submit" value="结算" />
		    <?php endif; ?>
	    <?php endif; ?>
	    <?php if ($this->_var['type'] == ''): ?>
	        <div  class="cart-item-number">共<span class="cart-num-set"><?php echo $this->_var['data']['total_data']['cart_item_number']; ?></span>商品，总计: <span><?php echo $this->_var['data']['total_data']['total_price']; ?></span>元</div>
	        <input class="check-btn" type="submit" value="结算" />
	    <?php endif; ?>
	    </div>
	</div>
	</form>
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch('inc/app_input_num.html'); ?>
<?php echo $this->fetch('inc/footer_menu.html'); ?>
<?php echo $this->fetch('inc/footer_index.html'); ?>
<?php endif; ?>
