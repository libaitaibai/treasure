
<div class="footer-menu-box">
    <div class="f_menu split-line-top">
  		<ul class="menu_box">
  			<li class="menu_item <?php if ($this->_var['MODULE_NAME'] == 'index'): ?>cur<?php endif; ?>">
  				<a href="<?php
echo parse_url_tag("u:index|index#index|"."".""); 
?>">
	  				<p><i class="iconfont">&#xe6ee;</i></p>
	  				<p class="item_txt">首页</p>
  				</a>
  			</li>
			<li class="menu_item <?php if ($this->_var['MODULE_NAME'] == 'anno'): ?>cur<?php endif; ?>">
				<a href="<?php
echo parse_url_tag("u:index|anno#index|"."".""); 
?>">
					<p><i class="iconfont">&#xe6ed;</i></p>
					<p class="item_txt">最新揭晓</p>
				</a>
			</li>
  			<li class="menu_item <?php if ($this->_var['MODULE_NAME'] == 'cart'): ?>cur<?php endif; ?>">
  				<a href="<?php
echo parse_url_tag("u:index|cart#index|"."".""); 
?>">
	  				<p style="position:relative;" >
	  					<i class="iconfont">&#xe6ea;</i>
	  					<div class="nav_cart_num" <?php if ($this->_var['data']['cart_info']['cart_item_num'] > 0): ?>style="display:block;"<?php endif; ?>><?php echo $this->_var['data']['cart_info']['cart_item_num']; ?></div>
	  				</p>
	  				<p class="item_txt">清单</p>
	  			</a>
	  		</li>
  			<li class="menu_item <?php if ($this->_var['MODULE_NAME'] == 'more'): ?>cur<?php endif; ?>">
  				<a href="<?php
echo parse_url_tag("u:index|more#index|"."".""); 
?>">
  					<p><i class="iconfont">&#xe69c;</i></p>
  					<p class="item_txt">发现</p>
  				</a>
  			</li>
  			<li class="menu_item <?php if ($this->_var['MODULE_NAME'] == 'user_center'): ?>cur<?php endif; ?>">
  				<a href="<?php
echo parse_url_tag("u:index|user_center#index|"."".""); 
?>" onclick="mt_rand(this);">
  					<p><i class="iconfont">&#xe6ec;</i></p>
  					<p class="item_txt">我</p>
  				</a>
  			</li>
		</ul>
		<a href="/o2onew/wap/biz.php?ctl=more"></a>
	</div>
</div>
<script type="text/javascript">
	<?php if ($this->_var['signin_result']): ?>
	show_signin_message(<?php echo $this->_var['signin_result']; ?>);
	<?php endif; ?>
</script>