/**
 * 打开考勤信息模态框
 **/
$(document).on("click",".inv_edit_btn",function () {
    //获取对应学生信息
    var sno =$(this).val();
    //打开编辑模态框
    $("#invAddModel").modal('open');

    $.ajax({
        url:"/studentOne/"+sno,
        type:"GET",
        data:sno,
        success:function (result) {
            var result = eval("("+result+")");
            $("#snoEdit").val(result.msgContent.Student.sno);
            $("#stuNameEdit").val(result.msgContent.Student.stuName);
        }
    });

});

/**
 * 确认添加学生考勤信息
 */
function confirmAddInv(){

    $.ajax({
        url:"/investigateMsg",
        type:"POST",
        data:$("#invAddMsgForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                layer.alert(result.msgContent.Fail, {
                    title: "提示"
                });
                return false;
            }
            //成功后关闭模态框,弹出提示
            layer.alert(result.msgContent.Success, {
                title: "提示"
            });
            $("#invAddModel").modal('close');
            //去掉遮罩层
            $('.modal-backdrop').remove();
        }
    });
}