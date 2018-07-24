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
  	function addComment(postNo){
  		var content = $("#content").val();
  		$.ajax({
  			url : "${pageContext.request.contextPath}/blog/${authUser.id}/addcomment",
  			type : "post",
  			data : "content="+content+"&postno="+postNo,
  			dataType : "json",
  			success : function(data){
				
  				if(data.length > 0){
  					var html = "";
  					$("#commentList").empty();
  					
  					for(i=0; i<data.length; i++){
  						html += "<label for='title' class='col-sm-2 control-label'>"+data[i].userName+"</label>";
  						html += "<div class='col-sm-7'> ";
  						html += "<p>"+data[i].content+"</p>";
  						html += "</div> ";
  						html += "<div class='col-sm-3'> ";
  						html += "<p>"+data[i].regDate+"</p>";
  						html += "</div> <br>";
  						html += "</div>";
  					}
  					
  					$("#commentList").html(html);
  					$("#content").val("");
  				}
  			},
  			error : function(request,status,error){
  				console.log("실패");
  				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 				
  			}
  		});
  	}
  	
  	/* function getComment(){
  		$.ajax({
  			url : "${pageContext.request.contextPath}/blog/${authUser.id}/getComment",
  			type : "post",
  			data : "postno="+postNo,
  			dataType : "json",
  			success : function(data){
				
  				if(data.length > 0){
  					console.log("성공?");
  					var html = "";
  					$("#commentList").empty();
  					
  					for(i=0; i<data.length; i++){
  						html += "<label for='title' class='col-sm-2 control-label'>"+data[i].userName+"</label>";
  						html += "<div class='col-sm-7'> ";
  						html += "<p>"+data[i].content+"</p>";
  						html += "</div> ";
  						html += "<div class='col-sm-3'> ";
  						html += "<p>"+data[i].regDate+"</p>";
  						html += "</div> <br>";
  						html += "</div>";
  					}
  					
  					$("#commentList").html(html);
  					$("#content").val("");
  				}
  			},
  			error : function(request,status,error){
  				console.log("실패");
  				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 				
  			}
  		});
  	} */
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
      <div id="post">
      <!-- 게시글 -->
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
	  
    <!-- 댓글 -->
     
	<c:if test="${!empty authUser }">
		<c:if test="${!empty postVo}">	
	  <hr style="border:solid 0.3px black;">
      
         <label class="col-sm-2 control-label">${authUser.name}</label>
         <div class="col-sm-8"> 
            <input type="text" class="form-control" id="content" /> 
         </div> 
         <div class="col-sm-2"> 
            <input type="button" onclick="addComment(${postVo.no})"class="form-control" name="save" value="저장"/>     
         </div> <br>
      
      <hr>
      </c:if>
	</c:if>
      
      <!-- comment 구현 -->
      <c:if test="${!empty commentVo }">
      <div id="commentList">
      	<c:forEach var="comment" items="${commentVo}" varStatus="Loop">
      		<label class="col-sm-2 control-label">${comment.userName}</label>
         	<div class="col-sm-7"> 
            	<p>${comment.content}</p>
         	</div> 
         	<div class="col-sm-3"> 
            	<p>${comment.regDate }</p>
         	</div> <br>
      	</c:forEach>
      </div>
      <hr style="border:solid 0.5px black;">
      </c:if>
      
      
      <div>
       <div id="postList">  
       	<c:forEach var="post" items="${postListVo}" varStatus="Loop">	
         	<div class="col-sm-9"> 
         	<!-- TODO : 게시글을 누르면, 그 게시글과 코멘트 불러오기 -->
            	<a href="${pageContext.request.contextPath }/blog/post/${userId}/${post.categoryNo}/${post.no}">${post.title}</a>
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
      			<li><a href="${pageContext.request.contextPath }/blog/category/${userId}/${category.no}">${ category.name }</a></li>
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