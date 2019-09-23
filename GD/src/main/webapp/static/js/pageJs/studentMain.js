/**
 * 学生分页信息
 */
function toStudentPage(pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/studentList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 打开学生信息添加模态框
 **/
function studentAddModel() {
    //获取班级信息
    getClassList("#clasListAdd");
    //获取课程信息
    getCourseList("#courseListAdd");
    //弹出添加模态框
    $("#stuAddModel").modal({
        backdrop:"static"
    });
}

/**
 * 确认添加学生信息
 */
function confirmAddStu(){
    $.ajax({
        url:"/student",
        type:"POST",
        data:$("#studentMsgAddForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#stuAddModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            toStudentPage($("#currentPage").text());
        }
    });
}


/**
 * 学生信息更新前获取学生信息
 **/
$(document).on("click",".stu_edit_btn",function () {
    //打开编辑模态框
    $("#stuUpdateModel").modal('show');
    //获取对应学生信息
    var sno =$(this).val();
    //获取班级信息
    getClassList("#clasList");
    //获取课程信息
    getCourseList("#courseList");
    $.ajax({
        url:"/studentOne/"+sno,
        type:"GET",
        data:sno,
        success:function (result) {
            var result = eval("("+result+")");
            $("#account").val(result.msgContent.Student.sno);
            $("#stuName").val(result.msgContent.Student.stuName);
            $("#stuPassword").val(result.msgContent.Student.stuPwd);
            $("#stuSex").val(result.msgContent.Student.stuSex);
            $("#stuAge").val(result.msgContent.Student.stuAge);
            $("#stuEmail").val(result.msgContent.Student.stuEmail);
            $("#stuPho").val(result.msgContent.Student.stuPhone);
            $("#stuAddress").val(result.msgContent.Student.stuAddress);
            $("#grade").val(result.msgContent.Student.grade);
            $("#clasList").val([result.msgContent.Student.claId]);
            $("#courseList").val([result.msgContent.Student.cno]);
        }
    });
});
/**
 * 确认提交修改学生信息
 */
function confirmAlterStu() {
    $.ajax({
        url:"/newStudentMsg",
        type:"POST",
        data:$("#studentMsgAlterForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#stuUpdateModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            toStudentPage($("#currentPage").text());
        }
    });
}

/**
 * 学生信息删除
 */
$(document).on("click",".stu_delete_btn",function () {
    //获取需要删除的学生信息
    var sno =$(this).val();
    var stuname =$(this).parents("tr").find("td:eq(2)").text();
    //判断是否确认删除
    var flag = confirm("确定删除？"+sno+" : "+stuname);
    if (flag == false){
        return false;
    }
    //删除学生信息
    $.ajax({
        url:"/student/"+sno,
        type:"delete",
        data:sno,
        success:function (result) {
            var result = eval("("+result+")");
            alert(result.msgContent.Success);
            //刷新当前页
            toStudentPage($("#currentPage").text());
        }

    });
});

/**
 * 获取需要查询信息
 */
function getSelectMsg() {
    var msg = $("#needMsg").val();
    var selType = $("#selMsgType").val();
    $.ajax({
        url:'/studentSelect',
        type:'POST',
        data:{msg:msg,pn:selType},
        contentType:"application/x-www-form-urlencoded; charset=utf-8",
        success:function (result) {
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
            //数据回显
            $("#needMsg").attr("value",msg);
            $("#selMsgType").val([selType]);
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