/**
 * 首页
 */
function teaHome() {
    location.reload(true);
}



/**
 * 个人信息修改
 */
function teaUpdate(tno) {

    $.ajax({
        url:"/teaUpdateGet/"+tno,
        data:tno,
        type:"POST",
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
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
function teaUpdatePost() {
    var checkName = checkTeaName();
    var checkEmail = checkTeaEmail();
    var checkTel = checkTeaTel();
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

    var formData = new FormData($('#teaMsgUpdateForm')[0]);
    $.ajax({
        url : '/teacherMsgUpdate',
        type : 'POST',
        data : formData,
        cache : false,
        processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
        contentType : false, // 不设置Content-type请求头
        success : function(res){
            var msg = eval("("+res+")");
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
 * 学生成绩获取
 */
function stuScoreGet(sno,pn) {

    $.ajax({
        url:"/stuScore",
        type:"GET",
        data:{sno:sno,pn:pn},
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
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
        dataType:'html',
        success:function (result) {
            $("#DataMsg").append(result);
        }
    });
}
/**
 * 获取留言信息
 */
function getCommunication(account,pn) {
    var orderByType = 3;
    $.ajax({
        url:"/communication",
        type:"POST",
        data:{sender:account,pn:pn,orderByType:orderByType},
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
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

    $.ajax({
        url:"/communication",
        type:"POST",
        dataType:'html',
        data:{sender:account,pn:pn,orderByType:type},
        success:function (result) {
            $("#teaMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 班级考勤
 * @param clas
 */
function investigateGet(clas) {
    $.ajax({
        url:"/investigate",
        type:"POST",
        data:{claId:clas},
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 班级考勤管理
 * @param clas
 */
function investigateEdit(tno,pn) {
    $.ajax({
        url:"/investigateEdit",
        type:"POST",
        data:{tno:tno,pn:pn},
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}

/**
 * 成绩管理
 */
function teaScoreManege(tno,pn) {
    $.ajax({
        url:"/teaScoreManege",
        type:"POST",
        data:{tno:tno,pn:pn},
        dataType:'html',
        success:function (result) {
            $("#teaMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}