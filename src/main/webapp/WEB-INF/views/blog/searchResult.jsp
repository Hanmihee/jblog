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
    <br> 
    <div class="row"> 
      <div class="col-sm-2"></div> 
     <c:choose>
     <c:when test="${!empty searchVo }">
      <div class="col-sm-8"> 
		<h2>검색결과</h2>
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th width="70%">blog Name</th>
						<th width="30%">blogger Name</th>
					</tr>
				</thead>
				<tbody id="searchResultList">
					 <c:forEach var="search" items="${searchVo}" varStatus="Loop">
						<tr>
							<td><a href="${pageContext.servletContext.contextPath }/blog/${search.id}">${search.blogName}</a></td>
							<td>${search.userName}</td>
						</tr>
					</c:forEach> 
				</tbody>
			</table>
			<form action="${pageContext.request.contextPath }/blog/search" method="get" name="blogSearchForm"
					onsubmit="return checkInput();">
				<div class="col-sm-1"></div>
				<div class="col-sm-7">
					<div class="row">
						<input type="text" name="search_text" id="search_text" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<button type="submit" class="btn btn-default" id="search_btn" >검색</button>
				</div>
				<div class="col-sm-3"></div>
				<div class="col-sm-4">
					<label><input type='radio' name='search_radio'value='blogname' id="blogname"/>블로그이름</label> 
					<label><input type='radio' name='search_radio' value='blogger' id="blogger"/>블로거</label>
				</div>
			</form>   
      </div>
      </c:when>
      <c:otherwise>
      	<div class="col-sm-8"> 
		<h2>검색결과과 존재하지 않습니다.</h2><br><br>
		<form action="${pageContext.request.contextPath }/blog/search" method="get" name="blogSearchForm"
					onsubmit="return checkInput();">
				
				<div class="col-sm-7">
					<div class="row">
						<input type="text" name="search_text" id="search_text" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<button type="submit" class="btn btn-default" id="search_btn" >검색</button>
				</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-4">
					<label><input type='radio' name='search_radio'value='blogname' id="blogname"/>블로그이름</label> 
					<label><input type='radio' name='search_radio' value='blogger' id="blogger"/>블로거</label>
				</div>
			</form>   
      </div>
      </c:otherwise>
      </c:choose> 
      <div class="col-sm-2"></div> 
    </div> <br><br>
    <div class="col-sm-4"></div>
    <a href="/jblog">Home 으로 가기</a>
    <br><br>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
    </div>
</body> 
</html>