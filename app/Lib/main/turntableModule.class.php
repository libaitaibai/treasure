<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2014 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

// +----------------------------------------------------------------------

class turntableModule extends MainBaseModule
{
    public  $type = [1=>'金币', 2=>'钻石' , 3=>'优惠券' , 4=>'实物'];
    public  $source = [1=>'money',2=>'jewel',3=>'coupons'];
    public  $img = [1=>'jin.jpg',2=>'zhuang.jpg',3=>'youhui.jpg','6'=>'thinks.jpg'];

    public function index()
    {
        global_run();
        init_app_page();
        $web_article_id = intval($_REQUEST['id']);
        $is_agreement = strim($_REQUEST['t']);
        $shptel = app_conf("SHOP_TEL");

        $actityid = strim($_REQUEST['actityid'])?$_REQUEST['actityid']:1;

        $actitys = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity where   status = 1");

        if($actityid){
            $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where id = '".$actityid."' and status = 1");
            $prize = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity_prize where actityid = '".$actityid."' and status = 1");
        }else{
            //倒叙查找
            $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where status = 1 order by id desc limit 1");
            $prize = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity_prize where id = '".$actityid."' and status = 1");
        }

        //查看实物信息
        $physical = array_map(function($val){
            if($val['type']==4){
                return $val['name'];
            }
        },$prize);
        $physical = array_filter($physical);
        if(!empty($physical)){
            $physical=implode(',',$physical);
            $deal = $GLOBALS['db']->getAll("select id,name,icon from ".DB_PREFIX."deal where id in ({$physical})");
            $icon = array_column($deal,'icon','id');
            $deal = array_column($deal,'name','id');
        }

        $actity['type'] = $this->type[$actity['type']];
        $actity['expenditure'] = round($actity['expenditure']);
        $img = $this->img;
        array_walk($prize,function(&$val) use ($deal,$img,$icon){
            $val['type_source'] = $this->type[$val['type']];
            $val['img'] = isset($img[$val['type']])&&(!empty($val['name'])) ? $img[$val['type']] : $img[6];
            isset($img[$val['type']])||(empty($val['name']))?'':$val['showimg'] = $icon[$val['name']];
            isset($deal[$val['name']]) ? $val['name'] = $deal[$val['name']]:'';
            $val['name'] = empty($val['name'])?'谢谢惠顾!':$val['type_source'].$val['name'];
            $val['abbrename'] = mb_substr($val['name'],0,6);
        });

        //选中中奖数据
        $goodluck = $this->price($prize);

        $GLOBALS['tmpl']->assign("goodluck",$goodluck);
        $GLOBALS['tmpl']->assign("actityid",$actityid);
        $GLOBALS['tmpl']->assign("actitys",$actitys);
        $GLOBALS['tmpl']->assign("prize",$prize);
        $GLOBALS['tmpl']->assign("prize_json",json_encode($prize));
        $GLOBALS['tmpl']->assign("actity",$actity);
        $GLOBALS['tmpl']->assign("actity_json",json_encode($actity));
        $GLOBALS['tmpl']->assign("is_agreement",$is_agreement);
        $GLOBALS['tmpl']->assign("web_article_id",$web_article_id);
        $GLOBALS['tmpl']->assign("shptel",$shptel);
        $GLOBALS['tmpl']->display("turntable.html");
    }

    /**
     * 轮盘赌
     */
    public function price ($prize)
    {
        $array = array_column($prize,'probability');

        $total = array_sum($array);
        $rand = rand(0,$total*100)/100;

        $return = 0;
        foreach ($array as $key => $val){
            $rand-=$val;
            if($rand <= 0 ){
                $return = $key;
                break ;
            }
        }
        return $return;
    }

    /**
     * 查看数量是否够用
     * ?ctl=turntable&act=check
     *         echo '/index.php?ctl=payment&act=check&class_name=Alipay';
     */
    public function check()
    {
        global_run();
        $actityid = strim($_REQUEST['actityid']);
        $user_info = $GLOBALS['user_info'];

        if(empty($user_info)){
            $this->Json([],500,'请先登录!');
        }
        if(empty($actityid) ){
            $this->Json([],500,'数据传输不全');
        }

        $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where id = '".$actityid."' and status = 1");
        $type = $this->source[$actity['type']];
        $field = 'id,user_name,'.$type;
        $use =  $GLOBALS['db']->getRow("select {$field} from ".DB_PREFIX."user where id = '".$user_info['id']."'");

        if($use[$type]<$actity['expenditure']){
            $this->Json([],500,"没有足够的{$this->type[$actity['type']]}");
        }else{
            //减去消费的钻石
            //减去消费的
            require_once APP_ROOT_PATH."system/model/user.php";
            modify_account([$this->source[$actity['type']]=>'-'.$actity['expenditure']],$user_info['id'],'大转盘游戏消耗');
            $this->rewirte($actityid);
//            $GLOBALS['db']->getRow("update ".DB_PREFIX."user set `{$type}` = `{$type}`-{$actity['expenditure']} WHERE `id` = {$user_info['id']}");
            $this->Json([],200,'成功!');
        }
    }

    /**
     * 重新修改库存信息
     */
    public function rewirte($actityid)
    {
        $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where id = '".$actityid."' and status = 1");
        $repertory = $actity['repertory'];

        if(empty((int)$repertory)){
            $actity1 = $GLOBALS['db']->getRow("select SUM(predict_repertory) as total from ".DB_PREFIX."turntable_actity_prize where actityid = '".$actityid."' and status = 1");
            $GLOBALS['db']->getRow("update ".DB_PREFIX."turntable_actity set `repertory` = -{$actity['total']} WHERE `id` = {$actityid}");
            $repertory = -$actity1['total'];
        }

        $save = $actity['expenditure'];
        $final  = $repertory+$save*(1-0.17);
        $GLOBALS['db']->getRow("update ".DB_PREFIX."turntable_actity set `repertory` = {$final} WHERE `id` = {$actityid}");
    }

    /**
     * 保存中奖结果
     */
    public function save()
    {
        $prizeid = strim($_REQUEST['prizeid']);
        global_run();
        $user_info = $GLOBALS['user_info'];

        if(empty($user_info)){
            $this->Json([],500,'请先登录!');
        }
        if(empty($prizeid) ){
            $this->Json([],500,'数据传输不全');
        }

        //奖品信息
        $prize =  $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity_prize where id = '".$prizeid."'");

        //活动信息
        $actity =  $GLOBALS['db']->getRow("select expenditure,type  from ".DB_PREFIX."turntable_actity where id = '".$prize['actityid']."'");

        if($actity['type'] == 1){  //分销返利
            $order_info = array(
                'user_id'=>$user_info['id'],
                'refund_amount'=>0,
                'pay_amount'=>$actity['expenditure'],
                'order_sn'=>''
            );
            require_once APP_ROOT_PATH."system/model/fx.php";
            send_fx_order_salary($order_info);
        }

        if($prize['name'] == 0){
            $this->Json([],200,'谢谢惠顾!');
        }

        //已经中奖的信息
        $win =  $GLOBALS['db']->getRow("select count(*) as num,actityid from ".DB_PREFIX."turntable_win where prizeyid = '".$prizeid."'");

        if($prize['count'] <= $win['num']){
            $this->Json([],500,'奖品库存不足!');
        }

        //用户添加奖品,非实物类型
        if(in_array($prize['type'],array_keys($this->source))){
            $type = $this->source[$prize['type']];
            $money = (int)$prize['name'];
            require_once APP_ROOT_PATH."system/model/user.php";
            modify_account([$type=>$money],$user_info['id'],'大转盘游戏中奖!');
//            $GLOBALS['db']->getRow("update ".DB_PREFIX."user set `{$type}` = `{$type}`+{$money} WHERE `id` = {$user_info['id']}");
        }
        //实物添加到订单
        if($prize['type'] == 4){
            require_once APP_ROOT_PATH . "system/model/deal_order.php";
            createPaidOrder([$prize['name']=>1],$user_info['id']);
        }

        //奖品的商品数量-1
        //$GLOBALS['db']->getRow("update ".DB_PREFIX."turntable_actity_prize set `{count}` = `{count}`-1 WHERE `id` = {$prizeid}");

        $save_data = ['actityid'=>$prize['actityid'],'prizeyid'=>$prize['id'],'userid'=>$user_info['id'],'name'=>$prize['name']];
        $GLOBALS['db']->autoExecute(DB_PREFIX."turntable_win",$save_data,'INSERT','','SILENT');
//        $insert_id = $GLOBALS['db']->insert_id();

        $this->Json([],200,'恭喜中奖!');

    }
}
//echo '<pre>';var_dump();exit;

