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
            <h3>学生信息管理</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row" style="font-size: 20px">
        <label class="col-md-offset-2" style="font-size: 20px">下载学生信息:<a href="/studentAllMsg">下载</a></label>

        <div class="col-md-6 col-md-offset-7" style="font-size: 20px">
            <input style="height: 30px" type="text" placeholder="请输入需要查询的信息" id="needMsg">
            <select style="height: 30px" id="selMsgType">
                <option value="1">学号查询</option>
                <option value="2">姓名查询</option>
                <option value="3">性别查询</option>
                <option value="4">年级查询</option>
                <option value="5">班级查询</option>
                <option value="0">模糊查询</option>
            </select>
            <button class="btn btn-light" onclick="getSelectMsg(1)" style="font-size: 15px">查询</button>
            <button type="button" class="btn btn-primary" onclick="studentAddModel()" style="font-size: 15px">新增</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="stu_table">
                <thead style="font-size: 20px">
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>年级</th>
                    <th>班级</th>
                    <th>邮箱</th>
                    <th>电话</th>
                    <th>地址</th>
                    <th>课程</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody style="font-size: 20px">
                <c:forEach items="${Student.msgContent.pageInfo.list}" var="item">
                    <tr>
                        <td>${item.sno}</td>
                        <td>${item.stuName}</td>
                        <td>${item.stuSex}</td>
                        <td>${item.stuAge}</td>
                        <td>${item.grade}</td>
                        <td>${item.claId}</td>
                        <td>${item.stuEmail}</td>
                        <td>${item.stuPhone}</td>
                        <td>${item.stuAddress}</td>
                        <td>${item.cno}</td>
                        <td>
                            <button class="btn btn-info btn-sm stu_edit_btn"  value="${item.sno}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-pencil">修改</span>
                            </button>&nbsp;
                            <button class="btn btn-danger btn-sm stu_delete_btn" value="${item.sno}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${Student.msgContent.pageInfo.list == null}">
                <label style="color: blue">${Student.msgContent.Fail}</label>
            </c:if>
        </div>
    </div>
    <br>

    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info">
            <label>当前第<span id="currentPage">${Student.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Student.msgContent.pageInfo.pages}页, 总共
                ${Student.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info">
            <ul class="pagination">
                <c:if test="${Student.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Student.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="toStudentPage(1)"><a href="#">首页</a></li>
                    <li onclick="toStudentPage(${Student.msgContent.pageInfo.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Student.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Student.msgContent.pageInfo.pageNum == item}">
                        <li onclick="toStudentPage(${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Student.msgContent.pageInfo.pageNum != item}">
                        <li onclick="toStudentPage(${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Student.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Student.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="toStudentPage(${Student.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="toStudentPage(${Student.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>
