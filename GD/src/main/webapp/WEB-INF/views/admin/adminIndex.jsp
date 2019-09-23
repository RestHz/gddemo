<%--
  Created by IntelliJ IDEA.
  User: HZ
  Date: 2019/3/13
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员页面</title>
</head>
<body>
<label>${adminMsg.getName()}</label><br>
<a href="/loginOut">退出</a>
<%--学生页面模态框--%>
<!-- 学生新增视图 -->
<div class="modal fade" id="stuAddModel" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生信息添加</h4>
            </div>
            <form id="studentMsgAddForm" class="form-horizontal">
                <div class="form-group has-success">
                    <label class="col-sm-2 control-label">学号:</label>
                    <div class="col-sm-6">
                        <input id="accountAdd" name="sno" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓名:</label>
                    <div class="col-sm-6">
                        <input id="stuNameAdd" name="stuName" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">密码:</label>
                    <div class="col-sm-6">
                        <input id="stuPasswordAdd" name="stuPwd" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别:</label>
                    <div class="col-sm-6">
                        <input id="stuSexAdd" name="stuSex" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年龄:</label>
                    <div class="col-sm-6">
                        <input id="stuAgeAdd" name="stuAge" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">邮箱:</label>
                    <div class="col-sm-6">
                        <input id="stuEmailAdd" name="stuEmail" type="email" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学生电话:</label>
                    <div class="col-sm-6">
                        <input id="stuPhoAdd" name="stuPhone" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学生住址:</label>
                    <div class="col-sm-6">
                        <input id="stuAddressAdd" name="stuAddress" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年级:</label>
                    <div class="col-sm-6">
                        <input id="gradeAdd" name="grade" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">班级:</label>
                    <div class="col-sm-6">
                        <select id="clasListAdd"  name="claId"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">课程:</label>
                    <div class="col-sm-6">
                        <select id="courseListAdd"  name="cno"></select>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="confirmAddStu()">添加</button>
            </div>
        </div>
    </div>
</div>

<!-- 学生编辑视图 -->
<div class="modal fade" id="stuUpdateModel" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生信息修改</h4>
            </div>
            <form id="studentMsgAlterForm" class="form-horizontal">
                <div class="form-group has-success">
                    <label class="col-sm-2 control-label">学号:</label>
                    <div class="col-sm-6">
                        <input id="account" name="sno" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓名:</label>
                    <div class="col-sm-6">
                        <input id="stuName" name="stuName" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">密码:</label>
                    <div class="col-sm-6">
                        <input id="stuPassword" name="stuPwd" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别:</label>
                    <div class="col-sm-6">
                        <input id="stuSex" name="stuSex" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年龄:</label>
                    <div class="col-sm-6">
                        <input id="stuAge" name="stuAge" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">邮箱:</label>
                    <div class="col-sm-6">
                        <input id="stuEmail" name="stuEmail" type="email" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学生电话:</label>
                    <div class="col-sm-6">
                        <input id="stuPho" name="stuPhone" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学生住址:</label>
                    <div class="col-sm-6">
                        <input id="stuAddress" name="stuAddress" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年级:</label>
                    <div class="col-sm-6">
                        <input id="grade" name="grade" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">班级:</label>
                    <div class="col-sm-6">
                        <select id="clasList"  name="claId"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">课程:</label>
                    <div class="col-sm-6">
                        <select id="courseList"  name="cno"></select>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="confirmAlterStu()">修改</button>
            </div>
        </div>
    </div>
</div>


<%--老师页面模态框--%>
<!-- 老师修改视图 -->
<div id="teaEditTab">
    <div class="modal fade" id="teaUpdateModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">老师信息修改</h4>
                </div>
                <form id="teacherMsgAlterForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">工号:</label>
                        <div class="col-sm-6">
                            <input id="teaAccount" name="tno" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名:</label>
                        <div class="col-sm-6">
                            <input id="teaName" name="tcName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-6">
                            <input id="teaPassword" name="tcPwd" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-6">
                            <input id="teaSex" name="tcSex" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄:</label>
                        <div class="col-sm-6">
                            <input id="teaAge" name="tcAge" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-6">
                            <input id="teaEmail" name="tcEmail" type="email" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">老师电话:</label>
                        <div class="col-sm-6">
                            <input id="teaPho" name="tcPhone" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所授课程:</label>
                        <div class="col-sm-6">
                            <select id="teaCourseList"  name="cno"></select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAlterTea()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 老师新增视图 -->
<div id="teaAddTab">
    <div class="modal fade" id="teaAddModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">老师信息新增</h4>
                </div>
                <form id="teacherAddMsgForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">工号:</label>
                        <div class="col-sm-6">
                            <input id="teaAccountAdd" name="tno" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名:</label>
                        <div class="col-sm-6">
                            <input id="teaNameAdd" name="tcName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码:</label>
                        <div class="col-sm-6">
                            <input id="teaPasswordAdd" name="tcPwd" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-6">
                            <input id="teaSexAdd" name="tcSex" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄:</label>
                        <div class="col-sm-6">
                            <input id="teaAgeAdd" name="tcAge" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-6">
                            <input id="teaEmailAdd" name="tcEmail" type="email" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">老师电话:</label>
                        <div class="col-sm-6">
                            <input id="teaPhoAdd" name="tcPhone" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所授课程:</label>
                        <div class="col-sm-6">
                            <select id="teaCourseListAdd"  name="cno"></select>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAddTea()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>


<%--课程页面模态框--%>
<!-- 课程修改视图 -->
<div id="couEditTab">
    <div class="modal fade" id="couUpdateModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">课程信息修改</h4>
                </div>
                <form id="courseMsgAlterForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">课程号:</label>
                        <div class="col-sm-6">
                            <input id="couAccount" name="cno" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课程名:</label>
                        <div class="col-sm-6">
                            <input id="couName" name="courseName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课时:</label>
                        <div class="col-sm-6">
                            <input id="couTime" name="courseTime" type="text" class="form-control">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAlterCou()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 课程新增视图 -->
<div id="couAddTab">
    <div class="modal fade" id="couAddModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">课程信息新增</h4>
                </div>
                <form id="courseAddMsgForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">课程号:</label>
                        <div class="col-sm-6">
                            <input id="couAccountAdd" name="cno" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课程名:</label>
                        <div class="col-sm-6">
                            <input id="couNameAdd" name="courseName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课时:</label>
                        <div class="col-sm-6">
                            <input id="couTimeAdd" name="courseTime" type="text" class="form-control">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAddCou()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>


<%--成绩页面模态框--%>
<!-- 成绩修改视图 -->
<div id="scoEditTab">
    <div class="modal fade" id="scoUpdateModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">成绩信息修改</h4>
                </div>
                <form id="scoreMsgAlterForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">学年:</label>
                        <div class="col-sm-6">
                            <input id="eaxmYearId" name="eaxmYear" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学期:</label>
                        <div class="col-sm-6">
                            <input id="examTermId" name="examTerm" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课程名:</label>
                        <div class="col-sm-6">
                            <input id="courseNameId" name="courseName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">班级名:</label>
                        <div class="col-sm-6">
                            <input id="claNameId" name="claName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考生名:</label>
                        <div class="col-sm-6">
                            <input id="stuNameId" name="stuName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考试成绩:</label>
                        <div class="col-sm-6">
                            <input id="examScoreId" name="examScore" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考试时间:</label>
                        <div class="col-sm-6">
                            <input id="examTimeId" name="examTime" type="text" class="form-control">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAlterSco()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 成绩新增视图 -->
<div id="scoAddTab">
    <div class="modal fade" id="scoAddModel" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">成绩信息新增</h4>
                </div>
                <form id="scoreAddMsgForm" class="form-horizontal">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">学年:</label>
                        <div class="col-sm-6">
                            <input id="eaxmYearAdd" name="examYear" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学期:</label>
                        <div class="col-sm-6">
                            <input id="examTermAdd" name="examTerm" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课程名:</label>
                        <div class="col-sm-6">
                            <input id="courseNameAdd" name="courseName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">班级名:</label>
                        <div class="col-sm-6">
                            <input id="claNameAdd" name="claName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考生名:</label>
                        <div class="col-sm-6">
                            <input id="stuScoreNameAdd" name="stuName" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考试成绩:</label>
                        <div class="col-sm-6">
                            <input id="examScoreAdd" name="examScore" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考试时间:</label>
                        <div class="col-sm-6">
                            <input id="examTimeAdd" name="examTime" type="text" class="form-control">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirmAddSco()">更新</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>学生家校联系系统管理页面</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-5 col-md-offset-8">
            <button class="btn btn-primary" onclick="getStudent(1)">学生信息</button>
            <button class="btn btn-primary" onclick="getTeacher(1)">老师信息</button>
            <button class="btn btn-primary" onclick="getCourse(1)">课程信息</button>
            <button class="btn btn-primary" onclick="getScore(1)">成绩信息</button>
            <button class="btn btn-primary" onclick="getSchedule(1)">课表信息</button>
        </div>
    </div>
    <div id="DataMsg" style="width: 600px;height: 400px">
        <div id="loading">
            <img style="width: 600px;height: 400px" src="http://localhost:8080/file/image?imageName=loading.gif">
        </div>
    </div>



</div>

<label>下载学生信息:</label><a href="/studentAllMsg">下载</a><br>
<%--引入Jquery--%>
<script src="../../../static/js/jquery-3.3.1.min.js"></script>
<%--引入Bootstrap--%>
<link rel="stylesheet" href="../../../static/css/bootstrap.min.css"/>
<script src="../../../static/js/bootstrap.min.js"></script>
<script src="../../../static/js/pageJs/adminIndex.js"></script>
<script src="../../../static/js/pageJs/studentMain.js"></script>
<script src="../../../static/js/pageJs/teacherMain.js"></script>
<script src="../../../static/js/pageJs/courseMain.js"></script>
<script src="../../../static/js/pageJs/scoreMain.js"></script>
<script src="../../../static/js/pageJs/scheduleMain.js"></script>
</body>
</html>
