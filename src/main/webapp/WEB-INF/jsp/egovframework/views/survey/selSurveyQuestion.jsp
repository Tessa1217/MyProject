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
<title>설문조사 진행</title>
</head>
<body>
<main class="surveyQuestion mt-2 pt-2">
	<div class="container fluid px-4 my-6">
		<div class="card mb-4">
			<div class="card-header px-3 py-4">
				<h3 class="ms-2"><i class="fas fa-poll-h"></i> 설문조사</h3>
				<div class="progress">
  					<div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar" style="width: ${comQCnt/reqQCnt * 100}%" aria-valuenow="${comQCnt}" aria-valuemin="0" aria-valuemax="${reqQCnt}"></div>
				</div>
			</div>
			<div class="card-body">
				<input type="hidden" name="surveyNo" value="${surveyNo}">
				<input type="hidden" name="submitterNo" value="${submitterNo}"> 
				<form id="surveyForm">
					<c:forEach items="${questionList}" var="q">
						<div class="mx-2 my-4 p-2 question <c:if test="${(q.questionTypeNo eq 2 or q.questionTypeNo eq 4) and not empty q.answerList}">counted</c:if>" 
							id="question-${q.questionNo}" 
							data-required="${q.questionReqyn}" 
							data-type="${q.questionTypeNo}" 
							data-order="<c:choose><c:when test="${q.questionLevel == 2}">${q.parentQuestionNo}-${q.questionOrder}</c:when><c:otherwise>${q.questionOrder}</c:otherwise></c:choose>"
							<c:if test="${q.questionTypeNo eq 2}">data-ans-cnt="${q.questionAnsCnt}"</c:if>>
							<c:forEach items="${q.answerList}" var="answer">
								<input type="hidden" name="answerNo" value="${answer.answerNo}">
							</c:forEach> 
						<input type="hidden" name="questionNo" value="${q.questionNo}">
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
							</p>
							<c:choose>
								<c:when test="${q.questionTypeNo eq 1}">
									<div class="container">
										<div class="row row-cols-4">
											<c:forEach items="${q.optionList}" var="o">
													<div class="col">
														<input type="checkbox" class="form-check-input radio <c:if test="${o.optionTypeNo eq 3}">etc</c:if>" value="${o.optionNo}" name="optionNo"
														<c:if test="${not empty q.answerList}">
															<c:if test="${q.answerList[0].optionNo eq o.optionNo}">
															checked=checked
															</c:if>
														</c:if> id="checkbox-${q.questionOrder}-${o.optionOrder}">
														<label class="form-check-label" for="checkbox-${q.questionOrder}-${o.optionOrder}">${o.optionContent}</label>
														<c:if test="${not empty q.answerList and q.answerList[0].optionNo eq o.optionNo}">
															<c:if test="${not empty q.answerList[0].answerText}">
																<input class="form-control d-inline" type="text" name='answerText' value="${q.answerList[0].answerText}">
															</c:if>
														</c:if>
													</div>
											</c:forEach>
										</div>
									</div>
								</c:when>
								<c:when test="${q.questionTypeNo eq 2}">
									<div class="container">
										<div class="row row-cols-3">
											<c:forEach items="${q.optionList}" var="o">
													<div class="col">
														<input type="checkbox" class="form-check-input checkbox <c:if test="${o.optionTypeNo eq 2}">none</c:if><c:if test="${o.optionTypeNo eq 3}">etc</c:if>" 
															value="${o.optionNo}" name="optionNo"
														<c:if test="${not empty q.answerList}">
															<c:forEach items="${q.answerList}" var="answer">
																<c:if test="${o.optionNo eq answer.optionNo}">
																	checked=checked
																</c:if>
															</c:forEach>
														</c:if> id="checkbox-${q.questionOrder}-${o.optionOrder}">
														<label class="form-check-label" for="checkbox-${q.questionOrder}-${o.optionOrder}">${o.optionContent}</label>
														<c:if test="${o.optionTypeNo eq 3 and not empty q.answerList}">
															<c:forEach items="${q.answerList}" var="answer">
																<c:if test="${not empty answer.answerText}">
																	<input class="form-control d-inline" type="text" name="answerText" value="${answer.answerText}">
																</c:if>
															</c:forEach>
														</c:if>
													</div>
											</c:forEach>
										</div>
									</div>
								</c:when>
								<c:when test="${q.questionTypeNo eq 4}">
									<textarea class="form-control" rows="8" name="answerText" placeholder="1,000자 이내로 작성해주세요." maxlength="1000"><c:if test="${not empty q.answerList}">${q.answerList[0].answerText}</c:if></textarea>
								</c:when>
							</c:choose>
						</div>
					</c:forEach>
					<div class="d-flex flex-row justify-content-between">
						<c:if test="${cri.pageIndex eq 1}">
							<a class="btn btn-rounded-pill btn-outline-secondary" href="javascript:history.back()">돌아가기</a>
						</c:if>
						<c:if test="${cri.pageIndex gt 1}">
							<button class="btn btn-lg btn-outline-danger" type="button" onclick="movePage(${cri.pageIndex-1}, 2)"><i class="fas fa-chevron-left"></i></button>
						</c:if>
						<c:if test="${cri.pageIndex lt paginationInfo.totalPageCount}">
							<button type="button" class="btn btn-lg btn-outline-danger" onclick="movePage(${cri.pageIndex+1}, 1)"><i class="fas fa-chevron-right"></i></button>
						</c:if>
						<c:if test="${cri.pageIndex eq paginationInfo.totalPageCount}">
							<button type="button" class="btn btn-outline-danger" onclick="submitSurvey()">제출하기</button>
						</c:if>
					</div>
				</form>
			</div>
			<c:if test="${cri.pageIndex eq paginationInfo.totalPageCount}">
				<div class="card-footer text-center p-3">
					<p class="survey-thanks"><i class="far fa-grin text-primary"></i> 귀한 시간 설문에 응해 주셔서 감사드립니다! <i class="far fa-grin text-primary"></i></p>
				</div>
			</c:if>
		</div>
	</div>
</main>
<script>
	let answers = [];
	let cntPercentage= 100/${reqQCnt}; 
 	let oriPercentage = ${comQCnt}/${reqQCnt} * 100;
	let completeArray = null;
	
	$(document).ready(function() {
		
		if (sessionStorage.getItem("answerList") != null) {
			completeArray = JSON.parse(sessionStorage.getItem('answerList'));
		}
		
		if (completeArray != null) {
			let reqCnt = 0;
			let removeItemArray = [];
			let beforeQ = "";
			for (let i = 0; i < completeArray.length; i++) {
				let answer = completeArray[i];
				if (answer.reqYn == 'Y') {
					if (beforeQ != answer.questionNo) {
						reqCnt++;
					}
				}
				if ($("#question-" + answer.questionNo).length > 0) {
					if (beforeQ != null && beforeQ != answer.questionNo) {
						$("#question-"+answer.questionNo).find("input[name='optionNo']:checked").prop("checked", false);
						$("#question-"+answer.questionNo).find("[name='answerText']").val('');
					}
					if ($("#question-" + answer.questionNo).data("required") == "Y" && 
							($("#question-" + answer.questionNo).data("type") == "2" || $("#question-" + answer.questionNo).data("type") == "4")) {
						$("#question-" + answer.questionNo).addClass("counted");
					}
					$("#question-" + answer.questionNo).find("input[name='optionNo']").eq(answer.optionOrder).prop("checked", true);
					if (answer.optionNo != null && answer.answerText != null) {
						if ($("#question-" + answer.questionNo).find("input[type='text']").length == 0) {
							$("#question-" + answer.questionNo).find("input.etc[name='optionNo']:checked").siblings("label").after($("<input/>").attr({
								"type" : "text",
								"name" : "answerText",
								"required" : true,
								"class" : "form-control d-inline",
								"maxlength" : 50,
								"placeholder" : "50자 이내로 입력해주세요."
							}))
						}
					}
					$("#question-" + answer.questionNo).find("[name='answerText']").val(answer.answerText);
					removeItemArray.push(i);
				}
				beforeQ = answer.questionNo;
			}
			for (let idx = removeItemArray.length - 1; idx >= 0; idx--) {
				completeArray.splice(removeItemArray[idx], 1);
			}
			if (oriPercentage == 0) {
				oriPercentage += reqCnt * cntPercentage;
			}
			progressBar(0);
		}

		
		$("input.checkbox.none").click(function() {
			let question = $(this).parents(".question");
			if ($(this).is(":checked")) {
				$(question).hasClass("counted") ? progressBar(-cntPercentage) : progressBar(0);
				$(question).find("input.checkbox").not($(this)).prop("checked", false);
				$(question).find("input[type='text'][name='answerText']").remove();
				if ($(question).data("required") == "Y") {
					$(question).addClass("counted");
					progressBar(cntPercentage);
				} 
			} else {
				$(question).removeClass("counted");
				progressBar(-cntPercentage);
			}
		});
		
		$("input.radio").click(function() {
			
			let question = $(this).parents(".question");
			if ($(this).is(":checked")) {
				if ($(question).data("required") == "Y" && !$(question).find("input.radio").not($(this)).is(":checked")) {
					progressBar(cntPercentage);
				}
				if ($(question).find("input.radio.etc").is(":checked")) {
					$(question).find("input[name='answerText']").remove();
				}
				$(question).find("input.radio").not($(this)).prop("checked", false);	
			} else if (!$(this).is(":checked")) {
				if ($(question).data("required") == "Y" && !$(question).find("input.radio").not($(this)).is(":checked")) {
					progressBar(-cntPercentage);
				}
			}
		});
		
		$("input.checkbox").not(".none").click(function() {
			let question = $(this).parents(".question");
			if ($(question).find("input.none.checkbox").is(":checked")) {
				$(question).find("input.checkbox.none").prop("checked", false);
				$(question).removeClass("counted");
				progressBar(-cntPercentage);
			}
			let maxCount = $(question).data("ans-cnt");
			let count = $(question).find("input.checkbox:checked").length;
			if ($(question).data("required") == 'Y') {
				if (!$(question).hasClass("counted") && count == maxCount) {
					$(question).addClass("counted");
					progressBar(cntPercentage);
				} else if ($(question).hasClass("counted") && count < maxCount) {
					$(question).removeClass("counted");
					progressBar(-cntPercentage);
				}
			}
			if (count > maxCount) {
				fireAlert(maxCount + "개까지만 선택 가능합니다.", 2);
				$(this).prop("checked", false);
			} 
		});
		
		$("input.etc").click(function() {
			if ($(this).is(":checked")) {
				if ($(this).siblings("input[type='text']").length == 0) {
					$(this).siblings("label").after($("<input/>").attr({
						"type" : "text",
						"name" : "answerText",
						"required" : true,
						"maxlength" : 50,
						"placeholder" : "50자 이내로 입력해주세요.",
						"class" : "form-control d-inline"
					}));
				}
			}
			if (!$(this).is(":checked")) {
				$(this).siblings("input[type='text']").remove();
			}
		});
		
		$("textarea[name='answerText']").on("change", function() {
			let question = $(this).parents(".question");
			if ($(question).data("required") == 'Y') {
				if ($(question).hasClass("counted") && $(this).val().trim() == '') {
					progressBar(-cntPercentage);
					$(question).removeClass("counted");
				} else if (!$(question).hasClass("counted") && $(this).val().trim() != '') {
					progressBar(cntPercentage);
					$(question).addClass("counted");
				}
			}
			if ($(this).val().trim() == '') {
				$(this).val('');
			}
		})
		
	})
	
	function progressBar(cntPercentage) {
		let pBar = $(".progress-bar");
		oriPercentage += cntPercentage; 
 		$(pBar).css("width", oriPercentage + "%");
 		progressColor(oriPercentage);
 	}
	
	function progressColor(oriPercentage) {
		let color = null;
		if (oriPercentage < 25) {
			color = "bg-danger";
		} else if (oriPercentage < 50) {
			color = "bg-warning";
		} else if (oriPercentage < 75) {
			color = "bg-primary";
		} else if (oriPercentage <= 100) {
			color = "bg-success";
		}
		$(".progress-bar").removeClass(["bg-danger", "bg-warning", "bg-primary", "bg-success"]).addClass(color);
	}
	
	function movePage(pageIndex, command) {
		if (command == 1) {
			if (checkForm() == 1) {
				insertAnswer();
				location.href="/survey/takeSurvey.do?" + locationString(pageIndex);
			}
		} else if (command == 2) {
			location.href="/survey/takeSurvey.do?" + locationString(pageIndex);
		}
		
	}
	
	function insertAnswer() {
		let data = answers;
		if (sessionStorage.key("answerList") != null) {
			data = [...completeArray,
					...answers];
		}
		sessionStorage.setItem("answerList", JSON.stringify(data));
	};
	
	
	function locationString(pageIndex) {
		let obj = new Object({
				surveyNo : $("input[name='surveyNo']").val(),
				pageIndex : pageIndex,
				submitterNo : $("input[name='submitterNo']").val()
		});
		return decodeURI($.param(obj));
	}
	
	function submitSurvey() {
		if (checkForm() == 1) {
			insertAnswer();
			insertSubmit();
		}
	}
	
	function insertSubmit() {
		let data = {
				surveyNo : $("input[name='surveyNo']").val(),
				submitterNo : $('input[name="submitterNo"]').val(),
				answerList : JSON.parse(sessionStorage.getItem("answerList"))
				
		}
		sessionStorage.removeItem("answerList");
		$.ajax({
			method : 'POST',
			url : '/survey/insAnswer.do',
			contentType : 'application/json',
			data : JSON.stringify(data),
			success : function(result) {
				let msg = (result == 'modify') ? "수정을" : "참여를";
				fireAlert("설문지 " + msg + " 완료하였습니다.", 1);
			}
		}) 
	}
	
	function checkForm() {
		answers = [];
		let formCheck = 1;
		$("#surveyForm").find(".question").each((idx, val) => {
			if (formCheck != 1) {
				return formCheck;
			}
			let order = $(val).data("order");
			let type = $(val).data("type");
			let optionType = 1;
			if (type == 1) {
 	 			if ($(val).data("required") == 'Y' && $(val).find("input.radio:checked").length == 0) {
					formCheck = 2;
				} else if ($(val).find("input.radio:checked").hasClass("etc") && $(val).find("input[name='answerText']").val() == '') {
					formCheck = 3;
				} else {
					if ($(val).find("input.radio:checked").hasClass("etc")) {
						optionType = 2;
					}
					answers.push(makeAnswerObject(val, 0, optionType));
				} 
			}
			if (type == 2) {
				let count = $(val).data("ans-cnt");
				if ($(val).data("required") == 'Y' && $(val).find("input.checkbox:checked").length < count) {
					if ($(val).find("input.checkbox.none:checked").length == 0) {
						formCheck = 2;
					} else if ($(val).find("input.checkbox.none:checked").length == 1) {
						answers.push(makeAnswerObject(val, 0, optionType));
					}
				} else if ($(val).find("input:checkbox:checked").hasClass("etc") && $(val).find("input[name='answerText']").val().trim() == ''){
					formCheck = 3;
					$(val).find("input[name='answerText']").val('').focus();
				} else {
					for (let i = 0; i < $(val).find("input.checkbox:checked").length; i++) {
						if ($(val).find("input.checkbox:checked").eq(i).hasClass("etc")) {
							optionType = 2;
						}
						answers.push(makeAnswerObject(val, i, optionType));
					}
				}
			} 
			if (type == 4) {
				if ($(val).data("required") == 'Y' && $(val).find("textarea[name='answerText']").val().trim() == '') {
					formCheck = 2;
					$(val).find("textarea[name='answerText']").val('').focus();
				} else if ($(val).find("textarea[name='answerText']").val().length > 1000) {
					fireAlert("답안은 1,000자 미만으로 작성해주세요!", 2);
					formCheck = 0;
				} else {
					answers.push(makeAnswerObject(val, 0, optionType));
				}
			}
			if (formCheck == 2) {
				alertMsg(order);
			} 
			if (formCheck == 3) {
				alertEtcMsg(order) 
			}
		}); 
		return formCheck;
	}
	
	function alertMsg(order) {
		let msg = "문항 <strong>" + order + "번</strong>에 답을 입력해주세요!";
		fireAlert(msg, 2);
	}
	
	function alertEtcMsg(order) {
		let msg = "문항 <strong>" + order + "</strong>번째 항목의 기타란을 작성해주세요!";
		fireAlert(msg, 2);
	}
	
	function makeAnswerObject(question, idx, type) {
		return {
			answerNo : $("input[name='answerNo']").eq(idx).val(),
			surveyNo : $("input[name='surveyNo']").val(),
			submitterNo : $("input[name='submitterNo']").val(),
			questionNo : $(question).find("input[name='questionNo']").val(),
			optionNo : $(question).find("input[name='optionNo']:checked").eq(idx).val(),
			optionOrder : $(question).find("input[name='optionNo']").index($(question).find("input[name='optionNo']:checked").eq(idx)),
			answerText : (type == 2) ? $(question).find("input.etc").siblings("input[name='answerText']").val() : $(question).find("textarea[name='answerText']").val(),
			reqYn : $(question).data("required")
		}
	}
</script>
</body>
</html>