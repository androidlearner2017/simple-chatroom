<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 98031
  Date: 2018/10/4
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<link rel="stylesheet" href="<%=path%>/static/css/bootstrap.min.css"
      type="text/css">
<script src="<%=path%>/static/js/jquery.min.js"></script>
<script src="<%=path%>/static/js/bootstrap.min.js"
        type="text/javascript"></script>
<head>
    <title>历史记录</title>
</head>
<body>
<div id="container" style="width:500px">
    <div>
        <ul class="nav navbar-nav">
            <li>
                <form class="form-inline navbar-form "
                      action="<%=path%>/chat/findMsg.do" method="post">
                    <input class="form-control" type="search"
                           placeholder="我想知道......" maxlength="15"
                           name="conSearch">
                    <button class="btn btn-success-outline" type="submit">搜索
                    </button>
                </form>
            </li>
        </ul>
    </div>
    <table class="table table-striped">
        <c:forEach items="${msgList}" var="msg">
            <tbody>
            <tr>
                <th>${msg.user.userName}</th>
                <th>${msg.chatDate}</th>
                <th>${msg.content}</th>
            </tr>
            </tbody>
        </c:forEach>
    </table>

</div>

</body>
<style>
    #container {
        display: flex;
        flex-direction: column;
        height: 100%;
        margin-left: 30%;
        margin-right: 30%;
        margin-top: 100px;
        margin-bottom: 200px;
        background-color: rgba(240, 255, 255, 0.5);
        width: 30%;
    }

</style>
</html>
