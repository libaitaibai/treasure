<?php
/**
 * Created by PhpStorm.
 * User: liuyu
 * Date: 2019/5/29
 * Time: 22:29
 */

import('ViewModel');
class ScratchWinModel extends ViewModel {
    protected $viewFields = array(
/*        'TurntableWin' =>array('id','actityid','prizeyid','userid','name','_type'=>'left'),
        'TurntableActity' => array('name'=>'actityName','expenditure','_on'=>'TurntableActity.id=TurntableWin.actityid', '_type'=>'left'),
        'TurntableActityPrize' => array('name'=>'prizeName','type'=>'prizeType','_on'=>'TurntableActityPrize.id=TurntableWin.prizeyid', '_type'=>'left'),
        'User' => ['user_name','_on'=>'TurntableWin.userid=User.id']*/
        'scratchstatics'=>array('id','scratch_id','prize_id','user_id','create_time','_type'=>'left'),
        'scratch'=>array('name','money','type','_on'=>'scratch.id=scratchstatics.scratch_id','_type'=>'left'),
        'scratchprize'=>array('prize','book_ids','_on'=>'scratchprize.id=scratchstatics.prize_id','_type'=>'left'),
        'user'=>array('user_name','_on'=>'scratchstatics.user_id=user.id')

    );

}
