<%--
  User: Carlson
  Date: 2019/3/13
  Time: 14:06
  To change this tuserlate use File | Settings | File Tuserlates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--引入C标签--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户注册页面</title>
    <%--引入Jquery--%>
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <%--引入Bootstrap--%>
    <link rel="stylesheet" href="static/css/bootstrap.min.css"/>
    <script src="static/js/bootstrap.min.js"></script>
</head>
<body>

<div class="modal-header col-sm-10">
    <h4 class="modal-title">用户注册</h4>
</div>
<div class="modal-body col-sm-10">
    <form class="form-horizontal" id="userRegisterForm" method="post">
        <div class="form-group">
            <label class="col-sm-2 control-label">学号:</label>
            <div class="col-sm-6">
                <input type="text" name="sno" class="form-control" placeholder="请填写学生学号！">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">用户名:</label>
            <div class="col-sm-6">
                <input type="text" name="account" class="form-control" placeholder="请填写登录使用的用户名！">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">姓名:</label>
            <div class="col-sm-6">
                <input type="text" name="userName" class="form-control" placeholder="请填写姓名！">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>
            <div class="col-sm-6">
                <input type="password" name="userPwd" class="form-control" placeholder="Password">
            </div>
            <span class="help-block" ></span>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">确认密码:</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" placeholder="ConfirmPassword">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">关系人:</label>
            <div class="col-sm-6">
                <select id="relSel" name="relation">
                    <option value="父亲">父亲</option>
                    <option value="母亲">母亲</option>
                    <option value="亲属">亲属</option>
                </select>
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性别:</label>
            <div class="col-sm-6">
                <select id="sexSel" name="userSex">
                    <option value="男">男</option>
                    <option value="女">女</option>
                    <option value="隐私">隐私</option>
                </select>
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-6">
                <input type="text" name="userAge" class="form-control" placeholder="年龄">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">邮箱:</label>
            <div class="col-sm-6">
                <input type="email" name="userEmail" class="form-control" placeholder="Email">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">电话:</label>
            <div class="col-sm-6">
                <input type="text" name="userPhone" class="form-control" placeholder="15874003693">
            </div>
            <span class="help-block" ></span>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">请填写住址:</label>
            <div class="col-sm-6">
                <input type="text" name="address" class="form-control" placeholder="北京市朝阳区">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">验证码:</label>
            <div class="col-sm-6">
                <input type="text" name="checkCode">
                <img src="/kaptcha" id="checkcode" onclick="onCheckCode()" title="看不清换一张">
            </div>
            <span class="help-block" ></span>
        </div>
    </form>
    <div class="modal-footer">
        <button class="btn btn-default" onclick="registerUser()">提交</button>
        <button type="button" class="btn btn-primary"><a href="login.jsp" style="color: #0f0f0f">登录</a></button>
    </div>
</div>

<%--引入页面JS--%>
<script src="static/js/pageJs/register.js"></script>
</body>
</html>
