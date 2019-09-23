<%--
  User: Carlson
  Date: 2019/4/27
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<label> ${Clas.claName} 班 ${Year}-${Mouth}-${Day}:${WeekDay} 的考勤：</label>
<div style="height:12px;"></div>
<table class="table table-hover" id="stu_table" style="font-size: 20px">
    <thead>
    <tr class="info">
        <th>学号</th>
        <th>姓名</th>
        <th>邮箱</th>
        <th>电话</th>
        <th>地址</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${Student}" var="item">
        <tr>
            <td>${item.sno}</td>
            <td>${item.stuName}</td>
            <td>${item.stuEmail}</td>
            <td>${item.stuPhone}</td>
            <td>${item.stuAddress}</td>
            <td>
                <button class="btn btn-info btn-sm inv_edit_btn"  value="${item.sno}">
                    <span class="glyphicon glyphicon-pencil">考勤</span>
                </button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<label>班主任：${Teacher.tcName}对班${Clas.claName}考勤</label>

<!-- 考勤新增视图 -->
<div class="am-modal am-modal-confirm" tabindex="-1" id="invAddModel">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">学生考勤</div>
        <div style="height:20px;"></div>
        <div class="am-modal-bd col-md-offset-2">
            <form id="invAddMsgForm" class="form-horizontal">
                <div class="form-group has-success">
                    <label class="col-sm-2 control-label">学号:</label>
                    <div class="col-sm-6">
                        <input id="snoEdit" name="sno" type="text" class="form-control" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学生姓名:</label>
                    <div class="col-sm-6">
                        <input id="stuNameEdit" name="stuName" type="text" class="form-control" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">情况:</label>
                    <div class="col-sm-6">
                        <select name="situation" class="form-control" style="background-color: rgb(242, 242, 242);">
                            <option value="迟到">迟到</option>
                            <option value="旷课">旷课</option>
                            <option value="请假">请假</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">备注:</label>
                    <div class="col-sm-6">
                        <textarea name="remark" class="form-control" rows="3" style="background-color: rgb(242, 242, 242);"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">考勤人:</label>
                    <div class="col-sm-6">
                        <input name="tcName" value="${Teacher.tcName}" type="text" class="form-control" readonly>
                    </div>
                </div>
                <input name="tno" value="${Teacher.tno}" style="display: none">
                <input name="claName" value="${Clas.claName}" style="display: none">
            </form>
        </div>
        <div style="height:10px;"></div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>关闭</span>
            <span class="am-modal-btn" onclick="confirmAddInv()" data-am-modal-confirm>提交</span>
        </div>
    </div>
</div>

<script src="../../../static/js/pageJs/investigate.js"></script>

