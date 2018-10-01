package dao;

import domain.User;

public interface UserDao {

    User getUser(int userID);

    User getUserByName(String userName);
    //判断用户是否已经注册
    int userLogin(User user);

    void userRegister(User user);



}
