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
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HOME</title>
<script language="javascript" type="text/javascript"
	src="${pageContext.request.contextPath }/jquery/jquery-1.12.4.js"></script>
</head>
<script type="text/javascript">
function checkInput() {

	var obj = document.blogSearchForm;

	if (isNull(obj.search_text)) {
		alert('검색 내용을 입력해주세요');
		return false;
	}else if( !(obj.blogger.checked || obj.blogname.checked) ){
		alert('검색 항목을 선택해주세요');
		return false;
	} 
	else {
		document.blogSearchForm.submit();
	}
}

function isNull(obj) {
	if (obj.value == "") {
		obj.focus();
		return true;
	} else {
		return false;
	}
}
</script>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<br> <br> <br> <br> <br> <br> <br>
		<br>
		<div id="content" class="row">
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-6">
					<a href="/jblog"><img
						src="${pageContext.request.contextPath }/img/jblog_logo.png"></a>
				</div>
				<br> <br> <br> <br> <br> <br> <br>
				<br>
			</div>

			<div class="row">
				<form action="${pageContext.request.contextPath }/blog/search" method="get" name="blogSearchForm"
					onsubmit="return checkInput();">
				<div class="col-sm-3"></div>
				<div class="col-sm-5">
					<div class="row">
						<input type="text" name="search_text" id="search_text" class="form-control col-sm-6" />
					</div>
				</div>
				<div class="col-sm-4">
					<button type="submit" class="btn btn-default col-sm-2" id="search_btn" >검색</button>
				</div>
				<div class="col-sm-5"></div>
				<div class="col-sm-4">
					<label><input type='radio' name='search_radio'value='blogname' id="blogname"/>블로그이름</label> 
					<label><input type='radio' name='search_radio' value='blogger' id="blogger"/>블로거</label>
				</div>
				</form>
				<div class="col-sm-3"></div>
			</div>
		</div>
		<br>
		<c:import url="/WEB-INF/views/includes/navigation.jsp" />
		<br> <br> <br> <br> <br> <br> <br>
		<br>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>