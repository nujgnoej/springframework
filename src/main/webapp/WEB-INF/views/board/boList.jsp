<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>boList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		// 페이지마다 보여주는 게시물갯수 처리
		function pageCheck() {
			let pageSize = $("#pageSize").val();
			location.href = "boList.bo?pag=${pag}&pageSize="+pageSize;
		}
		
		// 검색기 처리
		function searchCheck() {
			let searchString = $("#searchString").val();
			
			if(searchString.trim() == "") {
				alert("검색어를 입력하세요!");
				searchForm.searchString.focus();
			}
			else {
				searchForm.submit() ;
			}
		}
		
		function searchChange() {
			$("#searchString").focus();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/><p>
<div class="container">
    <h2 class="text-center">게 시 판 리 스 트</h2>
    <br/>
    <table class="table table-borderless">
    	<tr>
    		<td class="text-left p-0">
    			<a href="boInput" class="btn btn-secondary btn-sm">글쓰기</a>
    		</td>
    		<td class="text-right p-0">
    			<select name="pageSize" id="pageSize" onchange="pageCheck()">
    				<option value="5" ${pageVO.pageSize==5 ? 'selected' : ''}>5건</option>
    				<option value="10" ${pageVO.pageSize==10 ? 'selected' : ''}>10건</option>
    				<option value="15" ${pageVO.pageSize==15 ? 'selected' : ''}>15건</option>
    				<option value="20" ${pageVO.pageSize==20 ? 'selected' : ''}>20건</option>
    			</select>
    		</td>
    	</tr>
    </table>
    <table class="table table-hover text-center">
    	<tr class="table-dark text-dark">
    		<th>글번호</th>
    		<th>글제목</th>
    		<th>글쓴이</th>
    		<th>글쓴날짜</th>
    		<th>조회수</th>
    		<th>좋아요</th>
    	</tr>
    	<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    	<c:forEach var="vo" items="${vos}">
    		<tr>
    			<td>${curScrStartNo}</td>
    			<td class="text-left">
    				<a href="boContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
    				<c:if test="${vo.replyCount != 0}">[${vo.replyCount}]</c:if>
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
    		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    	</c:forEach>
    	<tr><td colspan="6" class="p-0"></td></tr>
    </table>
</div>
<!-- 블록 페이징 처리 시작 -->
<div class="text-center">
	<ul class="pagination justify-content-center">
		<c:if test="${pageVO.pag > 1}">
			<li class="page-item"><a href="boList?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
		</c:if>
		<c:if test="${pageVO.curBlock > 0}">
			<li class="page-item"><a href="boList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
		</c:if>
		<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			<c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
				<li class="page-item active"><a href="boList?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			</c:if>
			<c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
				<li class="page-item"><a href='boList?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			<li class="page-item"><a href="boList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
		</c:if>
		<c:if test="${pageVO.pag != pageVO.totPage}">
			<li class="page-item"><a href="boList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징 처리 끝 -->

<!-- 검색기 처리 시작 -->
<div class="container text-center">
	<form name="searchForm" method="post" action="boSearch">
		<b>검색 : </b>
		<select name="search" onchange="searchChange()">
			<option value="title">글제목</option>
			<option value="nickName">글쓴이</option>
			<option value="content">글내용</option>
		</select>
		<input type="text" name="searchString" id="searchString"/>
		<input type="button" value="검색" onclick="searchCheck()"/>
		<input type="hidden" name="pag" value="${pageVO.pag}"/>
		<input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
	</form>
</div>
<!-- 검색기 처리 끝 -->

<p><br/><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>