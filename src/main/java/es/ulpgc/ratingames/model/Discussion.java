package es.ulpgc.ratingames.model;

import java.util.ArrayList;
import java.util.List;

public class Discussion {
    private final int id;
    private String subject;
    private final List<Message> messages;

    public Discussion(int id, String subject) {
        this.id = id;
        this.subject = subject;
        messages = new ArrayList<>();
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void addMessage(Message message){
        messages.add(message);
    }
    public void removeMessage(Message message){
        messages.remove(message);
    }

}
