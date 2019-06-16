<?php
class turntableApiModule extends MainBaseApiModule{

    public  $type = [1=>'金币', 2=>'钻石' , 3=>'优惠券' , 4=>'实物'];
    public  $img = [1=>'jin.jpg',2=>'zhuang.jpg',3=>'youhui.jpg','6'=>'thinks.jpg'];
    /**
	 * 展示所有的大转盘的活动和奖品
	 */
    public function index(){
    	$root = array();
        $root['page_title']="大转盘";
        $actityid = strim($_REQUEST['actityid'])?$_REQUEST['actityid']:1;

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
            $deal = $GLOBALS['db']->getAll("select id,name,icon from ".DB_PREFIX."deal where id in ({$physical})");
            $icon = array_column($deal,'icon','id');
            $deal = array_column($deal,'name','id');
        }

        $actity['type'] = $this->type[$actity['type']];
        $actity['expenditure'] = round($actity['expenditure']);
        $img = $this->img;
        array_walk($prize,function(&$val) use ($deal,$img,$icon){
            $val['type_source'] = $this->type[$val['type']];
            $val['img'] = isset($img[$val['type']])&&(!empty($val['name'])) ? $img[$val['type']] : $img[6];
            isset($img[$val['type']])||(empty($val['name']))?'':$val['showimg'] = $icon[$val['name']];
            isset($deal[$val['name']]) ? $val['name'] = $deal[$val['name']]:'';
            $val['name'] = empty($val['name'])?'谢谢惠顾!':$val['type_source'].$val['name'];
            $val['abbrename'] = mb_substr($val['name'],0,6);
        });

        //选中中奖数据
        $goodluck = $this->price($prize,$actity);

        $root['list']['goodluck'] = $goodluck;
        $root['list']['actityid'] = $actityid;
        $root['list']['actitys'] = $actitys;
        $root['list']['actity'] = ($actity);
        $root['list']['prize'] = ($prize);
        $root['list']['actity_json'] = json_encode($actity);
        $root['list']['prize_json'] = json_encode($prize);
        return output($root);

    }

    /**
     * 轮盘赌
     */
    public function price ($prize,$actity)
    {
        //判断库存信息  库存加上人工干预数据
        $repertory =  $actity['repertory'] + $actity['person_repertory'];
        $user_info = $GLOBALS['user_info'];

        $array = array_column($prize,'probability');

        $total = array_sum($array);
        $rand = rand(0,$total*100)/100;

        $return = -1;
        foreach ($prize as $key => $val){
            //指定中奖人
            if($val['lucky_person'] == $user_info['id']){
                $return = $key;
                break ;
            }
            //轮盘转
            $rand-=$val['probability'];
            if($rand <= 0 ){
                if( ($repertory > $val['predict_repertory'])){
                    $return = $key;
                    break ;
                }else{
                    continue;
                }
            }
        }

        //预库存没有达到库存的值得时候设置为不中奖
        if($return == -1){
            foreach ($prize as $key => $val) {
                if($val['name'] == '谢谢惠顾!'){
                    $return = $key;
                    break ;
                }
            }
        }

        return $return;
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