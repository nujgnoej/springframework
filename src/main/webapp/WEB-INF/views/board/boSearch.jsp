<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boSearch.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <div class="container">
	  <h2 class="text-center">게 시 판 검 색 리 스 트</h2>
	  <div class="text-center">(<font color='blue'>${searchTitle}</font>)(으)로 <font color="blue">${searchString}(을)를 검색한 결과 <font color='red'>${pageVO.totRecCnt}</font>건이 검색되었습니다.</font></div>
	  <br/>
	  <table class="table table-hover text-center">
	    <tr class="table-dark text-dark">
	    	<th>글번호</th>
	    	<th>글제목</th>
	    	<th>글쓴이</th>
	    	<th>글쓴날짜</th>
	    	<th>조회수</th>
	    	<th>좋아요</th>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <tr>
	        <td>${st.count}</td>
	        <td class="text-left"><a href="boContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&flag=s&search=${search}&searchString=${searchString}">${vo.title}</a>
	          <c:if test="${vo.diffTime <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
	        </td>
	        <td>${vo.nickName}</td>
	        <td>
	          <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
	          <c:if test="${vo.diffTime > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	        </td>
	        <td>${vo.readNum}</td>
	        <td>${vo.good}</td>
	      </tr>
	    </c:forEach>
	    <tr><td colspan="6" class="p-0"></td></tr>
	  </table>
	</div>
</div>
<br/>
<div class="text-center"><input type="button" value="돌아가기" onclick="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/></div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>