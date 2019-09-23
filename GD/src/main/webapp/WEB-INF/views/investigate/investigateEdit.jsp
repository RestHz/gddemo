<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="am-panel am-panel-warning">
    <div class="am-panel-hd">考勤信息</div>
    <div class="am-panel-bd">
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="invEdit_table">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>班级</th>
                        <th>时间</th>
                        <th>情况</th>
                        <th>上传者</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${Investigate.msgContent.pageInfo.list}" var="item">
                        <tr>
                            <td>${item.sno}</td>
                            <td>${item.stuName}</td>
                            <td>${item.claName}</td>
                            <td>${item.addTime}</td>
                            <td>${item.situation}</td>
                            <td>${item.tcName}</td>
                            <td>
                                <button class="btn btn-danger btn-sm inv_delete_btn" value="${item.invId}">
                                    <span class="glyphicon glyphicon-trash">删除</span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${Investigate.msgContent.pageInfo.list == null}">
                    <label style="color: green">没有考勤信息！</label>
                </c:if>
            </div>
        </div>
        <!--显示分页信息-->
        <div class="row">
            <!--分页文字信息 -->
            <div class="col-md-6" id="page_info">
                <label>当前第<span id="currentPage">${Investigate.msgContent.pageInfo.pageNum}</span>页, 总共
                    ${Investigate.msgContent.pageInfo.pages}页, 总共
                    ${Investigate.msgContent.pageInfo.total}条记录
                </label>
            </div>
            <!-- 分页条信息 -->
            <div class="col-md-6" id="nav_info">
                <ul class="pagination">
                    <c:if test="${Investigate.msgContent.pageInfo.hasPreviousPage == false}">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>
                    <c:if test="${Investigate.msgContent.pageInfo.hasPreviousPage == true}">
                        <li onclick="investigateEdit(${Tno},1)"><a href="#">首页</a></li>
                        <li onclick="investigateEdit(${Tno},${Investigate.msgContent.pageInfo.pageNum}-1)"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>

                    <c:forEach items="${Investigate.msgContent.pageInfo.navigatepageNums}" var="item">
                        <c:if test="${Investigate.msgContent.pageInfo.pageNum == item}">
                            <li id="currentInvPage" onclick="investigateEdit(${Tno},${item})" class="active"><a href="#">${item}</a></li>
                        </c:if>
                        <c:if test="${Investigate.msgContent.pageInfo.pageNum != item}">
                            <li onclick="investigateEdit(${Tno},${item})"><a href="#">${item}</a></li>
                        </c:if>
                    </c:forEach>


                    <c:if test="${Investigate.msgContent.pageInfo.hasNextPage == false}">
                        <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </c:if>
                    <c:if test="${Investigate.msgContent.pageInfo.hasNextPage == true}">
                        <li onclick="investigateEdit(${Tno},${Investigate.msgContent.pageInfo.pageNum}+1)"><a href="#"><span>&raquo;</span></a></li>
                        <li onclick="investigateEdit(${Tno},${Investigate.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="am-panel am-panel-danger" data-am-scrollspy="{animation:'scale-down', delay: 300}">
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
                            <table class="table table-hover">
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
                            <table class="table table-hover">
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
                            <table class="table table-hover">
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

<script src="../../../static/js/pageJs/investigateEdit.js"></script>


