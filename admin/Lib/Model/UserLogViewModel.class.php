<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/6/7
 * Time: 19:27
 */
import('ViewModel');
class UserLogViewModel extends ViewModel {
    protected $viewFields = array(
        'UserLog' =>array('id','log_time','log_info','user_id','money','jewel','score','_type'=>'left'),
        'User' => ['user_name','_on'=>'UserLog.user_id=User.id']
    );
}
