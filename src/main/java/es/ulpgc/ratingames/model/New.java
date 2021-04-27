package es.ulpgc.ratingames.model;

import java.time.LocalDate;

public class New {
    private final int id;
    private String title;
    private String body;
    //private ? image;
    private LocalDate date;
    private final Journalist journalist;

    public New(int id, String title, String body, Journalist journalist) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.date = LocalDate.now();
        this.journalist = journalist;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public Journalist getJournalist() {
        return journalist;
    }
}
