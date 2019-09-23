/**
 * 考勤信息查看
 **/
$(document).on("click",".inv_detail_btn",function () {
    //获取对应考勤信息
    var invId =$(this).val();

    $.ajax({
        url:"/investigateOne/"+invId,
        type:"GET",
        data:invId,
        success:function (result) {
            //打开模态框
            $('#stuInvCheckModel').modal('open');
            var result = eval("("+result+")");
            $("#invIdCheck").val(result.msgContent.Investigate.invId);
            $("#snoCheck").val(result.msgContent.Investigate.sno);
            $("#stuNameCheck").val(result.msgContent.Investigate.stuName);
            $("#claNameCheck").val(result.msgContent.Investigate.claName);
            $("#situationCheck").val([result.msgContent.Investigate.situation]);

            if (result.msgContent.Investigate.remark == null){
                $("#remarkCheck").val("无备注");
            } else {
                $("#remarkCheck").val(result.msgContent.Investigate.remark);
            }

            $("#tcNameCheck").val(result.msgContent.Investigate.tcName);
        }
    });
});