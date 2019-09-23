/**
 * 老师分页信息
 */
function getTeaPage(pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/teacherList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 老师信息新增模态框
 */
function teacherAddModel() {
    //获取课程信息
    getCourseList("#teaCourseListAdd");
    //弹出添加模态框
    $("#teaAddModel").modal({
        backdrop:"static"
    });
}
/**
 * 确认添加学生信息
 */
function confirmAddTea(){
    $.ajax({
        url:"/teacher",
        type:"POST",
        data:$("#teacherAddMsgForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#teaAddModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            getTeaPage($("#currentPage").text());
        }
    });
}


/**
 * 打开老师信息模态框前获取老师信息
 **/
$(document).on("click",".tea_edit_btn",function () {
    //打开编辑模态框
    $("#teaUpdateModel").modal('show');
    //获取对应学生信息
    var tno =$(this).val();
    //获取课程信息
    getCourseList("#teaCourseList");
    $.ajax({
        url:"/teacherOne/"+tno,
        type:"GET",
        data:tno,
        success:function (result) {
            var result = eval("("+result+")");
            $("#teaAccount").val(result.msgContent.Teacher.tno);
            $("#teaName").val(result.msgContent.Teacher.tcName);
            $("#teaPassword").val(result.msgContent.Teacher.tcPwd);
            $("#teaSex").val(result.msgContent.Teacher.tcSex);
            $("#teaAge").val(result.msgContent.Teacher.tcAge);
            $("#teaEmail").val(result.msgContent.Teacher.tcEmail);
            $("#teaPho").val(result.msgContent.Teacher.tcPhone);
            $("#teaCourseList").val([result.msgContent.Teacher.cno]);
        }
    });
});
/**
 * 确认提交修改老师信息
 */
function confirmAlterTea() {
    $.ajax({
        url:"/newTeacherMsg",
        type:"POST",
        data:$("#teacherMsgAlterForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#teaUpdateModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            getTeaPage($("#currentPage").text());
        }
    });
}

/**
 * 老师信息删除
 */
$(document).on("click",".tea_delete_btn",function () {
    //获取需要删除的学生信息
    var tno =$(this).val();
    var tcname =$(this).parents("tr").find("td:eq(1)").text();
    //判断是否确认删除
    var flag = confirm("确定删除？"+tno+" : "+tcname);
    if (flag == false){
        return false;
    }
    //删除老师信息
    $.ajax({
        url:"/teacher/"+tno,
        type:"delete",
        data:tno,
        success:function (result) {
            var result = eval("("+result+")");
            alert(result.msgContent.Success);
            //刷新当前页
            getTeaPage($("#currentPage").text());
        }

    });
});


/**
 * 获取需要查询信息
 */
function getTeaSelectMsg() {
    var msg = $("#needTeaMsg").val();
    var selType = $("#selTeaMsgType").val();
    $.ajax({
        url:'/teacherSelect',
        type:'POST',
        data:{msg:msg,pn:selType},
        contentType:"application/x-www-form-urlencoded; charset=utf-8",
        success:function (result) {
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
            //数据回显
            $("#needTeaMsg").attr("value",msg);
            $("#selTeaMsgType").val([selType]);
        }
    });
}

/**
 * 得到班级列表
 */
function getClassList(ele) {
    //先清空,再发ajax
    $(ele).empty();
    $.ajax({
        url:"/classList",
        type:"GET",
        success:function (result) {
            var result = eval("("+result+")");
            $.each(result.msgContent.ClassList,function (index,item){
                var optionId = $("<option style='width: 120px'></option>")
                    .append(item.claName).val(item.claId);
                optionId.appendTo(ele);
            });
        }
    });
}

/**
 * 得到课程列表
 */
function getCourseList(ele) {
    //先清空,再发ajax
    $(ele).empty();
    $.ajax({
        url:"/courseList",
        type:"GET",
        success:function (result) {
            var result = eval("("+result+")");
            $.each(result.msgContent.CourseList,function (index,item){
                var optionId = $("<option style='width: 120px'></option>")
                    .append(item.courseName).val(item.cno);
                optionId.appendTo(ele);
            });
        }
    });
}