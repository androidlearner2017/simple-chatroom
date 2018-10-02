<%--
  Created by IntelliJ IDEA.
  User: 98031
  Date: 2018/10/1
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<!--
* 客户端连接服务端websocket
* 并且订阅一系列频道，用来接收不同种类的消息
* /app/chat/participants ：当前在线人数的消息，只会接收一次
* /topic/login ： 新登录用户的消息
* /topic/chat/message ： 聊天内容消息
* /topic/logout : 用户离线的消息
* 服务器发回json实例 {"userName":"chris","sendDate":1494664021793,"content":"hello"}
-->
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
            <b>在线人数<span>0</span></b>
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
<script>
    var wsServer = null;
    wsServer = "ws://" + location.host+"${pageContext.request.contextPath}" + "/socket";

    $(function () {
        var websocket = new WebSocket(wsServer);
        websocket.onopen = function (evnt) {
            $("#tou").html("链接服务器成功!")
        };
        websocket.onmessage = function (evnt) {
            $("#msg").html($("#msg").html() + "<br/>" + evnt.data);
        };
        websocket.onerror = function (evnt) {
            $("#tou").html("发生错误，与服务器断开了链接!")
        };
        websocket.onclose = function (evnt) {
            $("#tou").html("与服务器断开了链接!")
        }
        $('#send').bind('click', function () {
            send();
        });

        function send() {
            if (websocket != null) {
                var message = document.getElementById('message').value;
                websocket.send(message);
            } else {
                alert('未与服务器链接.');
            }
        }
    });


</script>

</html>
