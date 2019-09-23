/**
 * 回复留言
 */
function replyConfirm() {
    
    $.ajax({
       url:"/communicationReply",
       type:"POST",
       data:$("#replyMsgForm").serialize(),
       success:function (result) {
           result = eval("("+result+")");
           console.log(result);
           alert(result.msgContent.Success);
           $("#communicationModel").modal('close');
           //去掉遮罩层
           $('.am-dimmer').hide();
           $('#comCurrentPage').trigger("click");
       } 
    });
    
}