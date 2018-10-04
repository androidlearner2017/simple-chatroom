package controller;

import domain.ChatMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import service.ChatService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @RequestMapping(value = "/findMsg", method = RequestMethod.POST)
    public ModelAndView findMsg(String conSearch, HttpSession session) {

         List<ChatMsg> listMsg = chatService.findMsgList(conSearch);
         session.setAttribute("msgList",listMsg);

        chatService.testMsg();
        ModelAndView modelAndView = new ModelAndView("chatHistory");
        return modelAndView;
    }
}
