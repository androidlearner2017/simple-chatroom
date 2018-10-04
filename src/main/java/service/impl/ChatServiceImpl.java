package service.impl;

import dao.ChatDao;
import domain.ChatMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ChatService;

import java.util.List;

@Service
public class ChatServiceImpl implements ChatService {
    @Autowired
    private ChatDao chatDao;

    /*
    根据搜索内容查找聊天记录
     */
    @Override
    public List<ChatMsg> findMsgList(String conSearch) {
        for (ChatMsg chat : chatDao.findMsg(conSearch)){
            System.out.println(chat);
        }
        return  chatDao.findMsg(conSearch);
    }

    @Override
    public void addMessage(ChatMsg chatMsg) {
        chatDao.addMsg(chatMsg);
    }

    public void testMsg(){
        List<ChatMsg> list = chatDao.testMsg();
        for (ChatMsg chat : list){
            System.out.println(chat);
        }
    }
}
