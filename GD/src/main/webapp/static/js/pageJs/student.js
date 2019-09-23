/**
 * 首页
 */
function stuHome() {
    location.reload(true);
}



/**
 * 修改页面获取请求
 */
function stuUpdatePage(sno) {

    $.ajax({
        url:"/stuUpdatePage/"+sno,
        data:sno,
        type:"GET",
        success:function (result) {
            $("#stuScoreA").hide();
            $("#stuMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}
/**
 * 提交修改表单数据
 */
function studentMsgUpdate() {

    var checkName = checkStuName();
    var checkEmail = checkStuEmail();
    var checkTel = checkStuTel();
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

    var formData = new FormData($('#stuMsgUpdateForm')[0]);
    $.ajax({
        url : '/studentMsg',
        type : 'POST',
        data : formData,
        cache : false,
        processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
        contentType : false, // 不设置Content-type请求头
        success : function(res){
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
        },
        error : function(res){
            var msg = eval("("+res+")");
            alert(msg.prompt);

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
            $("#stuScoreA").hide();
            $("#stuMsgA").hide();
            //先清空
            $("#PreDataMsg").empty();
            $("#DataMsg").empty();
            $("#DataMsg").append(result);
        }
    });
}
