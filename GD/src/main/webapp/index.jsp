<%--
  User: Carlson
  Date: 2019/4/4
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>登录注册界面</title>
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/amazeUI/js/amazeui.js"></script>
    <link rel="stylesheet" href="static/amazeUI/css/amazeui.css"/>
    <link rel="stylesheet" type="text/css" href="static/css/styles.css">
<style type="text/css">
    .am-selected {
        width: 330px;
        background-color: white;
    }
    body{
        background:url(/static/img/indexBg.jpg) no-repeat center;
    }
</style>
</head>
<body>
<c:if test="${ERROR.msgContent.Fail != null}">
    <input id="errorMsg" style="color: red;display: none" value="${ERROR.msgContent.Fail}">
</c:if>
<c:if test="${ERROR.msgContent.Fail == null}">
    <input id="errorMsg" style="display: none" value="">
</c:if>
<div class="container" style="padding-top:70px;font-size: 20px">
    <div class="login-wrap">
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">登录</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">家长注册</label>
            <div class="login-form">
                <form class="form-horizontal" action="/login" method="post">
                    <div class="sign-in-htm">
                        <div class="am-input-group am-animation-fade" style="padding-top: 25px">
                            <span class="am-input-group-label"><i class="am-icon-user am-icon-fw"></i></span>
                            <input type="text" name="account" class="am-form-field" placeholder="Username">
                        </div>

                        <div class="am-input-group am-animation-fade" style="padding-top: 35px">
                            <span class="am-input-group-label"><i class="am-icon-lock am-icon-fw"></i></span>
                            <input type="password" name="password" class="am-form-field" placeholder="Password">
                        </div>

                        <div class="am-input-group" style="padding-top: 35px">
                            <span class="am-input-group-label"><i class="am-icon-user-secret am-icon-fw"></i></span>
                            <select name="role" data-am-selected required>
                                <option value="1">学生</option>
                                <option value="2">老师</option>
                                <option value="3">家长</option>
                            </select>
                        </div>
                      <%--  <div class="group">
                            <label class="label">密码：</label>
                            <input name="password" type="password" class="input" data-type="password">
                        </div>--%>
                        <div class="am-input-group am-animation-slide-bottom" style="padding-top: 35px">
                            <span class="am-input-group-label"><i class="am-icon-shield am-icon-fw"></i></span>
                            <div>
                                <input type="text" name="checkCode" style="width: 200px;height: 40px" class="am-form-field" placeholder="验证码">
                                <img src="/kaptcha" id="checkcode" onclick="onCheckCode()" title="看不清换一张" style="padding-left: 14px">
                            </div>
                        </div>

                        <div class="group">
                            <input id="check" type="checkbox" class="check">
                            <label for="check"><span class="icon"></span> Keep me Signed in</label>
                        </div>
                        <div class="group">
                            <input type="submit" style="color: #9eb4cb" class="button" value="登录">
                        </div>
                        <div class="hr"></div>
                    </div>
                </form>


                <div class="sign-up-htm">
                    <form class="form-horizontal" id="userRegisterForm" method="post">
                        <div class="group">
                            <label class="index-label" style="color: #9eb4cb">学号：</label>
                            <input name="sno" type="text" class="input" placeholder="请填写学生学号">
                        </div>
                        <div class="group">
                            <label class="index-label" style="color: #9eb4cb">用户名：</label>
                            <input name="account" type="text" class="input" placeholder="登录时使用的用户名">
                        </div>
                        <div class="group">
                            <label class="index-label" style="color: #9eb4cb">密码：</label>
                            <input id="userPwdInput" name="userPwd" type="password" class="input" placeholder="Password" autocomplete="off">
                        </div>
                        <div class="group">
                            <label class="index-label" style="color: #9eb4cb">真实姓名：</label>
                            <input id="userNameInput" name="userName" type="text" class="input" placeholder="请填实际真实姓名">
                        </div>
                        <div class="group">
                            <label class="index-label" style="color: #9eb4cb">电话：</label>
                            <input name="userPhone" type="text" class="input" placeholder="手机号码">
                        </div>
                        <div class="am-input-group group">
                            <label class="index-label" style="color: #9eb4cb">关系人：</label>
                            <select name="relation" data-am-selected required>
                                <option value="父亲">父亲</option>
                                <option value="母亲">母亲</option>
                                <option value="亲属">亲属</option>
                            </select>
                        </div>
                        <div class="group">
                            <input type="button" onclick="registerUser()" class="button" value="Sign Up">
                        </div>
                    </form>


                    <div class="hr"></div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--引入页面JS--%>
<script src="static/js/pageJs/login.js"></script>
<script src="static/js/pageJs/register.js"></script>
<link rel="stylesheet" href="static/css/bootstrap.min.css"/>
<link rel="stylesheet" href="static/layui/css/layui.css"/>
<script type="text/javascript" src="static/layui/layui.all.js"></script>
<script>
    var msg = null;
    $(function () {
        msg = $("#errorMsg").val();
        if (msg !== ""){
            layer.open({
                type: 1
                ,id: 'layerDemo'+1 //防止重复弹出
                ,title:"错误"
                ,content: '<div style="padding: 20px 100px;">'+ msg +'</div>'
                ,btn: '关闭'
                ,btnAlign: 'c' //按钮居中
                ,shade: 0 //不显示遮罩
                ,yes: function(){
                    layer.closeAll();
                }
            });
        }
    });
    function onCheckCode () {
        var date = new Date();
        $("#checkcode").attr("src", "kaptcha?d="+date);
    }

</script>
</body>
</html>
