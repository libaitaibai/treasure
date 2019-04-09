<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/index.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/utils/weebox.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/utils/fanweUI.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/zone.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/goods_item.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/pk.css";
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
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/pk_choose_pkgoods.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/page_js/pk_choose_pkgoods.js";
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/dc/js/page_js/slider.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/dc/js/page_js/slider.js";
?>
<?php echo $this->fetch('inc/header.html'); ?>
<div class="blank15"></div>
<div class="wrap_full_w clearfix">
    <div class="pk-type clearfix">
        <a href='<?php
echo parse_url_tag("u:index|pk#index|"."".""); 
?>' class="">进行中</a><a href='<?php
echo parse_url_tag("u:index|pk#choose_pkgoods|"."".""); 
?>' class="active">发起PK</a>
    </div>
    <div class="goods-list-wrap f_l">
        <ul class="goods-list clearfix ui-list" width="240" pin_col_init_width="0" wSpan="0" hSpan="1">
            <?php $_from = $this->_var['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'item');if (count($_from)):
    foreach ($_from AS $this->_var['item']):
?>
            <li class="goods ui-item">
                <div class="hover_line">
                    <?php if ($this->_var['item']['unit_price'] == 10): ?>
                    <div class="ico logo-box ten-logo-box"></div>
                    <?php elseif ($this->_var['item']['unit_price'] == 100): ?>
                    <div class="ico logo-box hundred-logo-box"></div>
                    <?php endif; ?>
                    <div class="clear"></div>
                    <div class="goods-wrap">
                        <div class="imgbox">
                            <a href='javascript:void(0)' style="cursor: default;text-decoration:none;" title="">
                                <img src="<?php echo $this->_var['item']['icon']; ?>" width="200" height="200">
                            </a>
                        </div>
                        <a href='javascript:void(0)' style="cursor: default;text-decoration:none;" class="goods-title" title="">
                            <?php echo $this->_var['item']['name']; ?>
                        </a>

                        <div class="p-price f_l">
                            总需：<?php echo $this->_var['item']['max_buy']; ?>
                        </div>
                        <div class="clear"></div>
                       <?php if ($this->_var['item']['status'] == 0): ?>
                        <div class="btn-box">
                            <a class="pk-now btn j-pking" href="javascript:void(0);">发起pk中</a>
                        </div>
                       <?php else: ?>
                        <div class="btn-box">
                            <a class="pk-now btn j-pk" href="javascript:void(0);" goodName="<?php echo $this->_var['item']['name']; ?>" max_buy="<?php echo $this->_var['item']['max_buy']; ?>" duobao_id="<?php echo $this->_var['item']['id']; ?>" pk_min_number="<?php echo $this->_var['item']['pk_min_number']; ?>">发起PK</a>
                        </div>
                       <?php endif; ?>
                    </div>
                </div>
            </li>
            <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
        </ul>
        <div class="pages"><?php echo $this->_var['pages']; ?></div>
    </div>
    <div class="duobao-rule f_r">
        <h1 class="title">pk专区 规则说明</h1>
        <div class="ten-rule-wrap">
            <ul class="ten-rule">
                <li><span>1.</span>发起任意PK活动，可以邀请其他用户一起参与，同时，您也可以参与已发起的PK活动;</li>
                <li><span>2.</span>“pk专区”是指限定参与人数且参与者数量相同;</li>
                <li><span>3.</span>可以对pk场进行设置密码或者不设置。</li>
            </ul>
        </div>
    </div>
</div>
<div class="pk-box">
    <div class="mask"></div>
    <div class="start-pk">
        <div class="hd">发起PK设置</div>
        <div class="close-pk"></div>
        <h2 class="pk-tit"id="pk-title"></h2>

        <p class="pk-num">总需人次：<span id="span-pk-num"></span></p>

        <form autocomplete="off">
            <div class="pk-set">
                <p>设置本商品参与人数：</p>

                <div class="number-box pk-num-count">
                    <!-- 减号 -->
                    <a href="javascript:void(0);" class="num-btn num-btn-min active" id="button_minus">-</a>
                    <!-- 输入框 -->
                    <input type="text" onfocus="this.select()" value="2" class="num-input" check-login='<?php
echo parse_url_tag("u:index|user#check_login|"."".""); 
?>' url='<?php
echo parse_url_tag("u:index|pk#choose_pkgoods_do|"."".""); 
?>' id="buyer_number">
                    <!-- 加号 -->
                    <a href="javascript:void(0);" class="num-btn num-btn-plus active" id="button_plus">+</a>
                </div>
            </div>
            <div class="pk-set">
                <p>设置本商品PK密码：</p>
                <input type="password" id="pk_password" placeholder="请设置密码(选填)">
            </div>
            <a href="javascript:void(0);" class="btn start-pk-btn" id="submit">确认发起</a>
        </form>
    </div>
</div>
<?php echo $this->fetch('inc/footer.html'); ?>