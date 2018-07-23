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
<!--  jquery -->
<script language="javascript" type="text/javascript"
	src="${pageContext.request.contextPath }/jquery/jquery-1.12.4.js"></script>
<link rel="stylesheet" 
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> 
<link rel="stylesheet" 
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>category setting</title> 
<script type="text/javascript">
 	function addCategory(){
 		var name = $("#categoryName").val();
		var description = $("#categoryDescription").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/blog/${authUser.id}/admin/categoryadd",
			type : "POST",
			data : "name="+name+"&description="+description,
			dataType : "json",
			success : function(result){
				if(result.data){
					console.log("데이터 삽입 성공");
					getCategoryList();
					$("#categoryName").val("");
					$("#categoryDescription").val("");
				}else{
					console.log("데이터 삽입 실패");
				}
			},
			error : function(request,status,error){
				 console.log("실패!!!error!!");
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}  
			
	function deleteCategory(no){
				$.ajax({
					url : "${pageContext.request.contextPath}/blog/${authUser.id}/admin/categorydelete",
					type : "POST",
					data : "no="+no,
					dataType : "json",
					success : function(result){
						if(result.data){
							console.log("데이터 삭제 성공");
							getCategoryList();
						}else{
							console.log("데이터 삭제 실패");
						}
					},
					error : function(xhr,status,error){
						
					}
				});
	}
			
	function getCategoryList(){
			    
			    $.ajax({
			        type:'GET',
			        url : "${pageContext.request.contextPath}/blog/${authUser.id}/admin/getCategoryList",
			        dataType : "json",
			        success : function(data){
			            
			            var html = "";
			            
			            // 안의 dom 내용을 지우고,
			            $("#commentList").empty();
				         
			          if(data.length > 0){
			                for(i=0; i<data.length; i++){
			                    html += "<tr><td>"+data[i].no+"</td>";
			                    html += "	<td>"+data[i].name+"</td>";
			                    html += "	<td>"+data[i].postCount+"</td>";
			                    html += "	<td>"+data[i].description+"</td>";
				   				html += "	<td><button class='btn btn-delfault' onclick='deleteCategory("+data[i].no+")'>삭제</button></td></tr>";
			                }
			            }  
			            $("#commentList").html(html);
			        },
			        error:function(request,status,error){
			            console.log("카테고리 리스트 불러오기 실패");
			            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			       }
			        
			    });
			}
</script>
</head> 
<body> 
  <div id="container"> 
    <c:import url="/WEB-INF/views/includes/header.jsp" /> 
    <br> 
    <div class="row"> 
      <div class="col-sm-1"></div> 
      <div class="col-sm-10">
        <div> 
         <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/basicsetting"><font size="4">기본설정 &nbsp&nbsp</font> </a> 
          <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/categorysetting"><font size="4">카테고리 설정 &nbsp&nbsp</font> </a>
          <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/boardwriteform"><font size="4">글 작성 &nbsp&nbsp</font> </a> 
        </div> 
        <br> 
  
  		<div>
        <table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th width="10%">번호</th>
						<th width="30%">카테고리명</th>
						<th width="10%">포스트 수</th>
						<th width="40%">설명</th>
						<th width="10%">삭제</th>
					</tr>
				</thead>
				<tbody id="commentList">
					 <c:forEach var="category" items="${categoryVo}" varStatus="Loop">
						<tr>
							<td>${category.no}</td>
							<td>${category.name }</td>
							<td>${category.postCount }</td>
							<td>${category.description }</td>
							<td><button class="btn btn-delfault"  onclick="deleteCategory(${category.no})">삭제</button></td>
						</tr>
					</c:forEach> 
				</tbody>
			</table>
			</div>
        	<br>
        
        <div>
        	<div><h3>새로운 카테고리 추가</h3></div>
        </div>
        <br>
        
        <form action="" class="form-horizontal" name="categorySetting">
          <div class="form-group"> 
            <label for="categoryName" class="col-sm-2 control-label">카테고리명</label> 
              <div class="col-sm-6"> 
                <input type="text" class="form-control" id="categoryName" /> 
              </div> 
              <BR> 
          </div> 
 
          <div class="form-group"> 
            <label for="categoryDescription" class="col-sm-2 control-label">설명</label> 
              <div class="col-sm-6"> 
                <input type="text" class="form-control" id="categoryDescription" /> 
              </div> 
          </div> 
          <br>
           
          <div class="form-group"> 
          <div class="col-sm-2"></div> 
          <div class="col-sm-1"> 
           <input type="button" id="addCtgr" onclick="addCategory()" class="btn btn-default" value="카테고리 추가">
            
          </div> 
          </div> 
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