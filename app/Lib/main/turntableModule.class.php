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

        $actity['type'] = $this->type[$actity['type']];
        $actity['expenditure'] = round($actity['expenditure']);
        array_walk($prize,function(&$val){
            $val['type_source'] = $this->type[$val['type']];
            $val['name'] = empty($val['name'])?'谢谢惠顾!':$val['name'];
        });

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
            $GLOBALS['db']->getRow("update ".DB_PREFIX."user set `{$type}` = `{$type}`-{$actity['expenditure']} WHERE `id` = {$user_info['id']}");
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

        $prize =  $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity_prize where id = '".$prizeid."'");
        if($prize['count'] < 1){
            $this->Json([],500,'奖品库存不足!');
        }

        //用户添加奖品,非实物类型
        if(in_array($prize['type'],array_keys($this->source))){
            $type = $this->source[$prize['type']];
            $money = (int)$prize['name'];
            $GLOBALS['db']->getRow("update ".DB_PREFIX."user set `{$type}` = `{$type}`+{$money} WHERE `id` = {$user_info['id']}");
        }
        //奖品的商品数量-1
        $GLOBALS['db']->getRow("update ".DB_PREFIX."turntable_actity_prize set `{count}` = `{count}`-1 WHERE `id` = {$prizeid}");

        $save_data = ['actityid'=>$prize['actityid'],'prizeyid'=>$prize['id'],'userid'=>$user_info['id'],'name'=>$prize['name']];
        $GLOBALS['db']->autoExecute(DB_PREFIX."turntable_win",$save_data,'INSERT','','SILENT');
//        $insert_id = $GLOBALS['db']->insert_id();

        $this->Json([],200,'恭喜中奖!');

    }
}
//echo '<pre>';var_dump();exit;

