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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<title>Insert title here</title> 
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
         
        <p>새로운 카테고리 추가</p> 
        <form action="" class="form-horizontal" name="categorySetting"> 
          <div class="form-group"> 
            <label for="categoryName" class="col-sm-3 control-label">카테고리명</label> 
            <div class="col-sm-6"> 
              <div name="child2" class="col-sm-6"> 
                <input type="text" class="form-control" name="categoryName" /> 
              </div> 
              <BR> 
            </div> 
          </div> 
 
          <div class="form-group"> 
            <label for="categoryDescription" class="col-sm-3 control-label">설명</label> 
            <div class="col-sm-6"> 
              <div name="child2" class="col-sm-6"> 
                <input type="text" class="form-control" name="categoryDescription" /> 
              </div> 
              </div> 
          </div> 
          <br><br> 
           
          <div class="form-group"> 
          <div class="col-sm-3"></div> 
          <div class="col-sm-6"> 
            <button class="btn btn-default">카테고리 시작</button> 
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