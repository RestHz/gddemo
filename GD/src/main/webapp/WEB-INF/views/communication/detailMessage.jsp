<%--
  User: Carlson
  Date: 2019/4/23
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<form id="replyMsgForm" class="dark-matter">
    <h1>Communication
        <span>Message Board.</span>
    </h1>
    <input name="cmId" value="${CommunicationOne.cmId}" style="display: none">
    <c:if test="${CommunicationOne.cwStatus == '已回复'}">
        <c:if test="${SenderType=='Teacher'}">
            <span style="color: red">'${teacherSender.tcName}'于'${CommunicationOne.replyTime}'已回复信息，不可再修改!</span>
        </c:if>
        <c:if test="${SenderType=='Parent'}">
            <span style="color: red">'${userSender.userName}'于'${CommunicationOne.replyTime}'已回复信息，不可再修改!</span>
        </c:if>
    </c:if>
    <label>
        <span>
            留言人
            <c:if test="${SenderType=='Teacher'}">
            ${teacherSender.tcName}
        </c:if>
        <c:if test="${SenderType=='Parent'}">
            ${userSender.userName}
        </c:if>:
        </span>
        <input id="senderName" type="text" readonly name="sender" value="${CommunicationOne.sender}"/>
    </label>

    <label>
        <span>标题 :</span>
        <input type="text" readonly name="cmTitle" value="${CommunicationOne.cmTitle}" />
    </label>

    <c:if test="${CommunicationOne.cwStatus == '未读'}">

        <c:if test="${Condition == 1}">
            <label>
                <span>留言信息 :</span>
                <textarea name="content">${CommunicationOne.content}</textarea>
            </label>
        </c:if>

        <c:if test="${Condition == 2}">
            <label>
                <span>留言信息 :</span>
                <textarea readonly name="content">${CommunicationOne.content}</textarea>
            </label>
            <label>
                <span>回复信息 :</span>
                <textarea name="replyContent"></textarea>
            </label>
        </c:if>
    </c:if>

    <c:if test="${CommunicationOne.cwStatus == '已回复'}">

        <label>
            <span>留言信息 :</span>
            <textarea readonly name="content">${CommunicationOne.content}</textarea>
        </label>
        <label>
            <span>回复信息 :</span>
            <textarea class="" name="content" rows="5" id="doc-ta-1">${CommunicationOne.replyContent}</textarea>
        </label>
    </c:if>

    <label>
        <span>
            接收人 <c:if test="${SenderType=='Teacher'}">
            ${userRec.userName}
        </c:if>
        <c:if test="${SenderType=='Parent'}">
            ${teacherRec.tcName}
        </c:if>:
        </span>
        <input id="recipient" type="text" readonly name="recipient" value="${CommunicationOne.recipient}" />
    </label>
    <div style="height: 25px"></div>
    <c:if test="${CommunicationOne.cwStatus != '已回复'}">
        <label>
            <span>&nbsp;</span>
            <input type="button" class="button" value="Send" onclick="replyConfirm()" />
        </label>
    </c:if>
    <div style="height: 25px"></div>
</form>
<link rel="stylesheet" href="../../../static/css/communiCss/detailMessage.css">
<script src="../../../static/js/pageJs/detailMessage.js"></script>