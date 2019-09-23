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
            <h3>成绩信息管理</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-6 col-md-offset-7" style="font-size: 20px">
            <input style="height: 30px" type="text" placeholder="请输入需要查询的信息" id="needScoMsg">
            <select style="height: 30px" id="selScoMsgType">
                <option value="1">学年查询</option>
                <option value="2">学期查询</option>
                <option value="3">课程名查询</option>
                <option value="4">班级查询</option>
                <option value="5">学生名查询</option>
                <option value="0">模糊查询</option>
            </select>
            <button class="btn btn-light" onclick="getScoreSelectMsg(1)" style="font-size: 15px">查询</button>
        <%--    <button type="button" class="btn btn-primary" onclick="scoreAddModel()">新增</button>--%>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="sco_table" style="font-size: 20px">
                <thead>
                <tr>
                    <th>学年</th>
                    <th>学期</th>
                    <th>课程名</th>
                    <th>班级</th>
                    <th>学生姓名</th>
                    <th>考试成绩</th>
                    <th>上传时间</th>
                    <th>操作</th>
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
                        <td>
                            <button class="btn btn-info btn-sm sco_edit_btn"  value="${item.scoreId}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-pencil">修改</span>
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-danger btn-sm sco_delete_btn" value="${item.scoreId}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
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
    <div class="row" style="font-size: 20px">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info">
            <label>当前第<span id="currentPage">${Score.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Score.msgContent.pageInfo.pages}页, 总共
                ${Score.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info" style="font-size: 20px">
            <ul class="pagination">
                <c:if test="${Score.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Score.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="toScorePageMain(1)"><a href="#">首页</a></li>
                    <li onclick="toScorePageMain(${Score.msgContent.pageInfo.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Score.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Score.msgContent.pageInfo.pageNum == item}">
                        <li onclick="toScorePageMain(${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Score.msgContent.pageInfo.pageNum != item}">
                        <li onclick="toScorePageMain(${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Score.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Score.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="toScorePageMain(${Course.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="toScorePageMain(${Course.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>
<script>
    /**
     * 学生成绩分页信息
     */
    function toScorePageMain(pn) {
        //先清空上次数据
        $("#DataMsg").empty();
        $.ajax({
            url:"/scoreList/"+pn,
            type:"GET",
            data:pn,
            dataType:"html",
            success:function (result) {
                $(result).appendTo("#DataMsg");
            }
        });
    }
</script>