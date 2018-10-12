package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import domain.ChatMsg;
import domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import service.ChatService;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
public class MyWebSocketHander implements WebSocketHandler {
    //这里好像是存储sessionID的，所以并没有和我们后端的用户session对应起来
    //最好不要直接用
    private final static List<WebSocketSession> USERS = new ArrayList<>();
    private final static List<User> USER_ONLINE = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
       USERS.add(webSocketSession);
        //每次有新的连接，就加入到user集合中
        User user = (User) webSocketSession.getAttributes().get("ws_user");
        USER_ONLINE.add(user);

        List<String> userNamelist = new ArrayList<>();
        for (User u : USER_ONLINE) {
            String userName = u.getUserName();
            userNamelist.add(userName);
        }

        //String类的format()方法用于创建格式化的字符串以及连接多个字符串对象。
        //这里传到前端的应该是JSON格式
        String messageFormat = "{onlineNum:\"%d\",userName:\"%s\" , msgTyp " +
                ":\"%s\"}";
        String msg = String.format(messageFormat, USERS.size(), userNamelist,
                "notice");

        TextMessage testMsg = new TextMessage(msg + "");
        //确保每个用户信息都能同步到
        for (WebSocketSession wss : USERS) {
            wss.sendMessage(testMsg);
        }
    }

    /**
     * 客户端发送服务器的消息时的处理函数，在这里收到消息之后可以分发消息
     */
    @Autowired
    private ChatService chatService;

    @Override
    public void handleMessage(WebSocketSession webSocketSession,
                              WebSocketMessage<?> webSocketMessage) throws Exception {

        String messageFormat = null;
        FileOutputStream output;

        System.out.println(webSocketSession.getAttributes().get("ws_user"));
        //发送消息的时间
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String sentMsgDate = dateFormat.format(new Date());

        User user = (User) webSocketSession.getAttributes().get("ws_user");

        String msgContent = webSocketMessage.getPayload() + "";
        System.out.println("前端传到后台的数据 " + msgContent);
        JSONObject chat = JSON.parseObject(msgContent);
        //消息的内容
        String msgJSON = chat.get("message").toString();
        //消息的样式
        String msgJSONType = chat.get("type").toString();
        String exit = "exit";
        String chatMsg = "chatMsg";
        String img = "img";

        System.out.println("JSON验证" + chat);
        System.out.println(chat.get("type").toString());

        if (msgJSONType.equals(exit)) {
            messageFormat = "{onlineNum:\"%d\",userName:\"%s\" ,userNameList:\"%s\", msgTyp:\"%s\"}";
            //从用户列表中移除已退出的用户
            USER_ONLINE.remove(user);
            List<String> userNamelist = new ArrayList<>();
            for (User u : USER_ONLINE) {
                String userName = u.getUserName();
                userNamelist.add(userName);
            }

            String msg = String.format(messageFormat, USERS.size()-1 ,msgJSON ,userNamelist,"exit");
            TextMessage testMsg = new TextMessage(msg + "");
            //确保每个用户信息都能同步到
            for(WebSocketSession wss : USERS) {
              wss.sendMessage(testMsg);
            }

        } else if (msgJSONType.equals(chatMsg)) {
            //将消息保存到数据库
            ChatMsg chatMessage = new ChatMsg(user.getId(), sentMsgDate,
                    msgContent);
            chatService.addMessage(chatMessage);

            messageFormat = "{user:\"%s\",sendDate:\"%s\" ," +
                    "sendContent:\"%s\" , msgTyp :\"%s\"}";
            String message = String.format(messageFormat, user.getUserName(),
                    sentMsgDate, msgJSON , "msg");
            TextMessage toMsg = new TextMessage(message + "");
            //遍历所有的用户，发信息，这个要注意哦，要不然不能做到多人同时聊天
            for (WebSocketSession wss : USERS) {
                wss.sendMessage(toMsg);
            }
        }else if(msgJSONType.equals(img)){
            System.out.println("i'm here");
            //设置图片保存路径
            output = new FileOutputStream(new File("D:\\images\\"+chat.get("filename").toString().split(":")[0]));
            System.out.println("图片路径"+"D:\\images\\"+chat.get("filename").toString().split(":")[0]);
            output.close();
        }

    }


    @Override
    public void handleTransportError(WebSocketSession webSocketSession,
                                     Throwable throwable) throws Exception {
        USERS.remove(webSocketSession);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession,
                                      CloseStatus closeStatus) throws Exception {
        User userRemove = (User) webSocketSession.getAttributes().get(
                "ws_user");
        USER_ONLINE.remove(userRemove);
        USERS.remove(webSocketSession);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
}
