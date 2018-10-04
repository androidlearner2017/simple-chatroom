package domain;

import java.sql.Timestamp;

public class ChatMsg {

    private int id;
    private int chatUserId;
    private String  chatDate;
    private String content;
    private User user;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getChatUserId() {
        return chatUserId;
    }

    public void setChatUserId(int chatUserId) {
        this.chatUserId = chatUserId;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getChatDate() {
        return chatDate;
    }

    public void setChatDate(String chatDate) {
        this.chatDate = chatDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ChatMsg() {
    }

    public ChatMsg(int id, int chatUserId, String chatDate, String content) {
        this.id = id;
        this.chatUserId = chatUserId;
        this.chatDate = chatDate;
        this.content = content;
    }

    public ChatMsg(int chatUserId, String chatDate, String content) {
        this.chatUserId = chatUserId;
        this.chatDate = chatDate;
        this.content = content;
    }


    @Override
    public String toString() {
        return "ChatMsg{" +
                "id=" + id +
                ", chatUserId=" + chatUserId +
                ", chatDate='" + chatDate + '\'' +
                ", content='" + content + '\'' +
                ", user=" + user +
                '}';
    }
}
