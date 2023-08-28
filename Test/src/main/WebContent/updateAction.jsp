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
        int board_id = Integer.parseInt(request.getParameter("board_id"));
        String title = request.getParameter("Title"); // 수정
        String contents = request.getParameter("Contents"); // 수정

        if (title == null || contents == null || title.equals("") || contents.equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.update(board_id, title, contents);
            if (result <= 0) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정에 실패 했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                // 업데이트 날짜 업데이트 부분 삭제
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'bbs.jsp'");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
