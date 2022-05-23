<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID"></jsp:setProperty>
<jsp:setProperty name="user" property="userPassword"></jsp:setProperty>
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
		if(userID != null){ // 로그인이 되어있는 경우
			PrintWriter script = response.getWriter();
			script.println("alert('로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){ // 로그인 성공
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if( result == 0){ // 비번 틀림
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if( result == -1){ // 아이디 없음
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if( result == -2){ // db 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류 발생')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>