<%--
  Created by IntelliJ IDEA.
  User: 98031
  Date: 2018/9/30
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<link rel="stylesheet" href="static/css/bootstrap.min.css" type="text/css">
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js" type="text/javascript"></script>
<style>
    /*web background*/
    .container {
        display: flex;
        flex-direction: column;
        height: 100%;
        margin-left: 30%;
        margin-right: 30%;
        margin-top: 100px;
        background-color: rgba(240, 255, 255, 0.5);
        width: 40%;
    }

    #buttonBox {
        display: flex;
        flex-direction: row;
        width: 200%

    }

    form {
        display: flex;
        flex-direction: column;
    }
</style>
<head>
    <title>Registration</title>
</head>
<body>
<div class="container">
    <form action="<%=path%>/user/register.do" method="post" name="registerForm"
          onsubmit="return validateForm()">

        <div class="form-group col-sm-4" style="width:70%">
            <label for="userName">用户名</label>
            <input id="userName" type="text" name="userName" maxlength="10"
                   class="form-control" placeholder="仅限数字 字母 下划线 "><br/>
            <p id="uNClass"></p>
        </div>


        <div class="form-group col-sm-4" style="width:70%">
            <label for="Password1">密码</label>
            <input id="Password1" type="password" name="password" maxlength="10"
                   class="form-control" placeholder="仅限数字 字母 下划线 "><br/>
            <p id="pWClass"></p>

        </div>

        <div id="buttonBox">
            <input type="submit" value="完成" class="btn btn-info btn-lg col-sm-2"
                   style="margin-right: 3%;">
            <input type="button" value="登录"
                   onclick="location.href='http://localhost:8080/chatroom/login.jsp'"
                   class="btn btn-info btn-lg col-sm-2">
        </div>
    </form>

</div>

</body>

<script type="text/javascript">
    /*字符串是否由字符，字母，下划线组成，可以用来判断密码
     *由数字、26个英文字母或者下划线组成的字符串：^\w+$ 或 ^\w{3,20}$
     */
    function isValid(str) {
        return /^\w+$/.test(str);
    }

    /*只含有汉字、数字、字母、下划线不能以下划线开头和结尾,验证用户名*/
    function isUserName(str) {
        var reg = /^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
        return reg.test(str);
    }

    function validateForm() {

        var userName = document.forms["registerForm"]["userName"].value;
        var password = document.forms["registerForm"]["password"].value;
        var passwordConfirm = document.forms["registerForm"]["passwordConfirm"].value;

        if (userName == null || userName == "") {
            text = "输入不能为空";
            document.getElementById("uNClass").innerHTML = text;
            return false;
        } else if (!isUserName(userName)) {
            text = "用户名格式错误，只能含有汉字、数字、字母、下划线且不能以下划线开头和结尾";
            document.getElementById("uNClass").innerHTML = text;
            return false;
        }

        if (password == null || password == "") {
            text = "密码不能为空";
            document.getElementById("pWClass").innerHTML = text;
            return false;
        } else if (!isValid(password)) {
            text = "密码格式错误，只能含有数字，字母，下划线";
            document.getElementById("pWClass").innerHTML = text;
            return false;
        }
        return true;
    }

</script>

</html>
