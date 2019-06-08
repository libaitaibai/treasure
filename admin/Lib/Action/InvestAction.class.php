<?php
/**
 * Created by PhpStorm.
 * User: liuyu
 * Date: 2019/4/21
 * Time: 12:07
 */

class InvestAction extends  CommonEnhanceAction{

    public function account(){
        $model = D('InvestWay');
        $map = $this->_search ($model);
        $map['status'] = 1;

        if(!empty($_REQUEST['name'])){
            $map['account'] = array('like','%'.$_REQUEST['name'].'%');
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

    public function insert(){

        $id = isset($_REQUEST['id'])?intval($_REQUEST['id']):0;
        $name = isset($_REQUEST['total_buy_name'])?$_REQUEST['total_buy_name']:'';
        $full_name = isset($_REQUEST['total_full_name'])?$_REQUEST['total_full_name']:'';
        $total_buy_price = isset($_REQUEST['total_need_price'])?$_REQUEST['total_need_price']:'';
        $s_type = isset($_REQUEST['s_type'])?intval($_REQUEST['s_type']):1;

        if(empty($name)){
            $this->error('请填写账号');
        }
        if($s_type==3 && empty($full_name)){
            $this->error('请填写开户行全称');
        }

        if(empty($total_buy_price)){
            $this->error('请填写真实姓名');
        }
        $way = '';

        if($s_type==2){
            $way = '支付宝';
        }else if($s_type==3){
            $way = $full_name;
        }

        $data = array();
        $data['account'] = $name;
        $data['account_name'] = $total_buy_price;
        $data['way'] = $way;
        empty($id) && $data['create_time'] = time();
        $data['status'] = 1;
        $data['type'] = $s_type;

        $model = D('InvestWay');

        if(empty($id)){ //添加
            $id = $model->data($data)->add();
        }else{

            $id = $model->where(array('id'=>$id))->save($data);
            $id!==false && $id=1;
        }

        if($id){
            $this->assign('jumpUrl',U('Invest/account'));
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

        $data = M('Invest_way')->where(array('id'=>$id))->find();

        if(empty($data)){
            $this->error('记录不存在');
        }

        $this->assign('data',$data);
        $this->display('add');
    }


    public function foreverdelete() {
        //彻底删除指定记录
        $ajax = intval($_REQUEST['ajax']);
        $ids = $_REQUEST ['id'];

        $scratch_model = M('Invest_way');
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



    //人工充值活动详情页
    public function detail(){


        $model = D('InvestDetail');
        $map = $this->_search ($model);
        $map['invest_detail.status'] = 1;

        if(!empty($_REQUEST['name'])){
            $map['invest_detail.user_name'] = array('like','%'.trim($_REQUEST['name']).'%');
        }

        if(!empty($_REQUEST['account'])){
            $map['invest_detail.user_account'] = trim($_REQUEST['account']);
        }


        if(!empty($_REQUEST['s_type'])){
            $map['invest_way.type'] = trim($_REQUEST['s_type']);
        }

        $this->_list($model,$map,'invest_detail.id');
        $this->display();

    }


    //人工充值编辑
    public function detailEdit(){

        $id = intval($_REQUEST['id']);
        $model = D('InvestDetail');
        $one = $model->where(array('invest_detail.id'=>$id))->find();
        if($one){

            if($one['type']==2){
                $one['way_type'] = '支付宝';
            }else if($one['type']==3){
                $one['way_type'] = '银行转账';
            }
        }

        $this->assign('data',$one);
        $this->display();
    }

    public function detailUpdate(){

        $check_aud = intval($_REQUEST['check_aud']);
        $remark = trim($_REQUEST['remark']);
        $id = intval($_REQUEST['id']);

       $one =  M('Invest_detail')->where(array('id'=>$id))->find();

       if(empty($one)){
           $this->error('记录不存在');
       }


       $data = array(
           'is_receive' =>1,
           'is_chong'=>1,
           'auditing'=>1,
           'remark'=>'',
           'up_time'=>time()
       );


       if($check_aud==0){
           $rst = M('Invest_detail')->where(array('id'=>$id))->save(array('remark'=>$remark,'up_time'=>time()));
       }else{

           $rst = M('Invest_detail')->where(array('id'=>$id))->save($data);

           //更新用户表
           $sql = 'update '.DB_PREFIX.'user set money=money+'.$one['fee_account'].' where id='.$one['user_id'];
           M('user')->execute($sql);
           //赠送优惠券
           $salary = M('Invest_salary')->where(array('is_open'=>1))->find();
           if($salary){
               $ss = round($salary['salary']*$one['fee_account'],2);
               if($salary['type']==1){
                  $u_str = 'money=money+'.$ss;
               }else if($salary['type']==2){
                   $u_str = 'jewel=jewel+'.$ss;
               }else{
                   $u_str = 'coupons=coupons+'.$ss;
               }

               $sql = 'update '.DB_PREFIX.'user set '.$u_str.' where id='.$one['user_id'];
               M('user')->execute($sql);
           }

       }

       if($rst!==false){
           $this->assign('jumpUrl',U('Invest/detail'));
           $this->success('更新成功');
       }
        $this->error('更新失败');
    }


    public function salary(){


        $one = M('invest_salary')->find();
        if(!empty($one)){
            $one['salary'] = $one['salary']*100;
        }
        $this->assign('data',$one);
        $this->display('salaryAdd');
    }


    public function salaryInsert(){

      $id = intval($_REQUEST['id']);
      $salary = trim($_REQUEST['salary']);
      $status = intval($_REQUEST['status']);
      $type = intval($_REQUEST['s_type']);

        $data = array('salary'=>round($salary/100,2),'status'=>$status,'type'=>$type);
      if(empty($id)){
         $s= M('invest_salary')->data($data)->add();
      }else{
         $s =  M('invest_salary')->where(array('id'=>$id))->save($data);
      }
       if($s){
           $this->assign('jumpUrl',U('Invest/salary'));
           $this->success('更新成功');
       }
        $this->error('更新失败');

    }



}