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
  <script type="text/javascript">
  	function getPostList(categoryno){
  		$.ajax({
  			url : "${pageContext.request.contextPath}/blog/${userId}/postList",
  			type : "post",
  			data : "categoryno="+categoryno,
  			dataType : "json",
  			success : function(data){
  				
  				if(data.length > 0){
  					var html ="";
  					$("#postList").empty();
  					for(i=0; i<data.length; i++){
  						html += "<div class='col-sm-9'>";
  						html += "<p onclick='getPost("+data[i].no+")'>"+data[i].title+"</p>";
  						html += "</div>";
  						html += "<div class='col-sm-3'> ";
  						html += "<p>"+data[i].regDate+"</p>";
  						html += "</div><br>";
  					}
  					$("#postList").html(html);
  				}
  			},
  			error : function(request,status,error){
  				console.log("실패");
  				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 				
  			}
  		});
  	}
  </script>
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
      	<!-- TODO  -->
      	<!-- 게시글 분기처리  : 게시글이 있을때와 아무것도 없을때.-->
      	<c:choose>
      	<c:when test="${empty postVo }">
      		<p>등록된 게시글이 존재하지 않습니다.</p>
      	</c:when>
      	<c:otherwise>
      		<h3>${postVo.title}</h3>
      		<p>${postVo.content }</p>
      	</c:otherwise>
      </c:choose>
	  </div> 
	  
	  <hr style="border:solid 0.3px black;">
	  
      <!-- 댓글 -->
         <label for="title" class="col-sm-2 control-label">${authUser.name}</label>
         <div class="col-sm-8"> 
            <input type="text" class="form-control" name="comment" /> 
         </div> 
         <div class="col-sm-2"> 
            <input type="button" class="form-control" name="save" value="저장"/>     
         </div> <br>
      
      <hr>
      
      <!-- TODO -->
      <!-- comment 구현 -->
      <!--
      	1. comment 리스트 불러오기 처리 
      	2. ajax 처리 
      -->
      <div id="commentList">
      	<c:forEach var="comment" items="${commentVo}" varStatus="Loop">
      		<label for="title" class="col-sm-2 control-label">${comment.name}</label>
         	<div class="col-sm-7"> 
            	<p>${comment.content}</p>
         	</div> 
         	<div class="col-sm-3"> 
            	<p>${comment.regDate }</p>
         	</div> <br>
      	</c:forEach>
      </div>
      
      <hr style="border:solid 0.5px black;">
      
      <div>
	  <!-- TODO : 게시글 목록 가져오기 -->
	  <!-- ajax 처리 -->
       <div id="postList">  
       	<c:forEach var="post" items="${postListVo}" varStatus="Loop">	
         	<div class="col-sm-9"> 
            	<p onclick="getPost(${post.no})">${post.title }</p>
         	</div> 
         	<div class="col-sm-3"> 
            	<p>${post.regDate}</p>
         	</div><br>
        </c:forEach>
        </div>
	  </div>
      <hr> 
    
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
      			<li><p onclick="getPostList(${category.no})">${ category.name }</p></li>
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