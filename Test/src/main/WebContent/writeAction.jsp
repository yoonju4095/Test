<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="comment_ID" />
<jsp:setProperty name="bbs" property="title" />
<jsp:setProperty name="bbs" property="contents" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>SMT Web Site</title>
</head>
<body>
	<%
		// 게시글의 제목 또는 내용이 비어있는 경우
		if (bbs.getTitle() == null || bbs.getContents() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					BbsDAO bbsDAO = new BbsDAO();
					 int result = bbsDAO.write(bbs.getComment_ID(), bbs.getTitle(), bbs.getContents());
					if (result == -1) {
						// 글쓰기에 실패한 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패 했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						// 글쓰기에 성공한 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}
				}	
	%>
</body>
</html>