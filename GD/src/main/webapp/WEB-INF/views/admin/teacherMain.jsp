<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<div class="container" style="font-size: 20px">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h3>老师信息管理</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-6 col-md-offset-7" style="font-size: 20px">
            <input style="height: 30px" type="text" placeholder="请输入需要查询的信息" id="needTeaMsg">
            <select style="height: 30px" id="selTeaMsgType">
                <option value="1">工号查询</option>
                <option value="2">姓名查询</option>
                <option value="3">性别查询</option>
                <option value="4">所授课程</option>
                <option value="0">模糊查询</option>
            </select>
            <button class="btn btn-light" onclick="getTeaSelectMsg(1)" style="font-size: 15px">查询</button>
            <button type="button" class="btn btn-primary" onclick="teacherAddModel()" style="font-size: 15px">新增</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="tea_table" style="font-size: 20px">
                <thead>
                <tr>
                    <th>工号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>邮箱</th>
                    <th>电话</th>
                    <th>所授课程</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${Teacher.msgContent.pageInfo.list}" var="item">
                        <tr>
                            <td>${item.tno}</td>
                            <td>${item.tcName}</td>
                            <td>${item.tcSex}</td>
                            <td>${item.tcAge}</td>
                            <td>${item.tcEmail}</td>
                            <td>${item.tcPhone}</td>
                            <td>${item.cno}</td>
                            <td>
                                <button class="btn btn-info btn-sm tea_edit_btn"  value="${item.tno}" style="font-size: 15px">
                                    <span class="glyphicon glyphicon-pencil">修改</span>
                                </button>&nbsp;
                                <button class="btn btn-danger btn-sm tea_delete_btn" value="${item.tno}" style="font-size: 15px">
                                    <span class="glyphicon glyphicon-trash">删除</span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${Teacher.msgContent.pageInfo.list == null}">
                <label style="color: blue">${Teacher.msgContent.Fail}</label>
            </c:if>
        </div>
    </div>
<br>

    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info" style="font-size: 20px">
            <label>当前第<span id="currentPage">${Teacher.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Teacher.msgContent.pageInfo.pages}页, 总共
                ${Teacher.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info" style="font-size: 20px">
            <ul class="pagination">
                <c:if test="${Teacher.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Teacher.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="getTeaPage(1)"><a href="#">首页</a></li>
                    <li onclick="getTeaPage(${Teacher.msgContent.pageInfo.pageNum}-1)"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Teacher.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Teacher.msgContent.pageInfo.pageNum == item}">
                        <li onclick="getTeaPage(${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Teacher.msgContent.pageInfo.pageNum != item}">
                        <li onclick="getTeaPage(${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Teacher.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Teacher.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="getTeaPage(${Teacher.msgContent.pageInfo.pageNum}+1)"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="getTeaPage(${Teacher.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>



