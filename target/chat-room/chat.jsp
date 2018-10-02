<%--
  Created by IntelliJ IDEA.
  User: 98031
  Date: 2018/10/1
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Start chatting now</title>
</head>
<link rel="stylesheet" href="static/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="static/css/chat.css" type="text/css">
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js" type="text/javascript"></script>
<body>

<div id="container" style="width:500px">

    <div id="header">
        <h1 id="title">chat-room</h1></div>
    <div class="middle">
        <div id="menu">
            <b>在线人数</b>
            <br>在线用户<br>
        </div>

        <div class="chatter" id="chatter">
            <ul class="am-comments-list am-comments-list-flip" id="chat">
            </ul>
        </div>
    </div>


        <div id="content">
        <textarea class="form-control" rows="3" placeholder="我想说.....">
        </textarea>
        </div>

    <div style="background-color: #F8F8F8;">
        <div id="buttons">
            <button type="button" class="btn btn-default">连接</button>
            <button type="button" class="btn btn-default">断开</button>
            <button type="button" class="btn btn-default">发送</button>
        </div>
    </div>

    <div id="footer">
        Designed by Annie
    </div>

</div>
</body>

</html>
