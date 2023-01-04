<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<%-- <jsp:include page="../cmmn/script.jsp"></jsp:include> --%>
<style>
	section {
		background-color: #ADD8E6;
	}
	
	.loginContainer {
		min-height: 600px;
	}
</style>
</head>
<body>
<section class="loginForm vh-100 d-flex flex-col justify-content-center align-items-center">
    <div class="container py-5 loginContainer d-flex flex-col justify-content-center align-items-center">
        <div class="flex-row col-12 d-flex justify-content-center align-items-center">
            <div class="col col-xl-10">
                <div class="card">
                    <div class="col g-0 d-flex justify-content-center align-content-center">
                        <div class="col-md-8 col-lg-7 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">
                                <form id="loginForm" action="/loginCheck.do" method="POST" onsubmit="return submitCheck()">
                                    <div class="d-flex align-items-center justify-content-center mb-3 pb-1">
                                        <h3 class="display-4">Login</h3>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="userId">아이디</label>
                                        <input type="text" id="userId" name="userId" class="form-control form-control-lg" value="user01">
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="userPassword">비밀번호</label>
                                        <input type="password" id="userPassword" name="userPassword" class="form-control form-control-lg" value="User01@@">
                                    </div>
                                    <div class="form-outline mb-4 d-flex flex-row justify-content-evenly">
                                    	<button class="btn btn-primary btn-lg btn-block" type="submit">로그인</button>
                                        <a class="btn btn-secondary btn-lg btn-block" href="/signIn.do">회원가입</a>
                                    </div>
                                </form>
                                 <form id="loginForm-admin" action="/loginCheck.do" method="POST" onsubmit="return submitCheck()">
                                    <div class="d-flex align-items-center justify-content-center mb-3 pb-1">
                                        <h3 class="display-4">Login</h3>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="userId">아이디</label>
                                        <input type="text" id="userId" name="userId" class="form-control form-control-lg" value="kwony4">
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="userPassword">비밀번호</label>
                                        <input type="password" id="userPassword" name="userPassword" class="form-control form-control-lg" value="Rnjsdbwls21@">
                                    </div>
                                    <div class="form-outline mb-4 d-flex flex-row justify-content-evenly">
                                    	<button class="btn btn-primary btn-lg btn-block" type="submit">로그인</button>
                                        <a class="btn btn-secondary btn-lg btn-block" href="/signIn.do">회원가입</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
	function submitCheckMember() {
		
		const id = $("input[name='userId']");
		const password = $("input[name='userPassword']");
		
		if (id.val() == '') {
			alert("아이디를 입력해주세요.");
			return false;
		}
		if (password.val() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
		
		$("#loginForm").submit();
		return false;
		
	}
	
	function submitCheckAdmin() {
		
		const id = $("input[name='userId']");
		const password = $("input[name='userPassword']");
		
		if (id.val() == '') {
			alert("아이디를 입력해주세요.");
			return false;
		}
		if (password.val() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
		
		$("#loginForm-admin").submit();
		return false;
		
	}
	
/* 		function submitCheck() {
			
			const id = $("input[name='userId']");
			const password = $("input[name='userPassword']");
			
			if (id.val() == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			if (password.val() == '') {
				alert('비밀번호를 입력해주세요.');
				return false;
			}
			
			$("#loginForm").submit();
			return false;
			
		} */
    </script>
</section>
</body>
</html>