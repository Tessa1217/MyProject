// 1.use strict?
// 2.즉시실행함수
// 3.module로 사용

/*
 * 요청 게시판 관련 AJAX 메소드
 */
	// 요청 생성
	function insRequest(form) {
		editor.updateSourceElement();
		if (formValidCheck(form)) {
			$.ajax({
				method : 'POST',
				url : '/request/insRequest.do',
				data : $(form).serialize(),
				dataType : 'json',
				success : (req) => {
					if (req.requesterNo != null) {
						location.href="/request/requestList.do";
					} else if (req.requesterNo == null) {
						errorAlert("요청 사항 생성에 실패하였습니다. 다시 시도해주시기 바랍니다.");
					}
				}
			});
		}
		return false;
	}

	// 요청 수정
	function updRequestAjax() {
		editor.updateSourceElement();
		if (formValidCheck($("#updForm"))) {
			$.ajax({
				method : 'POST',
				url : '/request/updRequest.do',
				data : $("#updForm").serialize(),
				dataType : 'json',
				success : (msg) => {
					if (msg == "success") {
						reloadStage(1);
					} else if (msg == "failed") {
						errorAlert("수정을 진행할 수 없습니다. 다시 확인해주세요.");
					}
				}
			});
		}
	}

	// 답변 생성
	function insResponseAjax(form) {
		if (editor != undefined) {
			editor.updateSourceElement();
		}
		let data = $(form).serialize();
		if (formValidCheck(form)) {
			$.ajax({
				method : 'POST',
				url : '/request/insResponse.do',
				data : data,
				dataType : 'json',
				success : (obj) => {
					if (obj.reqNo == null) {
						errorAlert("해당 요청을 처리할 수 없습니다. 다시 시도해주시기 바랍니다.");
					}
					if (obj.reqApproveyn == 1 || (obj.respType == "REVIEWED" && obj.respDegree == 3)) {
						location.reload();
					}
					if (obj.respType == "OBJECTION") {
						reloadStage(3);
					} else if (obj.respType == "REVIEWED") {
						if (obj.respDegree > 0) {
							reloadStage(3);
						} else {
							location.reload();
						}
					} 
				}
			});
		}
		return false;
	}

	// 답변 수정
	function updResponseAjax(formName) {
		if (editor != undefined) {
			editor.updateSourceElement();
		}
		let data = $("form#" + formName).serialize();
		if (formValidCheck($("form#" + formName))) {
			$.ajax({
				method : 'POST',
				url : '/request/updResponse.do',
				data : data,
				dataType : 'json',
				success : (resp) => {
					if (resp.respNo == null) {
						errorAlert("해당 요청을 처리할 수 없습니다. 다시 시도해주시기 바랍니다.");
					}
					if (resp.reqApproveyn == 1) {
						location.reload();
					}
					if (resp.respType == "REVIEWED") {
						(resp.respDegree == 0) ? reloadStage(2) : reloadStage(3);
					} else {
						reloadStage(3);
					}
				}
			});
		}
	}
	
	// 생성 또는 수정 후 해당 페이지 부분 리로드
	function reloadStage(stageIdx) {
		$("#state-badge").load(window.location.href + " #state-badge")
		$("#tab-nav").load(window.location.href + " #v-pills-tab", function() {
			activeTab();
		});
		switchTab(stageIdx);
	}
	
	function switchTab(idx) {
		$("#req-content").load("/request/selRequestStage.do", {reqNo : $("input[name='reqNo']").val(), reqStage : idx}, function() {
			activeTab();
		});
	}
	
	function activeTab() {
		const id = $("#req-content").find(".tab").attr("id");
		const idx = id.substring(id.indexOf("-") + 1);
		$("#v-pills-tab .nav-link").removeClass("active");
		$("#v-pills-tab .nav-link").eq(idx-1).addClass("active");
	}
	
	// Validation
	function formValidCheck(form) {
		let flag = true;
		$(form).find(".form-control").each((idx, val) => {
			if ($(val).val().trim() == '') {
				chkAlert("값을 입력해주세요.", val);
				flag = false;
				return flag;
			}
		});
		return flag;
	}
	
	// Alert 
	function chkAlert(msg, input) {
		let timeInterval;
		Swal.fire({
			html: '<h3>' + msg + '</h3>',
			icon : "warning",
			timer : 1000,
			showConfirmButton : false,
			onClose : focusInput(input)
		});
	}
	
	function errorAlert(msg) {
		let timeInterval;
		Swal.fire({
			html : '<h3>' + msg + '</h3>',
			icon : "error",
			timer : 1000,
			showConfirmButton : false
		}).then((result) => {
			if (result.dismiss === Swal.DismissReason.timer) {
				location.reload();
			}
		})
	}
	
	function focusInput(input) {
		if (input.tagName == 'TEXTAREA' && editor != undefined) {
			editor.focus();
		} 
		$(input).focus();
	}
	
	// 이력조회 모달
	
	function objectionHistory() {
		$("#objHistoryModal .modal-body").load("/request/selRequestStage.do", {reqNo : $("input[name='reqNo']").val(), reqStage : 3});
		$("#objHistoryModal").show();
	}
	
	function closeObjHistoryModal() {
		$("#objHistoryModal .modal-body").empty();
		$("#objHistoryModal").hide();
	}
	
	function modalLocation(modal) {
		let wrapper = $(modal).find(".modal-wrapper");
		wrapper.css({
			"position" : "absolute",
			"top" : Math.max(0, (($(window).height() - wrapper.outerHeight()) / 2) + $(window).scrollTop()) + "px",
			"left" : Math.max(0, (($(window).width() - wrapper.outerWidth()) / 2) + $(window).scrollLeft()) + "px"
		});
	}
	

