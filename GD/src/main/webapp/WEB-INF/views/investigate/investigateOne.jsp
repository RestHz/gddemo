<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<div class="container col-md-12" style="font-size: 20px">
    <div class="am-panel am-panel-default" data-am-scrollspy="{animation:'scale-down', delay: 300}">
        <div class="am-panel-hd col-md-12">考勤统计</div>
        <div class="am-panel-bd">
            <div class="am-tabs" data-am-tabs="{noSwipe: 1}" id="doc-tab-demo-1">
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active"><a href="javascript: void(0)">周统计</a></li>
                    <li><a href="javascript: void(0)">月统计</a></li>
                    <li><a href="javascript: void(0)">上学期统计</a></li>
                    <li><a href="javascript: void(0)">下学期统计</a></li>
                </ul>

                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-active">
                        <c:forEach items="${InvStaByWeek}" var="staWeek" end="0">
                            <c:if test="${InvStaByWeek == null or staWeek == null}">
                                没有统计数据
                            </c:if>
                            <c:if test="${staWeek != null}">
                                <table class="table table-hover" style="font-size: 20px">
                                    <thead>
                                    <tr class="info">
                                        <td>学生姓名</td>
                                        <td>周次/第几周</td>
                                        <td>情况</td>
                                        <td>次数</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${InvStaByWeek}" var="staWeek">
                                        <tr class="active">
                                            <td>${staWeek.stuName}</td>
                                            <td>${staWeek.staTime}</td>
                                            <td>${staWeek.situation}</td>
                                            <td>${staWeek.staData}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="am-tab-panel">
                        <c:forEach items="${InvStaByMonth}" var="staMonth" end="0">
                            <c:if test="${InvStaByMonth == null or staMonth == null}">
                                没有统计数据
                            </c:if>
                            <c:if test="${staMonth != null}">
                                <table class="table table-hover">
                                    <thead>
                                    <tr class="info">
                                        <td>学生姓名</td>
                                        <td>月份/第几月</td>
                                        <td>情况</td>
                                        <td>次数</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${InvStaByMonth}" var="staMonth">
                                        <tr class="active">
                                            <td>${staMonth.stuName}</td>
                                            <td>${staMonth.staTime}</td>
                                            <td>${staMonth.situation}</td>
                                            <td>${staMonth.staData}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="am-tab-panel">
                        <c:forEach items="${InvStaByLastTerm}" var="staLastTerm" end="0">
                            <c:if test="${InvStaByLastTerm == null or staLastTerm == null}">
                                没有统计数据
                            </c:if>
                            <c:if test="${staLastTerm != null}">
                                <table class="table table-hover" style="font-size: 20px">
                                    <thead>
                                    <tr class="info">
                                        <td>学生姓名</td>
                                        <td>学年</td>
                                        <td>上学期</td>
                                        <td>情况</td>
                                        <td>次数</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${InvStaByLastTerm}" var="staLastTerm">
                                        <tr class="active">
                                            <td>${staLastTerm.stuName}</td>
                                            <td>${InvStatistic.examYear}</td>
                                            <td>上学期</td>
                                            <td>${staLastTerm.situation}</td>
                                            <td>${staLastTerm.staData}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="am-tab-panel">
                        <c:forEach items="${InvStaByNextTerm}" var="staNextTerm" end="0">
                            <c:if test="${InvStaByNextTerm == null or staNextTerm == null}">
                                没有统计数据
                            </c:if>
                            <c:if test="${staNextTerm != null}">
                                <table class="table table-hover" style="font-size: 20px">
                                    <thead>
                                    <tr class="info">
                                        <td>学生姓名</td>
                                        <td>学年</td>
                                        <td>下学期</td>
                                        <td>情况</td>
                                        <td>次数</td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${InvStaByNextTerm}" var="staNextTerm">
                                        <tr class="active">
                                            <td>${staNextTerm.stuName}</td>
                                            <td>${InvStatistic.examYear}</td>
                                            <td>下学期</td>
                                            <td>${staNextTerm.situation}</td>
                                            <td>${staNextTerm.staData}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="am-panel am-panel-success" data-am-scrollspy="{animation:'scale-up', delay: 300}">

        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="invEdit_table" style="font-size: 20px">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>班级</th>
                        <th>时间</th>
                        <th>情况</th>
                        <th>考勤老师</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${Investigate}" var="item">
                        <tr>
                            <td>${item.sno}</td>
                            <td>${item.stuName}</td>
                            <td>${item.claName}</td>
                            <td>${item.addTime}</td>
                            <td>${item.situation}</td>
                            <td>${item.tcName}</td>
                            <td>
                                <button class="btn btn-info btn-sm inv_detail_btn" value="${item.invId}">
                                    <span class="glyphicon glyphicon-check">详情</span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${InvestigateIsEmpty != null}">
                    <label style="color: green">${InvestigateIsEmpty}</label>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 考勤查看视图 -->
    <div class="am-popup" id="stuInvCheckModel">
        <div class="am-popup-inner">
            <div class="am-popup-hd">
                <h4 class="am-popup-title">考勤详情</h4>
                <span data-am-modal-close
                      class="am-close">&times;</span>
            </div>
            <div class="am-popup-bd">
                <div style="height: 50px"></div>
                <form id="invCheckMsgForm" class="form-horizontal col-md-offset-2">
                    <input id="invIdCheck" name="invId" type="hidden">
                    <div class="form-group has-success">
                        <label class="col-sm-2 control-label">学号:</label>
                        <div class="col-sm-6">
                            <input id="snoCheck" name="sno" type="text" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学生姓名:</label>
                        <div class="col-sm-6">
                            <input id="stuNameCheck" name="stuName" type="text" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">班级:</label>
                        <div class="col-sm-6">
                            <input id="claNameCheck" name="claName" type="text" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">情况:</label>
                        <div class="col-sm-6">
                            <select id="situationCheck" name="situation" class="form-control" style="background-color: rgb(242, 242, 242);">
                                <option value="迟到">迟到</option>
                                <option value="旷课">旷课</option>
                                <option value="请假">请假</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">备注:</label>
                        <div class="col-sm-6">
                            <textarea id="remarkCheck" name="remark" class="form-control" rows="3" style="background-color: rgb(242, 242, 242);" readonly></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">考勤教师:</label>
                        <div class="col-sm-6">
                            <input id="tcNameCheck" name="tcName" type="text" class="form-control" readonly>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>



</div>

<script src="../../../static/js/pageJs/investigateOne.js"></script>
<link rel="stylesheet" href="../../../static/css/bootstrap.min.css"/>

