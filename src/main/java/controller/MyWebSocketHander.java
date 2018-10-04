package controller;

import domain.ChatMsg;
import domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import service.ChatService;
import service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
public class MyWebSocketHander implements WebSocketHandler {

    private final static List<WebSocketSession> users = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        users.add(webSocketSession);
    }
    /**
     * 客户端发送服务器的消息时的处理函数，在这里收到消息之后可以分发消息
     */
    @Autowired
    private ChatService chatService;
    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {
        System.out.println("3");
        System.out.println(webSocketSession.getAttributes().get("ws_user"));
        //发送消息的时间
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String sentMsgSate = dateFormat.format(new Date());

        User user = (User)webSocketSession.getAttributes().get("ws_user");
        String msgContent = webSocketMessage.getPayload() + "";
        //将消息保存到数据库
        ChatMsg chatMsg = new ChatMsg(user.getId(),sentMsgSate,msgContent);
        chatService.addMessage(chatMsg);

        String message = "用户：" + user.getUserName() + "发送时间："+sentMsgSate +  "内容:"+ webSocketMessage.getPayload() + "";
        System.out.println(message);
        TextMessage toMsg = new TextMessage( message + "");

        //遍历所有的用户，发信息，这个要注意哦，要不然不能做到多人同时聊天
        for(WebSocketSession wss : users) {
            wss.sendMessage(toMsg);
        }
    }

    @Override
    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {
        users.remove(webSocketSession);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {
        users.remove(webSocketSession);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}
