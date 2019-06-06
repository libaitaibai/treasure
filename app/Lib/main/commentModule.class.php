<?php
/**
 * Created by PhpStorm.
 * User: liuyu
 * Date: 2019/6/5
 * Time: 13:24
 */

class commentModule extends MainBaseModule{





      public function publish(){

          global_run();
          init_app_page();

          $user_info = $GLOBALS['user_info'];
          if(empty($user_info)){
              $res = array('code'=>401,'msg'=>'请先登录','data'=>array());
              ajax_return($res);
          }

          $share_id = intval($_REQUEST['share_id']);
          $content = trim($_REQUEST['content']);
          $target_id = intval($_REQUEST['target_id']);
          $parent_id = intval($_REQUEST['parent_id']);

          if(empty($share_id)){
              $res = array('code'=>201,'msg'=>'参数错误','data'=>array());
              ajax_return($res);
          }

          $target = array();
          if(!empty($target_id)){
              $target = $GLOBALS['db']->getRow('select * from '.DB_PREFIX.'user where id='.$target_id);
          }

          $data = array(
              'share_id'=>$share_id,
              'uid'=>$user_info['id'],
              'uname'=>$user_info['user_name'],
              'uimg'=>$user_info['avatar'],
              'to_uid'=>$target_id?$target_id:0,
              'to_uname'=>$target?$target['user_name']:'',
              'to_uimg'=>$target?$target['avatar']:'',
              'content'=>$content,
              'pid'=>$parent_id?$parent_id:0,
              'create_time'=>time()
          );

          if(!empty($target)){
              $data['to_uname'] = $target['user_name'];
              $data['to_uimg'] = $target['avatar'];
          }

          $rst = $GLOBALS['db']->autoExecute(DB_PREFIX.'share_comment',$data);
          if($rst){
              $GLOBALS['db']->query('update '.DB_PREFIX.'share set comments=comments+1 where id='.$share_id);
              $res = array('code'=>200,'msg'=>'评论成功','data'=>array());
              ajax_return($res);
          }

          $res = array('code'=>500,'msg'=>'评论失败','data'=>array());
          ajax_return($res);

      }


      public function comments(){

          $list = $this->getlist();
          $has_data = empty($list)?0:1;

          $data = array('html'=>'');


          if($has_data){

              if(isset($_REQUEST['parent_id']) && !empty($_REQUEST['parent_id'])){

                  $GLOBALS['tmpl']->assign('childs',$list);
                  $data['html']= $GLOBALS['tmpl']->fetch('share_comment_child.html');
              }else{

                  $GLOBALS['tmpl']->assign('has_data',$has_data);
                  $GLOBALS['tmpl']->assign('data',$list);
                  $data['html']= $GLOBALS['tmpl']->fetch('share_comment.html');

              }

          }

          $res = array('code'=>200,'msg'=>'获取成功','data'=>$data);
          ajax_return($res);

       }

      public function getlist(){

          global_run();
          init_app_page();

          $share_id = intval($_REQUEST['share_id']);
          $page = intval($_REQUEST['page']);
          $pid = intval($_REQUEST['parent_id']);
          $pid<=0 && $pid=0;
          if($page<=0)$page = 1;
          $pageSize = 4;

          $where = 'where share_id='.$share_id.' and pid='.$pid;

          $sql = 'select count(*) as num from '.DB_PREFIX.'share_comment '.$where;
          $tmp = $GLOBALS['db']->getRow($sql);

          if(empty($tmp) || !$tmp['num']){

              return array();

          }
          $pages = ceil($tmp['num']/$pageSize);

          $limit = (($page-1)*$pageSize).','.$pageSize;
          $sql = 'select * from '.DB_PREFIX.'share_comment '.$where.' order by create_time desc limit '.$limit;
          $rows = $GLOBALS['db']->getAll($sql);

          if($pid==0){

              foreach($rows as &$row){

                  $where = 'where share_id='.$share_id.' and pid='.$row['id'];
                  $sql = 'select count(*) as num from '.DB_PREFIX.'share_comment '.$where;
                  $c_tmp = $GLOBALS['db']->getRow($sql);
                  if(empty($c_tmp) || empty($c_tmp['num'])){
                      $row['childs'] = array();
                      continue;
                  }

                  $c_num = $c_tmp['num'];
                  $c_pages = ceil($c_num/$pageSize);
                  $sql = 'select * from '.DB_PREFIX.'share_comment '.$where.' order by create_time desc limit '.$pageSize;
                  $c_rows = $GLOBALS['db']->getAll($sql);
                  foreach($c_rows as &$k){
                      $k['publish_time'] = date('Y.m.d',$k['create_time']);
                  }

                  $c_data = array(
                      'rows'=>$c_rows,
                      'pages'=>array('page'=>1,'page_t'=>0,'pageSize'=>$pageSize,'pages'=>$c_pages,'nums'=>$c_num)
                  );
                  $row['childs'] = $c_data;

              }

          }

          foreach($rows as &$k){
              $k['publish_time'] = date('Y.m.d',$k['create_time']);
          }

          $data = array(
              'rows'=>$rows,
              'pages'=>array('page'=>$page,'page_t'=>$page,'pageSize'=>$pageSize,'pages'=>$pages,'nums'=>$tmp['num'])
          );

          //print_r($data);exit;
          return $data;
      }




}