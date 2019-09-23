
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="am-panel am-panel-default" data-am-scrollspy="{animation:'slide-bottom', delay: 300}" id="second">
    <div class="am-panel-hd">成绩信息</div>
    <div class="am-panel-bd">
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-6 col-md-offset-9">
                <a class="am-btn am-btn-danger" href="/file/scoreModelDown?tno=${Tno}" target="_blank">下载新增模板</a>
                <form id="scoreMsgPostForm"  method="post" enctype="multipart/form-data">
                    <input type="hidden" name="tno" value="${Tno}">
                    <label>导入班级成绩：</label><br>
                    <div class="am-form-group am-form-file">
                        <button type="button" class="am-btn am-btn-default am-btn-sm">
                            <i class="am-icon-cloud-upload"></i> 选择要上传的文件</button>
                        <input id="doc-form-file" type="file" name="scoreFile" multiple>
                    </div>
                    <div id="file-list" style="height: 20px"></div>
                    <button type="button" class="am-btn am-btn-success" onclick="scoreMsgPost(${Tno})">提交</button>
                </form>
            </div>
        </div>
        <hr data-am-widget="divider" style="" class="am-divider am-divider-dashed" />

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
                        <th>上传时间</th>
                        <%--<th>操作</th>--%>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ScoreList.list}" var="item">
                        <tr>
                            <td>${item.examYear}</td>
                            <td>${item.examTerm}</td>
                            <td>${item.courseName}</td>
                            <td>${item.claName}</td>
                            <td>${item.stuName}</td>
                            <td>${item.examScore}</td>
                            <td>${item.examTime}</td>
                                <%--<td>
                                    <button class="btn btn-danger btn-sm sco_delete_btn" value="${item.scoreId}">
                                        <span class="glyphicon glyphicon-trash">删除</span>
                                    </button>
                                </td>--%>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${ScoreList.list == null}">
                    <label style="color: blue">还没有学生成绩</label>
                </c:if>
            </div>
        </div>
        <br>

        <!--显示分页信息-->
        <div class="row">
            <!--分页文字信息 -->
            <div class="col-md-6" id="page_info">
                <label>当前第<span id="currentPage">${ScoreList.pageNum}</span>页, 总共
                    ${ScoreList.pages}页, 总共
                    ${ScoreList.total}条记录
                </label>
            </div>
            <!-- 分页条信息 -->
            <div class="col-md-6" id="nav_info">
                <ul class="pagination">
                    <c:if test="${ScoreList.hasPreviousPage == false}">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>
                    <c:if test="${ScoreList.hasPreviousPage == true}">
                        <li onclick="toScorePage(${Tno},1)"><a href="#">首页</a></li>
                        <li onclick="toScorePage(${Tno},${ScoreList.pageNum-1})"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>

                    <c:forEach items="${ScoreList.navigatepageNums}" var="item">
                        <c:if test="${ScoreList.pageNum == item}">
                            <li onclick="toScorePage(${Tno},${item})" class="active"><a href="#">${item}</a></li>
                        </c:if>
                        <c:if test="${ScoreList.pageNum != item}">
                            <li onclick="toScorePage(${Tno},${item})"><a href="#">${item}</a></li>
                        </c:if>
                    </c:forEach>


                    <c:if test="${ScoreList.hasNextPage == false}">
                        <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </c:if>
                    <c:if test="${ScoreList.hasNextPage == true}">
                        <li onclick="toScorePage(${Tno},${Course.msgContent.pageInfo.pageNum+1})"><a href="#"><span>&raquo;</span></a></li>
                        <li onclick="toScorePage(${Tno},${Course.msgContent.pageInfo.pages})"><a href="#">末页</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>


<script src="../../static/js/pageJs/scoreTea.js"></script>

<script>
    $(function() {
        $('#doc-form-file').on('change', function() {
            var fileNames = '';
            $.each(this.files, function() {
                fileNames += '<span class="am-badge">' + this.name + '</span> ';
            });
            $('#file-list').html(fileNames);
        });
    });
</script>