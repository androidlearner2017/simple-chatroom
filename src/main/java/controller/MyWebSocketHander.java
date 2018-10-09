package controller;

import com.alibaba.fastjson.JSONObject;
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
    //这里好像是存储sessionID的，所以并没有和我们后端的用户session对应起来
    //最好不要直接用
    private final static List<WebSocketSession> users = new ArrayList<>();
    private final static List<User> userOnline = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        users.add(webSocketSession);
        //每次有新的连接，就加入到user集合中
        User user = (User)webSocketSession.getAttributes().get("ws_user");
        userOnline.add(user);

        List<String> userNamelist = new ArrayList<>();
        for(User u : userOnline){
            String userName = u.getUserName();
            userNamelist.add(userName);
        }

        //String类的format()方法用于创建格式化的字符串以及连接多个字符串对象。
        //这里传到前端的应该是JSON格式
        String messageFormat = "{onlineNum:\"%d\",userName:\"%s\" , msgTyp :\"%s\"}";
        String msg = String.format(messageFormat, users.size(),userNamelist ,"notice");

        TextMessage testMsg = new TextMessage(msg + "");
        //确保每个用户信息都能同步到
        for(WebSocketSession wss : users) {
            wss.sendMessage(testMsg);
        }
    }
    /**
     * 客户端发送服务器的消息时的处理函数，在这里收到消息之后可以分发消息
     */
    @Autowired
    private ChatService chatService;
    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {

        System.out.println(webSocketSession.getAttributes().get("ws_user"));
        //发送消息的时间
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String sentMsgDate = dateFormat.format(new Date());

        User user = (User)webSocketSession.getAttributes().get("ws_user");
        String msgContent = webSocketMessage.getPayload() + "";

        //将消息保存到数据库
        ChatMsg chatMsg = new ChatMsg(user.getId(),sentMsgDate,msgContent);
        chatService.addMessage(chatMsg);

        String messageFormat = "{user:\"%s\",sendDate:\"%s\" ,sendContent:\"%s\" , msgTyp :\"%s\"}";
        String message = String.format(messageFormat,user.getUserName(),sentMsgDate,webSocketMessage.getPayload() + "","msg");
        System.out.println(message);
        TextMessage toMsg = new TextMessage( message + "");
        System.out.println(toMsg);
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
