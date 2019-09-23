<%--
  User: Carlson
  Date: 2019/4/19
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>老师页面</title>

    <link rel="stylesheet" href="../../static/css/bootstrap.css">
    <link rel="stylesheet" href="../../static/css/teacher.css">
</head>
<body class="col-md-10 col-sm-offset-1" style="background-color:#84AF9B;">
<nav class="scrollspy-nav" data-am-scrollspynav="{offsetTop: 45}" data-am-sticky style="font-size: 17px">
    <ul>
        <li><a href="#" onclick="teaHome()">欢迎老师：${teacherMsg.tcName}</a></li>
        <li><a href="#" onclick="teaHome()">首页</a></li>
        <li id="teaMsgA"><a href="#student">个人信息</a></li>
        <c:if test="${clasMsg != null}">
            <li><a href="#" onclick="investigateGet(${clasMsg.claId})">班级考勤</a></li>
            <li><a href="#" onclick="investigateEdit(${teacherMsg.tno},1)">考勤管理</a></li>
        </c:if>
        <li><a href="#" onclick="teaScoreManege(${teacherMsg.tno},1)">学生成绩管理</a></li>
        <li><a href="#" onclick="getCommunication(${teacherMsg.tno},1)">留言信息</a></li>
        <li><a href="#" onclick="teaUpdate(${teacherMsg.tno})">个人信息修改</a></li>
        <li><a href="/loginOut">退出</a></li>
    </ul>
</nav>

<div class="am-panel am-panel-primary" id="DataMsg">

</div>

<div id="PreDataMsg">

    <div class="am-panel am-panel-default">
        <div class="am-panel-hd">学校信息</div>
        <div class="am-panel-bd">
            <div data-am-widget="slider" class="am-slider am-slider-c3" data-am-slider='{"controlNav":false}' >
                <ul class="am-slides">
                    <li>
                        <img src="../../static/img/schoolA.jpg">
                        <div class="am-slider-desc"><div class="am-slider-counter"><span class="am-active">1</span>/4</div>学校百年文化,以“科学 民主 求真 创新”为校训</div>

                    </li>
                    <li>
                        <img src="../../static/img/schoolB.jpg">
                        <div class="am-slider-desc"><div class="am-slider-counter"><span class="am-active">2</span>/4</div>有“三宽 四自”的教育理念 ，“丰富 善良 理性 高贵”的核心品质</div>

                    </li>
                    <li>
                        <img src="../../static/img/schoolC.jpg">
                        <div class="am-slider-desc"><div class="am-slider-counter"><span class="am-active">3</span>/4</div>以“四高五强”作为育人目标，创造条件，把握机会，砥砺前行!</div>

                    </li>
                    <li>
                        <img src="../../static/img/schoolD.jpg">
                        <div class="am-slider-desc"><div class="am-slider-counter"><span class="am-active">4</span>/4</div>学校名师荟萃 ，高考成绩始终名列全省前茅</div>

                    </li>
                </ul>
            </div>

        </div>
    </div>

    <hr data-am-widget="divider" style="color: #0a628f" class="am-divider am-divider-dotted" />

    <div class="am-panel am-panel-secondary" id="student">
        <div class="am-panel-hd">${teacherMsg.tcName} 个人信息：</div>
        <div class="am-panel-bd" style="height: 350px">
            <c:if test="${teacherMsg.tcPicture == null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="http://localhost:8080/file/image?imageName=defaultImage.jpg" alt="还没头像照片哦" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <c:if test="${teacherMsg.tcPicture != null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="${teacherMsg.tcPicture}" alt="头像照片" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <div style="height: 80px;"></div>
            <ul class="col-md-3" style="list-style-type: none">
                <li><i class="am-icon-dot-circle-o am-icon-fw"></i> 教师工号：${teacherMsg.tno}</li>
                <li><i class="am-icon-user-secret am-icon-fw"></i> 教师姓名：${teacherMsg.tcName}</li>
                <li><i class="am-icon-venus-mars am-icon-fw"></i> 性别：${teacherMsg.tcSex}</li>
                <li><i class="am-icon-calendar am-icon-fw"></i> 年龄：${teacherMsg.tcAge}   </li>
                <li><i class="am-icon-envelope-square am-icon-fw"></i> 邮箱：${teacherMsg.tcEmail}   </li>
                <li><i class="am-icon-phone-square am-icon-fw"></i> 电话：${teacherMsg.tcPhone}   </li>
            </ul>
        </div>
    </div>

    <hr data-am-widget="divider" style="color: #0a6999" class="am-divider am-divider-dotted" />

</div>



<script src="../../static/js/jquery-3.3.1.min.js"></script>
<script src="../../static/js/bootstrap.min.js"></script>
<script src="../../static/js/pageJs/teacher.js"></script>
<script src="../../static/js/pageJs/upindex.js"></script>
<script src="../../static/js/pageJs/communication.js"></script>
<script src="../../static/amazeUI/js/amazeui.js"></script>
<link rel="stylesheet" href="../../static/amazeUI/css/amazeui.css"/>
<link rel="stylesheet" href="../../static/layui/css/layui.css"/>
<script type="text/javascript" src="../../static/layui/layui.all.js"></script>
<script type="text/javascript" src="../../static/layui/layui.js"></script>

<link rel="stylesheet" href="../../static/css/bootstrap.min.css">
</body>
</html>
