package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//DAO 클래스는 데이터베이스에 접근하여 데이터를 처리하는 역할을 수행합니다.
public class BbsDAO {
	
	private Connection conn;	// 데이터베이스 연결을 위한 Connection 객체
	private ResultSet rs;		// 결과셋을 담기 위한 ResultSet 객체
	
	// 생성자: 데이터베이스 연결을 초기화합니다.
	public BbsDAO() {
		try {
		// SQL Server JDBC 드라이버 클래스를 로드합니다.
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		// 데이터베이스 연결 정보를 설정합니다.
		String connectionUrl = "jdbc:sqlserver://smtv.iptime.org:2433;databaseName=Notice;integratedSecurity=false;"
				+ "encrypt=false;trustServerCertificate=true;"
				+ "user=sa;"
				+ "password=@admin9150;";
		// Connection을 생성하여 데이터베이스에 접속합니다.
		conn = DriverManager.getConnection(connectionUrl);
		System.out.println("서버접속 성공");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 현재 날짜와 시간을 가져오는 메소드
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
	
	// 다음 게시글 번호를 가져오는 메소드
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
	    String SQL = "INSERT INTO CS_Ques (Comment_ID, Title, Contents, Ins_Date_Time) VALUES (?, ?, ?, GETDATE())";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, comment_ID);
	        pstmt.setString(2, title);
	        pstmt.setString(3, contents);

	        return pstmt.executeUpdate(); 
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}

	// 페이지에 해당하는 게시글 목록을 가져오는 메소드	
	public ArrayList<Bbs> getList(int pageNumber) {
	    int pageSize = 10; // 페이지당 보여줄 게시글 수
	    int offset = (pageNumber - 1) * pageSize; // 페이지 번호에 따른 오프셋 계산

	    String SQL = "SELECT * FROM CS_Ques ORDER BY Board_ID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
	    ArrayList<Bbs> list = new ArrayList<Bbs>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, offset);
	        pstmt.setInt(2, pageSize);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setBoard_ID(rs.getInt("Board_ID")); 
	            bbs.setComment_ID(rs.getString("Comment_ID"));
	            bbs.setTitle(rs.getString("Title"));
	            bbs.setContents(rs.getString("Contents"));
	            bbs.setIns_Date_Time(rs.getString("Ins_Date_Time"));
	            list.add(bbs);
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	// 다음 페이지 존재 여부를 확인하는 메소드
	public boolean nextPage(int pageNumber) {
	    String SQL = "SELECT * FROM CS_Ques WHERE Board_ID < ? AND bbsAvailable = 1 ORDER BY Board_ID DESC";
	    
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        // 수정된 부분
	        pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return true; // 다음 페이지 존재함
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return false; // 다음 페이지 없음
	}

	// 특정 게시글 정보를 가져오는 메소드
	public Bbs getBbs(int board_id) {
	    String SQL = "SELECT * FROM CS_Ques WHERE Board_ID = ?";
	    
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, board_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setBoard_ID(rs.getInt("Board_ID"));
	            bbs.setComment_ID(rs.getString("Comment_ID"));
	            bbs.setTitle(rs.getString("Title"));
	            bbs.setContents(rs.getString("Contents"));
	            bbs.setIns_Date_Time(rs.getString("Ins_Date_Time"));
	            return bbs;
	        }            
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	// 게시글 수정 메소드
	public int update(int board_id, String title, String contents) {
	    String SQL = "UPDATE CS_Ques SET Title = ?, Contents = ?, Upd_Date_Time = GETDATE() WHERE Board_ID =?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, title);
	        pstmt.setString(2, contents);
	        pstmt.setInt(3, board_id);
	        
	        return pstmt.executeUpdate(); 
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}
	
	// 게시글 삭제 메소드
	public int delete(int board_id) {
		String SQL = "DELETE FROM CS_Ques WHERE Board_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_id);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
