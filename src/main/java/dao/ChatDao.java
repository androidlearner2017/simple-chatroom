package dao;

import domain.ChatMsg;

import java.util.List;

public interface ChatDao {

    void addMsg(ChatMsg chatMsg);

    List<ChatMsg> findMsg(String conSearch);

    List<ChatMsg> testMsg();

    //这是用来测试级联属性的
    ChatMsg getMsgUser(Integer id);
}
