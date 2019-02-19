<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include_header.jspf"%>
</head>
<body>
	<div>
		<p><span>죄송합니다.</span>요청하신 페이지를 찾을 수 없습니다.</p>
	</div>
	<div>
		<a href="javascript:history.back();">
			뒤로가기
		</a>
		<a href="<c:url value='/main.do' />">
			처음으로가기
		</a>
	</div>
</body>
</html>