<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<div id="header">
	<div>
		<%-- <c:choose>
			<c:when test="${empty authUser }">
				<div>
					<a href="${pageContext.servletContext.contextPath }/user/login">로그인
					</a> <a href="${pageContext.servletContext.contextPath }/user/join"> | 회원가입</a>
				</div>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.servletContext.contextPath }/user/modify">
					회원정보수정 | </a>
				<a href="${pageContext.servletContext.contextPath }/user/logout">
					로그아웃 </a>
						${authUser.name }님 안녕하세요 ^^
					</c:otherwise>
		</c:choose> --%>
		<div>
			<div class="navbar navbar-default" role="navigation">
				<div class="container-fluid">
					<div class="navbar-header">
						<ul class = "nav navbar-nav">
							<li class="active"><a class="navbar-brand" href="/jblog">JBlog</a></li>
							<li><a href="#signin">회원가입</a></li>
							<li><a href="#login">로그인</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>