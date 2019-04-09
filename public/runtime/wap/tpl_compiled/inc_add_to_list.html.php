<script>
$(document).ready(function () {
	var is_set_app = '<?php echo $this->_var['is_app']; ?>';
	if(is_set_app == '1'){
		var cin 		= $("input[name='choose_item_number']");
		var acin 		= $("input[name='app_choose_item_number']");
		var org_num 	= $("input[name='org_num']");
	 	var dstop 		= parseInt( $(document).scrollTop() ); 
	 	var docHset   	= parseInt( $(window).height() * 0.15 ); 
	 	
	 	$(document).scroll(function() {
	 		 dstop 		= $(document).scrollTop();
	 		$('.app-num-box').css('top', docHset+dstop+'px');
	 	});
	 	
		cin.click(function(){
			
			// 先隐藏预选包尾
			$(".add-to-list").removeClass('add-to-list-up');
			
			org_num.val( cin.val() );
			acin.val( cin.val() );
			$('.app-num-box').css('display', 'block');
			$('.app-num-box').css('top', docHset+dstop+'px');
			acin.focus();
			
			// 禁止触摸
			$("body").bind("touchmove",function(event){
				event.preventDefault();
			});
			
		});
		
		$('.num-comfirm').click(function(){
			$('.app-num-box').css('display', 'none');
			cin.val( acin.val() );
			get_last_num( cin );
			
			$(".add-to-list").addClass('add-to-list-up');
			
			 
		});
		
		$('.num-cancel').click(function(){
			// 恢复原先数据
			if(org_num.val() != ''){
				cin.val( org_num.val() );
			}
			get_last_num( cin );
			$('.app-num-box').css('display', 'none');
			
			
			$(".add-to-list").addClass('add-to-list-up');
			
		 
		});
		
		// + -
		$('.app-cart-num').bind("click", function () {
			var can_buy;
			// 原先的数值
			var org_number =  acin.val();
			var data_id = $("#duobao_item_id_set").val();
	         
			var number_item;
	        var data			= new Object;
			data.max_buy 		= cin.attr('max-buy');
			data.min_buy 		= cin.attr('min-buy');
			data.current_buy 	= cin.attr('cur-buy');
	    	
	    	can_buy 	= parseFloat(data.max_buy) - parseFloat(data.current_buy);
	    	
	    	if( $(this).hasClass('minus') ){
	    		number_item = parseFloat(org_number) - parseFloat(data.min_buy);
	    	}else{
	    		number_item = parseFloat(org_number) + parseFloat(data.min_buy);
	    	}
	    	
	    	
	    	if(number_item > can_buy){
	    		number_item = can_buy;
	    	}
	    	
	    	if(number_item <= 1){
	    		number_item = 1;
	    	}
 
	    	acin.val( number_item );
	    	
	    	acin.css("font-size", '0.9rem');
	        setTimeout(function(){
	        	acin.css("font-size", '0.5rem');
	        }, 200 );
	     
		});
		 
	}
});
</script>
<?php if ($this->_var['is_app'] == 1): ?>
<div class="num-box app-num-box">
	<div class="info">
		<div class="pay-select">
			<p class="tit">修改数量</p>
		  	<div class="select">
		  		<a href="javascript:;" class="iconfont split-line-right minus app-cart-num">&#xe6d3;</a>
		  		<input max-buy="" min-buy="" cur-buy=""  name="app_choose_item_number" class="buy_number set-buy-num" type="tel" value="<?php echo $this->_var['item']['number']; ?>" data-id="<?php echo $this->_var['item']['id']; ?>" />
		  		<a href="javascript:;" class="iconfont split-line-left plus app-cart-num">&#xe6d1;</a>
		  		<div id="duobao_item_id_set" data-id="" style="display:none"></div>
		  	</div>
		  	<div class="num-btn-box flex-box">
		  		<input type="hidden" name="org_num" value="" />
		  		<a href="javascript:;" class="num-btn flex-1 num-comfirm">确定</a>
		  		<a href="javascript:;" class="num-btn flex-1 num-cancel">取消</a>
		  	</div>
		</div>
	</div>
</div>
<?php endif; ?>
<div class="add-to-list">
	<div class="info">
		<header class="title split-line">
			请选择参与人次
			<a class="iconfont btn-close">&#xe64f;</a>
			<div class="imgbox"><a href=""><img data="<?php
echo parse_url_tag("u:index|duobao#index|"."".""); 
?>" src=""></a></div>
		</header>
		<div class="pay-select">
		  	<div class="select">
		  		<a href="javascript:;" class="iconfont split-line-right minus index-subtract-cart-num">&#xe6d3;</a>
		  		<input max-buy="" min-buy="" cur-buy=""  name="choose_item_number" class="buy_number set-buy-num" type="tel" value="<?php echo $this->_var['item']['number']; ?>" data-id="<?php echo $this->_var['item']['id']; ?>" />
		  		<a href="javascript:;" class="iconfont split-line-left plus index-add-cart-num">&#xe6d1;</a>
		  		<div id="duobao_item_id_set" data-id="" style="display:none"></div>
		  	</div>
		  	<div class="btn-box">
		  		<a class="price-btn">5</a>
		  		<a class="price-btn">20</a>
		  		<a class="price-btn">50</a>
		  		<a class="price-btn">我包了</a>
		  	</div>
		  	
		  	<?php if ($this->_var['data']['type'] == 'free' || $this->_var['item_data']['is_coupons'] == 1): ?>
		  	<h1 class="money-info">共<span>10</span>优惠币</h1>
		  	<div class="comfirm-btn-wrap">
		  		<a class="comfirm-btn index-comfirm-addto_cart">免费云购</a>
		  	</div>
		  	<?php else: ?>
		  	<h1 class="money-info">共<span>10</span>夺宝币</h1>
		  	<div class="comfirm-btn-wrap">
		  		<a class="comfirm-btn index-comfirm-addto_cart">立即夺宝</a>
		  		<a class="comfirm-btn comfirm-addto-list" onclick="add_cart(this);">加入清单</a>
		  	</div>
		  	<?php endif; ?>
		</div>
	</div>
</div>
<div class="add-bg"></div>