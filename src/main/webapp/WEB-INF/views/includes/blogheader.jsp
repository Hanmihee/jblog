<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.main_nav ul {
	float: right;
	list-style: none;
}

.main_nav ul>li {
	float: left;
}

#jumbo {
	color: white !important;
} 
</style>
</head>
<body>
	<div class="container">
		<div class="jumbotron" id="jumbo">
			<center>
				<h2>${blogVo.title}</h2>
			</center>
		</div>
		<div align="right">
			<nav class="main_nav"> <c:choose>
				<c:when test="${empty authUser }">
					<ul>
						<li><a
							href="${pageContext.servletContext.contextPath }/user/login">로그인</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<!-- TODO -->
					<!-- 사용자 자신의 블로그일때만 블로그 관리가 뜨드록 설정 -->
					<ul>
						<c:if test="${ authUser.id eq userId }"> 
							<li><a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/basicsetting">
																									내블로그 관리&nbsp&nbsp</a></li>
						</c:if>
						<li><a
							href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
					</ul>
				</c:otherwise>
			</c:choose> </nav>
		</div>
	</div>
</body>
</html>


