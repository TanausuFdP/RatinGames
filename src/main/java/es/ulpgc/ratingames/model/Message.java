package model;

import java.time.LocalDate;

public class Message {
    private final int id;
    private String body;
    private LocalDate date;
    private final ForumUser forumUser;

    public Message(int id, String body, LocalDate date, ForumUser forumUser) {
        this.id = id;
        this.body = body;
        this.date = date;
        this.forumUser = forumUser;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public ForumUser getUser() {
        return forumUser;
    }
}
