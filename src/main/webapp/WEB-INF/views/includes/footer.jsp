<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:choose>
	<c:when test="${empty authUser }">
		<center>
			<div id="footer">
				<p>this is JBlog</p>
			</div>
		</center>
	</c:when>
	<c:otherwise>
		<center>
			<div id="footer">
				<p>(c)opyright 2018, ${userId}</p>
			</div>
		</center>
	</c:otherwise>
</c:choose>

