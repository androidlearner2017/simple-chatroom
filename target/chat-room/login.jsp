<%--
  Created by IntelliJ IDEA.
  User: 98031
  Date: 2018/9/30
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<link rel="stylesheet" href="static/css/bootstrap.min.css" type="text/css">
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js" type="text/javascript"></script>
<style>
    html, body {width:100%;height:100%;}/*非常重要的样式让背景图片100%适应整个屏幕*/
    /*web background*/
    .container {
        display: flex;
        flex-direction:column;
        height: 100%;
        margin-left: 30%;
        margin-right: 30%;
        margin-top: 100px;
        background-color: rgba(240, 255, 255, 0.5);
        width:30%;
    }
    #buttonBox{
        display: flex;
        flex-direction:row;
        width:200%
    }
    form{
        display:flex;
        flex-direction:column;
    }

</style>
<body>

<div class="container">
    <form action="user/login.do" method="post" name="loginForm"
          onsubmit="return validateForm()">
        <div class="form-group col-sm-8">
            <label for="user">用户名</label>
            <input type="text" class="form-control" name="userName" maxlength="10" id="user"><br/>
            <p id="uNClass"></p>
        </div>

        <div class="form-group col-sm-8">
            <label for="password">密码</label>
            <input type="password" class="form-control" name="password"  maxlength="10" id="password"><br/>
            <p id="pWClass"></p>

        </div>

        <div id="buttonBox">
            <input type="submit" value="登录" class="btn btn-info btn-lg col-sm-2"
                   style="margin-right: 3%;">
            <input type="button" value="注册" onclick="location.href='http://localhost:8080/chatroom/register.jsp'" class="btn btn-info btn-lg col-sm-2">
        </div>
    </form>
</div>

</body>

<script type="text/javascript">
    function validateForm() {
        var x = document.forms["loginForm"]["userName"].value;
        var y = document.forms["loginForm"]["password"].value;
        var z = document.forms["loginForm"]["inputCode"].value;
        if (x == null || x == "") {
            text = "输入不能为空";
            document.getElementById("uNClass").innerHTML = text;
            return false;
        }
        if (y == null || y == "") {
            text = "密码不能为空";
            document.getElementById("pWClass").innerHTML = text;
            return false;
        }
        if (z == null || z == "") {
            text = "验证码不能为空";
            document.getElementById("inputCodeClass").innerHTML = text;
            return false;
        }
    }
</script>

</html>
