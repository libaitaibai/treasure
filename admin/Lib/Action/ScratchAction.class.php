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
        //奖项具体设置
        $details = M('scratchprizelist')->where(array('scratch_id'=>$scratch['scratch_id'],'prize_id'=>$scratch['id']))->select();

        $this->assign('scratch_id',$scratch['scratch_id']);
        $this->assign('scratch_prize',$scratch);
        $this->assign('details',$details);
        $this->display('detailAdd');
    }


    //刮刮乐活动详情页奖品设置 新增 编辑
    public function detailInsert(){


        $id = isset($_REQUEST['id'])?intval($_REQUEST['id']):0;
        $scratch_id = isset($_REQUEST['scratch_id'])?intval($_REQUEST['scratch_id']):0;
        $s_type = isset($_REQUEST['s_type'])?$_REQUEST['s_type']:array();
        $deal_key = isset($_REQUEST['deal_key'])?$_REQUEST['deal_key']:array();
        $prize = isset($_REQUEST['prize'])?trim($_REQUEST['prize']):'';
        $prize_num = isset($_REQUEST['prize_num'])?intval($_REQUEST['prize_num']):1;
        $last_num = isset($_REQUEST['last_num'])?intval($_REQUEST['last_num']):0;
        $rate = isset($_REQUEST['rate'])?trim($_REQUEST['rate']):'';
        $aim_profit = isset($_REQUEST['aim_profit'])?intval($_REQUEST['aim_profit']):0;
        $book_ids = isset($_REQUEST['book_ids'])?trim($_REQUEST['book_ids']):1;

        if(empty($scratch_id) || empty($deal_key) || empty($prize) || empty($rate)){
            $this->error('参数错误');
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
            'last_num'=>(empty($id)?$prize_num:$last_num),
            'book_ids'=>$book_ids,
        );

        $details = array();
        if(!empty($deal_key)){
            foreach($deal_key as $k=>$v){
                 if(!empty($v)){
                     $details[] = array('prize_deal'=>$v,'prize_type'=>$s_type[$k]);
                 }
            }
        }

        $model = D('scratchprize');

        if(empty($id)){ //添加

            $data['scratch_id'] = $scratch_id;
            $data['create_time'] = time();
            $id = $model->data($data)->add();
            $prize_id = $id;
        }else{
            $prize_id = $id;
            $id = $model->where(array('id'=>$id))->save($data);
            $id!==false && $id=1;
        }

        if($id){

            //奖项记录详情scratchprizelist
            M('scratchprizelist')->where(array('prize_id'=>$prize_id,'scratch_id'=>$scratch_id))->delete();
            $data = array();
            $data['prize_id'] = $prize_id;
            $data['create_time'] = time();
            $data['scratch_id'] = $scratch_id;
            foreach($details as $k=>$v){
                $data['prize_type'] = $v['prize_type'];
                $data['prize_deal'] = $v['prize_deal'];
                M('scratchprizelist')->add($data);
            }

            $this->assign('jumpUrl',U('Scratch/detail',array('scratch_id'=>$scratch_id)));
            $this->success('添加成功');
        }else{
            $this->error('添加失败');
        }


    }


    //奖项详情页
    public function detailDetail(){

        $prize_id = isset($_REQUEST['id'])?intval($_REQUEST['id']):0;
        $scratch_id = isset($_REQUEST['scratch_id'])?intval($_REQUEST['scratch_id']):0;
        if(empty($prize_id) || empty($scratch_id)){
            $this->error('参数错误');
        }
        //查询指定中奖人
        $prize = M('scratchprize')->where(array('id'=>$prize_id))->find();
        $users = '';
        if(!empty($prize['book_ids'])){

             $users_tmp = M('user')->where(array('id'=>array('in',$prize['book_ids'])))->select();
             foreach($users_tmp as $v){
                 $users .= $v['user_name'].',';
             }

        }
        $users = rtrim($users,',');
        //奖项具体设置
        $details = M('scratchprizelist')->where(array('prize_id'=>$prize_id,'scratch_id'=>$scratch_id))->select();

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
            $deals = M('deal')->where(array('id'=>array('in',$deal_ids)))->select();
            foreach($deals as $deal){
                if(isset($deal_id[$deal['id']])){
                    array_push($statistics,$deal['name'].'  ×'.$deal_id[$deal['id']]);
                }
            }

        }
        $jinbi!=0 && array_push($statistics,$jinbi.'金币  ×1');
        $zuanshi!=0 && array_push($statistics,$zuanshi.'钻石  ×1');

        $this->assign('scratch_id',$scratch_id);
        $this->assign('prize_id',$prize_id);
        $this->assign('prize',$prize);
        $this->assign('users',$users);
        $this->assign('statistics',$statistics);
        $this->display('detailDetail');
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


    //中奖列表
    public function active(){

        //编号 活动名称 消费类型 消费金额 奖项名称 奖品 中奖人 是否为指定中奖人

        $model = D ('ScratchWin');
        $map = $this->_search ($model);

        if(!empty($_REQUEST['id'])){
            $map['scratchstatistics.id'] = intval($_REQUEST['id']);
        }

        if(!empty($_REQUEST['name'])){
            $map['scratch.name'] = array('like','%'.$_REQUEST['name'].'%');
        }

        if(!empty($_REQUEST['prize'])){
            $map['scratchprize.prize'] = intval($_REQUEST['prize']);
        }

        if(!empty($_REQUEST['s_type'])){
            $map['scratch.type'] = intval($_REQUEST['s_type']);
        }
        $rst = $this->getlist($model,$map,'scratchstatics.id');


        $list = !empty($rst)?$rst['list']:array();
        $prize_ids = [];
        foreach($list as $k=>$v){
            !isset($prize_ids[$v['prize_id']]) && $prize_ids[$v['prize_id']] = $v['prize_id'];
        }

        $list_tmp = array();
        if(!empty($prize_ids)){
             $prizelist = M('scratchprizelist')->where(array('prize_id'=>array('in',$prize_ids)))->select();
             foreach($prizelist as $k=>$v){
                 if(!isset($list_tmp[$v['prize_id']])){
                     $list_tmp[$v['prize_id']] = [];
                 }
                 array_push($list_tmp[$v['prize_id']],$v);
             }
        }
         foreach($list_tmp as $k=>$v){
              $list_tmp[$k]['show'] = implode(', ',$this->statistics($v));
         }

        foreach($list as $k=>$v){
             $list[$k]['is_book'] = !empty($v['book_ids'])?'是':'否';
             $list[$k]['deals'] = isset($list_tmp[$v['prize_id']])?$list_tmp[$v['prize_id']]['show']:'';
        }


        $this->assign ( 'list', $list);
        $this->assign ( 'sort', $rst['sort'] );
        $this->assign ( 'order', $rst['order'] );
        $this->assign ( 'sortImg', $rst['sortImg'] );
        $this->assign ( 'sortType', $rst['sortType'] );
        $this->assign ( "page", $rst['page']);
        $this->assign ( "nowPage",$rst['nowPage']);
        $this->display('statistics');
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


    protected function getlist($model, $map, $sortBy = '', $asc = false) {
        //排序字段 默认为主键名
        if (isset ( $_REQUEST ['_order'] )) {
            $order = $_REQUEST ['_order'];
        } else {
            $order = ! empty ( $sortBy ) ? $sortBy : $this->getActionName().'.'.$model->getPk ();
        }
        //排序方式默认按照倒序排列
        //接受 sost参数 0 表示倒序 非0都 表示正序
        if (isset ( $_REQUEST ['_sort'] )) {
            $sort = $_REQUEST ['_sort'] ? 'asc' : 'desc';
        } else {
            $sort = $asc ? 'asc' : 'desc';
        }
        //取得满足条件的记录数
        $count = $model->where ( $map )->count ();
        // echo($model->getLastSql());
        if ($count > 0 ) {
            //创建分页对象
            if (! empty ( $_REQUEST ['listRows'] )) {
                $listRows = $_REQUEST ['listRows'];
            } else {
                $listRows = '30';
            }
            $p = new Page ( $count, $listRows );
            //分页查询数据

            $voList = $model->where($map)->order( $order . " " . $sort)->limit($p->firstRow . ',' . $p->listRows)->findAll ();


            //echo($model->getLastSql());exit;
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

            //print_r($voList);exit;
            return array(
                'list'=>$voList,
                'sort'=>$sort,
                'order'=>$order,
                'sortImg'=>$sortImg,
                'sortType'=>$sortAlt,
                'page'=>$page,
                'nowPage'=>$p->nowPage
                );
        }
        return array();
    }


}