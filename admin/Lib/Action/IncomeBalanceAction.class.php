<?php
// +----------------------------------------------------------------------
// | Fanwe 方维商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class IncomeBalanceAction extends CommonAction{
	public function index()
	{

	    $map['begin_time'] = to_timespan($_REQUEST['begin_time']);
	    $map['end_time'] = $_REQUEST['end_time']?$_REQUEST['end_time']:NOW_TIME;
	    $map['end_time'] = to_timespan($map['end_time']);
	    
	    $map['id'] = intval($_REQUEST['id']);
	    $contend='';
	    if($map['id'])
	        $contend = " and t_di.id=".$map['id'];
	    
	    if($map['begin_time'])
	       $contend = " and lottery_time >".$map['begin_time']." and lottery_time<".$map['end_time'];

	        
	    $page = intval($_REQUEST['p'])?intval($_REQUEST['p']):1;
	    $page_size = 50; 
	    $limit = (($page - 1)*$page_size).",".($page_size);
	    //取得满足条件的记录数
		$count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."duobao_item t_di where has_lottery = 1 ".$contend);
// echo "select count(*) from ".DB_PREFIX."duobao_item where has_lottery = 1 ".$contend;exit;

		if ($count > 0) {
			$p = new Page ( $count, $page_size );
			//分页查询数据
            $robot_ids = $GLOBALS['db']->getOne("select group_concat(id) from ".DB_PREFIX."user where is_robot=1");
            
            $sql = "select t_di.id,t_di.name,t_di.max_buy,t_d.origin_price,
                robot_buy_count as robot_count,
                t_di.luck_user_name as user_name,
                t_di.lottery_time
                from 
                fanwe_duobao_item t_di 
                left join fanwe_deal t_d on t_d.id=t_di.deal_id
                where t_di.has_lottery = 1 ".$contend." order by t_di.lottery_time desc ,t_di.id desc limit ".$limit;

            $voList = $GLOBALS['db']->getAll($sql);
			//分页跳转的时候保证查询条件
			foreach ( $map as $key => $val ) {
				if (! is_array ( $val )) {
					$p->parameter .= "$key=" . urlencode ( $val ) . "&";
				}
			}
			//分页显示

			$page = $p->show ();
			//列表排序显示
			$sortImg = $sort; //排序图标
			$sortAlt = $sort == 'desc' ? l("ASC_SORT") : l("DESC_SORT"); //排序提示
			$sort = $sort == 'desc' ? 1 : 0; //排序方式
			//模板赋值显示
			$this->assign ( 'list', $voList );
			$this->assign ( "page", $page);
			$this->assign ( "nowPage",$p->nowPage);
		}
		$this->display();
	}
	
	public function export_csv($page = 1)
	{
		set_time_limit(0);
// 		$limit = (($page - 1)*intval(app_conf("BATCH_PAGE_SIZE"))).",".(intval(app_conf("BATCH_PAGE_SIZE")));
		$map['begin_time'] = to_timespan($_REQUEST['begin_time']);
		$map['end_time'] = $_REQUEST['end_time']?$_REQUEST['end_time']:NOW_TIME;
		$map['end_time'] = to_timespan($map['end_time']);
		$map['id'] = intval($_REQUEST['id']);
		
		$contend='';
		if($map['id'])
		    $contend = " and t_di.id=".$map['id'];
		
		if($map['begin_time'])
		    $contend = " and lottery_time >".$map['begin_time']." and lottery_time<".$map['end_time'];
		
		$page = intval($_REQUEST['p'])?intval($_REQUEST['p']):$page;
		$page_size = 50;
		$limit = (($page - 1)*$page_size).",".($page_size);
		
		
		$sql = "select t_di.id,t_di.name,t_di.max_buy,t_d.current_price,
                robot_buy_count as robot_count,
                t_di.luck_user_name as user_name,
                t_di.lottery_time
                from 
                fanwe_duobao_item t_di 
                left join fanwe_deal t_d on t_d.id=t_di.deal_id
                where t_di.has_lottery = 1 ".$contend." limit ".$limit;

		$list = $GLOBALS['db']->getAll($sql);
		
		if($list)
		{
			register_shutdown_function(array(&$this, 'export_csv'), $page+1);
			
			$ecv_value = array(
			    'id'=>'""', 
			    'name'=>'""',
			    'max_buy'=>'""', 
			    'current_price'=>'""', 
			    'robot_count'=>'""',
			    'user_name'=>'""',
			    'lottery_time'=>'""',
			);
	    	if($page == 1)
	    	{
		    	$content = iconv("utf-8","gbk","期号,商品名称,参与人次,成本价格,机器人数量,中奖人姓名,开奖时间");	    		    	
		    	$content = $content . "\n";
	    	}
	    	
			foreach($list as $k=>$v)
			{
				
				$ecv_value['id'] = '"' . iconv('utf-8','gbk',$v['id']) . '"';
				$ecv_value['name'] = '"' . iconv('utf-8','gbk',$v['name']) . '"';
				$ecv_value['max_buy'] = '"' . iconv('utf-8','gbk',$v['max_buy']) . '"';
				$ecv_value['current_price'] = '"' . iconv('utf-8','gbk',round($v['current_price'],2)."元") . '"';
				$ecv_value['robot_count'] = '"' . iconv('utf-8','gbk',$v['robot_count']) . '"';
				$ecv_value['user_name'] = '"' . iconv('utf-8','gbk',$v['user_name']) . '"';
				$ecv_value['lottery_time'] = '"' . iconv('utf-8','gbk',to_date($v['lottery_time'])) . '"';			
				
				$content .= implode(",", $ecv_value) . "\n";
			}	

			
			header("Content-Disposition: attachment; filename=voucher_list.csv");
	    	echo $content;  exit;
		}
		else
		{
			if($page==1)
			$this->error(L("NO_RESULT"));
		}	
		
	}


    public $turntable = [1=>'jinbi',2=>'zuanshi',3=>'yiuhujuan',4=>'shiwu'];

	public  function dazhuanpan()
    {
        $_REQUEST['begin_time'] ? $map['begin_time'] = to_timespan($_REQUEST['begin_time']):'';
        $_REQUEST['end_time'] ? $map['end_time'] = to_timespan($_REQUEST['end_time']) : '';

        $page = intval($_REQUEST['p'])?intval($_REQUEST['p']):1;
        $page_size = 50;
        $limit = (($page - 1)*$page_size).",".($page_size);

        $contend = '';$contend1='';
        if(!empty($map)){
            $contend = " where win.on_create >'".to_date($map['begin_time'])."' and win.on_create<'".to_date($map['end_time'])."'";
            $contend1 = "log_time > ".$map['begin_time'].' and log_time < '.$map['end_time'] .' and  ';
            unset($map['end_time']);unset($map['begin_time']);
        }
        //大转盘中奖信息
        $sqlturn = "select win.`prizeyid`,win.`userid`,prize.type,prize.repertory,prize.name,user.user_name
        from fanwe_turntable_win as win 
        left join fanwe_turntable_actity_prize as prize on prize.id = win.prizeyid 
        left join fanwe_user as user on user.id = win.userid ";
        $sqlturn .=$contend;
        $sqlturn .=" order by win.id DESC limit ".$limit;
        $voListTurn = $GLOBALS['db']->getAll($sqlturn);

        $contend1.= ' log_info like "%大转盘游戏消耗%"';
        $UserLog = M("UserLog")->where($contend1)->order("id desc")->findAll();

        $return = [];$real=[];$username = [];
        foreach ($voListTurn as $key=>$val){
            if($val['type'] ==4){
                $temp = M('Deal')->field('origin_price,current_price,name')->where(['id'=>$val['name']])->find();
                $return[$val['userid']][$val['type']] += $temp['current_price'];
                $real[$val['userid']] .= $temp['name'].',';
            }else{
                $return[$val['userid']][$val['type']] += $val['name'];
            }
            $username[$val['userid']] = $val['user_name'];
        }

        $static = [];
        foreach ($UserLog as $val5 ){
            $static[$val5['log_user_id']]['money'] += $val5['money'];
            $static[$val5['log_user_id']]['jewel'] += $val5['jewel'];
            $static[$val5['log_user_id']]['coupons'] += $val5['coupons'];
        }

        $returnData = [];
        foreach ($return as $key1=>$val1){
            $returnData[$key1]['username'] = $username[$key1];
            $returnData[$key1]['have']  = $real[$key1];
            foreach ($this->turntable as $key2=>$val2){
                $returnData[$key1][$val2] = isset($val1[$key2]) ? $val1[$key2]: 0;
            }
            //消费的数据
            $returnData[$key1]['money'] =$static[$key1]['money'] ;
            $returnData[$key1]['jewel'] = $static[$key1]['jewel'] ;
            $returnData[$key1]['coupons'] = $static[$key1]['coupons'] ;
        }
        foreach ($returnData as $key9 => $val9){
            $returnData[$key9]['fenxiao'] = $val9['jinbi'] * 0.17;
        }


        $sqlturn = "select count(*) from fanwe_turntable_win as win ";
        $sqlturn .=$contend;
        $count = $GLOBALS['db']->getOne($sqlturn);
        $p = new Page ( $count, $page_size );
        foreach ( $map as $key => $val ) {
            if (! is_array ( $val )) {
                $p->parameter .= "$key=" . urlencode ( $val ) . "&";
            }
        }
        //分页显示
        $page = $p->show ();

        //模板赋值显示
        $this->assign ( 'list', $returnData );
        $this->assign ( "page", $page);
        $this->assign ( "nowPage",$p->nowPage);

        $this->display();
    }

    public function gauguale()
    {
        $_REQUEST['begin_time'] ? $map['begin_time'] = to_timespan($_REQUEST['begin_time']):'';
        $_REQUEST['end_time'] ? $map['end_time'] = to_timespan($_REQUEST['end_time']) : '';

        $page = intval($_REQUEST['p'])?intval($_REQUEST['p']):1;
        $page_size = 50;
        $limit = (($page - 1)*$page_size).",".($page_size);

        $contend = '';$contend1='';
        if(!empty($map)){
            $contend = " where statics.create_time >'".($map['begin_time'])."' and statics.create_time<'".($map['end_time'])."'";
            $contend1 = "log_time > ".$map['begin_time'].' and log_time < '.$map['end_time'] .' and  ';
            unset($map['end_time']);unset($map['begin_time']);
        }

        //消费信息
        $contend1.= ' log_info like "%刮刮乐消费%"';
        $UserLog = M("UserLog")->where($contend1)->order("id desc")->findAll();

        $static = [];
        foreach ($UserLog as $val5 ){
            $static[$val5['log_user_id']]['money'] += $val5['money'];
            $static[$val5['log_user_id']]['jewel'] += $val5['jewel'];
            $static[$val5['log_user_id']]['coupons'] += $val5['coupons'];
        }

        //中奖信息
        $sqlturn = "select statics.scratch_id,statics.prize_id,statics.user_id,user.user_name
        from fanwe_scratchstatics as statics 
        left join fanwe_scratchprize as prize on prize.id = statics.prize_id 
        left join fanwe_user as user on user.id = statics.user_id ";
        $sqlturn .=$contend;
        $sqlturn .=" order by statics.id DESC limit ".$limit;
        $voListTurn = $GLOBALS['db']->getAll($sqlturn);

        //具体奖项信息         1商品 2金币 3钻石
        $prize_ids = array_map(function($val){return $val['prize_id'];},$voListTurn);
        $prize_ids = array_unique($prize_ids);
        $details = M('scratchprizelist')->where(array ('prize_id' => array ('in', implode ( ',', $prize_ids ) ) ))->select();

        $price = [];
        foreach ($details as $key => $val){
            $price[$val['prize_id']][$val['prize_type']] = $val['prize_deal'];
        }

        $array = [1=>'shangpin', 2=>'jinbi', 3=>'zuanshi'];
        $reurn = [];
        foreach ($voListTurn as $key1 => $val){
            $reurn[$val['user_id']]['username'] = $val['user_name'];
            foreach ($price[$val['prize_id']] as $key2 => $val2){
                if($key2 == 1){
                    $temp = M('Deal')->field('origin_price,current_price,name')->where(['id'=>$val2])->find();
                    $reurn[$val['user_id']][$array[$key2]] += $temp['current_price'];
                    $reurn[$val['user_id']]['have'] .= $temp['name'].',';
                }else{
                    $reurn[$val['user_id']][$array[$key2]] += $val2;
                }
            }
        }

        array_walk($reurn, function(&$val,$key) use ($static){
            $val +=  $static[$key];
            $val['fenxiao'] = $val['jinbi']  * 0.17;
        });


        $sqlturn = "select count(*) from fanwe_scratchstatics as statics ";
        $sqlturn .=$contend;
        $count = $GLOBALS['db']->getOne($sqlturn);
        $p = new Page ( $count, $page_size );
        foreach ( $map as $key => $val ) {
            if (! is_array ( $val )) {
                $p->parameter .= "$key=" . urlencode ( $val ) . "&";
            }
        }
        //分页显示
        $page = $p->show ();

        //模板赋值显示
        $this->assign ( 'list', $reurn );
        $this->assign ( "page", $page);
        $this->assign ( "nowPage",$p->nowPage);


        $this->display();


    }

	public function duobao()
    {
        $map['begin_time'] = to_timespan($_REQUEST['begin_time']);
        $map['end_time'] = $_REQUEST['end_time']?$_REQUEST['end_time']:NOW_TIME;
        $map['end_time'] = to_timespan($map['end_time']);

        $map['id'] = intval($_REQUEST['id']);
        $contend='';
        if($map['id'])
            $contend = " and t_di.id=".$map['id'];

        if($map['begin_time'])
            $contend = " and lottery_time >".$map['begin_time']." and lottery_time<".$map['end_time'];


        $page = intval($_REQUEST['p'])?intval($_REQUEST['p']):1;
        $page_size = 50;
        $limit = (($page - 1)*$page_size).",".($page_size);
        //取得满足条件的记录数
        $count = $GLOBALS['db']->getOne("select count(*) from ".DB_PREFIX."duobao_item t_di where has_lottery = 1 ".$contend);
// echo "select count(*) from ".DB_PREFIX."duobao_item where has_lottery = 1 ".$contend;exit;

        if ($count > 0) {
            $p = new Page ( $count, $page_size );
            //分页查询数据
            $robot_ids = $GLOBALS['db']->getOne("select group_concat(id) from ".DB_PREFIX."user where is_robot=1");

            $sql = "select t_di.id,t_di.name,t_di.max_buy,t_d.origin_price,
                robot_buy_count as robot_count,
                t_di.luck_user_name as user_name,
                t_di.lottery_time
                from 
                fanwe_duobao_item t_di 
                left join fanwe_deal t_d on t_d.id=t_di.deal_id
                where t_di.has_lottery = 1 ".$contend." order by t_di.lottery_time desc ,t_di.id desc limit ".$limit;

            $voList = $GLOBALS['db']->getAll($sql);
            //分页跳转的时候保证查询条件
            foreach ( $map as $key => $val ) {
                if (! is_array ( $val )) {
                    $p->parameter .= "$key=" . urlencode ( $val ) . "&";
                }
            }
            //分页显示

            $page = $p->show ();
            //列表排序显示
            $sortImg = $sort; //排序图标
            $sortAlt = $sort == 'desc' ? l("ASC_SORT") : l("DESC_SORT"); //排序提示
            $sort = $sort == 'desc' ? 1 : 0; //排序方式
            //模板赋值显示
            $this->assign ( 'list', $voList );
            $this->assign ( "page", $page);
            $this->assign ( "nowPage",$p->nowPage);
        }
        $this->display();
    }
	
	
}
?>