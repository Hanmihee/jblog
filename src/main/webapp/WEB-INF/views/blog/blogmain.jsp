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
		var userId = "${authUser.id}";
		var a;
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
						html += "<div class='col-sm-6'> ";
						html += "<p>"+data[i].content+"</p>";
						html += "</div> ";
						html += "<div class='col-sm-3'> ";
						html += "<p>"+data[i].regDate+"</p>";
						html += "</div>";
						html += "</div>";
						
						console.log(userId == data[i].userId);
						
						if(userId == data[i].userId){
								html += "<div class='col-sm-1'> ";
								html += "<button onclick='deleteComment("+data[i].no+","+data[i].postNo+")'>X</button>";
								html += "</div> ";
						}
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
  
  function deleteComment(no,postNo){
	  $.ajax({
			url : "${pageContext.request.contextPath}/blog/${authUser.id}/deletecomment",
			type : "post",
			data : { no : no, postNo : postNo },
			dataType : "json",
			success : function(result){
				if(result.data){
				 	getComment(postNo);
				}
			},
			error : function(request,status,error){
				console.log("실패");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 				
			}
		});
  }
  
/*   	function addComment(postNo){
  		var content = $("#content").val();
  		var userName = "${authUser.name}";
  		var a;
  		$.ajax({
  			url : "${pageContext.request.contextPath}/blog/${authUser.id}/addcomment",
  			type : "post",
  			data : "content="+content+"&postno="+postNo,
  			dataType : "json",
  			success : function(data){
				console.log("성공했나?");
  				
  					var html = "";
  					console.log("data 받아왔나?");
  						html += "<label for='title' class='col-sm-2 control-label'>"+userName+"</label>";
  						html += "<div class='col-sm-6'> ";
  						html += "<p>"+content+"</p>";
  						html += "</div> ";
  						html += "<div class='col-sm-3'> ";
  						html += "<p>"+data.regDate+"</p>";
  						html += "</div> <br>";
  						html += "</div>";
  						html += "<div class='col-sm-1'> ";
						html += "<button>X</button>";
						html += "</div> ";
  					
  					
  					$("#commentList").html(html);
  					$("#content").val("");
  			},
  			error : function(request,status,error){
  				console.log("실패");
  				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 				
  			}
  		});
  	} */

  	function getComment(postNo){
  		var userId = "${authUser.id}";
  		$.ajax({
  			url : "${pageContext.request.contextPath}/blog/${authUser.id}/getComment",
  			type : "post",
  			data : { postNo : postNo },
  			dataType : "json",
  			success : function(data){

				if(data.length > 0){
					var html = "";
					$("#commentList").empty();
					
					for(i=0; i<data.length; i++){
						html += "<label for='title' class='col-sm-2 control-label'>"+data[i].userName+"</label>";
						html += "<div class='col-sm-6'> ";
						html += "<p>"+data[i].content+"</p>";
						html += "</div> ";
						html += "<div class='col-sm-3'> ";
						html += "<p>"+data[i].regDate+"</p>";
						html += "</div>";
						html += "</div>";
						
						console.log(userId == data[i].userId);
						
						if(userId == data[i].userId){
							console.log(data[i].postNo);
							console.log(data[i].no);
							
								html += "<div class='col-sm-1'> ";
								html += "<button onclick='deleteComment("+data[i].no+","+data[i].postNo+")'>X</button>";
								html += "</div> ";
						}
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
      <div id="commentList">
      	<c:forEach var="comment" items="${commentVo}" varStatus="Loop">
      		<label class="col-sm-2 control-label" >${comment.userName}</label>
         	<div class="col-sm-6"> 
            	<p>${comment.content}</p>
         	</div> 
         	<div class="col-sm-3"> 
            	<p>${comment.regDate }</p>
         	</div>
         	<!-- TODO -->
         	<!-- 세션의 userId 와 코멘트의 userId가 같을때 삭제 가능 -->
         	<c:if test="${!empty authUser }">
         		<c:if test="${ authUser.id eq comment.userId }"> 
         		<div class="col-sm-1"> 
            		<button onclick="deleteComment(${comment.no},${comment.postNo })">X</button>
         		</div> 
         		</c:if>
         	</c:if>
         	<br>
      	</c:forEach>
      </div><br>
      
      
      <div>
       <div id="postList">  
       	<c:forEach var="post" items="${postListVo}" varStatus="Loop">	
         	<div class="col-sm-9"> 
	        <hr style="border:solid 0.5px black;">
            	<a href="${pageContext.request.contextPath }/blog/post/${userId}/${post.categoryNo}/${post.no}">${post.title}</a>
         	</div> 
         	<div class="col-sm-3"> 
         		<hr style="border:solid 0.5px white;">
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