
/**
 * 学生成绩分页信息
 */
function toScorePage(tno,pn) {
    //先清空上次数据
    $("#DataMsg").empty();
    $.ajax({
        url:"/teaScoreManege",
        type:"GET",
        data:{tno:tno,pn:pn},
        dataType:"html",
        success:function (result) {
            $(result).appendTo("#DataMsg");
        }
    });
}



/**
 * 成绩提交
 */
function scoreMsgPost(tno) {
    //表单数据包含file
    var formData = new FormData($('#scoreMsgPostForm')[0]);
    $.ajax({
        url:"/file/scoreUpLoad",
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
            teaScoreManege(tno,1)
        }
    });
}