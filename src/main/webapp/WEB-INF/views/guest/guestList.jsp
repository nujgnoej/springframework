<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>guestList</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    function delCheck(idx) {
    	let ans = confirm("게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/guestDelete.gu?idx="+idx;
    }
  </script>
  <style>
    th {background-color:#ccc; text-align:center}
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide2.jsp" %>
<p><br/></p>
<div class="container">
  <h2 class="text-center m-3">방 명 록 리 스 트</h2>
  <div class="row mb-2">
    <a href="guestInput" class="btn btn-secondary">글쓰기</a>
  </div>
  <div>
  	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
	    <table class="table table-borderless m-0 p-0">
	      <tr>
	        <td class="text-left pl-0">
	          방문번호 : ${curScrStartNo}
	        </td>
	        <td class="text-right pr-0">방문IP : ${vo.hostIp}</td>
	      </tr>
	    </table>
		  <table class="table table-bordered">
		    <tr>
		      <th width="20%">성명</th>
		      <td width="30%">${vo.name}</td>
		      <th width="20%">방문일자</th>
		      <td width="30%">${vo.VDate}</td>
		    </tr>
		    <tr>
		      <th>전자우편</th>
		      <td colspan="3">
		        <c:if test="${empty vo.email}">없음</c:if>
		        <c:if test="${!empty vo.email}">${vo.email}</c:if>
		      </td>
		    </tr>
		    <tr>
		      <th>홈페이지</th>
		      <td colspan="3">
		        <c:set var="hpLen" value="${fn:length(vo.homepage)}"/>
		        <c:if test="${empty vo.homepage || hpLen <= 7}">없음</c:if>
		        <c:if test="${!empty vo.homepage && hpLen > 7}"><a href="${vo.homepage}" target="_blank">${vo.homepage}</a></c:if>
		      </td>
		    </tr>
		    <tr>
		      <th>글내용</th>
		      <td colspan="3" style="height:200px">${fn:replace(vo.content, newLine, '<br/>')}</td>
		    </tr>
	    </table>
	    <br/>
	    <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </div>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}">
	    <li class="page-item"><a href="guestList?pag=1" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	    <li class="page-item"><a href="guestList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="guestList?pag=${i}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='guestList?pag=${i}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="guestList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="guestList?pag=${pageVO.totPage}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<!-- 블록 페이징 처리 끝 -->
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>