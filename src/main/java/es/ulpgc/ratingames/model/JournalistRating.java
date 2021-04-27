package es.ulpgc.ratingames.model;

public class JournalistRating {
    private int rating;
    private String message;
    private final Journalist journalist;

    public JournalistRating(int rating, String message, Journalist journalist) {
        this.rating = rating;
        this.message = message;
        this.journalist = journalist;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Journalist getJournalist() {
        return journalist;
    }
}
