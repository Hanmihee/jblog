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
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입</title>
<script>
	function checkInput() {
		var obj = document.signUpForm;
		
		// TODO
		// messages 파일에 있는 요구 조건 자바스크립트도 추가하기
		
		if (isNull(obj.name)) {
			alert('이름을 입력해주세요');
			obj.inputName.focus();
			return false;
		} else if (isNull(obj.id)) {
			alert('아이디를 입력해주세요');
			obj.inputID.focus();
			return false;
		} /* else if (isNull(obj.validateID) //TODO
							|| (obj.validateID.value != obj.inputID.value)) {
						alert('아이디 중복확인을 해주세요');
						obj.inputID.focus();
						return false;
		} */else if (isNull(obj.password)) {
			alert('비밀번호를 입력해주세요');
			obj.password.focus();
			return false;
		} else if (obj.password.value != obj.passwordCk.value) {
			alert('비밀번호가 일치하지 않습니다.');
			obj.passwordCk.focus();
			return false;
		} else if (!(obj.checkbox.checked)) {
			alert('약관을 동의해주세요.');
			obj.passwordCk.focus();
			return false;
		} else {
			document.signUpForm.submit();
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

	function checkID() {
		sID = document.signUpForm.inputID.value;

		if (sID == "") {
			alert('입력된 아이디가 없습니다.');
		} else {
			/* window.open('/homework/checkID.do?id=' + sID, "",
					"width=400 height=150"); */
			// TODO
			// ajax로 아이디 중복확인 처리
		}
	}
</script>
</head>
<body>
	<div>
		<div id="container">
			<c:import url="/WEB-INF/views/includes/header.jsp" />
			<br>

			<div id="content" class="contentwrap" align="center">
				<article class="container">
				<div class="page-header">
					<hr width="80%">
					<h2>
						회원가입<small> 일반회원가입</small>
					</h2>
				</div>
				<br />


				<form:form action='${pageContext.request.contextPath }/user/join' method="post" class="form-horizontal" name="signUpForm"
					modelAttribute="userVo" onsubmit="return checkInput()">


					<div class="form-group">
						<label for="inputName" class="col-sm-3 control-label">이름</label>
						<div class="col-sm-6">
							<form:input path="name" class="form-control" placeholder="이름"/>
							<spring:hasBindErrors name="userVo">
							<c:if test="${errors.hasFieldErrors('name') }">
								<font color="red"> <spring:message
										code="${errors.getFieldError('name').codes[0] }"
										text="${errors.getFieldError('name').defaultMessage }" /> 
								</font>
							</c:if>
							</spring:hasBindErrors>
						</div>
					</div>

					<div class="form-group">
						<label for="inputID" class="col-sm-3 control-label">아이디</label>
						<div class="col-sm-4">
							<form:input path="id" class="form-control" placeholder="아이디"/>
							<spring:hasBindErrors name="userVo">
							<c:if test="${errors.hasFieldErrors('id') }">
								<font color="red"> <spring:message
										code="${errors.getFieldError('id').codes[0] }"
										text="${errors.getFieldError('id').defaultMessage }" /> 
								</font>
							</c:if>
							</spring:hasBindErrors>
						</div>
						<input type="hidden" name="validateID" />

						<div class="col-sm-2">
							<a class="btn btn-default" id="btnIdCheck" role="button">중복확인</a>
						</div>
					</div>

					<div name="inputPW" class="form-group">
						<label for="inputPassword" class="col-sm-3 control-label">비밀번호</label>
						<div name="child" class="col-sm-6">
							<form:input path="password" class="form-control" type="password" placeholder="비밀번호"/>
							<p class="help-block">숫자,문자 8자 이상 20이하</p>
							<spring:hasBindErrors name="userVo">
							<c:if test="${errors.hasFieldErrors('name') }">
								<font color="red"> <spring:message
										code="${errors.getFieldError('password').codes[0] }"
										text="${errors.getFieldError('password').defaultMessage }" /> 
								</font>
							</c:if>
							</spring:hasBindErrors>
						</div>
					</div>

					<div name="inputCHKPW" class="form-group">
						<label for="inputPasswordCheck" class="col-sm-3 control-label">비밀번호
							확인</label>
						<div name="child2" class="col-sm-6">
							<input type="password" class="form-control"
								name="passwordCk" placeholder="비밀번호 확인" />

							<p class="help-block">비밀번호를 한번 더 입력해주세요.</p>
						</div>
					</div>

					<br />
					<br />

					<div name="check" class="form-group">
						<div class="col-sm-7 control-label">
							<font> 약관동의<BR>
							</font> <label for="checkbox"> <input type="checkbox"
								name="checkbox" value="checkbox" /> 서비스 약관에 동의합니다.
							</label>
						</div>
					</div>

					<div class="form-group">
						<label for="signUp" class="col-sm-2 control-label"></label>
						<div class="col-sm-8">
							<button type="submit" class="btn btn-default">회원가입</button>
						</div>
					</div>
				</form:form> </article>
			</div>

			<br> <br> <br>
			<c:import url="/WEB-INF/views/includes/footer.jsp" />
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnIdCheck").on("click",function(){
			var id = $("#id").val();
			console.log(id);
			
			$.ajax({
				url:"${pageContext.request.contextPath}/user/checkid",
				type : "get",
				data : {id : id},
				success : function(result){
					if(result.data == true){
						alert("이미 가입되어있는 아이디 입니다.");
					}else{
						alert("사용 가능한 아이디 입니다.");
					}
				},
				error : function(xhr,status , error){
					alert("error");
					console.err(status + " : "+error);
				}
			});
		});
	});
</script>
</html>
