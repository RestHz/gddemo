/**
 * 提交留言
 */
function leavingamessageConfirm() {

    $.ajax({
        url:"/communicationMsg",
        type:"POST",
        data:$("#msgBoardForm").serialize(),
        success:function (result) {
            result = eval("("+result+")");
            if (result.code == 100){
                alert(result.msgContent.Fail);
                return false;
            }

            alert(result.msgContent.Success);

            $("#communicationModel").modal('close');
            $('.am-dimmer').hide();
            //刷新留言信息
            getCommunication($("#senderName").val(),1);
        }
    });

}