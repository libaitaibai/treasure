<?php
/**
 * Created by PhpStorm.
 * User: liuyu
 * Date: 2019/6/8
 * Time: 17:26
 */


import('ViewModel');
class InvestDetailModel extends ViewModel {
    protected $viewFields = array(
        /*        'TurntableWin' =>array('id','actityid','prizeyid','userid','name','_type'=>'left'),
                'TurntableActity' => array('name'=>'actityName','expenditure','_on'=>'TurntableActity.id=TurntableWin.actityid', '_type'=>'left'),
                'TurntableActityPrize' => array('name'=>'prizeName','type'=>'prizeType','_on'=>'TurntableActityPrize.id=TurntableWin.prizeyid', '_type'=>'left'),
                'User' => ['user_name','_on'=>'TurntableWin.userid=User.id']*/
        'invest_detail'=>array('id','way_id','fee_account','user_name','user_account','up_time','create_time','is_receive','is_chong','auditing','remark','_type'=>'left'),
        'invest_way'=>array('account','account_name','type','_on'=>'invest_way.id=invest_detail.way_id')

    );

}
