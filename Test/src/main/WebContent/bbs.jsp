<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!-- BbsDAO 함수를 사용하기때문에 가져오기 -->
<%@ page import="bbs.BbsDAO" %>
<!-- DAO쪽을 사용하면 당연히 javaBeans도 사용되니 들고온다.-->
<%@ page import="bbs.Bbs" %>
<!-- ArrayList같은 경우는 게시판의 목록을 가져오기위해 필요한 것 -->
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				 <tbody>
		            <%
		                BbsDAO bbsDAO = new BbsDAO();
		                ArrayList<Bbs> list = bbsDAO.getList(1);
		                
		                for (Bbs bbs : list) {
		            %>
		                <tr>
		                    <td><a href="view.jsp?board_id=<%= bbs.getBoard_ID() %>"><%= bbs.getBoard_ID() %></a></td>
		            		<td><a href="view.jsp?board_id=<%= bbs.getBoard_ID() %>"><%= bbs.getTitle() %></a></td>
		                    <td><%= bbs.getComment_ID() %></td>
		                    <td><%= bbs.getIns_Date_Time() %></td>
		                </tr>
		            <%
		                }
		            %>
				 </tbody>
			</table>

			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>