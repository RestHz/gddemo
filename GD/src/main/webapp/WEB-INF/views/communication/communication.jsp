<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  User: Carlson
  Date: 2019/4/4
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../../../static/css/communiCss/communication.css">

<div class="am-panel am-panel-success">
    <div class="am-panel-hd">${SenderMsg.msgContent.SenderName}'留言信息</div>
    <input id="SenderAccount" type="hidden" value="${SenderMsg.msgContent.SenderAccount}">
    <div class="am-panel-bd">
        <!-- 按钮 -->
        <div class="row">
            <div class="panel panel-default col-md-12">
                <div class="panel-body">
                    <c:if test="${OrderByType != 4}">
                        <div class="col-md-2">
                            <label class="control-label">选择联系人:</label>
                        </div>

                        <c:if test="${SenderType !=null and SenderType == 'Teacher'}">
                            <div class="">
                                <select id="classListSelect" onchange="getUserList()">
                                </select>
                            </div>
                            <div class="">
                                <select id="userListSelect" onchange="getUserOne(${SenderMsg.msgContent.SenderAccount})">
                                    <option style='width: 120px'>--请选择--</option>
                                </select>
                            </div>
                        </c:if>
                        <c:if test="${SenderType !=null and SenderType == 'Parent'}">
                            <div class="">
                                <select id="classListSelect" onchange="getTeaList()">
                                </select>
                            </div>
                            <div class="">
                                <select id="teaListSelect" onchange="getTeacherOne(${SenderMsg.msgContent.SenderAccount})">
                                    <option style='width: 120px'>--请选择--</option>
                                </select>
                            </div>
                        </c:if>
                        <select id="selComMsgType" class="col-md-offset-10" data-am-selected="{dropUp: 1}" onchange="getComOrderByMsg(${SenderMsg.msgContent.SenderAccount},1)">
                            <option value="0">选择排序方法</option>
                            <option value="0">按发送时间</option>
                            <option value="1">按回复时间</option>
                            <option value="2">按未读    </option>
                            <option value="3">按已回复  </option>
                        </select>
                    </c:if>
                </div>
            </div>
        </div>


        <button type="button" class="am-btn am-btn-secondary" onclick="getComPage(${SenderMsg.msgContent.SenderAccount},1,4)">我的留言</button>
        <button type="button" class="am-btn am-btn-warning" onclick="leavingamessage(${SenderMsg.msgContent.SenderAccount},'')">新建留言</button>
        <div style="height: 30px"></div>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <c:forEach items="${Communication.list}" var="item">
                    <c:if test="${item == null}">
                        <label style="color: blue">没有留言信息</label>
                        <c:if test="${ERROR != null}">
                            <span>${ERROR}</span>
                        </c:if>
                    </c:if>
                    <li class="layui-timeline-item am-animation-fade">
                        <i class="layui-icon layui-timeline-axis"></i>
                        <div class="layui-timeline-content layui-text">
                            <h3 class="layui-timeline-title">${item.addTime}</h3>
                            <p>标题：<em><span style="color: #6b0100">${item.cmTitle}</span></em></p>

                            <ul>
                                <li>
                                    <table class="table table-hover">
                                        <tr>
                                            <td>
                                                发送人ID：<em>${item.sender}</em>
                                            </td>
                                            <td>
                                                接收人ID：<em>${item.recipient}</em>
                                            </td>
                                            <td>
                                                回复时间：<em>${item.replyTime}</em>
                                            </td>

                                            <c:if test="${item.cwStatus == '未读'}">
                                                <td>状态： <em><span style="color: red">${item.cwStatus}</span></em><span class="layui-badge-dot"></span></td>
                                            </c:if>
                                            <c:if test="${item.cwStatus == '已回复'}">
                                                <td>状态： <em><span style="color: blue">${item.cwStatus}</span></em></td>
                                            </c:if>
                                            <td>
                                                <c:if test="${item.cwStatus == '已回复'}">
                                                    <button class="btn btn-success btn-sm com_edit_btn"  value="${item.cmId}">
                                                        <span class="glyphicon glyphicon-pencil">查看</span>
                                                    </button>&nbsp;
                                                </c:if>
                                                <c:if test="${item.cwStatus == '未读'}">
                                                    <button class="btn btn-info btn-sm com_reply_btn"  value="${item.cmId}">
                                                        <span class="glyphicon glyphicon-pencil">回复</span>
                                                    </button>&nbsp;
                                                </c:if>
                                                <button class="btn btn-warning btn-sm com_delete_btn" value="${item.cmId}">
                                                    <span class="glyphicon glyphicon-trash">删除</span>
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                </li>
                            </ul>
                        </div>
                    </li>

                </c:forEach>
            </div>
        </div>
        <br>

        <!--显示分页信息-->
        <div class="row">
            <!--分页文字信息 -->
            <div class="col-md-6" id="page_info">
                <label>当前第<span id="currentPage">${Communication.pageNum}</span>页, 总共
                    ${Communication.pages}页, 总共
                    ${Communication.total}条记录
                </label>
            </div>
            <!-- 分页条信息 -->
            <div class="col-md-6" id="nav_info">
                <ul class="pagination">
                    <c:if test="${Communication.hasPreviousPage == false}">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>
                    <c:if test="${Communication.hasPreviousPage == true}">
                        <li onclick="getComPage(${SenderMsg.msgContent.SenderAccount},1,${OrderByType})"><a href="#">首页</a></li>
                        <li onclick="getComPage(${SenderMsg.msgContent.SenderAccount},${Communication.pageNum}-1,${OrderByType})"><a href="#"><span>&laquo;</span></a></li>
                    </c:if>

                    <c:forEach items="${Communication.navigatepageNums}" var="item">
                        <c:if test="${Communication.pageNum == item}">
                            <li id="comCurrentPage" onclick="getComPage(${SenderMsg.msgContent.SenderAccount},${item},${OrderByType})" class="active"><a href="#">${item}</a></li>
                        </c:if>
                        <c:if test="${Communication.pageNum != item}">
                            <li onclick="getComPage(${SenderMsg.msgContent.SenderAccount},${item},${OrderByType})"><a href="#">${item}</a></li>
                        </c:if>
                    </c:forEach>


                    <c:if test="${Communication.hasNextPage == false}">
                        <li class="disabled"><a href="#"><span>&raquo;</span></a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </c:if>
                    <c:if test="${Communication.hasNextPage == true}">
                        <li onclick="getComPage(${SenderMsg.msgContent.SenderAccount},${Communication.pageNum}+1,${OrderByType})"><a href="#"><span>&raquo;</span></a></li>
                        <li onclick="getComPage(${SenderMsg.msgContent.SenderAccount},${Communication.pages},${OrderByType})"><a href="#">末页</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>





<!-- 留言视图 -->

<div class="am-popup" id="communicationModel">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">...</h4>
            <span data-am-modal-close
                  class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd">
            <div id="messageBoard">

            </div>
        </div>
    </div>
</div>
