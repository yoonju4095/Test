<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.AnswerDAO" %>

<%
// 게시글을 삭제할 때 필요한 정보 수집
String comment_ID = request.getParameter("comment_ID");
String board_id = request.getParameter("board_id"); // 해당 게시글의 board_id를 가져옵니다.

if (comment_ID != null) {
    AnswerDAO answerDAO = new AnswerDAO();
    
    // 댓글 삭제 메서드 호출
    int result = answerDAO.delete(comment_ID);
    
    if (result == 1) {
        out.println("댓글이 삭제되었습니다.");
        
    } else {
        out.println("댓글 삭제 실패");
    }
    
    // 해당 게시글의 상세 페이지로 이동
    response.sendRedirect("view.jsp?board_id=" + board_id);
} else {
    out.println("댓글 ID를 받아오지 못했습니다.");
}
%>
