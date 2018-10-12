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
            <p id="tou">欢迎来到聊天室</p>
            <br>在线用户人数<br>
            <p id="onlineNum">0</p>
            <p>当前在线用户</p>
            <div id="onlineUser"></div>

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
            <button type="button" class="btn btn-default"
                    onclick="sendMsgClose()">断开
            </button>
            <button type="button" class="btn btn-default" onclick="sendMsg()">
                发送
            </button>
            <button type="button" class="btn btn-default" onclick="clearMsg()">
                清屏
            </button>
            <button type="button" class="btn btn-default" data-toggle="modal"
                    data-target="#imgModal">
                上传图片
            </button>
            <input type="file" name="userImage" id="userImage1"
                   onchange="check()" placeholder="请选择要上传的图片">
            <button type="button" class="btn btn-default"
                    onclick="sendImg()">
                发送图片
            </button>
            <button type="button" class="btn btn-default"
                    onclick="location.href='http://localhost:8080/chatroom/chatHistory.jsp'">
                消息记录
            </button>
        </div>
    </div>

    <div id="footer">
        Designed by Annie
    </div>
</div>
<!-- 一下是bootstrap的模态框-->
<%--<div class="modal fade" id="imgModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">
                    &times;
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="file" name="userImage" id="userImage"
                           onchange="check()" placeholder="请选择要上传的图片"><br/>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        onclick="sendImg()">
                    发送图片
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->--%>
</div>
</body>
<script>

    var wsServer = null;
    wsServer = "ws://" + location.host + "${pageContext.request.contextPath}" + "/websocket.do";
    var websocket = null;
    //将后台传来的消息显示到前端
    /* websocket.onmessage = function (evnt) {
         var message = eval("(" + evnt.data + ")");
         if(message.msgTyp === "notice"){
             $("#onlineNum").text(message.onlineNum);
         }else if(message.msgTyp === "msg"){
             showChat(evnt);
         }
     };*/

    //从后台接受聊天消息，并展示到前端
    function showChat(evnt) {
        var message = eval("(" + evnt.data + ")");
        var msg = $("#msg");
        //msg.html是之前的聊天内容，空一行
        msg.html(msg.html() + "<br/>" + "用户: " + message.user + " 发送时间：" + message.sendDate + "<br/>" + message.sendContent);
    }

    //打开链接
    function getConnection() {
        if (websocket == null) {
            websocket = new WebSocket(wsServer);
            websocket.onopen = function (evnt) {
                alert("链接服务器成功!");
            };
            websocket.onmessage = function (evnt) {
                var onlineUser = $("#onlineUser");
                var message = eval("(" + evnt.data + ")");
                //显示在线人数及在线用户
                if (message.msgTyp === "notice") {
                    var htmlOnline;
                    $("#onlineNum").text(message.onlineNum);
                    htmlOnline = "<p> " + message.userName + " </p>";
                    //实时更新在线用户
                    onlineUser.html("");
                    $(onlineUser).append(htmlOnline);
                } else if (message.msgTyp === "msg") {
                    showChat(evnt);
                } else if (message.msgTyp === "exit") {
                    $("#onlineNum").text(message.onlineNum);
                    var msg = $("#msg");
                    //msg.html是之前的聊天内容，空一行
                    msg.html(msg.html() + "<br/>" + "用户: " + message.userName + "退出聊天");
                }
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
    function closeConnection() {
        if (websocket != null) {
            websocket.close();
            websocket = null;
            alert("已经关闭连接")
        } else {
            alert("未开启连接")
        }
    }

    function sendMsgClose() {
        var closeMsg = "${user.userName}";
        websocket.send(JSON.stringify({
            message: closeMsg,
            type: "exit"
        }));
        websocket.onmessage = function (evnt) {
            var onlineUser = $("#onlineUser");
            var message = eval("(" + evnt.data + ")");
            //显示在线人数及在线用户
            if (message.msgTyp === "exit") {
                $("#onlineNum").text(message.onlineNum);
                var msg = $("#msg");
                //msg.html是之前的聊天内容，空一行
                msg.html(msg.html() + "<br/>" + "用户: " + message.userName + "退出聊天");
                htmlOnline = "<p> " + message.userNameList + " </p>";
                onlineUser.html("");
                $(onlineUser).append(htmlOnline);
                //我之前是把这个函数放到下面的，但是js是异步操作，意味着它会先过一遍主函数再过枝干
                //而closeConnection()放到下面的话，就会先注册onmessage但是不调用，直接调到closeConnection然后
                //等电脑有空了再来调用里面的代码。
                closeConnection();
            }
        }
        //就是这里 closeConnection();
    }

    /*
        上传图片信息，传到后台+后台读取数据
     */
    function sendImg() {
        var inputElement = document.getElementById("userImage1");
        var fileList = inputElement.files;
        var file = fileList[0];
        if (!file) return;
        var reader = new FileReader();
        //以二进制形式读取文件
        reader.readAsArrayBuffer(file);
        //文件读取完毕后该函数响应
        reader.onload = function loaded() {
            var blob = document.getElementById("userImage1").files[0];
            //发送二进制表示的文件
            websocket.send(JSON.stringify({
                message: blob,
                filename: file.name,
                type: "img"
            }));
            inputElement.outerHTML = inputElement.outerHTML; //清空<input type="file">的值
        }
    }


    function sendMsg() {
        var msg = $("#msgContent");
        if (websocket == null) {
            alert("连接未开启!");
            return;
        }
        var message = msg.val();
        //输入完成后，清空输入区
        msg.val("");
        if (message == null || message === "") {
            alert("输入不能为空的哦");
            return;
        }
        //向后台MyWebSocketHandler中的handlemessage发送信息
        websocket.send(JSON.stringify({
            message: message,
            type: "chatMsg"
        }));
    }

    //清屏函数
    function clearMsg() {
        $("#chatter").html("");
    }

</script>

</html>
