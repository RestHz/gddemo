
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css" rel="stylesheet">
    .modal-backdrop {
        z-index:0;
        filter: alpha(opacity=0)!important;
        opacity: 0!important;
        position: static;
    }
</style>
<div class="container" style="font-size: 20px">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h3>课表信息管理</h3>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row" style="font-size: 20px">
        <div class="col-md-6 col-md-offset-9">
            <button type="button" class="btn btn-primary"><a href="/file/scheduleModelDown" style="color: white;font-size: 15px">下载课表模板</a></button>
            <form id="scheduleMsgPostForm"  method="post" enctype="multipart/form-data">
                <label>导入课表：</label><br>
                <input type="file" name="scheduleFile">
                <input type="button" onclick="scheduleMsgPost()" value="提交" style="font-size: 15px">
            </form>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="sch_table" style="font-size: 20px">
                <thead>
                <tr>
                    <th>班级号</th>
                    <th>班级名</th>
                    <th>学年</th>
                    <th>学期</th>
                    <%--<th>查看/修改</th>--%>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${Schedule.msgContent.pageInfo.list}" var="item">
                    <tr>
                        <td>${item.claId}</td>
                        <td>
                            <c:forEach items="${Schedule.msgContent.clasList}" var="clas">
                                <c:if test="${item.claId == clas.claId}">
                                    ${clas.claName}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>${item.examYear}</td>
                        <td>${item.examTerm}</td>
                       <%-- <td>
                            <button class="btn btn-primary btn-sm sch_edit_btn"  value="${item.claId}">
                                <span class="glyphicon glyphicon-pencil">查看/修改</span>
                            </button>
                        </td>--%>
                        <td>
                            <button class="btn btn-primary btn-sm sch_delete_btn" value="${item.claId}" style="font-size: 15px">
                                <span class="glyphicon glyphicon-trash">删除</span>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${Schedule.msgContent.pageInfo.list == null}">
                <label style="color: blue">没有课表信息</label>
            </c:if>
        </div>
    </div>
    <br>

    <!--显示分页信息-->
    <div class="row" style="font-size: 20px">
        <!--分页文字信息 -->
        <div class="col-md-6" id="page_info">
            <label>当前第<span id="currentPage">${Schedule.msgContent.pageInfo.pageNum}</span>页, 总共
                ${Schedule.msgContent.pageInfo.pages}页, 总共
                ${Schedule.msgContent.pageInfo.total}条记录
            </label>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="nav_info" style="font-size: 20px">
            <ul class="pagination">
                <c:if test="${Schedule.msgContent.pageInfo.hasPreviousPage == false}">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                </c:if>
                <c:if test="${Schedule.msgContent.pageInfo.hasPreviousPage == true}">
                    <li onclick="toSchedulePage(1)"><a href="#">首页</a></li>
                    <li onclick="toSchedulePage(${Schedule.msgContent.pageInfo.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                </c:if>

                <c:forEach items="${Schedule.msgContent.pageInfo.navigatepageNums}" var="item">
                    <c:if test="${Schedule.msgContent.pageInfo.pageNum == item}">
                        <li id="currentSchPage" onclick="toSchedulePage(${item})" class="active"><a href="#">${item}</a></li>
                    </c:if>
                    <c:if test="${Schedule.msgContent.pageInfo.pageNum != item}">
                        <li onclick="toSchedulePage(${item})"><a href="#">${item}</a></li>
                    </c:if>
                </c:forEach>


                <c:if test="${Schedule.msgContent.pageInfo.hasNextPage == false}">
                    <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </c:if>
                <c:if test="${Schedule.msgContent.pageInfo.hasNextPage == true}">
                    <li onclick="toSchedulePage(${Schedule.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                    <li onclick="toSchedulePage(${Schedule.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                </c:if>
            </ul>
        </div>
    </div>

</div>




<!-- 课程修改查看视图 -->
<div id="schUpdateTab">
    <div class="modal fade bs-example-modal-lg" id="schUpdateModel" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">课程信息修改</h4>
                </div>
                <form id="scheduleUpdateMsgForm" class="form-horizontal">
                    <table style="border: 1px" class="table table-hover">
                        <thead>
                        <tr>
                            <th></th>
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
                        <tr>
                            <td><label name="week" class="form-control-static">星期一</label></td>
                            <td><input style="width: 80px" name="firstLesson" type="text"></td>
                            <td><input style="width: 80px" name="secondLesson" type="text"></td>
                            <td><input style="width: 80px" name="thirdLesson" type="text"></td>
                            <td><input style="width: 80px" name="fourthLesson" type="text"></td>
                            <td><input style="width: 80px" name="fifthLesson" type="text"></td>
                            <td><input style="width: 80px" name="sixthLesson" type="text"></td>
                            <td><input style="width: 80px" name="seventhLesson" type="text"></td>
                            <td><input style="width: 80px" name="eighthLesson" type="text"></td>
                            <td><button type="button" class="btn btn-primary" onclick="confirmAddSch()">更新</button></td>
                        </tr>
                        <tr>
                            <td>星期二</td>
                            <td><input style="width: 80px" name="firstLesson" type="text"></td>
                            <td><input style="width: 80px" name="secondLesson" type="text"></td>
                            <td><input style="width: 80px" name="thirdLesson" type="text"></td>
                            <td><input style="width: 80px" name="fourthLesson" type="text"></td>
                            <td><input style="width: 80px" name="fifthLesson" type="text"></td>
                            <td><input style="width: 80px" name="sixthLesson" type="text"></td>
                            <td><input style="width: 80px" name="seventhLesson" type="text"></td>
                            <td><input style="width: 80px" name="eighthLesson" type="text"></td>
                            <td><button type="button" class="btn btn-primary" onclick="confirmAddSch()">更新</button></td>
                        </tr>
                        <tr>
                            <td>星期三</td>
                            <td><input style="width: 80px" name="firstLesson" type="text"></td>
                            <td><input style="width: 80px" name="secondLesson" type="text"></td>
                            <td><input style="width: 80px" style="width: 30px" name="thirdLesson" type="text"></td>
                            <td><input style="width: 80px" name="fourthLesson" type="text"></td>
                            <td><input style="width: 80px" name="fifthLesson" type="text"></td>
                            <td><input style="width: 80px" name="sixthLesson" type="text"></td>
                            <td><input style="width: 80px" name="seventhLesson" type="text"></td>
                            <td><input style="width: 80px" name="eighthLesson" type="text"></td>
                            <td><button type="button" class="btn btn-primary" onclick="confirmAddSch()">更新</button></td>
                        </tr>
                        <tr>
                            <td>星期四</td>
                            <td><input style="width: 80px" name="firstLesson" type="text"></td>
                            <td><input style="width: 80px" name="secondLesson" type="text"></td>
                            <td><input style="width: 80px" name="thirdLesson" type="text"></td>
                            <td><input style="width: 80px" name="fourthLesson" type="text"></td>
                            <td><input style="width: 80px" name="fifthLesson" type="text"></td>
                            <td><input style="width: 80px" name="sixthLesson" type="text"></td>
                            <td><input style="width: 80px" name="seventhLesson" type="text"></td>
                            <td><input style="width: 80px" name="eighthLesson" type="text"></td>
                            <td><button type="button" class="btn btn-primary" onclick="confirmAddSch()">更新</button></td>
                        </tr>
                        <tr>
                            <td>星期五</td>
                            <td><input style="width: 80px" name="firstLesson" type="text"></td>
                            <td><input style="width: 80px" name="secondLesson" type="text"></td>
                            <td><input style="width: 80px" name="thirdLesson" type="text"></td>
                            <td><input style="width: 80px" name="fourthLesson" type="text"></td>
                            <td><input style="width: 80px" name="fifthLesson" type="text"></td>
                            <td><input style="width: 80px" name="sixthLesson" type="text"></td>
                            <td><input style="width: 80px" name="seventhLesson" type="text"></td>
                            <td><input style="width: 80px" name="eighthLesson" type="text"></td>
                            <td><button type="button" class="btn btn-primary" onclick="confirmAddSch()">更新</button></td>
                        </tr>
                        <tr>
                            <td colspan="3"><label>班级：</label><input name="claId" type="text" readonly></td>
                            <td colspan="3"><label>学年：</label><input name="examYear" type="text" readonly></td>
                            <td colspan="3"><label>学期：</label><input name="examTerm" type="text" readonly></td>
                        </tr>
                        </tbody>
                    </table>

                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>