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
.main_nav ul > li{ 
	float: left;  
 }
 
 #jumbo{
	background-color: #A4A4A4;
	color: white !important;
 }
</style>
</head>
<body>
<div class="container">
	<div class="jumbotron" id="jumbo"> 
		<center><h2>${blog.title}</h2></center>
	</div>
	<div align="right">
		<nav class="main_nav">
			<ul>
				<li><a href="${pageContext.servletContext.contextPath }/admin/basicsetting">내 블로그 관리</a></li>
				<li><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
			</ul>
		</nav>
	</div>
</div>
</body>
</html>