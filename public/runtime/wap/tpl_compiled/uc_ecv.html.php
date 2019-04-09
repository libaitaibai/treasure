<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/uc_ecv.css";	
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";	
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

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/uc_ecv.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/uc_ecv.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/lib/touche.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";

?>
<?php echo $this->fetch('inc/header_evc_index.html'); ?>
<script>
var ajax_url  = '<?php echo $this->_var['ajax_url']; ?>';
var n_valid = '<?php echo $this->_var['n_valid']; ?>';
</script>
<a href="<?php
echo parse_url_tag("u:index|uc_ecv#exchange|"."".""); 
?>" class="exchange">红包兑换</a>
<div class="wrap">
<nav style="position: relative; z-index: 10;" class="ecv_criteria_tab">
   <ul class="ecv_tab_box" >
       <li class="<?php if ($this->_var['n_valid'] == 0): ?>this<?php endif; ?>"><a href="<?php
echo parse_url_tag("u:index|uc_ecv#index|"."".""); 
?>">可使用</a></li>
   	     <li class="<?php if ($this->_var['n_valid'] == 1): ?>this<?php endif; ?>"><a href="<?php
echo parse_url_tag("u:index|uc_ecv#index|"."&n_valid=1".""); 
?>">已失效</a></li>					   	     
   </ul>
</nav>
<?php endif; ?>

<div class="loading_container" id="loading_container">
	<?php if ($this->_var['ecv_list']): ?>
	<?php if ($this->_var['n_valid'] == 0): ?>
	<ul class="evc-list avilable scroll_bottom_list">
	    <?php $_from = $this->_var['ecv_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
		<li>
	
			<div class="evc-info split-line">
				<div class="evc-count">&yen;<span class="evc-count-sum"><?php echo $this->_var['item']['money']; ?></span></div>
				<div class="evc-count-info">
					<h2><?php echo $this->_var['item']['name']; ?></h2>
					<?php if ($this->_var['item']['memo']): ?><p><?php echo $this->_var['item']['memo']; ?></p><?php endif; ?>
					<?php if ($this->_var['item']['meet_amount'] == 0): ?>
					<p >订单金额无限制</p>
					<?php else: ?>
					<p >订单满<?php echo $this->_var['item']['meet_amount']; ?>元可用</p>
					<?php endif; ?>
					<?php if ($this->_var['item']['is_all']): ?>
					<p >所有区可用</p>
					<?php else: ?>
					<p ><?php echo $this->_var['item']['range_value1']; ?><?php echo $this->_var['item']['range_value2']; ?><?php echo $this->_var['item']['range_value3']; ?><?php echo $this->_var['item']['range_value4']; ?><?php echo $this->_var['item']['range_value5']; ?><?php echo $this->_var['item']['range_value6']; ?><?php echo $this->_var['item']['range_value7']; ?>可用</p>
					<?php endif; ?>
				</div>
			</div>
			<div class="evc-time">
				<p>
				<?php echo $this->_var['item']['datetime']; ?>
				</p>
			</div>
			<div class="evc-border">
			</div>
		</li>
	        <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	</ul>
	<?php else: ?>
	<ul class="evc-list unavilable scroll_bottom_list">
	    <?php $_from = $this->_var['ecv_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
		<li>
			<div class="evc-info split-line">
				<div class="evc-count">&yen;<span class="evc-count-sum"><?php echo $this->_var['item']['money']; ?></span></div>
				<div class="evc-count-info">
					<h2><?php echo $this->_var['item']['name']; ?></h2>
					<?php if ($this->_var['item']['memo']): ?><p><?php echo $this->_var['item']['memo']; ?></p><?php endif; ?>
					<?php if ($this->_var['item']['meet_amount'] == 0): ?>
					<p >订单金额无限制</p>
					<?php else: ?>
					<p >订单满<?php echo $this->_var['item']['meet_amount']; ?>元可用</p>
					<?php endif; ?>	
					<?php if ($this->_var['item']['is_all']): ?>
					<p >所有区可用</p>
					<?php else: ?>
					<p ><?php echo $this->_var['item']['range_value7']; ?><?php echo $this->_var['item']['range_value2']; ?><?php echo $this->_var['item']['range_value3']; ?><?php echo $this->_var['item']['range_value4']; ?><?php echo $this->_var['item']['range_value5']; ?><?php echo $this->_var['item']['range_value6']; ?><?php echo $this->_var['item']['range_value1']; ?>可用</p>
					<?php endif; ?>
				</div>
			</div>
			<div class="evc-time">
				<p>
				<?php echo $this->_var['item']['datetime']; ?>
				</p>
			</div>
			<div class="evc-border">
			</div>
		</li>
	        <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	</ul>
	<?php endif; ?>
	<?php if ($this->_var['pages']): ?>
	                <div class="fy scroll_bottom_page">
	                        <?php echo $this->_var['pages']; ?>
	                </div>
	              
	  <?php endif; ?>
	  <?php else: ?>
	    <div class="lose">
	    <div class="bgbox">
	    </div>
	    <h1>您还没有红包</h1>
	    <a href="<?php
echo parse_url_tag("u:index|index#index|"."".""); 
?>"><button>立即夺宝</button></a>
	  </div>
	
	  <?php endif; ?>   
	  
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch(footer_index); ?>
<?php endif; ?>