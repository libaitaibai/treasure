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
            $map['name'] = $_REQUEST['name'];
        }

        if(!empty($_REQUEST['money'])){
            $map['money'] = intval($_REQUEST['money']);
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

        $model = D($this->getActionName());

        if(empty($id)){ //添加
            $id = $model->data($data)->add();
        }else{
            $id = $model->where(array('id'=>$id))->save($data);
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

        $data = M('scratch')->field('id,name,money,is_effect')->where(array('id'=>$id))->find();
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





}