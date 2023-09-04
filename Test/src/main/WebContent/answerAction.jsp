<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bbs.AnswerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="answer" class="bbs.Answer" scope="page" />
<jsp:setProperty name="answer" property="contents" />
<jsp:setProperty name="answer" property="comment_ID" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" initial-scale="1">
    <title>SMT Web Site</title>
</head>
<body>
<%

	String comment_IDParam = request.getParameter("comment_ID");
	String contentsParam = request.getParameter("contents");
    String boardIdParam = request.getParameter("board_id");
    
    if (boardIdParam != null) {
        int board_id = Integer.parseInt(boardIdParam);
        // 댓글 내용을 가져옵니다.
        String contents = answer.getContents();
		String comment_id = answer.getComment_ID();
        
        // 댓글 작성 로직을 수행합니다.
        AnswerDAO answerDAO = new AnswerDAO();
        int result = answerDAO.write(board_id, comment_id, contents);
        
        if (result == -1) {
            // 댓글 쓰기 실패 시 처리
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글쓰기에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            // 댓글 쓰기 성공 시 처리
            String url = "view.jsp?board_id=" + board_id;
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='" + url + "'");
            script.println("</script>");
        }
    } else {
        // "board_id" 파라미터가 제공되지 않은 경우에 대한 처리
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('게시글 ID가 제공되지 않았습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>

</body>
</html>
