package service;

import domain.ChatMsg;

import java.util.List;

public interface ChatService {

    void addMessage(ChatMsg chatMsg);

    List<ChatMsg> findMsgList(String conSearch);

    void testMsg();
}
