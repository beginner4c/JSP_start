<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"></jsp:useBean>
<jsp:setProperty name="bbs" property="bbsTitle"></jsp:setProperty>
<jsp:setProperty name="bbs" property="bbsContent"></jsp:setProperty>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null; 
		// session 할당
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){ // 로그인이 되어있지 않은 경우
			PrintWriter script = response.getWriter();
			script.println("alert('로그인을 해야 작성이 가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){ // 정보 입력을  안 한 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안 된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
				} else{
					BbsDAO bbsDAO = new BbsDAO();
						
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						
					if(result == -1){ // 데이터베이스 오류 발생 시
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 등록에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					}
					else { // 글쓰기 성공
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}
				}
		}
		
	%>
</body>
</html>