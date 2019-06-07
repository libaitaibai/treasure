<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/29 0029
 * Time: 下午 3:28
 */
class TurntableWinAction extends CommonEnhanceAction
{
    public function index()
    {
        $model = D ('TurntableWinView');
        $map = $this->_search ($model);

        $map['TurntableActityPrize.name'] = array('gt',0);

        if($_REQUEST['id']){
            $map['TurntableWin.id'] = $_REQUEST['id'];
        }
        if($_REQUEST['name']){
            $map['TurntableActity.name'] = ['like','%'.$_REQUEST['name']."%"];
        }
        if($_REQUEST['expenditure']){
            $map['TurntableActity.expenditure'] = $_REQUEST['expenditure'];
        }
        if($_REQUEST['type']){
            $map['TurntableActityPrize.type'] = $_REQUEST['type'];
        }
//        echo '<pre>';var_dump();exit;
        $this->_list ( $model, $map );

        $this->display ();
    }

    /**
     * 添加指定用户信息
     */
    public function add ()
    {
        $this->display ();
    }

    public function addData()
    {
        $model = D ('TurntableWin');

        $data = [
            'actityid'=>$_REQUEST['actityid'],
            'userid'=>$_REQUEST['userid'],
            'prizeyid'=>$_REQUEST['prizeyid'],
        ];
        $id = $model->data($data)->add();
        if ($id) {
            $this->success('添加成功');
        }else{
            $this->error('添加失败');
        }

    }
}

