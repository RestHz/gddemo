/**
 * 成绩分页信息
 */
function getScoPage(pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/scoreList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 成绩信息新增模态框
 */
function scoreAddModel() {
    //弹出添加模态框
    $("#scoAddModel").modal({
        backdrop:"static"
    });
}
/**
 * 确认添加成绩信息
 */
function confirmAddSco(){
    $.ajax({
        url:"/score",
        type:"POST",
        data:$("#scoreAddMsgForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#scoAddModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            getScoPage($("#currentPage").text());
        }
    });
}


/**
 * 打开成绩信息模态框前获取成绩信息
 **/
$(document).on("click",".sco_edit_btn",function () {
    //打开编辑模态框
    $("#scoUpdateModel").modal('show');
    //获取对应成绩信息
    var scoreId =$(this).val();
    $.ajax({
        url:"/scoreOne/"+scoreId,
        type:"GET",
        data:scoreId,
        success:function (result) {
            var result = eval("("+result+")");
            $("#eaxmYearId").val(result.msgContent.Score.examYear);
            $("#examTermId").val(result.msgContent.Score.examTerm);
            $("#courseNameId").val(result.msgContent.Score.courseName);
            $("#claNameId").val(result.msgContent.Score.claName);
            $("#stuNameId").val(result.msgContent.Score.stuName);
            $("#examScoreId").val(result.msgContent.Score.examScore);
            $("#examTimeId").val(result.msgContent.Score.examTime);
        }
    });
});
/**
 * 确认提交修改成绩信息
 */
function confirmAlterSco() {
    $.ajax({
        url:"/newScoreMsg",
        type:"POST",
        data:$("#scoreMsgAlterForm").serialize(),
        success:function (result) {
            var result = eval("("+result+")");
            //处理失败
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }
            //成功后关闭模态框,弹出提示
            alert(result.msgContent.Success);
            $("#scoUpdateModel").modal('hide');
            //去掉遮罩层
            $('.modal-backdrop').remove();
            //刷新当前页
            getScoPage($("#currentPage").text());
        }
    });
}

/**
 * 成绩信息删除
 */
$(document).on("click",".sco_delete_btn",function () {
    //获取需要删除的成绩信息
    var scoreId =$(this).val();
    var couName =$(this).parents("tr").find("td:eq(4)").text();
    //判断是否确认删除
    var flag = confirm("确定删除："+couName+"此条成绩？");
    if (flag == false){
        return false;
    }
    //删除成绩信息
    $.ajax({
        url:"/course/"+scoreId,
        type:"delete",
        data:scoreId,
        success:function (result) {
            var result = eval("("+result+")");
            alert(result.msgContent.Success);
            //刷新当前页
            getScoPage($("#currentPage").text());
        }

    });
});


/**
 * 获取需要查询信息
 */
function getScoreSelectMsg() {
    var msg = $("#needScoMsg").val();
    var selType = $("#selScoMsgType").val();
    $.ajax({
        url:'/scoreSelect',
        type:'POST',
        data:{msg:msg,pn:selType},
        contentType:"application/x-www-form-urlencoded; charset=utf-8",
        success:function (result) {
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
            //数据回显
            $("#needScoMsg").attr("value",msg);
            $("#selScoMsgType").val([selType]);
        }
    });
}