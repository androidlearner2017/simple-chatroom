package domain;

import java.sql.Timestamp;

public class ChatMsg {

    private int id;
    private int chatUserId;
    private Timestamp chatDate;
    private String content;

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
        content = content;
    }

    public Timestamp getChatDate() {
        return chatDate;
    }

    public void setChatDate(Timestamp chatDate) {
        this.chatDate = chatDate;
    }
}
