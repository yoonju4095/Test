package bbs;

public class Answer {
    private int board_ID;
    private String comment_ID;
    private String answer_ID;
    private String contents;

    // 게터와 세터 메서드는 필요한 필드에 대해 올바른 이름을 사용하세요.
    public int getBoard_ID() {
        return board_ID;
    }

    public void setBoard_ID(int board_ID) {
        this.board_ID = board_ID;
    }

    public String getComment_ID() {
        return comment_ID;
    }

    public void setComment_ID(String comment_ID) {
        this.comment_ID = comment_ID;
    }

    public String getAnswer_ID() {
        return answer_ID;
    }

    public void setAnswer_ID(String answer_ID) {
        this.answer_ID = answer_ID;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }
}
