package es.ulpgc.ratingames.model;

import java.io.InputStream;
import java.time.LocalDate;

public class New {
    private final int id;
    private String title;
    private String body;
    private InputStream image;
    private LocalDate date;

    private final int journalist;
    
    public New(int id, String title, String body, int journalist, InputStream image) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.date = LocalDate.now();
        this.journalist = journalist;
        this.image = image;
    }
    
    public InputStream getImage() {
        return image;
    }

    public void setImage(InputStream image) {
        this.image = image;
    }

    public int getId() {
        return id;
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

    public int getJournalist() {
        return journalist;
    }
}
