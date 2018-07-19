<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div id="container">
			<c:import url="/WEB-INF/views/includes/header.jsp" />

			<div class="row">
				<div class="col-sm-5"></div>
				<div class="col-sm-4">
					<h2>회원가입 성공</h2>
					<a href="${pageContext.servletContext.contextPath }/user/login">	로그인 하기</a>
				</div>
				<div class="col-sm-4"></div>
			</div>
			<br><br><br>
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
		</div>
	</div>
</body>
</html>

