<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문조사 결과</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
<main class="surveyQuestion mt-2 pt-2">
	<div class="container fluid px-4 my-6">
		<div class="card mb-4">
			<div class="card-header px-3 py-4">
				<h3 class="ms-2">설문조사 결과</h3>
			</div>
			<div class="card-body">
				<input type="hidden" name="surveyNo" value="${result.surveyNo}">
				<c:forEach items="${questionList}" var="q">
					<div class="mx-2 my-4 p2 question">
						<p class="question-main">
							<span class="question-no">
								<c:choose>
									<c:when test="${q.questionLevel eq 1}">문항 ${q.questionOrder}.</c:when>
									<c:otherwise>${q.parentQuestionNo}-${q.questionOrder}.</c:otherwise>
								</c:choose>
								</span>
								<c:if test="${q.categoryNo > 0}"><span class="question-cate">[${q.categoryDesc}]</span></c:if> ${q.questionContent}
								<c:if test="${q.questionTypeNo eq 2}">(${q.questionAnsCnt}개 선택)</c:if>
								<span class="question-req">
									<c:choose>
										<c:when test="${q.questionReqyn eq 'Y'}">(필수)</c:when>
										<c:when test="${q.questionReqyn eq 'N' and q.questionTypeNo ne 6}">(자율)</c:when>
									</c:choose>
								</span>
								<c:if test="${q.questionTypeNo eq 4}">
									<button type="button" class="btn btn-sm rounded-pill btn-outline-success" onclick="shortForm(${q.questionNo})">응답 보기</button>
								</c:if>
						</p>
						<div class="container">
							<div>
								<c:set var="sum" value="0"/>
								<c:choose>
									<c:when test="${q.questionTypeNo eq 1 or q.questionTypeNo eq 2}">
										<div class="row row-cols-2">
										<c:forEach items="${q.optionList}" var="o">
											<div class="col">
												<span>${o.optionOrder}.</span>
												<span>${o.optionContent}</span>
												<c:forEach items="${result.answerList}" var="r">
													<c:choose>
														<c:when test="${q.questionTypeNo eq 1}">
															<c:if test="${r.questionNo eq q.questionNo and r.optionNo eq o.optionNo}">
																<span class="survey-result">(응답: <span class="survey-result-num">${r.answerCnt}</span>명, 비율: <span class="survey-result-num">${r.answerCnt/result.submitCnt * 100}</span> %)</span>
																<c:set var="sum" value="${sum + r.answerCnt}"/>
															</c:if>
														</c:when>
														<c:when test="${q.questionTypeNo eq 2}">
															<c:if test="${r.questionNo eq q.questionNo and r.optionNo eq o.optionNo}">
																<span class="survey-result">(응답: <span class="survey-result-num">${r.answerCnt}</span>명, 비율:<span class="survey-result-num"><c:if test="${o.optionTypeNo eq 2}">
																																${r.answerCnt/result.submitCnt * 100}
																																<c:set var="sum" value="${sum + r.answerCnt}"/>
																														</c:if>
																														<c:if test="${o.optionTypeNo ne 2}">
																															${(r.answerCnt*0.5)/result.submitCnt * 100}
																															<c:set var="sum" value="${sum + r.answerCnt * 0.5}"/></c:if></span>%)</span>
															</c:if>
														</c:when>
													</c:choose>
												</c:forEach>
											</div>
										</c:forEach>
										</div>
										<div>
											<p class="submit-counter bg-light p-2 mt-3">
												<fmt:parseNumber var="sum" integerOnly="true" value="${sum}"/>
												<span>총 ${result.submitCnt}명 중 <c:out value="${sum}"/>명 응답 (${sum/result.submitCnt * 100}%)</span>	
											</p>
										</div>
									</c:when>
									<c:when test="${q.questionTypeNo eq 4}">
										<div class="col"">
											<c:forEach items="${result.answerList}" var="r">
												<c:if test="${r.questionNo eq q.questionNo}">
													<p class="submit-counter border border-secondary p-2">총 ${result.submitCnt}명 중 ${r.answerCnt}명 응답 (${r.answerCnt/result.submitCnt * 100}%)</p>
												</c:if>
											</c:forEach>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>

					</div>
				</c:forEach>
				<div class="d-flex flex-row justify-content-between">
						<c:if test="${cri.pageIndex eq 1}">
							<a class="btn btn-rounded-pill btn-outline-secondary" href="/survey/surveyList.do">돌아가기</a>
						</c:if>
						<c:if test="${cri.pageIndex gt 1}">
							<a class="btn btn-lg btn-outline-danger" type="button" href="/survey/surveyResult.do?surveyNo=${result.surveyNo}&pageIndex=${cri.pageIndex-1}"><i class="fas fa-chevron-left"></i></a>
						</c:if>
						<c:if test="${cri.pageIndex lt paginationInfo.totalPageCount}">
							<a type="button" class="btn btn-lg btn-outline-danger" href="/survey/surveyResult.do?surveyNo=${result.surveyNo}&pageIndex=${cri.pageIndex+1}"><i class="fas fa-chevron-right"></i></a>
						</c:if>
						<c:if test="${cri.pageIndex eq paginationInfo.totalPageCount}">
							<a class="btn btn-rounded-pill btn-outline-secondary" href="/survey/surveyList.do">목록으로</a>
						</c:if>
				</div>
			</div>
		</div>
	</div>
	<div id="shortFormModal" class="modal modal-lg" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeModal()"></button>
	      </div>
	      <div class="modal-body">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeModal()">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<script>
	
		$(document).ready(function() {
			closeModal();
		})
		
		function shortForm(questionNo) {
			let data = {
					surveyNo : $("input[name='surveyNo']").val(),
					questionNo : questionNo
			}
			$.ajax({
				method : "POST",
				url : "/survey/showShortForm.do",
				data : JSON.stringify(data),
				contentType : 'application/json',
				dataType : 'json',
				success: function(answerList) {
					let title = $("#shortFormModal .modal-title");
					$(title).text(questionNo + "번 문항 응답")
					makeAnswerForm(answerList);
					showModal();	
				}
			})
		}
		
		function makeAnswerForm(answerList) {
			let body = $("#shortFormModal .modal-body");
			let cnt = 0;
			for (let answer of answerList) {
				if (answer.answerText != null) {
					cnt++;
					let div = $("<div/>");
					let textarea = $("<textarea/>").prop("disabled", true)
					.attr({
						"class" : "form-control my-2 overflow-scroll",
						"rows" : "3"
					})
					.val(answer.answerText).appendTo(div);
					$(body).append(div);
				}
			}
			$(body).prepend($("<p/>").text("총 " + cnt + "명 응답").attr("class", "text-end fw-bold"));
		}
		
		function showModal() {
			$("#shortFormModal").show();
		}
		
		function closeModal() {
			$("#shortFormModal").hide();
		}
	</script>
</main>
</body>
</html>