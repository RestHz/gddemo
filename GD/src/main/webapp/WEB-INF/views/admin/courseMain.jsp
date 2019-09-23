<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="font-size: 20px">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h3>课程信息管理</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-6 col-md-offset-7" style="font-size: 20px">
            <input style="height: 30px" type="text" placeholder="请输入需要查询的信息" id="needCouMsg">
            <select style="height: 30px" id="selCouMsgType">
                <option value="1">课程号查询</option>
                <option value="2">课程名查询</option>
                <option value="0">模糊查询</option>
            </select>
            <button class="btn btn-light" onclick="getCourseSelectMsg(1)" style="font-size: 15px">查询</button>
            <button type="button" class="btn btn-primary" onclick="courseAddModel()" style="font-size: 15px">新增</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="stu_table" style="font-size: 20px">
                <thead>
                <tr>
                    <th>课程号</th>
                    <th>课程名</th>
                    <th>学时</th>
                    <th>修改</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${Course.msgContent.pageInfo.list}" var="item">
                    <tr>
                        <td>${item.cno}</td>
                        <td>${item.courseName}</td>
                        <td>${item.courseTime}</td>
                        <td>
                            <button class="btn btn-info btn-sm cou_edit_btn"  value="${item.cno}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-pencil">修改</span>
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-danger btn-sm cou_delete_btn" value="${item.cno}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${Course.msgContent.pageInfo.list == null}">
                <label style="color: blue">${Course.msgContent.Fail}</label>
            </c:if>
        </div>
    </div>
    <br>

    <!--显示分页信息-->
    <div class="row" style="font-size: 20px">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info">
            <label>当前第<span id="currentPage">${Course.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Course.msgContent.pageInfo.pages}页, 总共
                ${Course.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info" style="font-size: 20px">
            <ul class="pagination">
                <c:if test="${Course.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Course.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="toCoursePage(1)"><a href="#">首页</a></li>
                    <li onclick="toCoursePage(${Course.msgContent.pageInfo.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Course.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Course.msgContent.pageInfo.pageNum == item}">
                        <li onclick="toCoursePage(${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Course.msgContent.pageInfo.pageNum != item}">
                        <li onclick="toCoursePage(${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Course.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Course.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="toCoursePage(${Course.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="toCoursePage(${Course.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>
