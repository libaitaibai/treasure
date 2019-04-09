<?php 
return array(
//fx 营销菜单位于订单菜单后面
	"marketing"	=>	array(
			"name"	=>	"营销管理",
			"key"	=>	"marketing",
			"groups"	=>	array(
					"fx"	=>	array(
							"name"	=>	"分销管理",
							"key"	=>	"fx",
							"nodes"	=>	array(
								array("name"=>"分销设置","module"=>"FxSalary","action"=>"index"),
							    array("name"=>"分销会员","module"=>"FxUser","action"=>"index"),
							),
					),
			),
	),
);
?>