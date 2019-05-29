<?php
class turntableApiModule extends MainBaseApiModule{

    public  $type = [1=>'金币', 2=>'钻石' , 3=>'优惠券' , 4=>'实物'];

    /**
	 * 展示所有的大转盘的活动和奖品
	 */
    public function index(){
    	$root = array();
        $root['page_title']="大转盘";
        $actityid = strim($GLOBALS['_GET']['actityid'])?$GLOBALS['_GET']['actityid']:1;

        $actitys = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity where   status = 1");

        if($actityid){
            $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where id = '".$actityid."' and status = 1");
            $prize = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity_prize where actityid = '".$actityid."' and status = 1");
        }else{
            //倒叙查找
            $actity = $GLOBALS['db']->getRow("select * from ".DB_PREFIX."turntable_actity where status = 1 order by id desc limit 1");
            $prize = $GLOBALS['db']->getAll("select * from ".DB_PREFIX."turntable_actity_prize where id = '".$actityid."' and status = 1");
        }

        //查看实物信息
        $physical = array_map(function($val){
            if($val['type']==4){
                return $val['name'];
            }
        },$prize);
        $physical = array_filter($physical);
        if(!empty($physical)){
            $physical=implode(',',$physical);
            $deal = $GLOBALS['db']->getAll("select id,name from ".DB_PREFIX."deal where id in ({$physical})");
            $deal = array_column($deal,'name','id');
        }

        $actity['type'] = $this->type[$actity['type']];
        $actity['expenditure'] = round($actity['expenditure']);
        array_walk($prize,function(&$val) use ($deal){
            $val['type_source'] = $this->type[$val['type']];
            isset($deal[$val['name']]) ? $val['name'] = $deal[$val['name']]:'';
            $val['name'] = empty($val['name'])?'谢谢惠顾!':$val['type_source'].$val['name'];
            $val['abbrename'] = mb_substr($val['name'],0,6);
        });

        $root['list']['actityid'] = $actityid;
        $root['list']['actitys'] = $actitys;
        $root['list']['actity'] = ($actity);
        $root['list']['prize'] = ($prize);
        $root['list']['actity_json'] = json_encode($actity);
        $root['list']['prize_json'] = json_encode($prize);
        return output($root);

        echo '<pre>';var_dump($prize);exit;

    }


    
	/**
	 * 帮助文章详细页接口
	 * 
	 * 输入： 
	 * id:int 帮助文章id 
	 *
	 */    
    
    public function show(){
    	$root = array();
        $id = intval($GLOBALS['request']['id']);
		$result = $GLOBALS['db']->getRow("select title,content,create_time from ".DB_PREFIX."article where is_effect=1 and id=".$id);
		if($result){
			$result['create_time']=to_date($result['create_time'],"Y-m-d");
			$result['content'] = get_abs_img_root(format_html_content_image($result['content'],720));
		}		
        $root['result'] = $result?$result:array();

		$root['page_title'].="帮助";
        return output($root);
    }
}