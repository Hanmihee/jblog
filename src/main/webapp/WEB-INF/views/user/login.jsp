<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String flag = request.getParameter("flag");
	pageContext.setAttribute("flag", flag);
%>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<script>
	function doCheck() {
		console.log("들어옴1");
		var f = document.loginForm;
		if (isNull(f.id)) {
			console.log("들어옴2");
			alert("아이디를 입력해주세요");
			return false;
		}
		else if (isNull(f.password)) {
			console.log("들어옴3");
			alert("비밀번호를 입력해주세요");
			return false;
		}else {
			console.log("들어옴4");
			document.loginForm.submit();
		}
	}
	function isNull(obj) {
		if (obj.value == "") {
			obj.focus();
			return true;
		}else{
			return false;
		}
	}
</script>
</head>
<body>
	<div>
		<div id="container">
			<c:import url="/WEB-INF/views/includes/header.jsp" />

			<div>
				<div class="container">
					<div class="row">
						<div class="col-sm-6 col-md-4 col-md-offset-4">
							<div class="account-wall">
								<div class="page-header">
									<hr width="70%">
									<center>
										<h2>
											<small>JBlog</small> Login
										</h2>
									</center>
								</div>
								<div class="row">
									<center>
										<div class='col-sm-5'>
											<img class="profile-img"
												src="http://www.buira.org/assets/images/shared/default-profile.png" />
											
										</div>
									</center>
								</div>
								<br />
								<br />
								<!-- 로그인을 처리하는 Controller의 주소 입력  -->
								<form class="form-signin" name="loginForm" action='${pageContext.request.contextPath }/user/login' method="POST" onsubmit="return doCheck()">
									<c:if test="${!empty flag }">
										<center><font color="red">로그인 실패</font></center>
										<center><font color="red">아이디 패스워드를 확인해주세요</font></center><br>
									</c:if>
									<input type="text" class="form-control" placeholder="ID"name="id" >
									<input type="password" class="form-control" placeholder="PASSWORD" name="password"> <br />
									<button class="btn btn-lg btn-default btn-block" type="submit">Login</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

			<br>
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
		</div>
	</div>
</body>
</html>