package service.impl;

import dao.ChatDao;
import domain.ChatMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ChatService;
@Service
public class ChatServiceImpl implements ChatService {
    @Autowired
    private ChatDao chatDao;

    @Override
    public void addMessage(ChatMsg chatMsg) {
        chatDao.addMsg(chatMsg);
    }
}
