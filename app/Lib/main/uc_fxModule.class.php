<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------


require APP_ROOT_PATH.'app/Lib/page.php';
class uc_fxModule extends MainBaseModule
{
	public function index()
	{
		require APP_ROOT_PATH."system/model/uc_center_service.php";
		global_run();
		init_app_page();
		assign_uc_nav_list();//左侧导航菜单
		

		//初始化参数
		$user_id = intval($GLOBALS['user_info']['id']);
		
		
		if(check_save_login()!=LOGIN_STATUS_LOGINED)
		{
			app_redirect(url("index","user#login"));
		}	
		 
		$user_data['id'] = $user_id;
		// 我的分销用户
		$first_all_fx_user = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid = ".$user_data['id']);
		$root['first_user_count'] = $GLOBALS['db']->getOne("select count(id) from ".DB_PREFIX."user where pid = ".$user_data['id']);
			
		// 我的二级分销用户
		foreach ($first_all_fx_user as $key=>$value){
		    $first_uid[] = $value['id'];
		    if ($key <= 3) {
		        $value['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
		        $root['first_fx_user'][$key] = $value;
		    }
		}
		$first_uid = join(',', $first_uid);
		$second_all_fx_user = '';
		$root['second_user_count'] = 0;
		if ($first_uid) {
		    $second_all_fx_user = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid in ({$first_uid})");
		    $root['second_user_count'] = $GLOBALS['db']->getOne("select count(id) from ".DB_PREFIX."user where pid in ({$first_uid})");
		}
		
			
		// 我的三级分销用户
		foreach ($second_all_fx_user as $key=>$value){
		    $second_uid[] = $value['id'];
		    if ($key <= 3) {
		        $value['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
		        $root['second_fx_user'][$key] = $value;
		    }
		}
		$second_uid = join(',', $second_uid);
		$three_fx_user = '';
		$root['three_user_count'] = 0;
		if ($second_uid) {
		    $three_fx_user = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid in ({$second_uid})"." limit 4");
		    foreach ($three_fx_user as $key=>$value){
		        $value['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
		        $root['three_fx_user'][$key] = $value;
		    }
		    $root['three_user_count'] = $GLOBALS['db']->getOne("select count(id) from ".DB_PREFIX."user where pid in ({$second_uid})");
		}
		
		 
		// 获取佣金分成多少
		$fx_salary = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."fx_salary");
		// 定额0， 比率1
		$fx_salary_type = $fx_salary[0]['fx_salary_type'];
		
		$now_time = to_date(NOW_TIME, 'Y-m-d');
		$start_time = strtotime($now_time);
		$end_time   = $start_time + 24*60*60;
			
		// 今日三级分销金额信息
		$today_three_info = $GLOBALS['db']->getRow("select sum(r.money) total_money,  sum(r.order_money) total_order_money, count(*) t_count from ".DB_PREFIX.
		    "user u left join ".DB_PREFIX."fx_user_reward r on u.id=r.user_id where r.fx_salary_type={$fx_salary_type} and r.pid = ".$user_data['id']." and r.fx_level=1 and (r.create_time > {$start_time} and r.create_time < {$end_time}) " );
			
			
		// 今日我的二级金额信息
		if ($first_uid) {
		    $today_second_info = $GLOBALS['db']->getRow("select sum(r.money) total_money,  sum(r.order_money)  total_order_money, count(*) t_count from ".DB_PREFIX.
		        "user u left join ".DB_PREFIX."fx_user_reward r on u.id=r.user_id where r.fx_salary_type={$fx_salary_type} and r.pid in ({$first_uid}) and r.fx_level=1 and (r.create_time > {$start_time} and r.create_time < {$end_time}) " );
		}
		
			
		// 今日我的一级金额信息
		if ($second_uid) {
		    $today_first_info = $GLOBALS['db']->getRow("select sum(r.money) total_money,  sum(r.order_money)  total_order_money, count(*) t_count from ".DB_PREFIX.
		        "user u left join ".DB_PREFIX."fx_user_reward r on u.id=r.user_id where r.fx_salary_type={$fx_salary_type} and r.pid in ({$second_uid}) and r.fx_level=1 and (r.create_time > {$start_time} and r.create_time < {$end_time}) " );
		}
		
		$root['fx_count']['three_fx_count'] = $today_three_info['t_count'];
		$root['fx_count']['second_fx_count'] = $today_second_info['t_count'];
		$root['fx_count']['first_fx_count'] = $today_first_info['t_count'];
		
		foreach ($fx_salary as $value){
		    // 定额0， 比率1
		    $root['fx_salary_type'] = $value['fx_salary_type'];
		
		    if($value['fx_level'] == 1){
		        if ( $root['fx_salary_type'] == 1) {
		            $root['fx_level_one_salary'] = round($value['fx_salary']*100, 2);
		            // 今日我的一级分销创收
		            $root['today_first_money'] = round($today_three_info['total_order_money'] * $value['fx_salary'], 2);
		             
		        }else{
		            $root['today_first_money'] = round($value['fx_salary'] * $today_three_info['t_count'], 2);
		             
		            $root['fx_level_one_salary'] = round($value['fx_salary'], 2);
		        }
		
		    }
		    if($value['fx_level'] == 2){
		        if ( $root['fx_salary_type'] == 1) {
		            $root['fx_level_two_salary'] = round($value['fx_salary']*100, 2);
		            // 今日我二级分销创收
		            $root['today_second_money'] = round($today_second_info['total_order_money'] * $value['fx_salary'], 2);
		        }else{
		            $root['today_second_money'] = round($value['fx_salary'] * $today_second_info['t_count'], 2);
		            $root['fx_level_two_salary'] = round($value['fx_salary'], 2);
		        }
		    }
		
		    if($value['fx_level'] == 3){
		        if ( $root['fx_salary_type'] == 1) {
		            $root['fx_level_three_salary'] = round($value['fx_salary']*100, 2);
		            // 今日我三级分销创收
		            $root['today_three_money'] = round($today_first_info['total_order_money'] * $value['fx_salary'], 2);
		        }else{
		            $root['today_three_money'] = round($value['fx_salary'] * $today_first_info['t_count'], 2);
		            $root['fx_level_three_salary'] = round($value['fx_salary'], 2);
		        }
		    }
		    	
		}
			
		// 邀请好友累积收入
		$root['total_brokerage_money'] = $GLOBALS['db']->getOne("select fx_total_balance from ".DB_PREFIX."user where id = ".$user_data['id']);
		$root['total_brokerage_money'] = round($root['total_brokerage_money'], 2);
		
		// 今日获得多宝币
		$root['today_total_brokerage_money'] = round($root['today_first_money'] + $root['today_second_money'] + $root['today_three_money'], 2);
			
			
		// 今日第一级分销交易金额
		$root['today_first_order_money'] = round($today_three_info['total_order_money'], 2);
			
		// 今日第二级分销交易金额
		$root['today_second_order_money'] = round($today_second_info['total_order_money'], 2);
			
		// 今日第三级分销交易金额
		$root['today_three_order_money'] = round($today_first_info['total_order_money'], 2);
			
		// 今日交易的总金额
		$root['today_total_money'] = round($today_first_info['total_order_money'] + $today_second_info['total_order_money'] + $today_three_info['total_order_money'], 2);
			
			
		$root['no_user_logo'] = SITE_DOMAIN.APP_ROOT."/public/avatar/noavatar_middle.gif";
	 
		
		$GLOBALS['tmpl']->assign("page_title","我的邀请");
		$GLOBALS['tmpl']->assign("data",$root);
		$GLOBALS['tmpl']->display("uc/uc_fx.html");
	}

    /**
     * 显示
     */
	public function show()
    {
        global_run();
        init_app_page();
        assign_uc_nav_list();//左侧导航菜单

        $action = $GLOBALS['_GET']['action'];
        $this->$action();

    }

    private function starttime($start_time,$new)
    {
        return $start_time-($new-1)*60*60*24;
    }

	public function user_list_one(){
	    require APP_ROOT_PATH."system/model/uc_center_service.php";
	    global_run();
	    init_app_page();
	    assign_uc_nav_list();//左侧导航菜单
        $new = $GLOBALS['_GET']['new']?:1;
	   
	    $user_id = intval($GLOBALS['user_info']['id']);
	    
	    if(check_save_login()!=LOGIN_STATUS_LOGINED)
	    {
	        app_redirect(url("index","user#login"));
	    }
	    
	    
	    $user_info = $GLOBALS['db']->getAll("select id, user_name, user_logo from ".DB_PREFIX."user where pid = ".$user_id);
	    $root['no_user_logo'] = SITE_DOMAIN.APP_ROOT."/public/avatar/noavatar_small.gif";
	    
	    foreach ($user_info as $key=>$value){
	        $fx_user_id[] = $value['id'];
	    }
	     
	    $now_time = to_date(NOW_TIME, 'Y-m-d');
	    $start_time = strtotime($now_time);
	    $end_time   = $start_time + 24*60*60;
        $start_time = $this->starttime($start_time,$new);

	    $fx_user_id = join(',', $fx_user_id);
	    
	    if ($fx_user_id) {
	        // 今天
	        $today_amount = $GLOBALS['db']->getAll("select id, cur_user_id uid, sum(money) today_money,  sum(order_money) order_number from ".DB_PREFIX."fx_user_reward where cur_user_id in({$fx_user_id}) "." and fx_level=1 and (create_time > {$start_time} and create_time < {$end_time}) group by cur_user_id ");
	        
	        // 总的
	        $amount   = $GLOBALS['db']->getAll("select u.id uid, sum(r.money) amount_money  from ".DB_PREFIX."fx_user_reward r left join ".DB_PREFIX."user u on u.id=r.cur_user_id where u.id in({$fx_user_id})  and r.fx_level=1 "." group by u.id ");
	         
	        // 用户信息
	        $user_list = $GLOBALS['db']->getAll("select id uid, user_name, user_logo from ".DB_PREFIX."user where id in({$fx_user_id})");
	        
	    }
	   
	     
	    foreach ($user_list as $key=>$value){
	        foreach ($today_amount as $k1=>$v1){
	            if ($value['uid'] == $v1['uid']) {
	                $user_list[$key]['today_money'] = round($v1['today_money'], 2);
	                $user_list[$key]['order_number'] = intval($v1['order_number']);
	            }
	        }
	         
	        foreach ($amount as $k2=>$v2){
	            if ($value['uid'] == $v2['uid']) {
	                $user_list[$key]['amount_money'] = round($v2['amount_money'], 2);
	            }
	        }
	         
	        $user_list[$key]['today_money']  = $user_list[$key]['today_money'] ? $user_list[$key]['today_money'] : 0;
	        $user_list[$key]['order_number'] = $user_list[$key]['order_number'] ? $user_list[$key]['order_number'] : 0;
	         
	        $user_list[$key]['amount_money'] = $user_list[$key]['amount_money'] ? $user_list[$key]['amount_money'] : 0;
	         
	        $user_list[$key]['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
	    }
	     
	    $root['amount_data'] = $user_list;

        $GLOBALS['tmpl']->assign("new", $new);
        $GLOBALS['tmpl']->assign("ACTION", 'user_list_one');
        $GLOBALS['tmpl']->assign("type", '一级');
	    $GLOBALS['tmpl']->assign("data", $root);
	    $GLOBALS['tmpl']->display("uc/user_list_one.html");
	}
	
	public function user_list_two(){
	    require APP_ROOT_PATH."system/model/uc_center_service.php";
	    global_run();
	    init_app_page();
	    assign_uc_nav_list();//左侧导航菜单
        $new = $GLOBALS['_GET']['new']?:1;
	    
	  
	    $user_id = intval($GLOBALS['user_info']['id']);
	     
	    if(check_save_login()!=LOGIN_STATUS_LOGINED)
	    {
	        app_redirect(url("index","user#login"));
	    }
	    
	    $root['no_user_logo'] = SITE_DOMAIN.APP_ROOT."/public/avatar/noavatar_small.gif";
	    
        // 我的佃户
        $first_user = $GLOBALS['db']->getAll("select id, user_name, user_logo from ".DB_PREFIX."user where pid = ".$user_id);
         
        // 我的佃户的佃户
        foreach ($first_user as $value){
            $first_uid[] = $value['id'];
        }
        $first_uid = join(',', $first_uid);
        
        $fx_user_id = '';
        if ($first_uid) {
            $user_info = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid in ({$first_uid})");
            foreach ($user_info as $key=>$value){
                $fx_user_id[] = $value['id'];
            }
            
            $fx_user_id = join(',', $fx_user_id);
        }
	    
	    $now_time = to_date(NOW_TIME, 'Y-m-d');
	    $start_time = strtotime($now_time);
	    $end_time   = $start_time + 24*60*60;
        $start_time = $this->starttime($start_time,$new);
	     
	   
	    if ($fx_user_id) {
	        // 今天
	        $today_amount = $GLOBALS['db']->getAll("select id, cur_user_id uid, sum(money) today_money,  sum(order_money) order_number from ".DB_PREFIX."fx_user_reward where cur_user_id in({$fx_user_id}) "." and fx_level=2 and (create_time > {$start_time} and create_time < {$end_time}) group by cur_user_id ");
	        
	        // 总的
	        $amount   = $GLOBALS['db']->getAll("select u.id uid, sum(r.money) amount_money from ".DB_PREFIX."fx_user_reward r left join ".DB_PREFIX."user u on u.id=r.cur_user_id where u.id in({$fx_user_id}) and r.fx_level=2 "." group by u.id ");
	        
	        // 用户信息
	        $user_list = $GLOBALS['db']->getAll("select id uid, user_name, user_logo from ".DB_PREFIX."user where id in({$fx_user_id})");
	    }
	  
	    
	    foreach ($user_list as $key=>$value){
	        foreach ($today_amount as $k1=>$v1){
	            if ($value['uid'] == $v1['uid']) {
	                $user_list[$key]['today_money'] = round($v1['today_money'], 2);
	                $user_list[$key]['order_number'] = intval($v1['order_number']);
	            }
	        }
	    
	        foreach ($amount as $k2=>$v2){
	            if ($value['uid'] == $v2['uid']) {
	                $user_list[$key]['amount_money'] = round($v2['amount_money'], 2);
	            }
	        }
	    
	        $user_list[$key]['today_money']  = $user_list[$key]['today_money'] ? $user_list[$key]['today_money'] : 0;
	        $user_list[$key]['order_number'] = $user_list[$key]['order_number'] ? $user_list[$key]['order_number'] : 0;
	    
	        $user_list[$key]['amount_money'] = $user_list[$key]['amount_money'] ? $user_list[$key]['amount_money'] : 0;
	    
	        $user_list[$key]['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
	    }
	    
	    $root['amount_data'] = $user_list;
        $GLOBALS['tmpl']->assign("new", $new);
        $GLOBALS['tmpl']->assign("ACTION", 'user_list_two');
        $GLOBALS['tmpl']->assign("type", '二级');
	    $GLOBALS['tmpl']->assign("data", $root);
	    $GLOBALS['tmpl']->display("uc/user_list_one.html");
	}
	
	public function user_list_three(){
	    require APP_ROOT_PATH."system/model/uc_center_service.php";
	    global_run();
	    init_app_page();
	    assign_uc_nav_list();//左侧导航菜单
        $new = $GLOBALS['_GET']['new']?:1;
	    
	    $user_id = intval($GLOBALS['user_info']['id']);
	    
	    if(check_save_login()!=LOGIN_STATUS_LOGINED)
	    {
	        app_redirect(url("index","user#login"));
	    }
	    
        // 我的佃户
        $first_user = $GLOBALS['db']->getAll("select id, user_name, user_logo from ".DB_PREFIX."user where pid = ".$user_id);
    
        // 我的佃户的佃户
        foreach ($first_user as $value){
            $first_uid[] = $value['id'];
        }
        $first_uid = join(',', $first_uid);
        
        $second_uid = '';
        if ($first_uid) {
            $second_user = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid in ({$first_uid})");
            // 我的佃户的佃户的佃户
            foreach ($second_user as $value){
                $second_uid[] = $value['id'];
            }
            
            $second_uid = join(',', $second_uid);
            
        }
        
        if ($second_uid) {
            $user_info = $GLOBALS['db']->getAll("select id, user_name, pid, user_logo from ".DB_PREFIX."user where pid in ({$second_uid})");
        }
       
    
	    $root['no_user_logo'] = SITE_DOMAIN.APP_ROOT."/public/avatar/noavatar_small.gif";
	    foreach ($user_info as $key=>$value){
	        $fx_user_id[] = $value['id'];
	    }
	     
	    $now_time = to_date(NOW_TIME, 'Y-m-d');
	    $start_time = strtotime($now_time);
	    $end_time   = $start_time + 24*60*60;
        $start_time = $this->starttime($start_time,$new);
	    $fx_user_id = join(',', $fx_user_id);
	     
	    if ($fx_user_id) {
	        // 今日
	        $today_amount = $GLOBALS['db']->getAll("select id, cur_user_id uid, sum(money) today_money, sum(order_money) order_number from ".DB_PREFIX."fx_user_reward where cur_user_id in({$fx_user_id}) "." and fx_level=3 and (create_time > {$start_time} and create_time < {$end_time}) group by cur_user_id ");
	        
	        // 总的
	        $amount   = $GLOBALS['db']->getAll("select u.id uid, sum(r.money) amount_money from ".DB_PREFIX."fx_user_reward r left join ".DB_PREFIX."user u on u.id=r.cur_user_id where u.id in({$fx_user_id}) and r.fx_level=3 "." group by u.id ");
	         
	        // 用户信息
	        $user_list = $GLOBALS['db']->getAll("select id uid, user_name, user_logo from ".DB_PREFIX."user where id in({$fx_user_id})");
	    }
	  
	     
	    foreach ($user_list as $key=>$value){
	        foreach ($today_amount as $k1=>$v1){
	            if ($value['uid'] == $v1['uid']) {
	                $user_list[$key]['today_money'] = round($v1['today_money'], 2);
	                $user_list[$key]['order_number'] = intval($v1['order_number']);
	            }
	        }
	         
	        foreach ($amount as $k2=>$v2){
	            if ($value['uid'] == $v2['uid']) {
	                $user_list[$key]['amount_money'] = round($v2['amount_money'], 2);
	            }
	        }
	         
	        $user_list[$key]['today_money']  = $user_list[$key]['today_money'] ? $user_list[$key]['today_money'] : 0;
	        $user_list[$key]['order_number'] = $user_list[$key]['order_number'] ? $user_list[$key]['order_number'] : 0;
	         
	        $user_list[$key]['amount_money'] = $user_list[$key]['amount_money'] ? $user_list[$key]['amount_money'] : 0;
	         
	        $user_list[$key]['user_logo'] = $value['user_logo']?get_abs_img_root($value['user_logo']):'';
	    }
	     
	    $root['amount_data'] = $user_list;
        $GLOBALS['tmpl']->assign("new", $new);
        $GLOBALS['tmpl']->assign("ACTION", 'user_list_three');
        $GLOBALS['tmpl']->assign("type", '三级');
	    $GLOBALS['tmpl']->assign("data", $root);
	    $GLOBALS['tmpl']->display("uc/user_list_one.html");
	}
	 
	

}
?>