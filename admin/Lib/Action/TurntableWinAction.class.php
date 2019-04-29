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

//        $_REQUEST ['_order'] = 'TurntableWin.id';


        if($_REQUEST['name']){
            $map['name'] = $_REQUEST['name'];
        }

        $this->_list ( $model, $map );
//        $model = $model->findAll();
        echo '<pre>';var_dump($model);exit;
        $this->display ();
    }
}

