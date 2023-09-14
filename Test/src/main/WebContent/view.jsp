<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Answer" %>
<%@ page import="bbs.AnswerDAO" %>

<%
	//게시글의 board_id를 파라미터로 받아와서 해당 게시글 정보를 가져옴
	int board_id = Integer.parseInt(request.getParameter("board_id"));
 	String comment_id = request.getParameter("board_id");
    BbsDAO bbsDAO = new BbsDAO();
    Bbs bbs = bbsDAO.getBbs(board_id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale"="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SMT Web Site</title>
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
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>						
					</tr>
				</thead>
				<tbody>
				<tr>
                    <td>글제목</td>
                    <td><%= bbs.getTitle() %></td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td><%= bbs.getComment_ID() %></td>
                </tr>
                <tr>
                    <td>작성일자</td>
                    <td><%= bbs.getIns_Date_Time().substring(0, 16) %></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><%= bbs.getContents() %></td>
                </tr>
				</tbody>
			</table>
			
			<form method="post" action="answerAction.jsp?>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<%-- 홀,짝 행 구분 --%>
					<thead>
						<tr>
							<th colspan="3"
								style="background-color: #eeeeeee; text-align: center;">댓글</th>
						</tr>
					</thead>
					
					<tbody>
					
						<%
							AnswerDAO answerDAO = new AnswerDAO();
							ArrayList<Answer> list = answerDAO.getList(board_id);
							for (Answer answer : list) {
						%>
						    <tr>
						          <td style="text-align: center;"><%= answer.getContents() %></td>
						        <td style="text-align: right;"><%= answer.getComment_ID() %>
						           <a href="answerUpdate.jsp?comment_ID=<%= answer.getComment_ID() %>&contents=<%= bbs.getContents() %>
						           &board_id=<%= bbs.getBoard_ID() %>" class="btn">수정</a>

						           <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="answerDelete.jsp?comment_ID=<%= answer.getComment_ID() %>
						           &board_id=<%= bbs.getBoard_ID() %>" class="btn">삭제</a>
						           
						        </td>
						   
						<%
							}
						%>
					
					 		</tr> 
						    
						    <tr>						    
						         <td colspan="2">
						         	<input type="hidden" name="board_id" value="<%= bbs.getBoard_ID() %>">
						        	<input type="text" class="form-control" placeholder="아이디를 입력하세요." name="comment_ID" maxlength="50" style="margin-bottom: 10px;">
						        	<input type="text" class="form-control" placeholder="댓글을 입력하세요." name="contents" maxlength="100" style="height: 50px;">
						        </td>
							</tr>
					
					</tbody>
					
				</table>
				<input type="submit" class="btn" value="댓글입력" style="margin-bottom: 10px;">
			</form>
			
			
			
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<a href="update.jsp?board_id=<%= bbs.getBoard_ID() %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?board_id=<%= bbs.getBoard_ID() %>" class="btn btn-primary">삭제</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>