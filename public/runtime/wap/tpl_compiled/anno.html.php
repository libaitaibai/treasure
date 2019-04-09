<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/anno.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/pull_refresh.css";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/fastclick.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery-1.6.2.min.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.timer.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";



$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/anno.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/anno.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/lib/touche.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/pull_refresh/pull-refresh.js";

?>

<?php echo $this->fetch('inc/header_title_only.html'); ?>

<?php endif; ?> 

<div class="wrap loading_container" id="loading_container">
      <?php if ($this->_var['list']): ?>
      <ul class="goods-list scroll_bottom_list">
      	<?php $_from = $this->_var['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
        <li>
        <a href="<?php
echo parse_url_tag("u:index|duobao|"."data_id=".$this->_var['item']['id']."".""); 
?>">
            <div class="imgbox">
            	<?php if ($this->_var['item']['min_buy'] == 10): ?>
                	<div class="tenyen"></div>
              	<?php endif; ?>
              	<a href="<?php
echo parse_url_tag("u:index|duobao|"."data_id=".$this->_var['item']['id']."".""); 
?>">
            		<img src="<?php echo $this->_var['item']['icon']; ?>" alt="">
           		</a>
            </div>

            <?php if ($this->_var['item']['has_lottery'] == 1): ?>
            <div class="txtbox announced">
              <h1><a href="<?php
echo parse_url_tag("u:index|duobao|"."data_id=".$this->_var['item']['id']."".""); 
?>">
            		<?php echo $this->_var['item']['duobaoitem_name']; ?>
           		</a></h1>
              <ul class="txtlist fl">
                <li>期<em></em><em></em><em></em><em></em>号：<span class="code"><?php echo $this->_var['item']['id']; ?></sapn></li>
                <li>获<em></em>得<em></em>者：<span class="user"><a href="<?php
echo parse_url_tag("u:index|anno_user_center|"."lucky_user_id=".$this->_var['item']['luck_user_id']."".""); 
?>"><?php echo $this->_var['item']['luck_user_name']; ?></a></span></li>
                <li>参与人次：<span class="people"><?php echo $this->_var['item']['luck_user_buy_count']; ?></span></li>
                <li>幸运号码：<span class="luckycode"><?php echo $this->_var['item']['lottery_sn']; ?></span></li>
                <li>揭晓时间：<time><?php echo $this->_var['item']['date']; ?><?php echo $this->_var['item']['lottery_time_show']; ?></time></li>
              </ul>
            </div>
            <!--
            <div style="display:none;" class="txtbox announcing">
	              <h1>中国黄金 AU9999万足金50g薄片</h1>
	              <p class="code">
	               		 期号：
	                <span>301202399</span>
	              </p>
	              <h2>
	                <i class="iconfont">&#xe629;</i>
	                	<span class="set_hint_info">即将开奖</span>
	              </h2>

	              <time class="w-countdown-nums" nowtime="<?php echo $this->_var['now_time']; ?>000" endtime="<?php echo $this->_var['item']['lottery_time']; ?>000">11:36:79</time>
             </div>
            -->
            <?php else: ?>

            <!--
            <div style="display:none;" class="txtbox announced">
              <div class="flexbox">
              <h1></h1>
              </div>
              <ul class="txtlist fl">
                <li>期号</li>
                <li>获得者</li>
                <li>参与人次</li>
                <li>幸运号码</li>
                <li>揭晓时间</li>
              </ul>
              <ul class="fl">
                <li>:<span class="code"></sapn></li>
                <li>:<span class="user"></span></li>
                <li>:<span class="people"></span></li>
                <li>:<span class="luckycode"></span></li>
                <li>:<time></time></li>
              </ul>
              <div class="clear"></div>
            </div>
            -->
            <div class="txtbox announcing">
	              <h1><?php echo $this->_var['item']['duobaoitem_name']; ?></h1>
	              <p class="code">
	               		 期号：
	                <span><?php echo $this->_var['item']['id']; ?></span>
	              </p>
	              <h2>
	                <i class="iconfont">&#xe629;</i>
	                	<span class="set_hint_info">即将开奖</span>
	              </h2>

	              <time class="w-countdown-nums ex_count_down" nowtime="<?php echo $this->_var['now_time']; ?>" endtime="<?php echo $this->_var['item']['lottery_time']; ?>">00:00:00</time>
                      <div class="w-countwaiting" data-pro="countdownwaiting" style="">正在计算...</div>
	              <!-- <time class="w-countdown-nums" nowtime="1453335545750" endtime="1453335546770">11:36:79</time>  -->
             </div>

            <?php endif; ?>

          </a>
        </li>
        <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
	<div class="clear"></div>
    </ul>
	<?php if ($this->_var['pages']): ?>
	<div class="fy scroll_bottom_page">
		<?php echo $this->_var['pages']; ?>
	</div>
	<?php endif; ?>
	<!-- 无数据↓ -->
	<?php else: ?>
    <div class="null_data">
      <p class="icon"><i class="iconfont">&#xe6e8;</i></p>
      <p class="message">暂无数据</p>
    </div>
	<?php endif; ?>
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch('inc/footer_menu.html'); ?>
<?php echo $this->fetch('inc/footer_index.html'); ?>
<?php endif; ?>
