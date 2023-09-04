package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AnswerDAO {

	private Connection conn;
	private ResultSet rs;
	
	public AnswerDAO() {
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
	
	
	public ArrayList<Answer> getList(int boardID) {
	    String SQL = "SELECT * FROM CS_Ans WHERE Board_ID = ? ORDER BY Ins_Date_Time DESC";
	    ArrayList<Answer> list = new ArrayList<Answer>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, boardID);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Answer answer = new Answer();
	            answer.setComment_ID(rs.getString("Comment_ID"));
	            answer.setAnswer_ID(rs.getString("Answer_ID"));
	            answer.setContents(rs.getString("Contents"));
	            list.add(answer);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}


	
	   public int getNext() {
	        String SQL = "SELECT MAX(CAST(Answer_ID AS INT)) FROM CS_Ans";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                return rs.getInt(1) + 1;
	            }
	            return 1;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return -1;
	    }

	   public int write(int boardID, String comment_ID , String contents) {
		    String SQL = "INSERT INTO CS_Ans (Board_ID, Comment_ID, Contents, Ins_Date_Time) VALUES (?, ?, ?, GETDATE())";

		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setInt(1, boardID);
		        pstmt.setString(2, comment_ID);
		        pstmt.setString(3, contents);

		        return pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1;
		}

	}









