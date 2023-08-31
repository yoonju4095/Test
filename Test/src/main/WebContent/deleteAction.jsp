<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>SMT Web Site</title>
</head>
<body>
	<%
		// 게시글의 board_id를 파라미터로 받아옴
		int board_id = Integer.parseInt(request.getParameter("board_id"));
	
		BbsDAO bbsDAO = new BbsDAO();  // BbsDAO 객체 생성
	    int result = bbsDAO.delete(board_id);  // 게시글 삭제 시도
	    
	    if (result == -1) {  // 삭제 실패 시
            PrintWriter script = response.getWriter();  // 스크립트 출력을 위한 PrintWriter 생성
            script.println("<script>");
            script.println("alert('글 삭제에 실패 했습니다.')");  // 경고창에 메시지 출력
            script.println("history.back()");  // 이전 페이지로 이동하는 스크립트 실행
            script.println("</script>");
        } else {  // 삭제 성공 시
            PrintWriter script = response.getWriter();  // 스크립트 출력을 위한 PrintWriter 생성
            script.println("<script>");
            script.println("location.href = 'bbs.jsp'");  // 'bbs.jsp' 페이지로 이동하는 스크립트 실행
            script.println("</script>");
        }
	%>
</body>
</html>