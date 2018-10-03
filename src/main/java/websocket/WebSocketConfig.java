package websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.*;
/**
 * Component注解告诉SpringMVC该类是一个SpringIOC容器下管理的类
 * 其实@Controller, @Service, @Repository是@Component的细化
 * Since Spring 5 you just need to implement the interface WebMvcConfigurer:
 *
 * public class MvcConfig implements WebMvcConfigurer {
 * This is because Java 8 introduced default methods on interfaces which
 * cover the functionality of the  WebMvcConfigurerAdapter class
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketConfigurer {
    public WebSocketConfig() {
    }

    //Handeler要添加@Component这里才能autowired
    @Autowired
    ChatWebSocketHandler handler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
        //添加websocket处理器，添加握手拦截器
        webSocketHandlerRegistry.addHandler(handler, "/user/login.do").addInterceptors(new MyHandShakeInterceptor());

    }

}

