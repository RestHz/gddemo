<%--
  User: Carlson
  Date: 2019/3/13
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>

    <%--引入Jquery--%>
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <%--引入Bootstrap--%>
    <link rel="stylesheet" href="static/css/bootstrap.min.css"/>
    <script src="static/js/bootstrap.min.js"></script>
</head>
<body>

<div class="modal-header  col-sm-10 col-sm-offset-1">
    <h4 class="modal-title" id="exampleModalLabel">登录</h4>
    <span style="color: red">${ERROR.msgContent.Fail}</span>
</div>
<div class="modal-body col-sm-10">
    <form class="form-horizontal" action="/login" method="post">
        <div class="form-group">
            <label for="empName" class="col-sm-2 control-label">账号:</label>
            <div class="col-sm-6">
                <input type="text"name="account" class="form-control" id="empName" placeholder="学号或账号">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>
            <div class="col-sm-6">
                <input name="password" type="password" class="form-control" placeholder="123456">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group" id="empSelectInput">
            <label class="col-sm-2 control-label">身份:</label>
            <div class="col-sm-6">
                <select name="role">
                    <option value="0">管理员登陆</option>
                </select>
            </div>
        </div>
        <div class="form-group" id="empTelInput">
            <label class="col-sm-2 control-label">验证码:</label>
            <div class="col-sm-6">
                <input type="text" name="checkCode">
                <img src="/kaptcha" id="checkcode" onclick="onCheckCode()" title="看不清换一张">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="modal-footer col-sm-10 col-sm-offset-1">
            <button type="submit" class="btn btn-primary">登录</button>
        </div>
    </form><br>
</div>

<%--引入页面JS--%>
<script src="static/js/pageJs/login.js"></script>
<script>
    function onCheckCode () {
        var date = new Date();
        $("#checkcode").attr("src", "kaptcha?d="+date);
    }

</script>
</body>
</html>
