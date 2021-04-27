package es.ulpgc.ratingames.model;

import java.util.ArrayList;
import java.util.List;

public class Game {
    private final int id;
    private String title;
    private final String studio;
    private String players;
    private String releaseDate;
    private String language;
    private int minimunAge;
    private Platform platform;
    private List<Genre> genre;
    private final List<PlayerRating> playerRatings;
    private final List<JournalistRating> journalistRatings;

    public Game(int id, String title, String studio, String players,
                String releaseDate,String language, int minimunAge,
                Platform platform, List<Genre> genre) {
        this.id = id;
        this.title = title;
        this.studio = studio;
        this.players = players;
        this.releaseDate = releaseDate;
        this.language = language;
        this.minimunAge = minimunAge;
        this.platform = platform;
        this.genre = genre;
        playerRatings = new ArrayList<>();
        journalistRatings = new ArrayList<>();
    }

    public Game(int id, String title, String studio, Platform platform) {
        this.id = id;
        this.title = title;
        this.studio = studio;
        this.platform = platform;
        playerRatings = new ArrayList<>();
        journalistRatings = new ArrayList<>();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStudio() {
        return studio;
    }

    public String getPlayers() {
        return players;
    }

    public void setPlayers(String players) {
        this.players = players;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public int getMinimunAge() {
        return minimunAge;
    }

    public void setMinimunAge(int minimunAge) {
        this.minimunAge = minimunAge;
    }

    public Platform getPlatform() {
        return platform;
    }

    public void setPlatform(Platform platform) {
        this.platform = platform;
    }

    public List<Genre> getGenre() {
        return genre;
    }

    public void setGenre(List<Genre> genre) {
        this.genre = genre;
    }

    public List<PlayerRating> getPlayerRatings() {
        return playerRatings;
    }

    public List<JournalistRating> getJournalistRatings() {
        return journalistRatings;
    }

    public void addPlayerRating(PlayerRating playerRating){
        playerRatings.add(playerRating);
    }

    public void removePlayerRating(PlayerRating playerRating){
        playerRatings.remove(playerRating);
    }

    public void addJournalistRating(JournalistRating journalistRating){
        journalistRatings.add(journalistRating);
    }

    public void removeJournalistRating(JournalistRating journalistRating){
        journalistRatings.remove(journalistRating);
    }
}
