<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/29 0029
 * Time: 上午 9:56
 */
import('ViewModel');
class TurntableWinViewModel extends ViewModel {
    protected $viewFields = array(
        'TurntableWin' =>array('id','actityid','prizeyid','userid','name','_type'=>'left'),
        'TurntableActity' => array('name'=>'actityName','expenditure','_on'=>'TurntableActity.id=TurntableWin.actityid', '_type'=>'left'),
        'TurntableActityPrize' => array('name'=>'prizeName','type'=>'prizeType','_on'=>'TurntableActityPrize.id=TurntableWin.prizeyid', '_type'=>'left'),
        'User' => ['user_name','_on'=>'TurntableWin.userid=User.id']
    );

}
