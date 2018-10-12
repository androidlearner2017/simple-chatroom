package controller;

import domain.User;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


/*   private static Map<WebSocketSession,String> map = new HashMap<WebSocketSession, String>();
 * websocket握手拦截器
 * 拦截握手前，握手后的两个切面
 * 目前毫无作用
 */
@Component
public class MyHandShakeInterceptor implements HandshakeInterceptor {


    @Override
    public boolean beforeHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> map) throws Exception {
        if(serverHttpRequest instanceof ServletServerHttpRequest){
            HttpServletRequest servletRequest = ((ServletServerHttpRequest)serverHttpRequest).getServletRequest();
            User user = (User)servletRequest.getSession().getAttribute("user");
            //这里给map赋值 相当于websockethandler的afterConnectionEstablished方法里的WebSocketSession
            //key是session，value是变量
            map.put("ws_user", user);
            System.out.println(user);

        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

        System.out.println("2");
    }
}
