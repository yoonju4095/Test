<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>


<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>SMT Web Site</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // 폼에서 전송된 데이터 받기
    String comment_ID = request.getParameter("comment_ID");
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");

    
    out.println("comment_ID: " + comment_ID);
    out.println("title: " + title);
    out.println("contents: " + contents);

    // 파일 업로드 관련 코드
    String fileName = ""; // 파일명 초기화
    String uploadPath = "fileFolder";

    Part filePart = request.getPart("fileName");
    if (filePart != null) {
        fileName = BbsDAO.getFileName(filePart); // 파일 이름을 추출하는 함수를 호출
        if (!fileName.isEmpty()) {
            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(uploadPath + fileName)) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = input.read(buffer)) > 0) {
                    output.write(buffer, 0, length);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    // 여기까지 파일 업로드 처리

    // 게시물 작성 처리
    BbsDAO bbsDAO = new BbsDAO();
    //int result = bbsDAO.write(bbs.getComment_ID(), bbs.getTitle(), bbs.getContents(), fileName);
    int result = bbsDAO.write(comment_ID, title,contents,fileName);
    if (result == -1) {
        // 글쓰기에 실패한 경우
        response.setContentType("text/html;charset=UTF-8");
        out.println("<script>");
        out.println("alert('글쓰기에 실패 했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // 글쓰기에 성공한 경우
        response.setContentType("text/html;charset=UTF-8");
        out.println("<script>");
        out.println("location.href = 'bbs.jsp';"); // 글 목록 페이지로 이동
        out.println("</script>");
    }
%>


</body>
</html>
