
/**
 * 学生分页信息
 */
function toSchedulePage(pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/scheduleList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}




/**
 * 打开编辑模态框
 */
$(document).on("click",".sch_edit_btn",function () {
    //弹出模态框
    $("#schUpdateModel").modal('show');
    //获取需要修改的信息
    var claId =$(this).val();
    var examYear =$(this).parents("tr").find("td:eq(2)").text();
    var examTerm =$(this).parents("tr").find("td:eq(3)").text();
});

/**
 * 确认提交课表
 */
function confirmAddSch() {
    $.ajax({
       url:"schedule",
       type:"POST",
       data:$("#scheduleAddMsgForm").serializeArray(),
       success:function (result) {
           console.log(result);
       }
    });
}

/**
 * 课表删除
 */
$(document).on("click",".sch_delete_btn",function () {
    //获取需要删除的信息
    var claId =$(this).val();
    var examYear =$(this).parents("tr").find("td:eq(2)").text();
    var examTerm =$(this).parents("tr").find("td:eq(3)").text();
    //判断是否确认删除
    var flag = confirm("确定删除此课表吗？");
    if (flag == false){
        return false;
    }
    //删除学生信息
    $.ajax({
        url:"/scheduleOne",
        type:"POST",
        data:{claId:claId,examYear:examYear,examTerm:examTerm},
        success:function (result) {
            var result = eval("("+result+")");
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return;
            }
            alert(result.msgContent.Success);
            //刷新页面
            $("#currentSchPage").trigger("click");
        }

    });
});

/**
 * 课表提交
 */
function scheduleMsgPost() {
    //表单数据包含file
    var formData = new FormData($('#scheduleMsgPostForm')[0]);
    $.ajax({
        url:"/file/scheduleUpLoad",
        data:formData,
        type:"POST",
        cache : false,
        processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
        contentType : false, // 不设置Content-type请求头
        success:function (result) {
            result = eval("("+result+")");
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return;
            }
            alert(result.msgContent.Success);
            //刷新页面
            $("#currentSchPage").trigger("click");
        }
    });
}