<?php
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/public.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/fanweUI.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/style.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/color.css";
$this->_var['pagecss'][] = $this->_var['TMPL_REAL']."/css/user_login.css";

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
$this->_var['pagejs'][] = $this->_var['TMPL_REAL']."/js/user_change_name.js";
$this->_var['cpagejs'][] = $this->_var['TMPL_REAL']."/js/user_change_name.js";


?>
<?php echo $this->fetch('inc/header_title_home.html'); ?>

<div class="wrap">

    <div class="content">
        <script type="text/javascript">
            var user_change_name_url='<?php
echo parse_url_tag("u:index|user#user_change_name_do|"."".""); 
?>'
            var user_center_index_url='<?php
echo parse_url_tag("u:index|uc_setting|"."".""); 
?>'
        </script>
        <form action="" id="ph_password_box">
        <section class="login-normal con-1">
            <ul class="input-list split-line-top split-line">

                <li>
                    <i class="iconfont">&#xe6f1;</i>
                    <div class="input-box split-line">
                        <label class="com-input">
                            <input  class="testing third" type="text" name="user_name" id="user_name"  placeholder="请输入昵称">
                        </label>
                    </div>
                </li>
            </ul>
            <div class="login-btn-box">
                <input id="chang_user_name" type="button" value="修改昵称" class="login-btn login-btn-red">
            </div>

        </section>
        </form>


    </div>
</div>
<?php echo $this->fetch('inc/footer_index.html'); ?>
