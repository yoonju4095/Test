<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.AnswerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Answer" %>

<%
    // 수정할 댓글의 comment_ID를 파라미터에서 가져옵니다.
    String comment_ID = request.getParameter("comment_ID");
    
    // 해당 comment_ID로 댓글 정보를 불러옵니다.
    AnswerDAO answerDAO = new AnswerDAO();
    Answer answer = answerDAO.getContents(comment_ID);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 수정</title>
</head>
<body>
    <h1>댓글 수정</h1>
    <form method="post" action="updateAnswerAction.jsp">
        <input type="hidden" name="comment_ID" value="<%= comment_ID %>">
        <input type="hidden" name="board_id" value="<%= answer.getBoard_ID() %>"> <!-- 댓글의 게시물 ID도 함께 전송 -->
        <textarea name="contents" rows="5" cols="40"><%= answer.getContents() %></textarea><br>
        <input type="submit" value="수정">
    </form>
    <%-- <a href="view.jsp?board_id=<%= answer.getBoard_ID() %>">게시물로 돌아가기</a> --%>
</body>
</html>
