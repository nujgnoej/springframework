<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		function fCheck() {
			var title = myForm.title.value;
			var content = myForm.content.value;
			
			if(title.trim() == "") {
				alert("게시글 제목을 입력하세요");
				myForm.title.focus();
			}
			else if(content.trim() == "") {
				alert("글내용을 입력하세요");
				myForm.content.focus();
			}
			else {
				myForm.submit();
			}
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br></p>
<div class="container">
	<form name="myForm" method="post" action="boUpdateOk.bo">
		<table class="table table-borderless">
			<tr>
				<td><h2>게시판 글 수정하기</h2></td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<th>글쓴이</th>
				<td>${sNickName}</td>
			</tr>
			<tr>
				<th>글제목</th>
				<td><input type="text" name="title" value="${vo.title}" class="form-control" autofocus required /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" value="${vo.email}" class="form-control"/></td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td><input type="text" name="homePage" value="${vo.homePage}" class="form-control"/></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td><textarea rows="6" name="content" class="form-control" required>${vo.content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="글수정하기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
					<input type="reset" value="다시입력" class="btn btn-secondary"/> &nbsp;
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
				</td>
			</tr>
		</table>
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
		<input type="hidden" name="idx" value="${vo.idx}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" value="${pageSize}"/>
	</form>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>