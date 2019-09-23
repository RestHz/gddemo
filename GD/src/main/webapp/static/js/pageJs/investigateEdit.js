

/**
 * 考勤信息删除
 */
$(document).on("click",".inv_delete_btn",function () {
    var invId =$(this).val();
    //判断是否确认删除
    //询问框
    layer.confirm('确认删除此条考勤信息吗？', {
        btn: ['确定','取消'] //按钮
    }, function(){
        //删除学生信息
        $.ajax({
            url:"/investigate/"+invId,
            type:"delete",
            data:invId,
            success:function (result) {
                var result = eval("("+result+")");
                //处理失败
                if (result.code == 100){
                    layer.msg(result.msgContent.Fail, {icon: 1});
                    return false;
                }
                //成功弹出提示
                layer.msg(result.msgContent.Success, {icon: 1});
                //刷新页面
                $("#currentInvPage").trigger("click");
            }

        });
    }, function(){
        layer.msg('已取消', {
            time: 1000 //1s后自动关闭
        });
    });
});

