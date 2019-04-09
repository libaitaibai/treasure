<?php if ($this->_var['result_list']['cart_list']): ?>
<div class="cart_tip_result_title">最近加入的商品</div>
<div class="cart_tip_result_list">
<?php $_from = $this->_var['result_list']['cart_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'cart_item');if (count($_from)):
    foreach ($_from AS $this->_var['cart_item']):
?>
<div class="cart_tip_result_item clearfix">
	<div class="cart_tip_result_img f_l"><a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['cart_item']['duobao_item_id']."".""); 
?>"><img src="<?php 
$k = array (
  'name' => 'get_spec_image',
  'v' => $this->_var['cart_item']['deal_icon'],
  'w' => '74',
  'h' => '74',
  'g' => '1',
);
echo $k['name']($k['v'],$k['w'],$k['h'],$k['g']);
?>" /></a></div>
	<div class="cart_tip_result_cnt">
		<span><a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['cart_item']['duobao_item_id']."".""); 
?>"><?php 
$k = array (
  'name' => 'msubstr',
  'v' => $this->_var['cart_item']['name'],
  'b' => '0',
  'e' => '40',
);
echo $k['name']($k['v'],$k['b'],$k['e']);
?></a></span>
	</div>
	<div>
		<div class="cart_tip_result_desc f_l">
		<?php 
$k = array (
  'name' => 'round',
  'v' => $this->_var['cart_item']['total_price'],
  'e' => '2',
);
echo $k['name']($k['v'],$k['e']);
?>云币  × 1期
		</div>
		<div class="cart_tip_result_op f_r">
		<a href="javascript:del_cart(<?php echo $this->_var['cart_item']['id']; ?>);">删除</a>
		</div>
	</div>
</div>
<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
</div>
<div class="cart_tip_result_bar">
<div class="cart_tip_result_count">共有<?php echo $this->_var['result_list']['total_data']['cart_item_number']; ?>件商品，金额总计：<span><?php 
$k = array (
  'name' => 'round',
  'v' => $this->_var['result_list']['total_data']['total_price'],
  't' => '2',
);
echo $k['name']($k['v'],$k['t']);
?>云币</span></div>
<a href="<?php
echo parse_url_tag("u:index|cart|"."".""); 
?>" class="cart_tip_result_btn btn">查看清单并计算</a>
</div>
<?php else: ?>
<div class="empty">您的清单中还没有任何商品</div>
<?php endif; ?>