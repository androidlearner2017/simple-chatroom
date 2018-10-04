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
<% String path = request.getContextPath();
    String socketPath = request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Start chatting now</title>
</head>
<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css"
      type="text/css">
<link rel="stylesheet" href="<%=path%>/static/css/chat.css" type="text/css">
<script src="<%=path%>/static/js/jquery.min.js"></script>
<script src="<%=path%>/static/js/bootstrap.min.js"
        type="text/javascript"></script>
<body>

<div id="container" style="width:500px">

    <div id="header">
        <h1 id="title">chat-room</h1></div>
    <div class="middle">
        <div id="menu">
         <!--   <b id="pOnline">在线人数<span>0</span></b> -->
            <br>在线用户<br>
            <p id="tou">欢迎来到聊天室</p>
        </div>

        <div class="chatter" id="chatter">

            <p id="msg"></p>

        </div>
    </div>


    <div id="content">
        <textarea class="form-control" rows="3" placeholder="我想说....."
                  id="msgContent">
        </textarea>
    </div>

    <div style="background-color: #F8F8F8;">
        <div id="buttons">
            <button id="butSent" type="button" class="btn btn-default"
                    onclick="getConnection()">连接
            </button>
            <button type="button" class="btn btn-default" onclick="closeConnection()">断开</button>
            <button type="button" class="btn btn-default" onclick="sendMsg()">发送</button>
            <button type="button" class="btn btn-default" onclick="location.href='http://localhost:8080/chatroom/chatHistory.jsp'">消息记录</button>
        </div>
    </div>

    <div id="footer">
        Designed by Annie
    </div>

</div>
</body>
<script>

    var wsServer = null;
    wsServer = "ws://" + location.host + "${pageContext.request.contextPath}" + "/websocket.do";
    var websocket = null;

    websocket.onopen = function (evnt) {
        alert("链接服务器成功!")
    };
    websocket.onmessage = function (evnt) {
        var msg = $("#msg");
        msg.html(msg.html() + "<br/>" + evnt.data);
    };
    websocket.onerror = function (evnt) {
        alert("发生错误，与服务器断开了链接!")
    };
    websocket.onclose = function (evnt) {
        alert("与服务器断开了链接!")
    };

    //打开链接
    function getConnection() {
        if (websocket == null) {
            websocket = new WebSocket(wsServer);
            websocket.onopen = function (evnt) {
                alert("链接服务器成功!")
            };
            websocket.onmessage = function (evnt) {
                var msg = $("#msg");
                msg.html(msg.html() + "<br/>" + evnt.data);
            };
            websocket.onerror = function (evnt) {
                alert("发生错误，与服务器断开了链接!")
            };
            websocket.onclose = function (evnt) {
                alert("与服务器断开了链接!")
            };
            $('#send').bind('click', function () {
                send();
            });
        } else {
            alert("连接已存在!")
        }
    }

    /**
     * 关闭连接
     */
    function closeConnection(){
        if(websocket != null){
            websocket.close();
            websocket = null;
            alert("已经关闭连接")
        }else{
           alert("未开启连接")
        }
    }

   /* function send() {
        if (websocket != null) {
            var message = document.getElementById('msgContent').value;
            websocket.send(message);
        } else {
            alert('未与服务器链接.');
        }
    }*/
    /*
    发送信息给后台
     */
    function sendMsg(){
        var msg = $("#msgContent");
        if(websocket == null){
            alert("连接未开启!");
            return;
        }
        var message = msg.val();
        //输入完成后，清空输入区
        msg.val("");
        if(message == null || message == ""){
            alert("输入不能为空的哦");
            return;
        }
        //向后台MyWebSocketHandler中的handlemessage发送信息
        websocket.send(message);
    }


</script>

</html>
