package service;

import domain.User;

public interface UserService {

    User getUser(int id);

    User getUserByName(String username);
    //查询用户是否已经注册
    int userLogin(User user);

    void userRegister(User user);

}
