package dao;

import domain.ChatMsg;

import java.util.List;

public interface ChatDao {

    void addMsg(ChatMsg chatMsg);

    List<ChatMsg> findMsg(String conSearch);

    List<ChatMsg> testMsg();
}
