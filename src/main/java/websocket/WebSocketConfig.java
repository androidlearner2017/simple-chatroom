package websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig extends AbstractWebSocketMessageBrokerConfigurer {
    public WebSocketConfig() {
    }

    public void registerStompEndpoints(StompEndpointRegistry stompEndpointRegistry) {
        ////表示添加了一个/socket端点，客户端就可以通过这个端点来进行连接。withSockJS()的作用是开启SockJS支持.
        stompEndpointRegistry.addEndpoint("/socket").withSockJS();
    }

    public void configureMessageBroker(MessageBrokerRegistry registry) {
        //指服务端接收地址的前缀，意思就是说客户端给服务端发消息的地址的前缀
        registry.setApplicationDestinationPrefixes("/app");
        //表示客户端订阅地址的前缀信息，也就是客户端接收服务端消息的地址的前缀信息
        registry.enableSimpleBroker("/topic");
    }
}

