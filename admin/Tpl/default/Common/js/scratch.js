
//新增跳转
function scratchAdd(name,str){

    var url = ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"="+name;
  /*  if(Object.keys(obj).length!=0){
         for(var i in obj){
             url += '&'+i+'='+obj[i];
         }
    }*/
   if(str!=''){

       var arr = str.split('-');
       arr.map(function(value,index){

           if(index%2==0){
               url += '&'+value;
           }else{
               url += '='+value;
           }

       });
   }
   console.log(url);
    window.location.href = url;
}

//编辑跳转
function scratchEdit(name,id){

    window.location.href = ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"="+name+"&id="+id;

}

//完全删除
function scratchdel(name,id)
{
    if(!id)
    {
        idBox = $(".key:checked");
        if(idBox.length == 0)
        {
            alert(LANG['DELETE_EMPTY_WARNING']);
            return;
        }
        idArray = new Array();
        $.each( idBox, function(i, n){
            idArray.push($(n).val());
        });
        id = idArray.join(",");
    }
    if(confirm(LANG['CONFIRM_DELETE']))
        $.ajax({
            url: ROOT+"?"+VAR_MODULE+"="+MODULE_NAME+"&"+VAR_ACTION+"="+name+"&id="+id,
            data: "ajax=1",
            dataType: "json",
            success: function(obj){
                $("#info").html(obj.info);
                if(obj.status==1)
                    location.href=location.href;
            }
        });
}


