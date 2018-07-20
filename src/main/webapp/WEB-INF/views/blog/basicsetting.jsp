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
		<div class="row">
			<div class="col-sm-1"></div>
			<div>
				<div>
					<a href=""><font size="4">기본설정 &nbsp&nbsp</font> </a> <a href=""><font
						size="4">카테고리 설정 &nbsp&nbsp</font> </a> <a href=""><font size="4">글
							작성 &nbsp&nbsp</font> </a>
				</div>
				<br>
				<br>
				
				<!-- TODO : multipart 추가 -->
				<form action="${pageContext.request.contextPath}/업로드할 경로" class="form-horizontal" name="blogSetting" method="post">

					<div class="form-group">
						<label for="blogName" class="col-sm-3 control-label">블로그
							제목</label>
						<div class="col-sm-6">
							<div name="child2" class="col-sm-6">
								<input type="text" class="form-control" name="blogName" />
							</div>
							<BR>
						</div>
					</div>

					<div class="form-group">
						<label for="blogName" class="col-sm-3 control-label">로고
							이미지</label>
						<div class="col-sm-6">
							<div name="child2" class="col-sm-6">
								<!-- 로고 이미지 -->
							</div>
							<BR>
							<button class="btn btn-default">파일 선택</button>
						</div>
					</div><br><br>
					
					<div class="form-group">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<button class="btn btn-default">기본 설정 변경</button>
					</div>
					</div>
					<br>
					<br>

				</form>
				<div class="col-sm-1"></div>
			</div>
		</div>
		<br>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>