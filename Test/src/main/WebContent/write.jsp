<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SMT Web Site</title>
</head>
<body>
	<!-- 웹사이트 공통메뉴 -->
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span><!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">SMT Web Site</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <!-- 현재의 게시판 화면이라는 것을 사용자에게 보여주는 부분 -->
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>

		</div>
		<!-- 화면 공통메뉴 끝 -->
	</nav>
	<!-- 게시판 글쓰기 화면 구현-->
	<div class="container">
		<!-- bbs에서 만든 양식 참조 사용 -->
		<div class = "row">
		<!-- form -->
			<form method="post" encType = "multipart/form-data" action="writeAction.jsp">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd"> 
				<thead>
					<tr>
						<!-- colspan="2" 현재의 속성이 2개의 열을 차지하게 해준다. -->
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<!-- 글 제목과 글 작성이 각각 한줄로 들어갈 수 있도록 tr로 각각 묶어준다. -->
					<tr>
					<!-- 아이디를 작성할 수있는 input을 삽입 해준다. -->
						<td><input type="text" class="form-control" placeholder="아이디" name="comment_ID" maxlength="50"></td>
					</tr>
					<tr>
					<!-- 글 제목을 작성할 수있는 input을 삽입 해준다. -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50"></td>
					</tr>
					<tr>
					<!-- 장문의 글을 작성 할 수있는 textarea태그를 이용해서 Content를 입력하도록 삽입한다. -->
						<td><textarea class="form-control" placeholder="글 내용" name="contents" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
					<tr>
					<!-- 사진 업로드 -->
						<td><input type="file" name=fileName></td>
					</tr>
				</tbody>
			</table>
				<!-- 사용자에게 보여지는 글쓰기 버튼을 구현 -->	
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기"/>
			</form>
		</div>
	<!-- 글쓰기 화면 구현 끝 -->	
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>