<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/6/7
 * Time: 19:15
 */
class StatisticsAction extends CommonAction
{
    public function duobao()
    {
        $search_user_name = trim($_REQUEST['user_name']);
        if(trim($_REQUEST['user_name'])){
            $result_data = $GLOBALS['db']->getAll("select id from ".DB_PREFIX."user where user_name like '%".$search_user_name."%'");
            foreach ($result_data as $v){
                $user_ids[] = $v['id'];
            }
        }

        //列表过滤器，生成查询Map对象
        $model = D ('DealOrderItem');
        $map = $this->_search ($model);

        if(strim($_REQUEST['order_sn']))
            $map['order_sn'] = strim($_REQUEST['order_sn']);
        if(strim($_REQUEST['duobao_item_id']))
            $map['duobao_item_id'] = strim($_REQUEST['duobao_item_id']);
        $map['type'] = 2;
        if($search_user_name)
            $map['user_id'] = array('in',implode(",", $user_ids));

        $user_id = intval($_REQUEST['user_id']);
        if($user_id){
            unset($map['user_id']);
            $map['user_id'] = $user_id;
        }
//        echo '<pre>';var_dump($map);exit;
        $this->_list( $model, $map ,"id");
        $this->display ();
    }

    public function scratch()
    {

        $model = D ('UserLogView');
        $map = $this->_search ($model);

        $map[ 'log_info'] = array('like','%刮刮乐消费%');

        $this->_list ( $model, $map );

        $this->display ();

    }

    public function turntable()
    {
        $model = D ('UserLogView');
        $map = $this->_search ($model);

        $map[ 'log_info'] = array('like','%大转盘游戏消耗%');

        $this->_list ( $model, $map );

        $this->display ();
    }


    public function foreverdelete_account_detail()
    {
        //彻底删除指定记录
        $ajax = intval($_REQUEST['ajax']);
        $id = $_REQUEST ['id'];
        if (isset ( $id )) {
            $condition = array ('id' => array ('in', explode ( ',', $id ) ) );
            $rel_data = M("UserLog")->where($condition)->findAll();
            foreach($rel_data as $data)
            {
                $info[] = $data['id'];
            }
            if($info) $info = implode(",",$info);
            $list = M("UserLog")->where ( $condition )->delete();

            if ($list!==false) {
                save_log($info.l("FOREVER_DELETE_SUCCESS"),1);
                $this->success (l("FOREVER_DELETE_SUCCESS"),$ajax);
            } else {
                save_log($info.l("FOREVER_DELETE_FAILED"),0);
                $this->error (l("FOREVER_DELETE_FAILED"),$ajax);
            }
        } else {
            $this->error (l("INVALID_OPERATION"),$ajax);
        }
    }
}