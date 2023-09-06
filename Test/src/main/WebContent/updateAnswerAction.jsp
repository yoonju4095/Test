<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.AnswerDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Answer" %>

<%
    // 폼에서 넘어온 데이터를 받습니다.
    String comment_ID = request.getParameter("comment_ID");
    String contents = request.getParameter("contents");
    String board_id = request.getParameter("board_id"); // 해당 게시글의 board_id를 가져옵니다.

    // 데이터베이스 업데이트를 위해 AnswerDAO를 사용합니다.
    AnswerDAO answerDAO = new AnswerDAO();

    // 댓글 수정 메서드를 호출하여 수정을 수행합니다.
    int result = answerDAO.update(comment_ID, contents);

    if (result > 0) {
        // 댓글 수정 성공 시 해당 게시물의 상세 페이지로 이동합니다.
        response.sendRedirect("bbs.jsp");
    } else {
        // 댓글 수정 실패 시 경고창을 띄우고 이전 페이지로 돌아갑니다.
        out.println("<script>alert('댓글 수정 실패'); history.go(-1);</script>");
    }
%>

