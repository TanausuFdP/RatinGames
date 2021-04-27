package es.ulpgc.ratingames.model;

public abstract class ForumUser extends User {
    public ForumUser(int id, String username, String password, String email) {
        super(id, username, password, email);
    }
}
