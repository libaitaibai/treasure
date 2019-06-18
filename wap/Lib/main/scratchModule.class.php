<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class scratchModule extends MainBaseModule
{
    private $type = ['1'=>'money','2'=>'jewel','3'=>'coupons'];
    private $tips = ['1'=>'金币','2'=>'钻石','3'=>'优惠券'];
    public function index()
    {
        global_run();
        init_app_page();
        $scratch_id = intval($_REQUEST['scratch_id']);

        $rows = $GLOBALS['db']->getAll('select id,name from '.DB_PREFIX.'scratch where is_effect=1 and status=1 order by id desc');
        if(empty($scratch_id)) {
            $scratch_id = $rows[0]['id'];
        }

        if(!$scratch_id){
            $scratch = array();
        }else {
            $one = $GLOBALS['db']->getRow('select * from ' . DB_PREFIX . 'scratch where id=' . $scratch_id);
            if($one){
                $one['tip'] = $one['money'].$this->tips[$one['type']];
                $scratch = $one;
            }else{
                $scratch = array();
            }
        }

        $prizes = array();
        $prizes_tmp = array();
        if(!empty($scratch_id)){

            $t_prize = DB_PREFIX.'scratchprize';
            $t_prized = DB_PREFIX.'scratchprizelist';

            $sql = 'select p.id,p.rate,p.prize_num,p.prize,pd.prize_type,pd.prize_deal from '.$t_prize.' p left join '.$t_prized.' pd on p.id=pd.prize_id and p.scratch_id=pd.scratch_id'
                .' where p.scratch_id='.$scratch_id.' order by p.rate asc';
            $res = $GLOBALS['db']->getAll($sql);


            foreach($res as $k=>$v){

                if(!isset($prizes[$v['id']])){
                    $prizes[$v['id']] = [];
                    $prizes_tmp[$v['id']] = array('prize'=>$v['prize'],'prize_num'=>$v['prize_num']);
                }

                array_push($prizes[$v['id']],$v);

            }

            $prizes_last = array();

            foreach($prizes as $k=>$v){
                $prizes_last[$prizes_tmp[$k]['prize'].' ('.$prizes_tmp[$k]['prize_num'].'个)'] = $this->statistics($v);
            }

            $prizes = $prizes_last;

        }
        empty($prizes) && $prizes = array();

        $GLOBALS['tmpl']->assign("scratch",$scratch);
        $GLOBALS['tmpl']->assign("scratch_id",$scratch_id);
        $GLOBALS['tmpl']->assign("scratch_tip",isset($scratch['tip'])?$scratch['tip']:'');
        $GLOBALS['tmpl']->assign("prizes",$prizes);
        $GLOBALS['tmpl']->assign("rows",$rows);
        $GLOBALS['tmpl']->assign("data",array('page_title'=>'刮刮乐'));
        $GLOBALS['tmpl']->display("scratch.html");
    }


    //统计
    private function statistics($details){

        $statistics = array();
        $jinbi = 0;
        $zuanshi = 0;
        $deal_ids = '';
        $deal_id = array();
        foreach($details as $k=>$detail){

            if($detail['prize_type']==2){
                $jinbi += $detail['prize_deal'];
            }else if($detail['prize_type']==3){
                $zuanshi += $detail['prize_deal'];
            }else{
                $deal_ids .= $detail['prize_deal'].',';
                if(!isset($deal_id[$detail['prize_deal']])){
                    $deal_id[$detail['prize_deal']] = 1;
                }else{
                    $deal_id[$detail['prize_deal']]++;
                }
            }
        }

        if(!empty($deal_ids)){
            $deal_ids = rtrim($deal_ids,',');
            $sql = 'select * from '.DB_PREFIX.'deal where id in('.$deal_ids.')';
            $deals = $GLOBALS['db']->getAll($sql);
            foreach($deals as $deal){
                if(isset($deal_id[$deal['id']])){
                    array_push($statistics,$deal['name'].'  ×'.$deal_id[$deal['id']]);
                }
            }

        }
        $jinbi!=0 && array_push($statistics,$jinbi.'金币  ×1');
        $zuanshi!=0 && array_push($statistics,$zuanshi.'钻石  ×1');

        return $statistics;

    }


    //获取中奖结果
    public function get_result(){

        global_run();
        init_app_page();

        $user_info = $GLOBALS['user_info'];
        if(empty($user_info)){
            $res = array('code'=>401,'msg'=>'请先登录','data'=>array());
            ajax_return($res);
        }

        $scratch_id = intval($_REQUEST['scratch_id']);
        if(empty($scratch_id)){
            $res = array('code'=>201,'msg'=>'参数错误，刷新页面重试','data'=>array());
            ajax_return($res);
        }

        $sql = 'select * from '.DB_PREFIX.'scratch where id ='.$scratch_id;
        $one = $GLOBALS['db']->getRow($sql);
        if(empty($one)){
            $res = array('code'=>204,'msg'=>'活动不存在，刷新页面重试','data'=>array());
            ajax_return($res);
        }

        $this->get_prize($user_info['id'],$scratch_id);

    }

    /*
     *
     *  指定玩家输赢优先于库存，库存优先于概率。
     *  库存定义：一个商品，（玩家游戏投入的金币）- （中商品的成本）-（代理提成）
     *
     *
     * */
    private function get_prize($user_id,$scratch_id){

        $t_scratchprize = DB_PREFIX.'scratchprize';
        $t_scratch = DB_PREFIX.'scratch';
        $t_statistics = DB_PREFIX.'scratchstatics';
        $t_user = DB_PREFIX.'user';
        $db = $GLOBALS['db'];

        try{
            $db->query('begin');

            $activity = $db->getRow('select * from '.$t_scratch.' where id='.$scratch_id.' for update');
            $type = $activity['type'];

            $user_info = $db->getRow('select * from '.$t_user.' where id='.$user_id.' for update');
            if($user_info[$this->type[$type]]<$activity['money']){

                $db->query('commit');
                $this->showRes(402,'没有足够的'.$this->tips[$type]);
            }
            //扣除参与活动费用
            $this->updateUserM($user_id,$activity);

            //记录代理提成
            if($activity['type']==1){
                $levels = $this->calculateAgent($user_id,$activity['money']);
                if(!empty($levels)){
                    $reward = array_sum($levels);
                    $GLOBALS['db']->query('update '.DB_PREFIX.'scratch set reward=reward+'.$reward.' where id='.$activity['id']);
                }

            }

            //统计代理提成
            $tmp = $GLOBALS['db']->getRow('select initial_stock,parti_score,reward from '.DB_PREFIX.'scratch where id='.$scratch_id);
            $reward = $tmp?$tmp['reward']:0;
            $parti_score = $tmp?$tmp['parti_score']:0;
            $initial_stock = $tmp?$tmp['initial_stock']:0;

            //统计商品成本
            $profit = $this->calculateProfit($scratch_id,array());

            //计算库存
            $sum = 0;
            foreach($profit as $p){
                $sum+=$p['sum'];
            }

            $now_stock = $parti_score-$sum-$reward;
            //$now_stock<0 && $now_stock=0;

            //更新当前库存
            $GLOBALS['db']->query('update '.DB_PREFIX.'scratch set stock='.$now_stock.' where id='.$scratch_id);

            $stock = $initial_stock+$now_stock;

            //指定玩家中奖 中奖之后相同奖项不能再中
            $sql1 = 'select * from '.$t_scratchprize.' where scratch_id='.$scratch_id.
                ' and last_num>0 and find_in_set('.$user_id.',book_ids) for update';

            //$sql2 = 'select * from '.$t_scratch.' where id = '.$scratch_id.' for update';
            //$two = $db->getRow($sql2);

            //统计参与人数 参与金额
            //$db->query('update '.$t_scratch.' set parti_num=parti_num+1,parti_score=parti_score+'.$two['money'].' where id='.$scratch_id);

            $ones = $db->getAll($sql1);
            $zhiding = array();
            $zhongjiang = array();
            if(!empty($ones)){

                $ones_tmp = array();
                foreach($ones as $v){
                    $zhiding[$v['id']] = $v['id'];
                    $ones_tmp[$v['id']] = $v;
                }

                //查询当前用户中奖纪录
                $tmp2 = $db->getAll('select prize_id from '.$t_statistics.
                    ' where scratch_id='.$scratch_id.' and user_id='.$user_id.' group by prize_id');
                foreach($tmp2 as $v){
                    $zhongjiang[] = $v['prize_id'];
                }

                $diff = array_diff($zhiding,$zhongjiang);
                $one = $ones_tmp[$diff[array_rand($diff)]];

                if(!empty($one)){
                    $db->query('update '.$t_scratchprize.' set last_num=last_num-1,nodraw_num=nodraw_num-1 where id='.$one['id']);
                    $db->query('insert into '.$t_statistics.'(scratch_id,prize_id,user_id,create_time) values('.$scratch_id.','.$one['id'].','.$user_id.','.time().')');
                    $this->updateMoney($user_id,$profit[$one['id']],$scratch_id);
                    $this->createPaidOrder($scratch_id,$one['id'],$user_id);
                    $db->query('commit');
                    $this->showRes(200,'已中奖',array('prize'=>$one['prize']));
                }

            }


            $sql = 'select * from '.$t_scratchprize.' where scratch_id='.$scratch_id.
                ' and last_num>0 for update';
            $prize = $db->getAll($sql);
            //小于所有预设库存不中奖
            if(empty($prize)){
                $db->query('commit');
                $this->showRes(200,'未中奖',array('prize'=>'谢谢参与'));
            }

            //获取大于预设库存的记录
            $probability = array();
            $prizes_tmp = array();
            foreach($prize as $k=>$v){
                $prizes_tmp[$v['id']] = $v;
                /*if(!isset($profit[$v['id']]) ||
                    (isset($profit[$v['id']]) && $v['aim_profit']<$profit[$v['id']['sum']])){
                    continue;
                }*/
                if(!isset($profit[$v['id']])){
                    continue;
                }

                if($v['aim_profit']>$stock){ //库存小于预设库存不让中奖
                    continue;
                }
                //指定中奖人中奖后不能再中该奖
                if(isset($zhiding[$v['id']])){
                    continue;
                }

                //指定中奖人保留中奖项
                if($v['last_num']<=$v['nodraw_num']){
                    continue;
                }
                $probability[$v['id']] = round($v['rate'],2);

            }
            $probability[0] = 1-array_sum($probability);
            asort($probability);

            $keys = array_keys($probability);
            $values = array_values($probability);
            $key_id = $this->wheel($values);

            if($key_id==-1){
                $db->query('commit');
                $this->showRes(200,'未中奖',array('prize'=>'谢谢参与'));
            }


            $prize_id = $keys[$key_id];

            if(empty($prize_id)){
                $db->query('commit');
                $this->showRes(200,'未中奖',array('prize'=>'谢谢参与'));
            }

            $db->query('update '.$t_scratchprize.' set last_num=last_num-1 where id='.$prize_id);
            $db->query('insert into '.$t_statistics.'(scratch_id,prize_id,user_id,create_time) values('.$scratch_id.','.$prize_id.','.$user_id.','.time().')');
            $this->updateMoney($user_id,$profit[$prize_id],$scratch_id);
            $this->createPaidOrder($scratch_id,$prize_id,$user_id);
            $db->query('commit');
            $this->showRes(200,'已中奖',array('prize'=>$prizes_tmp[$prize_id]['prize']));

        }catch(Exception $e){

            $db->query('rollback');
            $this->showRes(500,'请稍后重试');
        }

    }


    //中奖获得金币钻石增加到用户表
    private function updateMoney($user_id,$get_prize,$scratch_id=0){

        if(empty($get_prize) || !$user_id){
            return false;
        }
        $str = '';
        $moneys = array();
        if(isset($get_prize['coin']) && !empty($get_prize['coin'])){
            $log_msg = '刮刮乐中奖'.$get_prize['coin'].'金币';
            $moneys['money'] = $get_prize['coin'];
            $str .= 'money=money+'.$get_prize['coin'].',';
        }else if(isset($get_prize['jewel']) && !empty($get_prize['jewel'])){
            $log_msg = '刮刮乐中奖'.$get_prize['coin'].'钻石';
            $moneys['jewel'] = $get_prize['jewel'];
            $str .= 'jewel=jewel+'.$get_prize['coin'].',';
        }

        if($scratch_id){
            //记录扣除奖项后的库存
            $GLOBALS['db']->query('update '.DB_PREFIX.'scratch set stock=stock-'.$get_prize['sum'].' where id='.$scratch_id);
        }

        //增加资金流水
        $this->moneyLog($user_id,$moneys,$log_msg);

        $sql = 'update '.DB_PREFIX.'user set '.rtrim($str,',').' where id='.$user_id;
        $GLOBALS['db']->query($sql);


        return true;
    }

    //用户金币钻石扣除 增加代理提成
    private function updateUserM($user_id,$activity){

        $type = $activity['type'];
        $money = $activity['money'];

        //记录资金流日志
        $moneys = array($this->type[$type]=>-$money);

        $log_msg = '刮刮乐消费'.$money.$this->tips[$type];

        $this->moneyLog($user_id,$moneys,$log_msg);

        //金币 钻石 优惠券扣除
        $tmp_str = "{$this->type[$type]}={$this->type[$type]}-{$money}";
        $GLOBALS['db']->query('update '.DB_PREFIX.'user set '.$tmp_str.' where id='.$user_id);

        //记录活动收益
        $GLOBALS['db']->query('update '.DB_PREFIX.'scratch set parti_num=parti_num+1,parti_score=parti_score+'.$money.' where id='.$activity['id']);

    }


    private function moneyLog($user_id,$moneys=array(),$log_msg=''){

        $user_info = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."user where is_delete = 0 and is_effect = 1 and id = ".$user_id);

        $log_info = array();
        $log_info['log_info'] = $log_msg;
        $log_info['log_time'] = NOW_TIME;
        $log_info['log_user_id'] = intval($user_info['id']);


        $data = array(
            'money'=>0,
            'score'=>0,
            'point'=>0,
            'coupons'=>0,
            'jewel'=>0
        );

        $data = array_merge($data,$moneys);
        $log_info['money'] = floatval($data['money']);
        $log_info['score'] = intval($data['score']);
        $log_info['point'] = intval($data['point']);
        $log_info['coupons'] = intval($data['coupons']);
        $log_info['jewel'] = intval($data['jewel']);


        $log_info['current_money'] = floatval($log_info['money']+$user_info['money']);
        $log_info['current_score'] = intval($log_info['score']+$user_info['score']);
        $log_info['current_point'] = intval($log_info['point']+$user_info['point']);
        $log_info['current_coupons'] = intval($log_info['coupons']+$user_info['coupons']);
        $log_info['current_jewel'] = intval($log_info['jewel']+$user_info['jewel']);
        $log_info['user_id'] = $user_id;
        $GLOBALS['db']->autoExecute(DB_PREFIX."user_log",$log_info);

    }


    //计算代理提成
    private function calculateAgent($user_id,$money){

        //代理提成
        require_once APP_ROOT_PATH."system/model/fx.php";
        $order_info = array(
            'user_id'=>$user_id,
            'refund_amount'=>0,
            'pay_amount'=>$money,
            'order_sn'=>''
        );
        $levels = send_fx_order_salary($order_info,true);
        empty($levels) && $levels = array();

        return $levels;
    }



    //计算当前利润
    private function calculateProfit($scratch_id,$levels=array())
    {
        $activity = $GLOBALS['db']->getRow('select * from '.DB_PREFIX.'scratch where id='.$scratch_id.' for update');

        $sql = 'select p.*,pd.prize_type,pd.prize_deal from '.DB_PREFIX.'scratchprize p left join '.DB_PREFIX.'scratchprizelist pd 
        on p.scratch_id=pd.scratch_id and p.id=pd.prize_id where p.scratch_id='.$activity['id'];
        $prizes = $GLOBALS['db']->getAll($sql);

        if(empty($prizes)){
            return array();
        }

        /*        $deal_ids = '';
                $profit_other = 0;
                $profit_deal = 0;
                foreach($prizes as $k=>$prize){

                    if($prize['prize_type']==1){ //商品
                        $deal_ids .= $prize['prize_deal'].',';
                    }else{
                        $profit_other += $prize['prize_deal'];
                    }

                }

                //查询商品表
                $deals_tmp = array();
                $deal_ids = rtrim($deal_ids,',');

                if(!empty($deal_ids)){

                    $deals = $GLOBALS['db']->getAll('select * from '.DB_PREFIX.'deal where id in('.$deal_ids.')');
                    foreach($deals as $v){
                        $deals_tmp[$v['id']] = $v['origin_price'];
                    }
                }

                foreach($prizes as $k=>$prize){
                    if($prize['prize_type']==1){

                        isset($deals_tmp[$prize['prize_deal']]) && ($profit_deal +=$deals_tmp[$prize['prize_deal']] );
                        //$tmp = explode(',',$prize['prize_deal']);
                        //foreach($tmp as $kk=>$vv){
                          // isset($deals_tmp[$vv]) && ($profit_deal += $deals_tmp[$vv]*$prize['prize_num']);
                        //}
                    }
                }

                //所有奖品本身成本
                $profit = $profit_other + $profit_deal;
                if($activity['type']==1){ //金币去掉代理提成
                    $profit += $activity['reward'];
                }*/

        $deal_ids = '';
        $profit = array();

        foreach($prizes as $k=>$prize){

            if($prize['prize_type']==1){ //商品
                $deal_ids .= $prize['prize_deal'].',';
            }else if($prize['prize_type']==2){ //金币
                if(!isset($profit[$prize['id']]['coin'])){
                    $profit[$prize['id']]['coin'] = $prize['prize_deal'];
                }else{
                    $profit[$prize['id']]['coin'] += $prize['prize_deal'];
                }

            }else if($prize['prize_type']==3){ //钻石
                if(!isset($profit[$prize['id']]['jewel'])){
                    $profit[$prize['id']]['jewel'] = $prize['prize_deal'];
                }else{
                    $profit[$prize['id']]['jewel'] += $prize['prize_deal'];
                }
            }

        }

        //查询商品表
        $deals_tmp = array();
        $deal_ids = rtrim($deal_ids,',');

        if(!empty($deal_ids)){

            $deals = $GLOBALS['db']->getAll('select * from '.DB_PREFIX.'deal where id in('.$deal_ids.')');
            foreach($deals as $v){
                $deals_tmp[$v['id']] = $v['origin_price'];
            }
        }

        foreach($prizes as $k=>$prize){
            if($prize['prize_type']==1){

                if(!isset($profit[$prize['id']]['deal'])){
                    $profit[$prize['id']]['deal']=$deals_tmp[$prize['prize_deal']];
                }else{
                    $profit[$prize['id']]['deal']+=$deals_tmp[$prize['prize_deal']];
                }

            }
        }


        //金币去掉代理提成
        $agent = !empty($levels)?array_sum($levels):0;

        foreach($profit as $k=>&$t){

            $deal = isset($t['deal'])?$t['deal']:0;
            $coin = isset($t['coin'])?$t['coin']:0;
            $jewel = isset($t['jewel'])?$t['jewel']:0;
            $t['deal'] = $deal;
            $t['jewel'] = $jewel;
            $t['coin'] = $coin;
            $t['agent'] = $agent;
            $t['sum'] = $deal+$coin+$jewel+$agent;
        }

        return $profit;
    }


    //轮盘赌算法
    private function wheel($arr=array())
    {
        $key = -1;
        $rand = $this->randomFloat(0,1);
        for($i=0,$sum=0,$len=count($arr);$i<$len;$i++){
            $sum+=$arr[$i];
            if($sum>=$rand){
                $key = $i;
                break;
            }
        }

        return $key;
    }


    //生成0到1之间的小数
    private function randomFloat($min = 0, $max = 1)
    {
        return $min + mt_rand() / mt_getrandmax() * ($max - $min);
    }


    //显示数据
    private function showRes($code=000,$msg='',$data=array())
    {
        $res = array('code'=>$code,'msg'=>$msg,'data'=>$data);
        ajax_return($res);
    }



    public function test(){

        require_once APP_ROOT_PATH . "system/model/deal_order.php";

        createPaidOrder(['177'=>2],263);

    }

    //生成订单
    private function createPaidOrder($scratch_id,$prize_id,$user_id){

        $sql = 'select * from '.DB_PREFIX.'scratchprizelist where scratch_id='.$scratch_id.' and prize_id='.$prize_id;
        $all = $GLOBALS['db']->getAll($sql);

        $deals = array();
        foreach($all as $v){
            if($v['prize_type']!=1){
                continue;
            }

            if(!isset($deals[$v['prize_deal']])){
                $deals[$v['prize_deal']] = 1;
            }else{
                $deals[$v['prize_deal']]++;
            }
        }


        if(!empty($deals)){
            require_once APP_ROOT_PATH . "system/model/deal_order.php";
            createPaidOrder($deals,$user_id);
        }


    }



}