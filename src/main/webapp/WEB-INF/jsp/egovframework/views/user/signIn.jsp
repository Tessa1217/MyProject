<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>퓨전소프트 게시판(회원가입)</title>
<%-- <jsp:include page="../cmmn/script.jsp"></jsp:include> --%>
</head>
<body>
<section class="signInForm vh-100 d-flex flex-row justify-content-center align-items-center">
        <div class="container col-12 py-6 d-flex flex-row justify-content-center align-items-center">
            <div class="flex-row col-12 d-flex justify-content-center align-items-center">
                <div class="col col-xl-12">
                    <div class="card h-100">
                        <div class="col g-0 d-flex justify-content-center align-items-center">
                            <div class="col-md-10 col-lg-7 d-flex align-items-center">
                                <div class="card-body p-5 p-lg-6 text-black">
                                    <form id="sign-in-form" action="#" method="POST" onsubmit="return signIn()">
                                        <div class="d-flex align-items-center justify-content-center mb-3 pb-1">
                                            <h3 class="display-4">Sign Up</h3>
                                        </div>
                                        <div class="form-outline mb-4 d-flex row">
                                            <div class="col-sm-12">
                                            	<label class="form-label" for="userName">이름</label>
                                            	<input type="text" id="userName" name="userName" class="form-control form-control-md" 
                                            	placeholder="이름을 입력하세요." valid="false">
                                            </div>
                                            <div class="nameForm mt-2">
                                            	<p class="check-msg"></p>
                                            </div>
                                        </div>
                                        <div class="form-outline mb-4 d-flex row align-items-end">
                                            <div class="col-sm-10">
	                                            <label class="form-label" for="userId">아이디</label>
	                                            <input type="text" id="userId" name="userId" class="form-control form-control-md" 
	                                            placeholder="아이디를 입력하세요." valid="false" overlap="false">
                                            </div>
                                            <div class="col-sm-2">
                                            	<button type="button" class="overlap-check btn btn-md btn-secondary" disabled onclick="id_check()">중복</button>
                                            </div>
                                            <div class="idForm mt-2">
                                            	<p class="check-msg"></p>
                                            </div>
                                        </div>
                                        <div class="form-outline mb-4 d-flex row align-items-end justify-content-center">
                                            <div class="col-sm-12">
                                            	<label class="form-label" for="userPassword">비밀번호</label>
                                            	<input type="password" id="userPassword" name="userPassword" class="form-control form-control-md" 
                                            	placeholder="비밀번호를 입력하세요." valid="false">
                                            </div>
                                            <div class="pwdForm mt-2">
                                            	<p class="check-msg"></p>
                                            </div>
                                        </div>
                                        <div class="pt-1 mb-4 d-flex flex-row justify-content-center">
                                            <button class="btn btn-primary btn-md" type="submit">회원가입</button>
                                            <a class="mx-2 btn btn-secondary btn-md" href="/login.do">로그인 화면으로</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
      </div>
 </section>
<script>
	$(document).ready(function() {
		
		// Name validation
		$("input[name='userName']").on("input", function() {
			
			const name = $(this).val();
			
			$(this).attr("valid", "false");
			$(".nameForm .check-msg").removeClass("check-success");
			
			regex = /^[가-힣]{2,10}$/;
			
			if (name == '') {
				$('.nameForm .check-msg').text("이름을 입력해주세요.");
				return;
			}
			if (regex.test(name) == false) {
				$(".nameForm .check-msg").text("이름은 2~10자리의 한글만 입력 가능합니다.");
				return;
			}
			
			$(this).attr("valid", "true");
			
			if ($(this).attr("valid") == "true") {
				$(".nameForm .check-msg").text("").addClass("check-success");
			}
			
		})
		
		// ID validation
		$("input[name='userId']").on("input", function() {
			
			const id = $(this).val();
			
			$(this).attr("valid", "false").attr("overlap", "false");
			$(".idForm .check-msg").removeClass("check-success");
			$(".overlap-check").prop("disabled", true);
			
			regex = /[~!@#$%^&*()_+|<>?:{}ㄱ-ㅎㅏ-ㅣ가-힣\s]/gi;
			
			if (id == '') {
				$(".idForm .check-msg").text("아이디를 입력해주세요.");
				return;
			}
			
			if (regex.test(id)) {
				$(".idForm .check-msg").text("아이디는 특수문자, 공백, 한글을 포함할 수 없습니다.");
				return;
			}
			
			if (id.length < 5 || id.length > 40) {
				$(".idForm .check-msg").text("아이디는 5~40자리 사이로 입력해주세요.");
				return;
			}
			
			$(this).attr("valid", "true");
			
			if ($(this).attr("valid") == "true" && $(this).attr("overlap") == "false") {
				$(".idForm .check-msg").text("아이디 중복 확인을 해주세요.");
				$(".overlap-check").prop("disabled", false);
			}
			
		})
		
		// Password validation
		$("input[name='userPassword']").on("input", function() {
			
			const password = $(this).val();
			
			$(this).attr("valid", "false");
			$(".pwdForm .check-msg").removeClass("check-success");
			
			regex =  /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,20}/;
			
			if (!regex.test(password)) {
				$(".pwdForm .check-msg").text("비밀번호는 8~20자리, 영어 대소문자, 숫자, 특수문자를 한 개 이상 포함해야 합니다.");
				return;
			}
			
			$(this).attr("valid", "true");
			
			if ($(this).attr("valid") == "true") {
				$(".pwdForm .check-msg").text("사용가능한 비밀번호 입니다.").addClass("check-success");
			}
			
		})

	})
	
	/* 아이디 중복 체크 */
	function id_check() {
		const userId = $("input[name='userId']");
		$.ajax({
			method : 'POST',
			url : '/idCheck.do',
			data : {'userId' : $(userId).val()}
		}).done(function(msg) {
			if (msg == 'success') {
				userId.attr("overlap", "true");
				$(".idForm .check-msg").text("사용가능한 아이디입니다.").addClass("check-success");
			} else if (msg == 'failed'){
				alert("중복된 아이디입니다.");
			}
		})
	}
	
	/* 회원가입 */
	function signIn() {
		
		if ($(".check-msg.check-success").length != 3) {
			alert("이름, 아이디, 비밀번호를 다시 확인해주세요.");
			return false;
		}
		
		$("#sign-in-form").attr("method", "post")
						  .attr("action", "/signIn.do");
		$("#sign-in-form").submit();
		return false;
		
	}
</script>
</body>
</html>