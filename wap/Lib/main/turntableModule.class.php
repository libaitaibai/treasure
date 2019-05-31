<?php

class turntableModule extends MainBaseModule
{
    public  $type = [1=>'金币', 2=>'钻石' , 3=>'优惠券' , 4=>'实物'];
    public  $source = [1=>'money',2=>'jewel',3=>'coupons'];

    public function index()
    {
        global_run();
        init_app_page();

        $param['page']         = intval($_REQUEST['page']) ? intval($_REQUEST['page']) : 1;
        $param['data_id'] = intval($_REQUEST['data_id']);
        $param['keyword'] = strim($_REQUEST['keyword']);
        $data = call_api_core("turntable","index", $param);

        $page = new Page($data['page']['total'], $data['page']['page_size']); // 初始化分页对象
        $p = $page->show();


        /* 数据 */
        $GLOBALS['tmpl']->assign('pages', $p);
        $GLOBALS['tmpl']->assign("list", $data['list']);
        $GLOBALS['tmpl']->assign("data", $data);
        $GLOBALS['tmpl']->display("turntable.html");

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
//            echo '<pre>';var_dump($actity);exit;
            $this->Json([],500,"没有足够的{$this->type[$actity['type']]}");
        }else{
            //减去消费的钻石
            //减去消费的
            require_once APP_ROOT_PATH."system/model/user.php";
            modify_account([$this->source[$actity['type']]=>'-'.$actity['expenditure']],$user_info['id'],'大转盘游戏消耗');
//            $GLOBALS['db']->getRow("update ".DB_PREFIX."user set `{$type}` = `{$type}`-{$actity['expenditure']} WHERE `id` = {$user_info['id']}");
            $this->Json([],200,'成功!');
        }
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

