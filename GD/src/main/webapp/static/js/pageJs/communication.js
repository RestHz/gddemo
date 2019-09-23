
/**
 * 留言分页信息
 */
function getComPage(account,pn,orderByType) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/communication",
        type:"POST",
        data:{sender:account,pn:pn,orderByType:orderByType},
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
            getClassList();
        }
    });
}

/**
 * 留言板
 */
function leavingamessage(account,recipient) {

    $.ajax({
        url:"/messageBoard",
        type:"GET",
        data:{sender:account,recipient:recipient},
        dataType:"html",
        success:function (result) {
            $("#communicationModel").modal('open');
            $("#messageBoard").empty();
            $(result).appendTo("#messageBoard");
        }
    });
}

/**
 * 查看、修改留言
 **/
$(document).on("click",".com_edit_btn",function () {

    //获取对应留言信息
    var cmId =$(this).val();

    $.ajax({
        url:"/communicationOne",
        type:"GET",
        data:{cmId:cmId,condition:1},
        success:function (result) {
            $("#communicationModel").modal('open');
            $("#messageBoard").empty();
            $(result).appendTo("#messageBoard");
        }
    });
});

/**
 * 回复留言
 **/
$(document).on("click",".com_reply_btn",function () {

    //获取对应留言信息
    var cmId =$(this).val();

    $.ajax({
        url:"/communicationOne",
        type:"GET",
        data:{cmId:cmId,condition:2},
        success:function (result) {
            $("#communicationModel").modal('open');
            $("#messageBoard").empty();
            $(result).appendTo("#messageBoard");
        }
    });
});

/**
 * 留言信息删除
 */
$(document).on("click",".com_delete_btn",function () {
    //获取需要删除的留言信息
    var cmId =$(this).val();
    var sender =$(this).parents("tr").find("td:eq(2)").text();
    //判断是否确认删除
    layer.alert("确定删除这条留言吗？", {
        title: "提示"
        ,yes: function(){
            //删除信息
            $.ajax({
                url:"/communicationMsg/"+cmId,
                type:"delete",
                data:cmId,
                success:function (result) {
                    result = eval("("+result+")");
                    if (result.code == 200){
                        alert(result.msgContent.Success);
                        //刷新留言信息
                        getCommunication(sender,1);
                        getClassList();
                    }else {
                        alert(result.msgContent.Fail);
                    }
                }

            });
            $("comCurrentPage").target("click");
            getClassList();
        }
    });
});

/**
 * 留言查询
 */
function getNeedComMsg() {
    $("#needComMsgMenu").empty();
    var needMsg = $("#needComMsg").val();
    $.ajax({
       url:"/userMsgNeed",
       type:"GET",
       data:{needMsg:needMsg},
       success:function (result) {
           result = eval("("+result+")");
           $("#needComMsgMenu").show();
           if (result.code == 100){
               var oli = $("<li></li>").append(result.msgContent.Fail);
               oli.appendTo("#needComMsgMenu");
               return;
           }
           $.each(result.msgContent.Success,function (index,item){
               var oli = $("<li></li>").addClass("li_selected")
                   .append(item.userName).val(item.account);
               oli.appendTo("#needComMsgMenu");
           });
       }
    });


}
/**
 * 信息选择
 **/
$(document).on("click",".li_selected",function () {
    var needMsg = $(this).text();
    var needMsgGet = $(this).val();
    var sender = $("#SenderAccount").val();
    $("#needComMsg").val(needMsg);
    $("#needComMsgMenu").empty();
    leavingamessage(sender,needMsgGet);
});




/**
 * 留言信息排序
 */
function getComOrderByMsg(account,pn) {
    var selType = $("#selComMsgType").val();
    //先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/communication",
        type:"POST",
        data:{sender:account,pn:pn,orderByType:selType},
        success:function (result) {
            $("#DataMsg").append(result);
            getClassList();
        }
    });
}

/**
 * 得到班级列表
 */
function getClassList() {
    //先清空,再发ajax
    $("#classListSelect").empty();
    $.ajax({
        url:"/classList",
        type:"GET",
        success:function (result) {
            var result = eval("("+result+")");

            $.each(result.msgContent.ClassList,function (index,item){
                if (index == 0){
                    var optionFist = $("<option style='width: 120px'>--请选择--</option>");
                    optionFist.appendTo("#classListSelect");
                }
                var optionId = $("<option style='width: 120px'></option>")
                    .append(item.claName).val(item.claName);
                optionId.appendTo("#classListSelect");
            });
        }
    });
}

/**
 * 得到用户列表
 */
function getUserList() {
    var claName = $("#classListSelect").val();

    $.ajax({
        url:"/teaUserList",
        type:"GET",
        data:{claName:claName},
        success:function (result) {
            //先清空
            $("#userListSelect").empty();
            var result = eval("("+result+")");
            if (result.code == 100){
                alert(result.msgContent.Fail);
                var optionFist = $("<option style='width: 120px'>--请选择--</option>");
                optionFist.appendTo("#userListSelect");
                return false;
            }

            $.each(result.msgContent.UserList,function (index,item){
                if (index == 0){
                    var optionFrist = $("<option style='width: 120px'>--请选择--</option>");
                    optionFrist.appendTo("#userListSelect");
                }
                var optionId = $("<option style='width: auto'></option>")
                    .append(item.userName+'('+item.stuName+'的'+item.relation+')').val(item.account);
                optionId.appendTo("#userListSelect");
            });
        }
    });
}

/**
 * 得到教师列表
 */
function getTeaList() {
    var claName = $("#classListSelect").val();

    $.ajax({
        url:"/userTeaList",
        type:"GET",
        data:{claName:claName},
        success:function (result) {
            //先清空
            $("#teaListSelect").empty();
            var result = eval("("+result+")");
            if (result.code == 100){
                alert(result.msgContent.Fail);
                var optionFist = $("<option style='width: 120px'>--请选择--</option>");
                optionFist.appendTo("#teaListSelect");
                return false;
            }

            $.each(result.msgContent.TeaList,function (index,item){
                if (index == 0){
                    var optionFrist = $("<option style='width: 120px'>--请选择--</option>");
                    optionFrist.appendTo("#teaListSelect");
                }
                var optionId = $("<option style='width: auto'></option>")
                    .append(item.tcName+'('+item.courseName+')').val(item.tno);
                optionId.appendTo("#teaListSelect");
            });
        }
    });
}

/**
 * 得到用户账号
 */
function getUserOne(sender) {
    var recipient = $("#userListSelect").val();
    var recipientName = $("#userListSelect").text();
    console.log(recipientName);
    leavingamessage(sender,recipient);
}

/**
 * 得到老师账号
 */
function getTeacherOne(sender) {
    var recipient = $("#teaListSelect").val();
    var recipientName = $("#teaListSelect").text();
    console.log(recipientName);
    leavingamessage(sender,recipient);
}

/**
 * 失去焦点，清除提示
 */
function clearNeedComMsgMenu() {
    $("#needComMsgMenu").empty();
}