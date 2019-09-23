/**
 * 注册信息
 */
function registerUser(){
    $.ajax({
        url:"/register",
        type:"POST",
        data:$("#userRegisterForm").serialize(),
        success:function(result) {
            var result = eval("("+result+")");
            console.log(result);
            if (result.code == 100){
                layer.msg(result.msgContent.Fail, {
                    time: 2000, //2s后自动关闭
                    btn: [ '确认']
                });
                return false;
            }

            layer.msg(result.msgContent.Success+" , 请登录后尽快完善信息！", {
                btn: [ '确认']
            });
            location.reload(true);
        }
    });
}