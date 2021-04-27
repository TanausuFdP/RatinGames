package model;

import java.util.List;

public class Forum {
    private final List<Discussion> discussions;

    public Forum(List<Discussion> discussions) {
        this.discussions = discussions;
    }

    public List<Discussion> getDiscussions() {
        return discussions;
    }
}
