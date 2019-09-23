<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h3>‘${Score.msgContent.student.stuName}’同学的成绩信息</h3>
        </div>
    </div>

    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="sco_table">
                <thead>
                <tr>
                    <th>学年</th>
                    <th>学期</th>
                    <th>课程名</th>
                    <th>班级</th>
                    <th>学生姓名</th>
                    <th>考试成绩</th>
                    <th>考试时间</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${Score.msgContent.pageInfo.list}" var="item">
                    <tr>
                        <td>${item.examYear}</td>
                        <td>${item.examTerm}</td>
                        <td>${item.courseName}</td>
                        <td>${item.claName}</td>
                        <td>${item.stuName}</td>
                        <td>${item.examScore}</td>
                        <td>${item.examTime}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${Score.msgContent.pageInfo.list == null}">
                <label style="color: blue">${Score.msgContent.Fail}</label>
            </c:if>
        </div>
    </div>
    <br>

    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info">
            <label>当前第<span id="currentPage">${Score.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Score.msgContent.pageInfo.pages}页, 总共
                ${Score.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info">
            <ul class="pagination">
                <c:if test="${Score.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Score.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="stuScoreGet(${Score.msgContent.student.sno},1)"><a href="#">首页</a></li>
                    <li onclick="stuScoreGet(${Score.msgContent.student.sno},${Score.msgContent.pageInfo.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Score.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Score.msgContent.pageInfo.pageNum == item}">
                        <li onclick="stuScoreGet(${Score.msgContent.student.sno},${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Score.msgContent.pageInfo.pageNum != item}">
                        <li onclick="stuScoreGet(${Score.msgContent.student.sno},${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Score.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Score.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="stuScoreGet(${Score.msgContent.student.sno},${Course.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="stuScoreGet(${Score.msgContent.student.sno},${Course.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>
