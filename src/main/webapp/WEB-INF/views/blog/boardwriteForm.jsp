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
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>HOME</title> 
<script language="javascript" type="text/javascript" 
  src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script> 
<script type="text/javascript">
function checkInput() {

	var obj = document.boardwriteForm;

	if (isNull(obj.title)) {
		alert('제목을 입력해주세요');
		// obj.title.focus();
		return false;
	} else if (isNull(obj.content)) {
		alert('내용을 입력해주세요');
		// obj.content.focus();
		return false;
	} else{
		document.boardwriteForm.submit();
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
</head> 
<body> 
  <div id="container"> 
    <c:import url="/WEB-INF/views/includes/header.jsp" /> 
    <br> 
    <div class="row"> 
      <div class="col-sm-1"></div> 
      <div> 
        <div> 
          <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/basicsetting"><font size="4">기본설정 &nbsp&nbsp</font> </a> 
          <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/categorysetting"><font size="4">카테고리 설정 &nbsp&nbsp</font> </a>
          <a href="${pageContext.servletContext.contextPath }/blog/${authUser.id}/admin/boardwriteform"><font size="4">글 작성 &nbsp&nbsp</font> </a> 
        </div> 
        <br> 
        <br> 
         
        <div class="col-sm-10">
        <form:form action="${pageContext.request.contextPath}/blog/${authUser.id}/admin/boardwrite" class="form-horizontal" name="boardwriteForm" 
        	method="post" modelAttribute="postVo"> 
 
          <div class="form-group"> 
            <label for="title" class="col-sm-3 control-label">제목</label> 
              <div class="col-sm-6"> 
                <input type="text" class="form-control" name="title" /> 
              </div> 
              <div class="col-sm-2"> 
                <select class="form-control" name="categoryNo" class="selectpicker" >
    				<c:forEach var="category" items="${categoryVo}" varStatus="Loop">
						<option value="${category.no}">${ category.name }</option>
					</c:forEach> 
				</select>
              </div> 
          </div> 
          
 
          <div class="form-group"> 
            <label for="content" class="col-sm-3 control-label">내용</label> 
              <div class="col-sm-8"> 
             <textarea id="content" style="overflow-y:auto;" name="content" class="form-control" rows="15" cols="65"></textarea>
              <BR> 
            </div> 
          </div>
           
          <div class="form-group"> 
          <div class="col-sm-3"></div> 
          <div class="col-sm-6"> 
            <input class="btn btn-default" type="button" onclick="checkInput()" value="포스트 하기"/> 
          </div> 
          </div> 
          <br> 
          <br> 
 
        </form:form> 
        </div>
        <div class="col-sm-1"></div> 
      </div> 
    </div> 
    <br> 
    <c:import url="/WEB-INF/views/includes/footer.jsp" /> 
  </div> 
</body> 
</html>