package model;

public class PlayerRating {
    private int rating;
    private String message;
    private final Player player;

    public PlayerRating(int rating, String message, Player player) {
        this.rating = rating;
        this.message = message;
        this.player = player;
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

    public Player getPlayer() {
        return player;
    }
}
