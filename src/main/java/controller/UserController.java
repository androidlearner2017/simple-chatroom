package controller;

import domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping(value ="/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("getUser")
    public @ResponseBody
    User getUser(int userID) {
        return userService.getUser(userID);
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "register";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView loginUser(String userName, String password, HttpSession session) {
        System.out.println(userName);
        ModelAndView modelAndView=null;
        User user = new User(userName,password);
        int result = userService.userLogin(user);
        if(result > 0){
            User userGet = userService.getUserByName(user.getUserName());
            session.setAttribute("user",userGet);
            modelAndView=new ModelAndView("chat");
        }else{
            modelAndView=new ModelAndView("redirect:register");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/register" ,method = RequestMethod.POST)
    public ModelAndView register(String userName,String password ){
        ModelAndView modelAndView=null;
        User user = new User();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        user.setUserName(userName);
        user.setPassword(password);
        user.setRegisterData(dateFormat.format(new Date()));
        userService.userRegister(user);
        modelAndView=new ModelAndView("redirect:register");
        return modelAndView;
    }
}
