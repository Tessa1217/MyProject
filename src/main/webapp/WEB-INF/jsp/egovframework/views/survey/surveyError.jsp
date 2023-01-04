<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
<script>
	if (${errorType} == 1) {
		 fireAlert("로그인 후 <br>설문조사를 진행해주세요!", 4);
	} else if (${errorType} == 2) {
		fireAlert("설문조사 기간이 아닙니다!", 3);
	}
</script>
</html>