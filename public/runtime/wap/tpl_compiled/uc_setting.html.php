<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/weebox.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/fanweUI.css";
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
<?php echo $this->fetch('inc/header_evc.html'); ?>
<?php endif; ?>

<div class="wrap loading_container" id="loading_container">
    <div class="content">
        <!--用户信息部分-->
        <?php echo $this->fetch('inc/uc_info_head.html'); ?>
        <script type="text/javascript">
            var suce_url = '<?php
echo parse_url_tag("u:index|uc_account_head#submit_cert|"."".""); 
?>';
        </script>
        <!--end 用户信息部分-->
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
        <div class="uc-list-view" style="margin-top: .4rem;">
            <ul class="uc-list-v-items split-line split-line-top">
                <li class="uc-v-item">
                    <a href="<?php
echo parse_url_tag("u:index|user#user_change_name|"."".""); 
?>">
                    <div class="sub-uc-v-item">
                        <i class="left-icon iconfont font-violet">&#xe6f1;</i>

                        <div class="flex-box flex-1 split-line">
                            <span>修改昵称</span>
                            <i class="right-jt iconfont">&#xe6fa;</i>
                        </div>
                    </div>
                    </a>
                </li>
                <li class="uc-v-item">
                    <a href="<?php
echo parse_url_tag("u:index|user#getpassword|"."".""); 
?>">
                    <div class="sub-uc-v-item">
                        <i class="left-icon iconfont font-violet">&#xe6cc;</i>

                        <div class="flex-box flex-1 split-line">
                            <span>修改密码</span>
                            <i class="right-jt iconfont">&#xe6fa;</i>
                        </div>
                    </div>
                    </a>
                </li>
                <li class="uc-v-item">
                    <a href="<?php
echo parse_url_tag("u:index|uc_account#phone|"."".""); 
?>">
                    <div class="sub-uc-v-item ">
                        <i class="left-icon iconfont font-pink">&#xe700;</i>

                        <div class="flex-box flex-1 split-line">
                            <span>修改手机</span>
                            <i class="right-jt iconfont">&#xe6fa;</i>
                        </div>
                    </div>
                    </a>
                </li>
                <li class="uc-v-item">
                    <a href="<?php
echo parse_url_tag("u:index|uc_address|"."".""); 
?>">
                    <div class="sub-uc-v-item">
                        <i class="left-icon iconfont font-light-green">&#xe6cd;</i>

                        <div class="flex-box flex-1">
                            <span>配送地址</span>
                            <i class="right-jt iconfont">&#xe6fa;</i>
                        </div>
                    </div>
                    </a>
                </li>

            </ul>
        </div>
        <div class="blank8"></div>
        <div class="blank8"></div>
        <div class="buy ">
            <a href="<?php
echo parse_url_tag("u:index|user#loginout|"."".""); 
?>" class="plank" style="color:#fff;">退出当前账号</a>
        </div>
   </div>
</div>

<?php if ($this->_var['ajax_refresh'] == 0): ?>
<?php echo $this->fetch('inc/no_footer.html'); ?>
<?php endif; ?>
