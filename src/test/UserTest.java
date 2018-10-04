import dao.ChatDao;
import dao.UserDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class UserTest {
    @Autowired
    private UserDao userDao;
    @Autowired
    private ChatDao chatDao;

    @Autowired
    private UserService userService;

    @Test
    public void test1() {
        System.out.println(userDao.getUser(1));
        System.out.println(userService.getUser(2));
        System.out.println(chatDao.getMsgUser(1));
    }
}
