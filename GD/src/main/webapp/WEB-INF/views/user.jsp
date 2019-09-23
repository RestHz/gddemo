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
    <title>用户页面</title>
    <link rel="stylesheet" href="../../static/css/bootstrap.css">
    <link rel="stylesheet" href="../../static/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/layui/css/layui.css">
</head>
<body class="col-md-10 col-sm-offset-1" style="background-color:#9eb4cb;">

<nav class="scrollspy-nav" data-am-scrollspynav="{offsetTop: 45}" data-am-sticky style="font-size: 17px">
    <ul>
        <li><a href="#" onclick="userHome()">欢迎‘${studentMsg.stuName}’家长：${userMsg.userName}</a></li>
        <li><a href="#" onclick="userHome()">首页</a></li>
        <li id="userMsgA"><a href="#parent">个人信息</a></li>
        <li id="userStuScoreA"><a href="#second">成绩</a></li>
        <li><a href="#" onclick="userUpdate(${userMsg.account})">个人信息修改</a></li>
        <li><a href="#" onclick="stuInvMsg(${studentMsg.sno})">${studentMsg.stuName}考勤信息</a></li>
        <li><a href="#" onclick="getCommunication(${userMsg.account},1)">留言</a></li>
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

    <div class="am-panel am-panel-secondary" id="parent">
        <div class="am-panel-hd">${userMsg.userName} 个人信息：</div>
        <div class="am-panel-bd" style="height: 300px">
            <c:if test="${userMsg.userPicture == null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="http://localhost:8080/file/image?imageName=defaultImage.jpg" alt="还没头像照片哦" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <c:if test="${userMsg.userPicture != null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="${userMsg.userPicture}" alt="头像照片" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <ul class="col-md-3" style="list-style-type: none">
                <li><i class="am-icon-dot-circle-o am-icon-fw"></i> 个人账号：${userMsg.account}</li>
                <li><i class="am-icon-user-secret am-icon-fw"></i> 用户姓名：${userMsg.userName}</li>
                <li><i class="am-icon-venus-mars am-icon-fw"></i> 性别：${userMsg.userSex}</li>
                <li><i class="am-icon-calendar am-icon-fw"></i> 年龄：${userMsg.userAge}   </li>
                <li><i class="am-icon-envelope-square am-icon-fw"></i> 邮箱：${userMsg.userEmail}   </li>
                <li><i class="am-icon-phone-square am-icon-fw"></i> 电话：${userMsg.userPhone}   </li>
                <li><i class="am-icon-map am-icon-fw"></i> 住址：${userMsg.address}   </li>
                <li><i class="am-icon-home am-icon-fw"></i> 与学生关系：${userMsg.relation}   </li>
            </ul>
        </div>
    </div>

    <hr data-am-widget="divider" style="color: #0a628f" class="am-divider am-divider-dotted" />

    <div class="am-panel am-panel-secondary" id="student">
        <div class="am-panel-hd">${studentMsg.stuName} 学生信息：</div>
        <div class="am-panel-bd" style="height: 300px">
            <c:if test="${studentMsg.stuPicture == null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="http://localhost:8080/file/image?imageName=defaultImage.jpg" alt="还没头像照片哦" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <c:if test="${studentMsg.stuPicture != null}">
                <div class="col-md-3 col-md-offset-1">
                    <img src="${studentMsg.stuPicture}" alt="头像照片" class="am-circle" width="140" height="140">
                </div>
            </c:if>
            <ul class="col-md-3" style="list-style-type: none">
                <li><i class="am-icon-dot-circle-o am-icon-fw"></i> 学生学号：${studentMsg.sno}</li>
                <li><i class="am-icon-user-secret am-icon-fw"></i> 学生姓名：${studentMsg.stuName}</li>
                <li><i class="am-icon-venus-mars am-icon-fw"></i> 学生性别：${studentMsg.stuSex}</li>
                <li><i class="am-icon-calendar am-icon-fw"></i> 学生年龄：${studentMsg.stuAge}   </li>
                <li><i class="am-icon-envelope-square am-icon-fw"></i> 学生邮箱：${studentMsg.stuEmail}   </li>
                <li><i class="am-icon-phone-square am-icon-fw"></i> 学生电话：${studentMsg.stuPhone}   </li>
                <li><i class="am-icon-map am-icon-fw"></i> 学生住址：${studentMsg.stuAddress}   </li>
                <li><i class="am-icon-book am-icon-fw"></i> 学生年级：${studentMsg.grade}   </li>
            </ul>
        </div>
    </div>

<%--    <hr data-am-widget="divider" style="color: #0a6999" class="am-divider am-divider-dotted" />

    <div class="am-panel am-panel-default" id="">

                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                        <legend>高考倒计时&nbsp;&nbsp;
                            <div class="layui-inline">
                              <input type="text" class="layui-input" id="test1" value="2019-06-07 09:00:00">
                            </div>
                        </legend>
                    </fieldset>
                    <blockquote class="layui-elem-quote" style="margin-top: 10px;">
                        <div id="test2"></div>
                    </blockquote>

                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                    <legend>当前日期</legend>
                    </fieldset>
                    <div class="site-demo-laydate col-sm-offset-2">
                        <div class="layui-inline" id="test-n1"></div>
                    </div>

    </div>--%>

    <hr data-am-widget="divider" style="color: #0a6999" class="am-divider am-divider-dotted" />

    <div class="am-panel am-panel-default" id="second" style="font-size: 20px">
        <div class="am-panel-hd">${studentMsg.stuName} 成绩</div>
        <div class="am-panel-bd">

            <c:if test="${ExamYearTerm == null}">
                <label style="color: blue">没有成绩信息</label>
            </c:if>
            <c:if test="${ExamYearTerm != null}">
                <c:forEach items="${ExamYearTerm}" var="yearTerm">

                    <div class="am-panel-group" id="accordion">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd">
                                <h4 class="am-panel-title" data-am-collapse="{parent: '#accordion', target: '#do-not-say-1'}">
                                        ${yearTerm.examYear}学年，${yearTerm.examTerm}：学生成绩 <i class="am-icon-angle-right am-fr am-margin-right"></i>
                                </h4>
                            </div>
                            <div id="do-not-say-1" class="am-panel-collapse am-collapse am-in">
                                <div class="am-panel-bd">
                                    <table class="table table-hover">

                                        <tr class="danger">
                                            <c:forEach items="${ScoreMsg}" var="score">
                                                <c:if test="${score.examYear == yearTerm.examYear and score.examTerm == yearTerm.examTerm}">
                                                    <th>${score.courseName}</th>
                                                </c:if>
                                            </c:forEach>
                                        </tr>
                                        <tr class="active">
                                            <c:forEach items="${ScoreMsg}" var="score">
                                                <c:if test="${score.examYear == yearTerm.examYear and score.examTerm == yearTerm.examTerm}">
                                                    <td>${score.examScore}</td>
                                                </c:if>
                                            </c:forEach>
                                        </tr>
                                        <tr class="active">
                                            <c:forEach items="${ScoreMsg}" var="score" end="0">
                                                <c:if test="${score.examYear == yearTerm.examYear and score.examTerm == yearTerm.examTerm}">
                                                    <c:forEach items="${StuStatistic}" var="stuScore">
                                                        <td colspan="9" style="color: red">个人成绩统计: &nbsp;&nbsp;&nbsp; 总成绩: ${stuScore.staMaxData}分 &nbsp;&nbsp;&nbsp; 个人平均分: ${stuScore.staAvgData}分</td>
                                                    </c:forEach>
                                                </c:if>
                                            </c:forEach>
                                        </tr>
                                    </table>
                                    <table class="table table-hover">
                                        <thead>
                                        <tr class="info"><th colspan="3">班级单科成绩统计</th></tr>
                                        <tr>
                                            <td>课程名</td>
                                            <td>班级最高分</td>
                                            <td>班级平均分</td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${Statistic}" var="score">
                                            <tr class="active">
                                                <td>${score.staName}</td>
                                                <td>${score.staMaxData}</td>
                                                <td>${score.staAvgData}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:forEach>
            </c:if>
        </div>
    </div>

    <hr data-am-widget="divider" style="" class="am-divider am-divider-dashed" />

    <div class="am-panel am-panel-success">
        <div class="am-panel-hd">学生班级课表</div>
        <div class="am-panel-bd">
                <c:if test="${Fail != null}">
                    ${Fail}
                </c:if>

                <c:if test="${ScheduleMsg != null}">
                <c:forEach items="${YearTermsMsg}" var="yearterm" varStatus="status">

                <div class="am-panel-group" id="accordion">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-hd">
                            <h4 class="am-panel-title" data-am-collapse="{parent: '#accordion', target: '#${yearterm.examYear}${yearterm.examTerm}'}">
                                <i class="am-icon-table am-margin-left-sm"></i> ${yearterm.examYear}学年，${yearterm.examTerm}，${ClassMsg.claName}班课表 <i class="am-icon-angle-right am-fr am-margin-right"></i>
                            </h4>
                        </div>
                        <div id="${yearterm.examYear}${yearterm.examTerm}" class="am-panel-collapse am-collapse am-in">
                                <div class="am-panel-bd">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr class="danger">
                                            <th>时间/星期</th>
                                            <th>第一节课</th>
                                            <th>第二节课</th>
                                            <th>第三节课</th>
                                            <th>第四节课</th>
                                            <th>第五节课</th>
                                            <th>第六节课</th>
                                            <th>第七节课</th>
                                            <th>第八节课</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${ScheduleMsg}" var="item">
                                            <c:if test="${yearterm.examYear == item.examYear and yearterm.examTerm == item.examTerm}">
                                                <tr class="active">
                                                    <td>${item.week}</td>
                                                    <td>${item.firstLesson}</td>
                                                    <td>${item.secondLesson}</td>
                                                    <td>${item.thirdLesson}</td>
                                                    <td>${item.fourthLesson}</td>
                                                    <td>${item.fifthLesson}</td>
                                                    <td>${item.sixthLesson}</td>
                                                    <td>${item.seventhLesson}</td>
                                                    <td>${item.eighthLesson}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                        <tr class="info">
                                            <td colspan="9">
                                                此课表为：${yearterm.examYear}学年，${yearterm.examTerm}，${ClassMsg.claName}班课表
                                            </td>
                                        </tr>

                                        </tbody>

                                    </table>
                                </div>
                            </div>

                    </div>
                </div>
                </c:forEach>
                </c:if>
        </div>
    </div>
</div>

    <hr data-am-widget="divider" style="" class="am-divider am-divider-dashed" />


<script src="../../static/js/jquery-3.3.1.min.js"></script>
<script src="../../static/js/bootstrap.min.js"></script>
<script src="../../static/js/pageJs/user.js"></script>
<link rel="stylesheet" href="../../static/css/user.css"/>
<script src="../../static/js/pageJs/upindex.js"></script>
<script src="../../static/js/pageJs/communication.js"></script>
<script src="../../static/amazeUI/js/amazeui.js"></script>
<link rel="stylesheet" href="../../static/amazeUI/css/amazeui.css"/>
<script type="text/javascript" src="../../static/layui/layui.js"></script>
<script>
    layui.use(['util', 'laydate', 'layer'], function(){
        var util = layui.util
            ,laydate = layui.laydate
            ,layer = layui.layer;

        //倒计时
        var thisTimer, setCountdown = function(y, M, d, H, m, s){
            var endTime = new Date(y, M||0, d||1, H||0, m||0, s||0) //结束日期
                ,serverTime = new Date(); //假设为当前服务器时间，这里采用的是本地时间，实际使用一般是取服务端的

            clearTimeout(thisTimer);
            util.countdown(endTime, serverTime, function(date, serverTime, timer){
                var str = date[0] + '天' + date[1] + '时' +  date[2] + '分' + date[3] + '秒';
                lay('#test2').html(str);
                thisTimer = timer;
            });
        };
        setCountdown(2019,6-1,7,9,0,0);

        laydate.render({
            elem: '#test1'
            ,type: 'datetime'
            ,done: function(value, date){
                setCountdown(date.year, date.month - 1, date.date, date.hours, date.minutes, date.seconds);
            }
        });

        laydate.render({
            elem: '#test3'
            ,type: 'datetime'
            ,done: function(value, date){
                setTimeAgo(date.year, date.month - 1, date.date, date.hours, date.minutes, date.seconds);
            }
        });
        laydate.render({
            elem: '#test-n1'
            ,position: 'static'
        });
    });
</script>
</body>
</html>
