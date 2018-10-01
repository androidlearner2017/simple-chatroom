package service.impl;

import dao.UserDao;
import domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User getUser(int id) {
        return userDao.getUser(id);
    }

    @Override
    public int userLogin(User user){
        /*
        如果登录成功的话，count的返回值大于0
         */
        int flag = 0;
        flag = userDao.userLogin(user);
        return flag;
    }
    @Override
    public User getUserByName(String username) {
        return userDao.getUserByName(username);
    }

    @Override
    public void userRegister(User user){
        userDao.userRegister(user);
    }

}
