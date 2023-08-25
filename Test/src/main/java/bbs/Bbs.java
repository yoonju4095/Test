package bbs;

public class Bbs {
	
	private int Board_ID;
	private String Title;		
	private String Contents;	
	private String Ins_Date_Time;	
	
	public int getBoard_ID() {
		return Board_ID;
	}
	public void setBoard_ID(int board_ID) {
		Board_ID = board_ID;
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

}