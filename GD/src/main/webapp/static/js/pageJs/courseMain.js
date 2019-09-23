/**
 * 课程分页信息
 */
function toCoursePage(pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/courseList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 课程信息新增模态框
 */
function courseAddModel() {
    //弹出添加模态框
    $("#couAddModel").modal({
        backdrop:"static"
    });
}
/**
 * 确认添加课程信息
 */
function confirmAddCou(){
    $.ajax({
        url:"/course",
        type:"POST",
        data:$("#courseAddMsgForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#couAddModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            getCouPage($("#currentPage").text());
        }
    });
}


/**
 * 打开课程信息模态框前获取课程信息
 **/
$(document).on("click",".cou_edit_btn",function () {
    //打开编辑模态框
    $("#couUpdateModel").modal('show');
    //获取对应课程信息
    var cno =$(this).val();
    $.ajax({
        url:"/courseOne/"+cno,
        type:"GET",
        data:cno,
        success:function (result) {
            var result = eval("("+result+")");
            $("#couAccount").val(result.msgContent.Course.cno);
            $("#couName").val(result.msgContent.Course.courseName);
            $("#couTime").val(result.msgContent.Course.courseTime);
        }
    });
});
/**
 * 确认提交修改课程信息
 */
function confirmAlterCou() {
    $.ajax({
        url:"/newCourseMsg",
        type:"POST",
        data:$("#courseMsgAlterForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#couUpdateModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            toCoursePage($("#currentPage").text());
        }
    });
}

/**
 * 课程信息删除
 */
$(document).on("click",".cou_delete_btn",function () {
    //获取需要删除的课程信息
    var cno =$(this).val();
    var couName =$(this).parents("tr").find("td:eq(1)").text();
    //判断是否确认删除
    var flag = confirm("确定删除？"+cno+" : "+couName);
    if (flag == false){
        return false;
    }
    //删除课程信息
    $.ajax({
        url:"/course/"+cno,
        type:"delete",
        data:cno,
        success:function (result) {
            var result = eval("("+result+")");
            alert(result.msgContent.Success);
            //刷新当前页
            getCouPage($("#currentPage").text());
        }

    });
});


/**
 * 获取需要查询信息
 */
function getCourseSelectMsg() {
    var msg = $("#needCouMsg").val();
    var selType = $("#selCouMsgType").val();
    $.ajax({
        url:'/courseSelect',
        type:'POST',
        data:{msg:msg,pn:selType},
        contentType:"application/x-www-form-urlencoded; charset=utf-8",
        success:function (result) {
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
            //数据回显
            $("#needCouMsg").attr("value",msg);
            $("#selCouMsgType").val([selType]);
        }
    });
}