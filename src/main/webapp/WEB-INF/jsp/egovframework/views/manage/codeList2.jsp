<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mt-2 pt-2 codeList">
	<div class="container-fluid px-4">
		<div class="card my-2">
			<div class="card-header p-3 d-flex flex-row justify-content-between">
				<div class="col-11 d-flex flex-row justify-content-start">
					<h3 class="me-4">공통 코드 관리</h3>
					<div class="col-3">
						<form id="common-search-form" class="d-flex flex-row justify-content-between align-items-center" action="/manage/commonList.do" method="GET" onSubmit="return searchFormCheck(this);">
							<select class="form-select d-inline w-25 me-2" name="searchCnd">
								<option value="" <c:if test="${empty cri.searchCnd}">selected='selected'</c:if>>전체</option>
								<option value="GP_CODE" <c:if test="${cri.searchCnd eq 'GP_CODE'}">selected='selected'</c:if>>대분류 코드</option>
								<option value="GP_NM" <c:if test="${cri.searchCnd eq 'GP_NM'}">selected='selected'</c:if>>대분류 코드명</option>
								<option value="ALL" <c:if test="${cri.searchCnd eq 'ALL'}">selected='selected'</c:if>>전체 검색</option>
							</select>
							<input type="text" class="code-input-form form-control me-2 w-50" name="searchKeyword" 
								required maxlength="50"
								<c:if test="${not empty cri.searchCnd}">value="${cri.searchKeyword}"</c:if>
								<c:if test="${empty cri.searchCnd}">disabled='disabled'</c:if>>
							<input type="hidden" name="tabIndex" value="${tabIndex}">
							<button type="submit" class="btn w-25 btn-primary">검색</button>
						</form>
					</div>
				</div>
				<div class="col-1">
					<ul class="nav nav-pills nav-fill tab-nav justify-content-end">
						<li class="nav-item"><a class="nav-link <c:if test="tabIndex eq '0'">active</c:if>"
							href="javascript:changeTab(0);">테이블</a></li>
						<li class="nav-item"><a class="nav-link <c:if test="tabIndex eq '1'">active</c:if>"
							href="javascript:changeTab(1);">트리</a></li>
					</ul>
				</div>
			</div>
			<div class="tabPage card-body p-3 d-flex flex-column justify-content-center">
				<div class="card">
					<div class="card-header p-3 d-flex flex-row justify-content-between">
						<h4>대분류 공통코드</h4>
						<div>
							<button type="button" class="btn rounded-pill btn-outline-success" onclick="insertTr('group-table')">대분류 추가</button>
						</div>
					</div>
					<div id="common-code-table" class="card-body">
						<jsp:include page="tableGroup.jsp"></jsp:include>
					</div>
					<div class="card-footer d-flex justify-content-end align-items-center p-2">
						<button type="button" class="btn rounded-pill btn-outline-danger me-2" onclick="deleteCode('gp-code')">선택삭제</button>
					</div>
				</div>
				<div class="d-flex align-items-center justify-content-center">
					<h3 class="m-4"><i class="fas fa-angle-double-down"></i></h3>
				</div>
				<div class="card">
					<div class="code-table card-header p-3 d-flex flex-row justify-content-between align-items-center">
						<div class="d-flex flex-row justify-content-between align-items-center">
							<h4 class="me-4">소분류 공통코드</h4>
							<div class="d-flex flex-row">
								<label for="gpCode" class="input-group-text me-2">대분류</label>
								<input class="d-inline form-control" type="text" name="gpCode" id="gpCode" value="" readonly>
							</div>
						</div>
						<div>
							<button type="button" onclick="insertTr('code-table')" class="btn btn-outline-success rounded-pill">소분류 추가</button>
							<button type="button" onclick="changeOrder()" class="btn btn-outline-warning rounded-pill update-start disabled">순서 변경</button>
							<button type="button" onclick="updateOrder()" class="d-none btn update-done rounded-pill btn-outline-danger">변경 완료</button>
						</div>
					</div>
					<div class="card-body">
						<table class="code-table table table-hover">
							<input type="hidden" name="gpCode" value="">
							<thead class="text-center">
								<tr>
									<th width="3%"><input class="form-check-input del-check cd-check all" type="checkbox"></th>
									<th width="10%">소분류 코드</th>
									<th width="10%">코드명</th>
									<th width="42%">코드 설명</th>
									<th width="5%">코드 순서</th>
									<th width="10%">등록일</th>
									<th width="10%">수정일</th>
									<th width="10%">변경</th>
								</tr>
							</thead>
							<tbody class="code-body">
							</tbody>
						</table>
					</div>
					<div class="card-footer d-flex flex-row justify-content-end p-2">
						<button type="button" class="btn btn-outline-danger rounded-pill" onclick="deleteCode('cd-code')">선택삭제</button>
					</div>
				</div>
			</div>
			<div class="tabPage card-body p-3 d-flex flex-row justify-content-between">
				<div class="card col-6">
					<div class="card-header d-flex flex-row justify-content-between">
						<h4>공통 코드</h4>
						<button class="btn btn-success" onclick="showInsertModal()">추가하기</button>
					</div>
					<div id ="common-code-tree" class="tree-body card-body">
						<jsp:include page="codeTree.jsp"></jsp:include>
					</div>
				</div>
				<div class="col-1 d-flex flex-row justify-content-center align-items-center">
					<h3 class="m-4"><i class="fas fa-angle-double-right"></i></h3>
				</div>
				<div class="card col-5">
					<div class="card-header d-flex flex-row justify-content-between">
						<h4>코드 변경</h4>
					</div>
					<div class="tree-forms card-body">
						<form id="groupForm" class="p-3">
							<input type="hidden" name="oriGpCode">
							<div>
								<label class="form-input-label" id="gpCode">대분류 코드</label>
								<input class="form-control" type="text" name="gpCode" id="gpCode">
							</div>
							<div>
								<label class="form-input-label" id="gpNm">대분류 코드명</label>
								<input class="form-control" type="text" name="gpNm" id="gpNm">
							</div>
							<div>
								<label class="form-input-label" id="gpDesc">대분류 설명</label>
								<textarea class="form-control" rows="5" name="gpDesc"></textarea>
							</div>
							<div>
								<label class="form-input-label" id="gpRegDate">대분류 등록일</label>
								<input class="form-control" type="text" name="gpRegDate" id="gpRegDate" readonly>
							</div>
							<div>
								<label class="form-input-label" id="gpModDate">대분류 수정일</label>
								<input class="form-control" type="text" name="gpModDate" id="gpModDate" readonly>
							</div>
						</form>
						<form id="codeForm" class="p-3 d-none">
							<input type="hidden" name="oriCdCode">
							<div>
								<label class="form-input-label" id="gpCode">대분류 코드</label>
								<input class="form-control" type="text" name="gpCode" id="gpCode">
							</div>
							<div>
								<label class="form-input-label" id="cdCode">소분류 코드</label>
								<input class="form-control" type="text" name="cdCode" id="cdCode">
							</div>
							<div>
								<label class="form-input-label" id="cdNm">소분류 코드명</label>
								<input class="form-control" type="text" name="cdNm" id="cdNm">
							</div>
							<div>
								<label class="form-input-label" id="cdDesc">소분류 설명</label>
								<textarea class="form-control" rows="5" name="cdDesc"></textarea>
							</div>
							<div>
								<label class="form-input-label" id="cdRegDate">대분류 등록일</label>
								<input class="form-control" type="text" name="cdRegDate" id="cdRegDate" readonly>
							</div>
							<div>
								<label class="form-input-label" id="cdModDate">대분류 수정일</label>
								<input class="form-control" type="text" name="cdModDate" id="cdModDate" readonly>
							</div>
						</form>
					</div>
					<div class="card-footer d-flex flex-row justify-content-end">
						<button type="button" class="btn btn-outline-primary rounded-pill me-2" onclick="updateTreeCode()">변경하기</button>
						<button type="button" class="btn btn-outline-danger rounded-pill" onclick="deleteTreeCode()">삭제하기</button>
					</div>
				</div>
			</div> 
		</div>
	</div>
	<div id="common-modal">
		<jsp:include page="codeModal.jsp"></jsp:include>
	</div>
	<script src="/js/code-ajax.js"></script>
	<script src="/js/code-validation.js"></script>
	<script>
		let copy = '';
		const cdList = ["check", "code editable", "nm editable", "desc editable", "order", "regDate", "modDate", "modify"];
		const gpList = ["check", "code editable", "nm editable", "desc editable", "regDate", "modDate", "modify"];
		$(document).ready(function() {
			
			changeTab(${tabIndex});
			
			$(document).on("click", ".gp-code", (e) => {
				if ((e.target.type == 'checkbox') || (e.target.type == 'button') || ($(e.target).hasClass("editable bg-light"))) {
					return;
				}
				if ($(e.target).parents(".gp-code").data("code") != $(".code-table input[name='gpCode']").val()) {
					$(".code-body").empty();
					$(".code-table thead").find("input[type='checkbox']").prop("checked", false);
	 				$(".code-table [name='gpCode']").val('');
					let gpCode = $(e.target).parents(".gp-code").data("code");
					getCdList(gpCode); 
				}
			});
			
			$(document).on("click", ".gp-list > li > i", (e) => {
				e.stopPropagation();
				let ul = $(e.target).parents("li").next(".cd-list");
				$(ul).toggleClass("d-none");
				$(e.target).toggleClass("fa-plus fa-minus");
				if ($(e.target).hasClass("fa-minus") && !$(ul).hasClass("d-none")) {
					$(e.target).siblings(".tree-upd-start").removeClass("d-none");	
				} else {
					$(e.target).siblings(".tree-upd-start").addClass("d-none");
				}
				
			});
			
			$("#common-search-form select").on("change", function(e) {
				let input =$(e.target).siblings("input[name='searchKeyword']"); 
				if ($(e.target).val() == "") {
					$(input).attr("disabled", true).val('');
				} else {
					$(input).attr("disabled", false).val('');
				}
			})

			$(document).on("click", ".del-check", (e) => {
				let type = ($(e.target).hasClass("gp-check")) ? 'gp-check' : 'cd-check';
				if ($(e.target).hasClass("all")) {
					$(".del-check." + type).prop("checked", $(e.target).prop("checked"));
				} else {
					if ($(".del-check." + type).not(".all").length == $(".del-check." + type + ":checked").not(".all").length) {
						$(".del-check." + type + ".all").prop("checked", true);
					} else {
						$(".del-check." + type + ".all").prop("checked", false);
					}
				}
			});

			$(document).on("click", ".mod-btn", (e) => {
				let tr = $(e.target).parents("tr");
				$(tr).find("button").toggleClass("d-none");
				editableTd(tr);
			});
			
			$(document).on("click", ".mod-done-btn", (e) => {
				let tr = $(e.target).parents("tr");
				if (insertTdCheck(tr)) {
					if ($(tr).hasClass("gp-code")) {
						updGpAjax(tr, makeGroupObj(tr));
					} else if ($(tr).hasClass("cd-code")) {
						updateOrderAjax([makeCodeObj(tr)]);
					}
				}
			});
			
			$(document).on("click", ".mod-reset-btn", (e) => {
				let tr = $(e.target).parents("tr");
				$(tr).find("button").toggleClass("d-none");
				$(tr).find(".editable").attr("contenteditable", false).removeClass("bg-light");
			})
			
			$(document).on("click", ".tree-body li", function(e) {
				let code = $(e.target).find("span").text().trim();
				let data = {};
				if ($(e.target).hasClass('cd-code')) {
					data.cdCode = code;
					data.gpCode = $(e.target).parents("ul").prev("li").find("span").text().trim();
					getCommonCd(data);
				} else if ($(e.target).hasClass('gp-code')) {
					data.gpCode = code;
					getCommonGp(data);
				}
			});
			
			$(document).on("change", "select.codeType", (e) => {
				$(".modal-body form").addClass("d-none");
				$("#" + $(e.target).val()).removeClass("d-none");
			});
			
			
			$(document).on("click", ".ins-rem-btn", (e) => {
				$(e.target).parents("tr").remove();
				if ($(e.target).parents("table").find("tr").length > 1) {
					$("button.update-start").removeClass("disabled")
				};
			});
			
			$(document).on("click", ".ins-done-btn", (e) => {
				let tr = $(e.target).parents("tr");
				if (insertTdCheck(tr)) {
					insertCode(tr);
					if ($(e.target).parents("table").find("tr").length > 1) {
						$("button.update-start").removeClass("disabled")
					};
				}
			});
			
		});	
		
		// Tab 변경
		function changeTab(idx) {
			let a = $(".tab-nav a.nav-link").eq(idx);
			let page = $(".tabPage").eq(idx);
			$(a).addClass("active");
			$(page).removeClass("d-none");
			$(".tab-nav").find("a.nav-link").not(a).removeClass("active");
			$(".tabPage").not(page).addClass("d-none");
			$("input[name='tabIndex']").val(idx);
		}
		
		// 모달
		function showInsertModal() {
			$("#insertModal form").each((idx, form) => {$(form)[0].reset()});
			$("select.codeType").val("insertGpForm").trigger("change");
			$("#insertModal").show();
		}
		
		function closeInsertModal() {
			$("#insertModal").hide();
		}
		
		// 코드 생성 (테이블)
		
		function editableTd(tr) {
			$(tr).find(".editable").attr("contenteditable", true).addClass("bg-light");
			$(tr).find(".editable").eq(0).focus();
		}
		
		function insertTr(tableType) {
			let tr = $("<tr/>");
			$(tr).attr("class", (tableType == "group-table") ? "gp-code" : "cd-code");
			
			if ($(tr).hasClass("gp-code")) {
				for (let i = 0; i < 8; i++) {
					tr.append($("<td/>").attr("class", gpList[i]));
				}
			} else {
				$("button.update-start").addClass("disabled");
				for (let i = 0; i < 9; i++) {
					tr.append($("<td/>").attr("class", cdList[i]));
				}
			}
			$(tr).find(".modify").append($("<button/>").text("취소").attr("class", "btn ins-rem-btn btn-sm rounded-pill btn-secondary d-inline me-2"));
			$(tr).find(".modify").append($("<button/>").text("완료").attr("class", "btn ins-done-btn btn-sm rounded-pill btn-danger d-inline"));
			$("." + tableType + " tbody").append(tr);
			
			editableTd(tr);
			
		}
		
		function insertCode(tr) {
			if (tr.hasClass("gp-code")) {
				insertCodeAjax(makeGroupObj(tr));	
			} else if (tr.hasClass("cd-code")) {
				insertCodeAjax(makeCodeObj(tr));
			}
		}
		
		// 코드 생성 (트리)
		function makeForm(obj) {
 			$("#groupForm")[0].reset();
			$("#codeForm")[0].reset(); 
			let form = "";
			for (field in obj) {
				if (field.endsWith("Date")) {
					obj[field] = dateField(obj[field]);
				} else if (field.endsWith("Desc")) {
					obj[field] = brConvert(obj[field]);
				}
				$("form [name='" + field +"']").val(obj[field]);
			}
			formTransition(obj);
		}
		
		function brConvert(val) {
			return val.replaceAll("<br>", "\r\n");
		}
		
		function lineConvert(val) {
			return val.replaceAll("\r\n", "<br>");
		}
		
		function dateField(val) {
			return (val == null) ? "-" : new Date(val).toLocaleDateString('ko-KR');
		}
		
		function formTransition(obj) {
 			if (obj.hasOwnProperty("oriGpCode")) {
				$("#groupForm").removeClass("d-none");
				$("#codeForm").addClass("d-none");
			} else if (obj.hasOwnProperty("oriCdCode")) {
				$("#groupForm").addClass("d-none");
				$("#codeForm").removeClass("d-none");
			} 
		}
		
		function insertTreeCode() {
			let form = $(".modal-body form").not(".d-none");
			if (insertFormCheck(form)) {
				insertCodeAjax(makeFormObj(form));	
			}
		}
		
		// 코드 변경
		
		function updateTreeCode() {
			let form = $(".tree-forms form").not(".d-none");
			if (!insertFormCheck(form)) {
				return;
			}
		 	if ($(form).attr("id") == "groupForm") {
		 		updGpAjax(null, makeFormObj(form));	
			} else if ($(form).attr("id") == "codeForm") {
				updateOrderAjax([makeFormObj(form)]);
			} 
		}
		
		// 데이터 불러오기
		function makeCdRow(elem, idx) {
			let tr = $("<tr/>").attr("class", "cd-code").data("code", elem.cdCode);
			let i = 0;
			$(tr).append($("<td/>").attr("class", cdList[i++]).append($("<input/>").attr({
				"type" : "checkbox",
				"class" : "form-check-input del-check cd-check"
			})));
			let fieldSet = ['cdCode', 'cdNm', 'cdDesc', 'cdOrder', 'cdRegDate', 'cdModDate'];
			for (field in elem) {
  				if (field.endsWith("Date")) {
  					elem[field] = dateField(elem[field]);
				} 
  				if (field == "cdOrder") {
  					elem[field] = idx + 1;
  				}
				if (fieldSet.indexOf(field) >= 0) {
					$(tr).append($("<td/>").text(elem[field]).attr("class", cdList[i]));
					i++;
				}
			}
			$(tr).append($("<td/>").attr("class", "modify").append($("<button/>").attr("class", "mod-btn btn btn-sm rounded-pill btn-primary").text("수정")));
			$(tr).find(".modify").append($("<button/>").text("취소").attr("class", "mod-reset-btn d-none btn btn-sm rounded-pill btn-secondary me-2"));
			$(tr).find(".modify").append($("<button/>").text("완료").attr("class", "mod-done-btn d-none btn btn-sm rounded-pill btn-danger"));
			return tr;
		}
		
		function makeFormObj(form) {
			let data = {};
			for (field of $(form).serializeArray()) {
				if (!field.name.endsWith("Date")) {
					data[field.name] = field.value;
				}
				if (field.name.endsWith("Desc")) {
					data[field.name] = lineConvert(field.value);
				}
			};
			return data;
		}
		
		// 삭제 (테이블)
		function deleteCode(codeType) {
			if ($("." + codeType + " .del-check:checked").not(".all").length == 0) {
				fireAlert("선택된 코드가 없습니다!", 2);
				return;
			}
			let delTr = $("." + codeType + " .del-check:checked").parents("tr");
 			let delArray = [];
 			let flag = true;
 			if (codeType == "gp-code") {
 				for (tr of delTr) {
 					delArray.push(makeGroupObj(tr));
 					let cntList = getCommonCdCnt(delArray);
 					$(cntList).each((idx, val) => {
 						if (val != null) {
 							fireAlert("대분류 " + val.gpCode + "에 소분류 코드가 존재합니다.", 2);
 							flag = false;
 							return;
 						}
 					})
 				} 
 			} else if (codeType == "cd-code") {
				for (tr of delTr) {
					delArray.push(makeCodeObj(tr));
				} 				
 			}
 			if (flag) {
 				delCodeAjax(delArray);	
 			}
		}
		
		// 삭제 (트리)
		function deleteTreeCode() {
			let form = $(".tree-forms form").not(".d-none");
			if ($(form).attr("id") == "groupForm") {
				let cntList = getCommonCdCnt([makeFormObj(form)]);
				if (cntList[0] != null) {
					fireAlert("대분류 " + cntList[0].gpCode + "에 소분류 코드가 존재합니다.", 2);
					return;
				}
			}
			delCodeAjax([makeFormObj(form)]);	
		}
		
		// 순서 바꾸기
		function changeOrder() {
			$("button.update-start").addClass("d-none");
			$("button.update-done").removeClass("d-none");
			$(".code-table tbody").sortable({
				disabled : false,
				update : function(e, ui) {
					$(this).find("")
					$(this).find("tr").each((idx, val) => {
						$(val).find("td.order").text(idx + 1);
					});
				}
			})
		}

		function updateOrder() {
			$("button.update-start").removeClass("d-none");
			$("button.update-done").addClass("d-none");
			$(".code-table tbody").sortable({
				disabled : true
			})
			updateOrderAjax(changeCdOrder()); 
		}
		
		// 순서바꾸기 (트리)
		function changeTreeOrder(elem) {
			$(elem).toggleClass("d-none");
			$(elem).siblings("button").toggleClass("d-none");
			$(elem).parents("li").next("ul").sortable();
		}
		
		function updateTreeOrder(elem) {
			$(elem).toggleClass("d-none");
			$(elem).siblings("button").toggleClass("d-none");
			let ul = $(elem).parents("li").next("ul");
			let objArray = [];
			$(ul).sortable({
				disabled : true
			})
			$(ul).find("li").each((idx, val) => {
				let obj = {
					oriCdCode : $(val).find("span").text().trim(),
					cdOrder : idx + 1
				}
				objArray.push(obj);
			})
			updateOrderAjax(objArray);
		}

		// Object 
		
		function makeCodeObj(tr) {
			let obj = {
				gpCode : $(".code-table [name='gpCode']").val(),
				oriCdCode : $(tr).data("code"),
				cdCode : $(tr).find(".code").text().trim(),
				cdOrder : $(tr).find(".order").text().trim(),
				cdNm : $(tr).find(".nm").text().trim(),
				cdDesc : $(tr).find(".desc").html()
			}
			return obj;
		}
		
		function makeGroupObj(tr) {
			let obj = {
					oriGpCode : $(tr).data("code"),
					gpCode : $(tr).find(".code").text().trim(),
					gpNm: $(tr).find(".nm").text().trim(),
					gpDesc: $(tr).find(".desc").html()
			}
			return obj;
		}
		
		// 변경된 Object 배열로 반환 
		function changeCdOrder() {
			let objArray = [];
			$(".code-table tr").each((idx, val) => {
				objArray.push(makeCodeObj(val));
			})
			return objArray;
		}
		
	</script>
</div>