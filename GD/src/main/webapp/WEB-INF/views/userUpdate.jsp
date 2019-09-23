<%--
  User: Carlson
  Date: 2019/4/20
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="../../static/css/updateIndex.css">
<section class="aui-content am-animation-slide-bottom">
    <div style="height:20px;"></div>
    <div class="aui-content-up">
        <form id="userMsgUpdateForm" method="post" enctype="multipart/form-data">
            <div class="aui-content-up-form">
                <h2>信息修改</h2>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    姓名 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input style="display: none" name="account" value="${User.account}">
                    <input type="text" id="userName" class="aui-form-control-two" name="userName" value="${User.userName}">
                    <span class="tips">长度1~6个字符</span>
                    <span id="divName" class="am-badge am-badge-warning am-radius"></span>
                </div>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    旧密码 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input type="password" class="aui-form-control-two" name="userPwd"/>
                </div>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    新密码 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input type="password" class="aui-form-control-two" name="newPwd"/>
                </div>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    年龄 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input type="text" class="aui-form-control-two" name="userAge" value="${User.userAge}"/>
                </div>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    邮箱 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input type="text" id="userEmail" class="aui-form-control-two" name="userEmail" value="${User.userEmail}"/>
                    <span class="tips">输入符合格式的邮箱</span>
                    <span id="email" class="am-badge am-badge-warning am-radius"></span>
                </div>
            </div>
            <div class="aui-form-group clear">
            <label class="aui-label-control">
                电话 <em>*</em>
            </label>
            <div class="aui-form-input">
                <input type="text" id="userPhone" class="aui-form-control-two" name="userPhone" value="${User.userPhone}"/>
                <span class="tips">必须是11位的数字</span>
                <span id="phone" class="am-badge am-badge-warning am-radius"></span>
            </div>
        </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    地址 <em>*</em>
                </label>
                <div class="aui-form-input">
                    <input type="text" id="address" class="aui-form-control-two" name="address" value="${User.address}"/>
                </div>
            </div>
            <div class="aui-form-group clear">
                <label class="aui-label-control">
                    头像上传：
                </label>
                <div class="aui-form-input">
                    <div class="aui-content-img-box aui-content-full">
                        <div class="am-form-group am-form-file">
                            <button type="button" class="am-btn am-btn-danger am-btn-sm">
                                <i class="am-icon-cloud-upload"></i> 选择要上传的图片</button>
                            <input id="doc-form-file" name="imageFile" type="file" multiple>
                        </div>
                        <div id="file-list"></div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="aui-btn-default">
        <button class="aui-btn aui-btn-account" onclick="userUpdatePost()">保存</button>
    </div>
</section>

<script type="text/javascript">
    //验证姓名是否合法
    //验证规则：1-6位。
    function checkUserName(){
        var str = $("#userName").val();
        //验证姓名正则
        var regName = /(^[a-zA-Z0-9_-]{1,6}$)|(^[\u2E80-\u9FFF0-9]{1,6})/;
        if(regName.test(str)){
            $("#divName").text("正确");
            return true;
        }else{
            $("#divName").text("错误");
            return false;
        }
    }

    //邮箱
    function checkUserEmail(){
        var str = $("#userEmail").val();
        //正则验证邮箱
        var regEmail= /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        if(regEmail.test(str)){
            $("#email").text("正确");
            return true;
        }else{
            $("#email").text("错误");
            return false;
        }
    }

    //验证手机号码
    function checkUserTel(){
        var str = $("#userPhone").val();
        var regTel = /^((13\d|14[57]|15[^4,\D]|17[678]|18\d)\d{8}|170[059]\d{7})$/;
        if(regTel.test(str)){
            $("#phone").text("正确");
            return true;
        }else{
            $("#phone").text("错误");
            return false;
        }
    }

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