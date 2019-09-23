<%--
  User: Carlson
  Date: 2019/4/25
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn" class="no-js">
<head>
    <meta charset="UTF-8" />

    <title>管理员主页面</title>



    <link rel="stylesheet" type="text/css" href="../../../static/css/adminTest.css" />
    <%--引入Bootstrap--%>
    <link rel="stylesheet" href="../../../static/css/bootstrap.min.css"/>


</head>
<body>

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
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学分:</label>
                        <div class="col-sm-6">
                            <input id="couCredit" name="credit" type="text" class="form-control">
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
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学分:</label>
                        <div class="col-sm-6">
                            <input id="couCreditAdd" name="credit" type="text" class="form-control">
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

<%--主页面--%>
<div id="st-container" class="st-container">

    <nav class="st-menu st-effect-11" id="menu-11">
        <h2>信息管理</h2>
        <ul>
            <li><a href="#" onclick="getStudent(1)">学生信息</a></li>
            <li><a href="#" onclick="getTeacher(1)">老师信息</a></li>
            <li><a href="#" onclick="getCourse(1)">课程信息</a></li>
            <li><a href="#" onclick="getScore(1)">成绩信息</a></li>
            <li><a href="#" onclick="getSchedule(1)">课表信息</a></li>
        </ul>
    </nav>


    <div class="st-pusher">

        <div class="st-content">
            <div class="st-content-inner">
                <div class="col-md-offset-1">
                    <label style="font-size: 35px;margin-top: 15px;margin-bottom: 20px">
                        欢迎管理员：${adminMsg.getName()}
                    </label>
                    <a class="col-sm-offset-8" href="/loginOut">退出</a>
                </div>

                <div id="st-trigger-effects" class="col-sm-offset-1">
                    <button class="btn btn-dark" data-effect="st-effect-11">信息管理</button>
                </div>

            </div>

            <div id="DataMsg" style="width: 100%;height: 70%">
                <div id="loading">
                    <img style="width: 100%;height: 70%" src="http://localhost:8080/file/image?imageName=loading.gif">
                </div>
            </div>

        </div>
    </div>



</div>









<%--引入Jquery--%>
<script src="../../../static/js/jquery-3.3.1.min.js"></script>

<script src="../../../static/js/bootstrap.min.js"></script>
<script src="../../../static/js/pageJs/adminTest.js"></script>
<script src="../../../static/js/pageJs/studentMain.js"></script>
<script src="../../../static/js/pageJs/teacherMain.js"></script>
<script src="../../../static/js/pageJs/courseMain.js"></script>
<script src="../../../static/js/pageJs/scoreMain.js"></script>
<script src="../../../static/js/pageJs/scheduleMain.js"></script>
</body>
</html>
