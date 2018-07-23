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
  src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script> 
</head> 
<body> 
  <div class="container"> 
    <div class="jumbotron"> 
      <c:import url="/WEB-INF/views/includes/blogheader.jsp" /> 
    </div> 
  </div> 
  <br> 
  <div class="row"> 
    <div class="col-sm-1"></div> 
 
    <div class="col-sm-7"> 
      <div>
      	
	  </div> 
      <div>댓글</div> 
      <div>게시글 목록</div> 
    </div> 
 
    <div class="col-sm-3"> 
      <c:choose>
      	<c:when test="${empty blogVo.logo }">
      		<div><img src="${pageContext.request.contextPath }/img/default_logo.png"></div>
      	</c:when>
      	<c:otherwise>
      		<div><img src="${pageContext.request.contextPath }/logo/${blogVo.logo}"></div>
      	</c:otherwise>
      </c:choose>
      <br>
      <div>
      	<ul>
      		<c:forEach var="category" items="${categoryVo}" varStatus="Loop">
      			<!-- TODO -->
      			<!-- 카테고리 눌렀을때 게시글 가져오기 -->
      			<li><a href="">category.name</a></li>
			</c:forEach> 
      	</ul>
      </div> 
    </div> 
 
    <div class="col-sm-1"></div> 
  </div> 
  <br> 
  <c:import url="/WEB-INF/views/includes/footer.jsp" /> 
</body> 
</html>