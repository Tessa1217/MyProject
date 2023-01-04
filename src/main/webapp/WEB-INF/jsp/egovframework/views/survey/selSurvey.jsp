<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<title>설문조사 설명</title>
</head>
<body>
<main class="surveyDesc mt-2 pt-2">
	<div class="container-fluid mt-5 px-4 survey-desc-container p-4 card col-8 d-flex flex-row justify-content-center align-items-center">
		<div class="card-body d-flex flex-column justify-content-start align-items-center">
			<div class="mb-4">
				<div class="survey-description d-flex flex-row justify-content-center align-items-center border border-secondary p-4">
					퓨전소프트 회원분들을 대상으로 만족도 조사를 진행합니다.<br>
					&nbsp응답하신 내용은 통계법 33조(비밀의 보호)에 의거 비밀이 보장되며,<br> 
					서비스 개선을 위한 자료 외에 어떠한 목적으로도 사용되지 않음을 <br>
					약속드립니다. 많은 참여 부탁드리며, 앞으로도 교육정책 및 교육과정 <br>
					정보를 보다 빠르게 활용할 수 있도록 더욱 노력하겠습니다.
				</div>
			</div>
			<div class="mb-4">
				<div class="p-4">
					<ul class="list-group list-group-flush">
						<li class="list-group-item"><strong>조사주관</strong>: ${survey.surveyOwnerName}</li>
						<li class="list-group-item"><strong>참여대상</strong>: ${survey.participantTypeDesc} <c:if test="${survey.participantTypeNo eq 1}"><span class="desc">(로그인 필요)</span></c:if></li>
						<li class="list-group-item"><strong>참여기간</strong>: '<fmt:formatDate value="${survey.surveyStartDate}" pattern="YY.MM.dd.(E)"></fmt:formatDate>
						~ '<fmt:formatDate value="${survey.surveyEndDate}" pattern="YY.MM.dd.(E)"></fmt:formatDate>, 총 <strong>${survey.dateDifference}</strong>일간</li>
						<li class="list-group-item"><strong>참여방법</strong>: 하단의 설문시작 버튼을 클릭하여 총 <strong>${survey.questionLength}</strong>개의 문항에 답변을 마치면 응모 완료</li>
						<li class="list-group-item"><strong>당첨자발표</strong>: '<fmt:formatDate value="${survey.winnerDate}" pattern="YY.MM.dd. (E)"></fmt:formatDate>, 퓨전소프트 공지사항 게시판</li>
					</ul>
				</div>
			</div>
			<div class="mb-4">
				<div class="p-4">
					<p><i class="fas fa-exclamation-circle text-danger"></i> 유의사항</p>
					<ul>
						<li>당첨자 선정은 응답 내용의 성실성 등을 고려하여 선정됩니다.</li>
						<li>1인 1회에 한하여 참여가능 합니다.</li>
					</ul>
				</div>
			</div>
			<div>
				<a class="btn rounded-pill btn-outline-secondary" href="javascript:history.back()">목록으로</a>
				<c:choose>
					<c:when test="${surveyType eq 1}">
						<a class="btn rounded-pill btn-outline-danger" href="/survey/takeSurvey.do?surveyNo=${survey.surveyNo}&submitterNo=${submitterNo}">참여하기</a>
					</c:when>
					<c:when test="${surveyType eq 2}">
						<a class="btn rounded-pill btn-outline-primary" href="/survey/takeSurvey.do?surveyNo=${survey.surveyNo}&submitterNo=${submitterNo}">수정하기</a>
					</c:when>
				</c:choose>
			</div>
		</div>
	</div>
</main>
<script>
	if (sessionStorage.getItem("answerList") != null) {
		sessionStorage.removeItem("answerList");
	}
</script>
</body>
</html>