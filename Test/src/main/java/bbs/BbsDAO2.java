package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//DAO클래스는 실제로 데이터베이스에 접근을 해서 어떤 데이터를 빼오는 역할을 하는 클래스
public class BbsDAO2 {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO2() {
		try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String connectionUrl = "jdbc:sqlserver://smtv.iptime.org:2433;databaseName=Notice;integratedSecurity=false;"
				+ "encrypt=false;trustServerCertificate=true;"
				+ "user=sa;"
				+ "password=@admin9150;";
		
		conn = DriverManager.getConnection(connectionUrl);
		System.out.println("서버접속 성공");

	} catch (Exception e) {
		e.printStackTrace();
	}
	}
	
	//현재의 시간을 가져오는 메소드
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	// 게시글 번호 가져오는 메소드
	public int getNext() {
		String SQL = "SELECT Board_ID FROM CS_Ques ORDER BY Board_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	//실제로 글을 작성하는 write 메소드 
	public int write(String comment_ID, String title, String contents) {
		//CS_Ans 테이블에 들어갈 인자의 갯수를 ?로 선언 해준다.
		String SQL = "INSERT INTO CS_Ques (Comment_ID, Title, Contents) VALUES ( ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext());
			pstmt.setString(1, comment_ID);
			pstmt.setString(2, title);
			pstmt.setString(3, contents);
			//pstmt.setString(5, Ins_Date_Time);
			pstmt.setInt(3, 1);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
		
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM CS_Ques WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setComment_ID(rs.getString(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContents(rs.getString(3));
				bbs.setIns_Date_Time(rs.getString(4));
				list.add(bbs);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setComment_ID(rs.getString(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContents(rs.getString(3));
				bbs.setIns_Date_Time(rs.getString(4));
				return bbs;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
