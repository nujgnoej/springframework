<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memPwdCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
	<form method="post">
		<h2>비밀번호 확인</h2>
		<hr/>
		<table class="table table-border">
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" autofocus class="form-control" required /></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" value="비밀번호확인" class="btn btn-secondary"/> &nbsp;
					<input type="reset" value="다시입력" class="btn btn-secondary"/> &nbsp;
					<input type="button" value="돌아가기" class="btn btn-secondary" onclick="location.href='memMain';"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>