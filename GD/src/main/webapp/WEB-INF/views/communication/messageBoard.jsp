<%--
  User: Carlson
  Date: 2019/4/23
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="msgBoardForm" class="smart-green">
    <h1>Communication
        <span>Message Board.</span>
    </h1>
    <label>
        <span>留言人 :</span>
        <input id="senderName" type="text" readonly name="sender" value="${Sender}" placeholder="您的账号或工号" />
    </label>
    <label>
        <span>标题 :</span>
        <input id="email" type="text" name="cmTitle" placeholder="留言主题" />
    </label>

    <label>
        <span>Message :</span>
        <textarea id="message" name="content" placeholder="Your Message"></textarea>
    </label>
    <label>
        <span>接收人 :</span>
        <input id="recipient" type="text" name="recipient" value="${Recipient}" placeholder="接收人账号或工号" />
    </label>
    <div style="height: 25px"></div>
    <label>
        <span>&nbsp;</span>
        <input type="button" class="button" value="Send" onclick="leavingamessageConfirm()" />
    </label>
</form>


<link rel="stylesheet" href="../../../static/css/communiCss/messageBoard.css">
<script src="../../../static/js/pageJs/messageBoard.js"></script>
