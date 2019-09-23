<%--
  User: Carlson
  Date: 2019/4/17
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
<div class="col-md-10">


    <c:if test="${Fail != null}">
        ${Fail}
    </c:if>

    <c:if test="${Schedule != null}">
        <c:forEach items="${YearTerms}" var="yearterm" varStatus="status">

            <div class="am-panel-group" id="accordion">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd">
                        <h4 class="am-panel-title" data-am-collapse="{parent: '#accordion', target: '#${yearterm.examYear}${yearterm.examTerm}'}">
                            <i class="am-icon-table am-margin-left-sm"></i> ${yearterm.examYear}学年，${yearterm.examTerm}，${Clas.claName}班课表 <i class="am-icon-angle-right am-fr am-margin-right"></i>
                        </h4>
                    </div>
                    <c:if test="${status == 0}">
                        <div id="${yearterm.examYear}${yearterm.examTerm}" class="am-panel-collapse am-collapse am-in">
                    </c:if>
                    <c:if test="${status != 0}">
                        <div id="${yearterm.examYear}${yearterm.examTerm}" class="am-panel-collapse am-collapse">
                    </c:if>
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
                                <c:forEach items="${Schedule}" var="item">
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
                                        此课表为：${yearterm.examYear}学年，${yearterm.examTerm}，${Clas.claName}班课表
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
--%>
<c:forEach items="${Schedule}" var="schedule">
    ${schedule.week}
</c:forEach>

