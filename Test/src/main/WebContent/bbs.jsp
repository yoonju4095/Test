
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SMT Web Site</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">SMT Web Site</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form action="bbs.jsp" method="get" class="form-inline mb-3">
				<input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요" value="<%= request.getParameter("searchKeyword") %>">
				<input type="submit" value="검색" class="btn btn-primary ml-2">
			</form>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%@ page isErrorPage="true" %>
					<%
						int pageSize = 10; // 한 페이지에 보여줄 게시글 수
						int pageNumber = 1; // 기본 페이지 번호는 1
						String pageNumberStr = request.getParameter("pageNumber");
						if (pageNumberStr != null && !pageNumberStr.isEmpty()) {
							pageNumber = Integer.parseInt(pageNumberStr);
						}

						String searchKeyword = request.getParameter("searchKeyword");
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list;
						boolean hasPrevPage;
						boolean hasNextPage;

						if (searchKeyword != null && !searchKeyword.isEmpty()) {
							list = bbsDAO.searchList(searchKeyword, pageNumber, pageSize);
							hasPrevPage = pageNumber > 1;
							hasNextPage = bbsDAO.nextPage(pageNumber, pageSize);
						} else {
							list = bbsDAO.getList(pageNumber, pageSize);
							hasPrevPage = pageNumber > 1;
							hasNextPage = bbsDAO.nextPage(pageNumber, pageSize);
						}
						for (Bbs bbs : list) {
					%>
					<tr>
						<td><a href="view.jsp?board_id=<%= bbs.getBoard_ID() %>"><%= bbs.getBoard_ID() %></a></td>
						<td><a href="view.jsp?board_id=<%= bbs.getBoard_ID() %>"><%= bbs.getTitle() %></a></td>
						<td><%= bbs.getComment_ID() %></td>
						<td><%= bbs.getIns_Date_Time().substring(0, 16) %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

			<% if (hasPrevPage) { %>
    <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-default">이전 페이지</a>
<% } %>

<% if (hasNextPage) { %>
    <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-default">다음 페이지</a>
<% } %>


			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>