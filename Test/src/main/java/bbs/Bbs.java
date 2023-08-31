package bbs;

public class Bbs {
    
    private int Board_ID;           // 게시글 번호
    private String Title;           // 게시글 제목
    private String Contents;        // 게시글 내용
    private String Ins_Date_Time;   // 게시글 작성 일자 및 시간
    private String Comment_ID;      // 게시글 작성자 아이디
    private String File_Name;       // 업로드된 파일명

    public int getBoard_ID() {
        return Board_ID;
    }
    public void setBoard_ID(int board_ID) {
        Board_ID = board_ID;
    }
    public String getComment_ID() {
        return Comment_ID;
    }
    public void setComment_ID(String comment_ID) {
        Comment_ID = comment_ID;
    }
    public String getTitle() {
        return Title;
    }
    public void setTitle(String title) {
        Title = title;
    }
    public String getContents() {
        return Contents;
    }
    public void setContents(String contents) {
        Contents = contents;
    }
    public String getIns_Date_Time() {
        return Ins_Date_Time;
    }
    public void setIns_Date_Time(String ins_Date_Time) {
        Ins_Date_Time = ins_Date_Time;
    }
    public String getFile_Name() {
        return File_Name;
    }
    public void setFile_Name(String file_Name) {
        File_Name = file_Name;
    }
}
