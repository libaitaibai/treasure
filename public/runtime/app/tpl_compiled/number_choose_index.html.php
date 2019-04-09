<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/index.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/utils/weebox.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/utils/fanweUI.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/zone.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/goods_item.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/number_choose.css";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.bgiframe.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.weebox.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.pngfix.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.animateToClass.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.timer.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/jquery.SuperSlide.2.1.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/utils/lazyload.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/fanwe_utils/fanweUI.js";

$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/script.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/login_panel.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/login_panel.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/index.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/index.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/number_choose.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/number_choose.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/dc/js/page_js/slider.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/dc/js/page_js/slider.js";

?>
<?php echo $this->fetch('inc/header.html'); ?>
<div class="blank15"></div>
<div class="wrap_full_w clearfix">
    <div class="goods-list-wrap f_l">
        <h1 class="main-title">所有商品</h1>
        <ul class="goods-list clearfix ui-list" width="240" pin_col_init_width="0" wSpan="-1" hSpan="1">
            <?php $_from = $this->_var['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('key', 'cart_item_group');if (count($_from)):
    foreach ($_from AS $this->_var['key'] => $this->_var['cart_item_group']):
?>
            <li class="goods ui-item">
                <div class="hover_line">
                    <?php if ($this->_var['cart_item_group']): ?>
                    <?php if ($this->_var['cart_item_group']['unit_price'] == 10): ?>
                    <div class="ico logo-box ten-logo-box"></div>
                    <?php elseif ($this->_var['cart_item_group']['unit_price'] == 100): ?>
                    <div class="ico logo-box hundred-logo-box"></div>
                    <?php endif; ?>
                    <div class="clear"></div>
                    <div class="goods-wrap">
                        <div class="imgbox">
                            <a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['cart_item_group']['id']."".""); 
?>" title="<?php echo $this->_var['cart_item_group']['name']; ?>">
                            <img src="<?php echo $this->_var['cart_item_group']['icon']; ?>" width="200" height="200">
                            </a>
                        </div>
                        <a href="<?php
echo parse_url_tag("u:index|duobao|"."id=".$this->_var['cart_item_group']['id']."".""); 
?>" class="goods-title" title="<?php echo $this->_var['cart_item_group']['name']; ?>">
                        <?php echo $this->_var['cart_item_group']['name']; ?>
                        </a>
                        <div class="p-price f_l">
                            总需：<?php echo $this->_var['cart_item_group']['max_buy']; ?>人次
                        </div>
                        <div class="clear"></div>
                        <div class="progress" title="<?php echo $this->_var['cart_item_group']['progress']; ?>%">
                            <div class="progress-bar" style="width: <?php echo $this->_var['cart_item_group']['progress']; ?>%"></div>
                        </div>
                        <ul class="person-info">
                            <li class="f_l">
                                <p class="num"><?php echo $this->_var['cart_item_group']['number']; ?></p>
                                <p class="info">已参与人次</p>
                            </li>
                            <li class="f_r tar">
                                <p class="num"><?php echo $this->_var['cart_item_group']['less']; ?></p>
                                <p class="info">剩余人次</p>
                            </li>
                            <div class="clear"></div>
                        </ul>
                        <div class="btn-box">
                            <a class="duobao-now btn" href="javascript:void(0);" duobao-item-id="<?php echo $this->_var['cart_item_group']['id']; ?>" url='<?php
echo parse_url_tag("u:index|number_choose#select|"."".""); 
?>'>立即选号</a>
                        </div>
                    </div>
                    <?php else: ?>
                    <li class="goods goods-pic">
                        <img src="<?php echo $this->_var['TMPL']; ?>/images/goods_list_li_bg.png" width="237" height="396">
                    </li>
                    <?php endif; ?>
                </div>
            </li>
            <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
        </ul>
        <div class="pages"><?php echo $this->_var['pages']; ?></div>
    </div>
    <div class="duobao-rule f_r">
        <h1 class="title">选号专区 规则说明</h1>
        <div class="ten-rule-wrap">
            <ul class="ten-rule">
                <li><span>1.</span>“选号专区”是指每次参与的号码都可以自己选择;</li>
                <li><span>2.</span>选号专区只能选择还没有人购买的号码；</li>
                <li><span>3.</span>幸运号码计算规则与一元夺宝商品相同。</li>
            </ul>
        </div>
    </div>
</div>
<div class="number-choose-box">
    <div class="mask"></div>
    <div class="choose-number">
        <div class="close-choose"></div>
        <div class="hd">
            <a class="can-choose-only" href="javascript:void(0);">只显示可选号码</a>
            <a class="all-choose" href="javascript:void(0);">全选</a>
            <a class="cancel-all-choose active" href="javascript:void(0);">取消全选</a>
            <a href="javascript:void(0)" class="choose-btn btn" id="confirm" check-login='<?php
echo parse_url_tag("u:index|user#check_login|"."".""); 
?>' url='<?php
echo parse_url_tag("u:index|number_choose#add_cart|"."".""); 
?>'>确定</a>
        </div>
        <ul class="clearfix number-list" id="number-list">

        </ul>
        <ul class="choose-tip">
            <li><div class="tip-ico tip-ico-can"></div><p>可选</p></li>
            <li><div class="tip-ico tip-ico-cant"></div><p>不可选</p></li>
            <li><div class="tip-ico tip-ico-ready"></div><p>已选</p></li>
        </ul>
    </div>
</div>
<?php echo $this->fetch('inc/footer.html'); ?>