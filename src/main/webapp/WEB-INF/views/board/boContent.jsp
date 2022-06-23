<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>boContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		'use strict';
		function goodCheck() {
			$.ajax({
				type	: "post",
				url		: "${ctp}/boGoodCount",
				data	: {idx : ${vo.idx}},
				success	: function() {
					location.reload();
				},
				error	: function() {
					alert("전송오류~~");
				}
			});
		}
		
		function boardDelCheck() {
			let ans = confirm("현 게시물을 삭제하시겠습니까?");
			if(ans) {
				location.href = "boDeleteOk.bo?idx=${vo.idx}";
			}
		}
		
		// 댓글 입력처리(ajax처리)
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == "") {
				alert("댓글을 입력하세요!");
				$("#content").focus();
				return false;
			}
			
			let query = {
				boardIdx : ${vo.idx},
				mid		 : '${sMid}',
				nickName : '${sNickName}',
				content	 : content,
				hostIp	 : '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/boReplyInput",
				data	: query,
				success : function(data) {
					if(data == "1") {
						alert("댓글이 입력되었습니다.");
						location.reload();
					}
					else {
						aleft("댓글 입력실패~~~");
					}
				},
				error : function() {
					aleft("전송오류!");
				}
			});
		}
		
		// 댓글 삭제(ajax처리)
		function replyDelCheck(idx) {
			let ans = confirm("현재 댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type	: "post",
				url		: "${ctp}/boReplyDeleteOk",
				data	: {idx : idx},
				success : function(data) {
					if(data == "1") {
						alert("댓글이 삭제되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 삭제 실패~~");
					}
				},
				error : function() {
					alert("전송 실패!!!");
				}
			});
		}
		
		// 댓글 수정하기
		function boReplyUpdate(idx) {
			let content = $("#content").val();
			let hostIp = '${pageContext.request.remoteAddr}';
			if(content.trim()=="") {
				alert("수정할 댓글을 입력하세요!");
				$("#content").focus();
				return;
			}
			let query = {
				idx		: idx,
				content : content,
				hostIp	: hostIp
			}
			$.ajax({
				type : "post",
				url  : "${ctp}/boReplyUpdateOk.bo",
				data : query,
				success : function(data) {
					if(data == "1") {
						alert("댓글이 수정되었습니다.");
						location.href = "${ctp}/boContent.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
					}
					else {
						alert("댓글 수정 실패~~");
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	</script>
	<style>
		th {
			background-color: #ddd;
			text-align: center;
		}
	</style>
</head>
<body>
<c:if test="${sLevel!=0}">
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
</c:if>
<p><br/><p>
<div class="container">
    <h2 class="text-center">글 내 용 보 기</h2>
    <br/>
    <table class="table table-borderless text-right m-0">
    	<tr><td>IP : ${vo.hostIp}</td></tr>
    </table>
    <table class="table table-bordered">
    	<tr>
    		<th>글제목</th>
    		<td colspan="3">${vo.title}</td>
    	</tr>
    	<tr>
    		<th>글쓴이</th>
			<td>${vo.nickName}</td>
    		<th>글쓴날짜</th>
			<td>${fn:substring(vo.WDate,0,19)}</td>
    	</tr>
    	<tr>
    		<th>이메일</th>
			<td>${vo.email}</td>
    		<th>조회수</th>
			<td>${vo.readNum}</td>
    	</tr>
    	<tr>
    		<th>홈페이지</th>
			<td>${vo.homePage}</td>
    		<th>좋아요</th>
			<td><a href="javascript:goodCheck()">❤</a>(${vo.good}) / 👍 / 👎
    	</tr>
    	<tr>
    		<th>글내용</th>
			<td colspan="3" style="height:300px">${fn:replace(vo.content,newLine,"<br/>")}</td>
    	</tr>
    	<tr>
			<td colspan="4" class="text-center">
				<c:if test="${flag == 's'}">
					<input type="button" value="돌아가기" onclick="location.href='boSearch.bo?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-secondary"/>
				</c:if>
				<c:if test="${flag != 's'}">
					<input type="button" value="돌아가기" onclick="location.href='boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
				</c:if>
				<c:if test="${sMid == vo.mid}">
					<input type="button" value="수정하기" onclick="location.href='boUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
				</c:if>
				<c:if test="${sMid == vo.mid || sLevel == 0}">
					<input type="button" value="삭제하기" onclick="boardDelCheck()" class="btn btn-secondary"/>
				</c:if>
			</td>
    	</tr>
    </table>

	<!-- 이전글/다음글 처리 -->
	<table class="table table-borderless">
		<tr>
			<td>
				<c:if test="${!empty pnVos[1]}">
					☝ 다음글 : <a href="boContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">${pnVos[1].title}</a><br/>
				</c:if>
				<c:if test="${!empty pnVos[0]}">
					<c:if test="${minIdx == vo.idx}">☝ 다음글 : </c:if>
					<c:if test="${minIdx != vo.idx}">👇 이전글 : </c:if>
					<a href="boContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">${pnVos[0].title}</a><br/>
				</c:if>
			</td>
		</tr>
	</table>
	<br/>
	
	<!-- 댓글 처리(출력/입력) -->
	<!-- 댓글 출력 처리 -->
	<table class="table table-hover text-center">
		<tr>
			<th>작성자</th>
			<th>댓글내용</th>
			<th>작성일자</th>
			<th>접속IP</th>
		</tr>
		<c:forEach var="replyVo" items="${replyVos}">
			<tr>
				<td>
					${replyVo.nickName}
					<c:if test="${sMid == replyVo.mid || sLevel == 0}">
						(<a href="boContent.bo?replyIdx=${replyVo.idx}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">√</a>,
						<a href="javascript:replyDelCheck(${replyVo.idx})">x</a>)
					</c:if>
				</td>
				<td class="text-left">
					${fn:replace(replyVo.content,newLine,"<br/>")}
					<c:if test="${replyVo.WNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
				</td>
				<td>
					<c:if test="${replyVo.WNdate <= 24}">${fn:substring(replyVo.WDate,11,19)}</c:if>
    				<c:if test="${replyVo.WNdate > 24}">${fn:substring(replyVo.WDate,0,10)}</c:if>
				</td>
				<td>${replyVo.hostIp}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 댓글 입력 -->
	<form name="replyForm" method="post" action="boReplyInput">
		<table class="table text-center">
			<tr>
				<td style="width:85%" class="text-left">
					글내용 :
					<textarea rows="4" name="content" id="content" class="form-control">${replyContent}</textarea>
				</td>
				<td style="width:15%">
					<br/>
					<p>작성자 : ${sNickName}</p>
					<p>
						<c:if test="${empty replyContent}">
							<input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/>
						</c:if>
						<c:if test="${!empty replyContent}">
							<input type="button" value="댓글수정" onclick="boReplyUpdate(${replyIdx})" class="btn btn-info btn-sm"/>
						</c:if>
					</p>
				</td>
			</tr>
		</table>
		<input type="hidden" name="boardIdx" value="${vo.idx}"/>
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="nickName" value="${sNickName}"/>
	</form>
	
</div>
<p><br/><p>
<c:if test="${sLevel!=0}">
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</c:if>
</body>
</html>