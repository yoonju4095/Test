package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//DAO클래스는 실제로 데이터베이스에 접근을 해서 어떤 데이터를 빼오는 역할을 하는 클래스
public class BbsDAO {
		
		// connection:db에접근하게 해주는 소스를 넣을 부분
		private Connection conn; 
		//private PreparedStatement pstmt; bbsDAO에서는 여러개의 함수를 사용하기때문에 마찰이 없게 함수내부에서 선언을 해준다.
		private ResultSet rs;
		// mysql 연결 부분은 user 에서 사용한것과 동일하기 때문에 그대로 들고와준다.
		public BbsDAO() {
			// 생성자를 만들어준다.
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
		
		
		//게시판 글쓰기를 위해서는 총 3개의 함수가 필요하다.(ex. 현재의 시간을 가져오는 함수
		public String getDate() {
			//이건 mysql에서 현재의 시간을 가져오는 하나의 문장
			String SQL = "SELECT NOW()";
			try {
				//각각 함수끼리 데이터 접근에 있어서 마찰방지용으로 내부 pstmt선언 (현재 연결된 객체를 이용해서 SQL문장을 실행 준비단계로 만들어준다.)
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				//rs내부에 실제로 실행했을때 나오는 결과를 가져온다
				rs = pstmt.executeQuery();
				//결과가 있는경우는 다음과 같이 getString 1을 해서 현재의 그 날짜를 반환할 수 있게 해준다.
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				//오류 발생 내용을 콘솔에 띄움
				e.printStackTrace();
			}
			//데이터베이스 오류인데 웬만해선 디비오류가 날 이유가없기때문에 빈문장으로 넣어준다.
			return ""; 
		}
		//bbsID 게시글 번호 가져오는 함수
			public int getNext() { 
				//들어가는 SQL문장은 bbsID를 가져오는데 게시글 번호같은 경우는 1번부터 하나씩 늘어나야 하기때문에
				//마지막에 쓰인 글을 가져와서 그 글번호에다가 1을 더한 값이 그 다음번호가 되기때문에 내림차순으로 들고와서 +1해 주는 방식을 사용한다.
				String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
				try {
					//나머진 그대로 가고 리턴값만 수정
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						//나온 결과물에 1을 더해서 다음 게시글~ 
						return rs.getInt(1) + 1;
					}
					//현재 쓰이는 게시글이 하나도 없는 경우에는 결과가 안나오기 때문에 1을 리턴해준다.
					return 1;
				} catch (Exception e) {
					e.printStackTrace();
				}
				//데이터베이스 오류가 발생했을때 -1이 반환하면서 프로그래머에게 오류를 알려준다.
				return -1; 
			}
			//실제로 글을 작성하는 write함수 작성 Title,ID,Content를 외부에서 받아서 함수를 실행 시킨다.
			public int write(String bbsTitle, String userID, String bbsContent) { 
				//BBS 테이블에 들어갈 인자 6개를 ?로 선언 해준다.
				String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, getNext());
					pstmt.setString(2, bbsTitle);
					pstmt.setString(3, userID);
					pstmt.setString(4, getDate());
					pstmt.setString(5, bbsContent);
					//이 인자는 bbsAvailable이기 때문에 처음에 글이 작성되었을때는 글이 보여지는 형태가
					//되어야하고 삭제가 안된상태니까 1을 넣어준다.
					pstmt.setInt(6,1);
					//INSERT같은 경우에는 성공했을때 0이상의 값을 반환하기 때문에 return을 이렇게 작성해준다.
					return pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}
				//데이터베이스 오류
				return -1; 
			//이렇게 만들어 줌으로서 성공적으로 글이 들어갔는지 확인이 가능하다.
			}
 }