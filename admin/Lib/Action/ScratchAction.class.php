<?php
/**
 * Created by PhpStorm.
 * User: liuyu
 * Date: 2019/4/21
 * Time: 12:07
 */

class ScratchAction extends  CommonEnhanceAction{

    //显示刮刮乐列表
    public function index(){

        $model = D ('Scratch');
        $map = $this->_search ($model);
        $map['status'] = 1;
        if(!empty($_REQUEST['id'])){
            $map['id'] = intval($_REQUEST['id']);
        }

        if(!empty($_REQUEST['name'])){
            $map['name'] = array('like','%'.$_REQUEST['name'].'%');
        }

        if(!empty($_REQUEST['money'])){
            $map['money'] = intval($_REQUEST['money']);
        }

        if(!empty($_REQUEST['s_type'])){
            $map['type'] = $_REQUEST['s_type'];
        }

        $this->_list($model,$map,'id');

        $this->display();
    }


    //刮刮乐新增页面
    public function add(){

        $this->display();
    }


    public function get_deal_option(){
        $name = strim($_REQUEST['deal_key']);
        $deal_model = M('Deal');
        $map[ 'name'] = array('like','%'.$name.'%');
        $map[ 'is_effect'] = 1;
        $deal_result = $deal_model->where($map)->select();
        $option = '<option value="0">==请选取商品==</option>';
        foreach ($deal_result as $key=>$val){
            $option .= '<option price="'.$val['current_price'].'" value="'.$val['id'].'">'.$val['name'].'</option>';
        }

        $this->ajaxReturn($option);


    }



    //添加刮刮乐活动
    public function insert(){

        $id = isset($_REQUEST['scratch_unique'])?intval($_REQUEST['scratch_unique']):0;
        $name = isset($_REQUEST['total_buy_name'])?$_REQUEST['total_buy_name']:'';
        $total_buy_price = isset($_REQUEST['total_need_price'])?$_REQUEST['total_need_price']:0;
        $s_type = isset($_REQUEST['s_type'])?intval($_REQUEST['s_type']):1;

        if(empty($name)){
            $this->error('请填写活动名称');
        }
        if(empty($total_buy_price)){
            $this->error('请填写消费金额');
        }

        if(!preg_match('/^\d+$/',$total_buy_price)){
            $this->error('消费金额不正确');
        }

        $is_effect = intval($_REQUEST['is_scratch_effect']);
        $data = array();
        $data['name'] = $name;
        $data['money'] = $total_buy_price;
        empty($id) && $data['create_time'] = time();
        $data['is_effect'] = $is_effect;
        $data['type'] = $s_type;

        $model = D($this->getActionName());

        if(empty($id)){ //添加
            $id = $model->data($data)->add();
        }else{

            $id = $model->where(array('id'=>$id))->save($data);
            $id!==false && $id=1;
        }

        if($id){
            $this->assign('jumpUrl',U('Scratch/index'));
            $this->success('添加成功');
        }else{
            $this->error('添加失败');
        }

    }


    //编辑页面
    public function edit(){

        $id = intval($_REQUEST['id']);
        if(empty($id)){
            $this->error('参数错误');
        }

        $data = M('scratch')->field('id,name,money,type,is_effect')->where(array('id'=>$id))->find();
        if(empty($data)){
            $this->error('记录不存在');
        }

        $this->assign('data',$data);
        $this->display();
    }


    public function foreverdelete() {
        //彻底删除指定记录
        $ajax = intval($_REQUEST['ajax']);
        $ids = $_REQUEST ['id'];

        $scratch_model = M('scratch');
        $cond = array('id'=>array('in',explode(',',$ids)));
        $rst = $scratch_model->where($cond)->find();
        if(empty($rst)){
            $this->error('记录不存在');
        }

        $result = $scratch_model->where($cond)->save(array('status'=>0));
        if($result){
            $this->success('删除成功',$ajax);
        }else{
            $this->success('删除失败',$ajax);
        }

    }



    //刮刮乐活动详情页
    public function detail(){

       $scratch_id= isset($_REQUEST['scratch_id'])?intval($_REQUEST['scratch_id']):0;
       if(empty($scratch_id)){
           $this->error('参数错误');
       }

        $scratch = M('scratch')->where(array('id'=>$scratch_id,'status'=>1))->find();
        if(empty($scratch)){
            $this->error('活动不存在');
        }

        $model = D ('Scratchprize');
        $map = $this->_search ($model);


        if(!empty($_REQUEST['id'])){
            $map['id'] = intval($_REQUEST['id']);
        }
        if(!empty($_REQUEST['prize'])){
            $map['prize'] = $_REQUEST['prize'];
        }
        if(!empty($_REQUEST['s_type'])){
            $map['prize_type'] = intval($_REQUEST['s_type']);
        }
        if(!empty($_REQUEST['prize_deal'])){
            $map ['concat(",",prize_deal,",")']  = array('exp','regexp "[^0-9]+'.intval($_REQUEST['prize_deal']).'[^0-9]+"');
        }

       $this->_list($model,$map,'id');

       $this->assign('scratch_id',$scratch_id);
       $this->assign('scratch',$scratch);
       $this->display();

    }


    //刮刮乐活动详情页奖品设置 新增页面
    public function detailAdd(){

        $scratch_id = isset($_REQUEST['scratch_id'])?intval($_REQUEST['scratch_id']):0;
        if(empty($scratch_id)){
            $this->error('参数错误');
        }

        $scratch = M('scratch')->where(array('id'=>$scratch_id,'status'=>1))->find();
        if(empty($scratch)){
            $this->error('活动不存在');
        }

        $this->assign('scratch_id',$scratch_id);
        $this->assign('scratch',$scratch);
        $this->display();
    }

    //刮刮乐活动详情页奖品设置 新增页面
    public function detailEdit(){

        $id = isset($_REQUEST['id'])?intval($_REQUEST['id']):0;
        if(empty($id)){
            $this->error('参数错误');
        }

        $scratch = M('scratchprize')->where(array('id'=>$id))->find();
        if(empty($scratch)){
            $this->error('活动设置不存在');
        }
        $this->assign('scratch_id',$scratch['scratch_id']);
        $this->assign('scratch_prize',$scratch);
        $this->display('detailAdd');
    }


    //刮刮乐活动详情页奖品设置 新增 编辑
    public function detailInsert(){

        $id = isset($_REQUEST['id'])?intval($_REQUEST['id']):0;
        $scratch_id = isset($_REQUEST['scratch_id'])?intval($_REQUEST['scratch_id']):0;
        $s_type = isset($_REQUEST['s_type'])?intval($_REQUEST['s_type']):1;
        $deal_key = isset($_REQUEST['deal_key'])?trim($_REQUEST['deal_key']):'';
        //$deal_id = isset($_REQUEST['deal_id'])?intval($_REQUEST['deal_id']):0;
        $prize = isset($_REQUEST['prize'])?trim($_REQUEST['prize']):'';
        $prize_num = isset($_REQUEST['prize_num'])?intval($_REQUEST['prize_num']):1;
        $last_num = isset($_REQUEST['last_num'])?intval($_REQUEST['last_num']):0;
        $rate = isset($_REQUEST['rate'])?trim($_REQUEST['rate']):'';
        $aim_profit = isset($_REQUEST['aim_profit'])?intval($_REQUEST['aim_profit']):0;
        $book_ids = isset($_REQUEST['book_ids'])?trim($_REQUEST['book_ids']):1;

        if(empty($scratch_id) || empty($deal_key) || empty($prize) || empty($rate)){
            $this->error('参数错误');
        }


        if($s_type!=1){
            if(!preg_match('/^\d+$/',$deal_key)){
                $this->error('填写的必须是整数');
            }
        }
        $cond = array('prize'=>$prize);
        !empty($id) && $cond['id'] = array('NEQ',$id);
        $one = M('scratchprize')->where($cond)->find();

        if(!empty($one)){
            $this->error('该奖项已经存在');
        }

        $data = array(
            'rate'=>$rate,
            'aim_profit'=>$aim_profit,
            'prize'=>$prize,
            'prize_num'=>$prize_num,
            'last_num'=>$last_num,
            'book_ids'=>$book_ids,
            'prize_type'=>$s_type,
            'prize_deal'=>$deal_key
        );

        $model = D('scratchprize');

        if(empty($id)){ //添加

            $data['scratch_id'] = $scratch_id;
            $data['create_time'] = time();
            $id = $model->data($data)->add();

        }else{
            $id = $model->where(array('id'=>$id))->save($data);
            $id!==false && $id=1;
        }

        if($id){
            $this->assign('jumpUrl',U('Scratch/detail',array('scratch_id'=>$scratch_id)));
            $this->success('添加成功');
        }else{
            $this->error('添加失败');
        }



    }



    public function detailDel() {
        //彻底删除指定记录
        $ajax = intval($_REQUEST['ajax']);
        $ids = $_REQUEST ['id'];

        $scratch_model = M('scratchprize');
        $cond = array('id'=>array('in',explode(',',$ids)));
        $rst = $scratch_model->where($cond)->find();
        if(empty($rst)){
            $this->error('记录不存在');
        }

        $result = $scratch_model->where($cond)->delete();
        if($result){
            $this->success('删除成功',$ajax);
        }else{
            $this->success('删除失败',$ajax);
        }

    }



}