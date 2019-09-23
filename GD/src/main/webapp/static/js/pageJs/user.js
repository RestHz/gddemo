/**
 * 用户首页
 */
function userHome() {
    location.reload(true);
}



/**
 * 个人信息修改
 */
function userUpdate(account) {

    $.ajax({
        url:"/userUpdateGet",
        data:{account:account},
        type:"POST",
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 个人信息修改提交
 */
function userUpdatePost() {

    var checkName = checkUserName();
    var checkEmail = checkUserEmail();
    var checkTel = checkUserTel();
    if (!checkName || !checkEmail || !checkTel){
        layer.open({
            type: 1
            ,id: 'layerDemo'+1 //防止重复弹出
            ,title:"错误"
            ,content: '<div style="padding: 20px 100px;">'+ '请输入正确信息' +'</div>'
            ,btn: '关闭'
            ,btnAlign: 'c' //按钮居中
            ,shade: 0 //不显示遮罩
            ,yes: function(){
                layer.closeAll();
            }
        });
        return;
    }

    //表单数据包含file
    var formData = new FormData($('#userMsgUpdateForm')[0]);
    $.ajax({
        url:"/userUpdate",
        data:formData,
        type:"POST",
        cache : false,
        processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
        contentType : false, // 不设置Content-type请求头
        success:function (res) {
            var msg = eval("("+res+")");
            console.log(msg);
            if (msg.code == 100){
                layer.alert('修改失败,'+msg.msgContent.Fail, {
                    icon: 5,
                    title: "提示"
                });
                return;
            }
            layer.alert(msg.msgContent.Success+"，请刷新！", {
                title: "提示"
                ,yes: function(){
                    window.location.reload();
                }
            });
        }
    });
}


/**
 * 学生个人考勤信息
 */
function stuInvMsg(sno) {

    $.ajax({
        url : '/studentInvestigateMsg',
        type : 'GET',
        data : {sno:sno},
        success : function(result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}


/**
 * 学生成绩获取
 */
function stuScoreGet(sno,pn) {
//先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/stuScore",
        type:"GET",
        data:{sno:sno,pn:pn},
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 获取学生课表信息
 */
function getStuSchedule(claId) {
//先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/scheduleOne",
        type:"GET",
        data:{claId:claId},
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 获取学生考勤信息
 */
function getStuInvestigate(sno) {
//先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/studentInvestigateMsg",
        type:"GET",
        data:{sno:sno},
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 获取留言信息
 */
function getCommunication(account,pn) {
    var orderByType = 3;
    //先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/communication",
        type:"POST",
        data:{sender:account,pn:pn,orderByType:orderByType},
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
            getClassList();
        }
    });
}

/**
 * 我的留言信息
 */
function getMyMsg(account,pn,type) {
    //先清空
    $("#DataMsg").empty();
    $.ajax({
        url:"/communication",
        type:"POST",
        data:{sender:account,pn:pn,orderByType:type},
        success:function (result) {
            $("#userMsgA").hide();
            $("#userStuScoreA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}




