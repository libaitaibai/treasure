<?php
class TurntableAction extends CommonAction
{
    public function index()
    {
        //列表过滤器，生成查询Map对象
        $model = D ('TurntableActity');

        $map = $this->_search ($model);

        if($_REQUEST['name']){
            $map['name'] = $_REQUEST['name'];
        }
        if($_REQUEST['id']){
            $map['id'] = $_REQUEST['id'];
        }
        if($_REQUEST['expenditure']){
            $map['expenditure'] = $_REQUEST['expenditure'];
        }
        if($_REQUEST['type']){
            $map['type'] = $_REQUEST['type'];
        }

        $this->_list ( $model, $map );

        $this->display ();
    }

    public function edit(){
        $id     = intval($_REQUEST['id']);
        $model = D ('TurntableActity');
        $result = $model->where('id='.$id )->find();

        $this->assign('result', $result);
        $this->display();
    }

    public function update(){

        $id = $_REQUEST['id'];
        if(!($_REQUEST['id'])){
            $this->error('主键不能为空!');
        }
        if(!($_REQUEST['name'])){
            $this->error('名称不能为空!');
        }
        if(!($_REQUEST['expenditure'])){
            $this->error('花费不能为空');
        }

        $model = D ('TurntableActity');

        $data = [
            'name'=>$_REQUEST['name'],
            'expenditure'=>(int)($_REQUEST['expenditure']),
            'type'=>$_REQUEST['type'],
            'status'=>$_REQUEST['status']
        ];
        $model->where(['id'=> $id])->data($data)->save();

        $this->success('修改成功');

    }

    public  function  add(){
        // 获取分类
        $cate_model  = M('TurntableActity');
        $cate_result = $cate_model->select();
        $this->assign('cate_result', $cate_result);
        $this->display();
    }

    public function insert(){
        if(!($_REQUEST['name'])){
            $this->error('名称不能为空!');
        }
        if(!($_REQUEST['expenditure'])){
            $this->error('花费不能为空');
        }

        $model = D ('TurntableActity');

        $data = [
            'name'=>$_REQUEST['name'],
            'expenditure'=>(int)($_REQUEST['expenditure']),
            'type'=>$_REQUEST['type'],
            'status'=>$_REQUEST['status']
        ];
        $id = $model->data($data)->add();
        if ($id) {
            $this->success('添加成功');
        }else{
            $this->error('添加失败');
        }

    }

    public function foreverdelete() {
        //彻底删除指定记录
        $ajax = intval($_REQUEST['ajax']);
        $id = $_REQUEST ['id'];

        if ( $id ) {
            $condition = array ('id' => array ('in', explode ( ',', $id ) ) );
            $list = M('TurntableActity')->where ( $condition )->delete();
            if ($list!==false) {
                $this->success (l("FOREVER_DELETE_SUCCESS"),$ajax);
            } else {
                $this->error (l("FOREVER_DELETE_FAILED"),$ajax);
            }
        } else {
            $this->error (l("INVALID_OPERATION"),$ajax);
        }
    }

//--------------------分割线-------------------------------

    /**
     * 奖品详情
     */
    public function show()
    {

    }


    //echo '<pre>';var_dump($config_file);exit;


}