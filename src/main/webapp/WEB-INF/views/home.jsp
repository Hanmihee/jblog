<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HOME</title>
<script language="javascript" type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<div id="content" class="row">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-6">
					<a href="/jblog"><img src="${pageContext.request.contextPath }/img/jblog_logo.png"></a>
				</div>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
			</div>

			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-5">
					<div class="row">
						<input type="text" id="search_text" class="form-control col-sm-6" />
					</div>
				</div>
				<div class="col-sm-4">
					<button type="button" class="btn btn-default col-sm-2"
						id="search_btn">검색</button>
				</div>
			</div>
		</div>
		<br>
		<div>
			<div class="col-sm-5"></div>
			<div class="col-sm-4"><form>
				<label><input type='checkbox' name='search_checkbox' value='blogname' />블로그이름</label>
				<label><input type='checkbox' name='search_checkbox' value='blogger' checked />블로거</label> 
			</form></div>
			<div class="col-sm-3"></div>
		</div>
		<c:import url="/WEB-INF/views/includes/navigation.jsp" />
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>