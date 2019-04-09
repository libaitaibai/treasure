<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/user_center.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/publish.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/pull_refresh.css";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery-1.6.2.min.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.bgiframe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.timer.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.weebox.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.touchwipe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/fastclick.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/exif.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/lrz.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/uc_account_head.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/uc_account_head.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/lib/touche.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";


?>
<?php echo $this->fetch('inc/no_header.html'); ?>
<?php endif; ?>

<div class="wrap loading_container" id="loading_container">
<div class="content">
<?php echo $this->fetch('inc/uc_info_head.html'); ?>
<script type="text/javascript">
var suce_url = '<?php
echo parse_url_tag("u:index|uc_account_head#submit_cert|"."".""); 
?>';
</script>
<!--副导航-->
	<div class="uc-sub-nav split-line">
		<ul class="uc-nav-list">
			<li class="uc-nav-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_duobao_record|"."log_type=1".""); 
?>">
					<div class="iconfont">&#xe6e0;</div>
					<div class="nav-title">正在进行</div>
				</a>
			</li>
			<li class="uc-nav-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_duobao_record|"."log_type=2".""); 
?>">
					<div class="iconfont">&#xe6f6;</div>
					<div class="nav-title">已经揭晓</div>
				</a>
			</li>
			<li class="uc-nav-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_winlog#index|"."".""); 
?>">
					<div class="iconfont">&#xe6e1;</div>
					<div class="nav-title">中奖记录</div>
				</a>
			</li>
		</ul>
	</div>
	<!--end 副导航-->

	<!--
	菜单连接
	1.全部夺宝记录
	2.中奖记录
	3.配送地址
	4.我的红包
	5.我的消息
	6.我的邀请
	7.资金明细
	8。晒单
	9.设置
	-->
	<div class="uc-list-view split-line">
	     <ul class="uc-list-v-items">
	     	    <li class="uc-v-item">
	       	    	<a href="<?php
echo parse_url_tag("u:index|uc_duobao_record#index|"."".""); 
?>">
	       	    	    <div class="sub-uc-v-item">
	       	    	    	<i class="left-icon iconfont font-green">&#xe6ff;</i>
								<span>全部夺宝记录</span>
							<i class="right-jt iconfont">&#xe6fa;</i>
	       	    	    </div>
	       	        </a>
							</li>
	     </ul>
	</div>
	<div class="uc-list-view split-line split-line-top">
	     <ul class="uc-list-v-items">
	     	    <li class="uc-v-item">
	       	    	<a href="<?php
echo parse_url_tag("u:index|uc_totalbuy|"."".""); 
?>">
	       	    	    <div class="sub-uc-v-item">
	       	    	    	<i class="left-icon iconfont font-orange">&#xe6f3;</i>
								<span>购买记录</span>
							<i class="right-jt iconfont">&#xe6fa;</i>
	       	    	    </div>
	       	        </a>
							</li>
	     </ul>
	</div>
	<div class="uc-list-view split-line-top split-line">
		<ul class="uc-list-v-items">
			<li class="uc-v-item">
	        	<a href="<?php
echo parse_url_tag("u:index|uc_ecv#index|"."".""); 
?>">
	        		<div class="sub-uc-v-item">
	        	    	<i class="left-icon iconfont font-pink">&#xe6c7;</i>
	        	    	<div class="flex-box flex-1 split-line">
	 					<span>我的红包</span>
	 					<i class="right-jt iconfont">&#xe6fa;</i>
	 					</div>
	        	    </div>
	        	</a>
	 		</li>
			<li class="uc-v-item">
	        	<a href="<?php
echo parse_url_tag("u:index|uc_msg#index|"."".""); 
?>">
	        		<div class="sub-uc-v-item">
	        	    	<i class="left-icon iconfont font-light-gray">&#xe6fb;</i>
	 					<span>我的消息<em class="msg_count"><?php if ($this->_var['data']['msg_count']): ?>（<?php echo $this->_var['data']['msg_count']; ?>条未读）<?php endif; ?></em></span>
	 					<i class="right-jt iconfont">&#xe6fa;</i>
	        		</div>
	        	</a>
	 		</li>
		</ul>
	</div>
	<div class="uc-list-view split-line-top split-line">
		<ul class="uc-list-v-items">
			<li class="uc-v-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_money#setting|"."".""); 
?>">
					<div class="sub-uc-v-item">
						<i class="left-icon iconfont font-violet">&#xe6c9;</i>
						<div class="flex-box flex-1 split-line">
						<span>资金记录</span>
						<i class="right-jt iconfont">&#xe6fa;</i>
						</div>
					</div>
				</a>
			</li>
			<li class="uc-v-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_winlog#index|"."".""); 
?>">
					<div class="sub-uc-v-item">
						<i class="left-icon iconfont font-light-green">&#xe6fe;</i>
						<div class="flex-box flex-1 split-line">
						<span>中奖记录</span>
						<i class="right-jt iconfont">&#xe6fa;</i>
						</div>
					</div>
				</a>
			</li>
			<li class="uc-v-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_share|"."".""); 
?>">
					<div class="sub-uc-v-item">
					<i class="left-icon iconfont font-blue">&#xe6ce;</i>
						<div class="flex-box flex-1 split-line">
							<span>我的晒单</span>
							<i class="right-jt iconfont">&#xe6fa;</i>
						</div>
					</div>
				</a>
			</li>
			 
		</ul>
		 	
	</div>  
	<div class="uc-list-view split-line-top split-line">
		<ul class="uc-list-v-items">
				<?php if ($this->_var['data']['is_open_scan'] && $this->_var['data']['fx_is_open'] == 1): ?>
				<li class="uc-v-item">
	       	    	<a href="<?php
echo parse_url_tag("u:index|uc_fxinvite#index1|"."".""); 
?>">
	       	    	    <div class="sub-uc-v-item">
	       	    	    	<i class="left-icon iconfont  font-gules">&#xe6fc;</i> 
	       	    	    	<div class="flex-box flex-1 split-line">
								<span>我的邀请</span>
								<i class="right-jt iconfont">&#xe6fa;</i>
							</div>
	       	    	    </div>
	       	        </a>
				</li>
				<?php endif; ?>
				<li class="uc-v-item">
					<a href="<?php
echo parse_url_tag("u:index|uc_fxinvite#index|"."".""); 
?>">
						<div class="sub-uc-v-item">
							<i class="left-icon iconfont font-orange">&#xe65b;</i>
							<div class="flex-box flex-1 split-line">
								<span>链接推广</span>
								<i class="right-jt iconfont">&#xe6fa;</i>
							</div>
						</div>
					</a>
				</li>
				
				<?php if ($this->_var['data']['is_open_scan'] && $this->_var['data']['fx_is_open'] == 1): ?>
				<li class="uc-v-item">
					<a href="<?php
echo parse_url_tag("u:index|user_center#qrcode|"."data_id=".$this->_var['data']['uid']."".""); 
?>"}">
						<div class="sub-uc-v-item">
							<i class="left-icon iconfont font-light-gray">&#xe650;</i>
							<span>微信渠道二维码</span>
							<i class="right-jt iconfont">&#xe6fa;</i>
						</div>
					</a>
				</li>
				<?php endif; ?>
		</ul>
	</div>
	 
	<!--设置里面
		修改密码
		配送地址
		退出登录 -->
	<div class="uc-list-view split-line-top split-line">
		<ul class="uc-list-v-items">
			<li class="uc-v-item">
				<a href="<?php
echo parse_url_tag("u:index|uc_setting#index|"."r=".$this->_var['data']['random']."".""); 
?>">
					<div class="sub-uc-v-item">
						<i class="left-icon iconfont">&#xe6cf;</i>
						<span>设置</span>
						<i class="right-jt iconfont">&#xe6fa;</i>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch('inc/footer_menu.html'); ?>
<?php echo $this->fetch('inc/footer_index.html'); ?>
<?php endif; ?>