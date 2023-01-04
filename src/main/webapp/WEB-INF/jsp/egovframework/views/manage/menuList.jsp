<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<div class="menuList mt-2 pt-2">
	<div class="container-fluid px-4">
		<div class="card my-2">
			<div class="card-header d-flex justify-content-between align-items-center p-4">
				<h3 class="fw-bold">메뉴 관리</h3>
				<div>
				<button type="button" class="btn rounded-pill btn-primary btn-sm" onclick="openMenuModal()"><i class="fas fa-plus"></i> 메뉴 추가</button>
				<button type="button" class="btn update-start rounded-pill btn-success btn-sm" onclick="changeOrder()"><i class="fas fa-sort"></i> 순서 변경하기</button>
				<button type="button" class="btn d-none update-done rounded-pill btn-danger btn-sm" onclick="updateOrder()"><i class="fas fa-sort"></i> 순서 변경 완료</button>
				</div>
			</div>
			<div class="card-body">
				<table id="menuTable" class="table table-hover">
					<thead class="thead-primary text-center">
						<tr>
							<th width="5%">메뉴 순서</th>
							<th width="10%">메뉴명</th>
							<th width="15%">메뉴 유형</th>
							<th width="25%">URL</th>
							<th width="20%">허용된 사용자</th>
							<th width="5%">삭제 여부</th>
							<th width="10%">새창</th>
							<th width="5%">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="menu" varStatus="status">
							<tr id="menu_${status.index}" data-menu-no="${menu.menuNo}" class="<c:if test="${menu.menuDelyn eq 'Y'}">bg-delete</c:if>">
								<td><input type="number" class="form-control no-change" disabled name="menuOrder" value="${menu.menuOrder}"></td>
								<td class="menuNm"><input type="text" class="form-control" disabled name="menuNm" value="${menu.menuNm}"></td>
								<td>
									<select class="form-select no-change" name="menuType" disabled>
										<c:forEach items="${menuTypeList}" var="type">
											<option value="${type.cdCode}" <c:if test="${menu.menuType eq type.cdCode}">selected="selected"</c:if>>${type.cdNm}</option>
										</c:forEach>
									</select>
								</td>
								<td class="menuPath text-start"><input type="text" class="form-control" disabled name="menuPath" value="${menu.fullPath}"></td>
								<td>
									<select class="form-select" name="userAuthCode" disabled>
										<option value="1" <c:if test="${fn:length(menu.userAuthList) eq 4}">selected="selected"</c:if>>모든 사용자</option>
										<option value="2" <c:if test="${fn:length(menu.userAuthList) eq 3}">selected="selected"</c:if>>회원</option>
										<option value="3" <c:if test="${fn:length(menu.userAuthList) eq 2}">selected="selected"</c:if>>관리자</option>
										<option value="4" <c:if test="${fn:length(menu.userAuthList) eq 1}">selected="selected"</c:if>>최고 관리자</option>
									</select>
								</td>
								<td>
									<select class="form-select" name="menuDelyn" disabled>
										<option value="N" <c:if test="${menu.menuDelyn eq 'N'}">selected="selected"</c:if>>사용 중</option>
										<option value="Y" <c:if test="${menu.menuDelyn eq 'Y'}">selected="selected"</c:if>>삭제</option>
									</select>
								</td>
								<td>
									<select class="form-select" disabled name="menuTarget">
										<option value="_blank" <c:if test="${menu.menuTarget eq '_blank'}">selected="selected"</c:if>>새창</option>
										<option value="_self" <c:if test="${menu.menuTarget eq '_self'}">selected="selected"</c:if>>현재 창</option>
									</select>
								</td>
								<td>
									<button type="button" class="btn rounded-pill btn-primary btn-sm" onclick="modifyMenu('${status.index}')">변경</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div id="insMenuModal" class="modal modal-lg p-4" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header p-2 bg-warning">
	        <h5 class="modal-title"><i class="fas fa-plus"></i> 메뉴 추가하기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeMenuModal()"></button>
	      </div>
	      <div class="modal-body p-4">
	        <form id="insMenuForm">
	        	<div class="my-2">
	        		<label for="menuType" class="form-control-label">메뉴 유형</label>
	        		<select class="form-select" name="menuType" id="menuType">
	        			<c:forEach items="${menuTypeList}" var="type">
	        				<option value="${type.cdCode}">${type.cdNm}</option>
	        			</c:forEach>
	        		</select>
	        	</div>
	        	<div class="my-2">
	        		<label for="menuNm" class="form-control-label">메뉴 이름</label>
	        		<input class="form-control" type="text" name="menuNm" id="menuNm" required>
	        	</div>
	        	<div class="url-wrap my-2 d-none">
	        		<label for="menuPath" class="form-control-label">URL</label>
	        		<input class="form-control" type="text" name="menuPath" id="menuPath" required>
	        	</div>
	        	<div class="my-2">
	        		<label for="userAuthList" class="form-control-label">허용된 사용자</label>
	        		<div class="d-flex justify-content-center align-items-center">
		        		<select class="form-select authIdx">
		        			<c:forEach items="${authList}" var="auth" varStatus="status">
		        				<option value="${auth.cdCode}">${auth.cdNm}</option>
		        			</c:forEach>
		        		</select>
	        		</div>
	        	</div>
	        	<input type="hidden" name="userAuthCode">
	        	<div class="my-2">
	        		<label for="menuTarget" class="form-control-label">창 옵션</label>
	        		<select class="form-select" name="menuTarget">
	        			<option value="_self">기존 창</option>
	        			<option value="_blank">새 창</option>
	        		</select>
	        	</div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeMenuModal()">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="addMenu()">추가</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<script>

	let boardMenu = "/board/boardList.do?";
	
	$(document).ready(function() {
		
		$("#menuTable tbody").sortable({
			disabled : true
		})
		
		$("#insMenuForm select[name='menuType']").on("change", function() {
			if ($(this).find("option:selected").val() == 'LINK') {
				$(this).parents("#insMenuForm").find(".url-wrap").removeClass("d-none");
			} else {
				$(this).parents("#insMenuForm").find(".url-wrap").addClass("d-none");
			}
		})
	})

	function closeMenuModal() {
		$("#insMenuModal").hide();
	}
	
	function openMenuModal() {
		$("#insMenuModal").show();
	}
	
	function changeOrder() {
		$("button.update-start").addClass("d-none");
		$("button.update-done").removeClass("d-none");
		$("#menuTable tbody").sortable({
			disabled : false,
			update : function(e, ui) {
				$(this).find("input[name='menuOrder']").each((idx, val) => {
					$(val).val(idx + 1);
				});
			}
		})
	}
	
	function updateOrder() {
		let rows = $("#menuTable tbody tr");
		let orderArray = [];
		$(rows).each((idx, val) => {
			orderArray.push(menuObj(idx));
		})
		updAjax(orderArray);
	}
	
	function addMenu() {
 		let form = $("#insMenuForm");
		let menuType = $(form).find("[name='menuType']").val();
		let menuPath = $(form).find("[name='menuPath']");
		let authArray = ['USER', 'MEMBER', 'ADMIN', 'SUPERADMIN'];
		let auth = $(form).find(".authIdx").val();
		$(form).find("[name='userAuthCode']").val(authArray.splice(auth-1).join(","));
		if (menuType != 'LINK') {
			$(menuPath).val(boardType(menuType));
		}
		if (checkMenu(form)) {
			insMenu(form.serialize());	
		} 
	}
	
	function boardType(menuType) {
		if (menuType != "link") {
			boardMenu += "boardTypeNo=" + menuType.toUpperCase();	
		}
		return boardMenu;
	}
	
	function checkMenu(elem) {
		let name = $(elem).find("input[name='menuNm']").val();
		if (name.trim() == '') {
			fireAlert("메뉴 이름을 입력해주세요!", 2);
			return false;
		}
		let allName = $("input[name='menuNm']").not($(elem).find("input[name='menuNm']"));
		let flag = true;
		$(allName).each((idx, val) => {
			if ($(val).val() == name) {
				flag = false;
				return;
			}
		})
		if (!flag) {
			fireAlert("중복된 메뉴 이름이 있습니다!", 2);	
			return false;
		}
		let url = $(elem).find("input[name='menuPath']").val();
		if (url.trim() == '') {
			fireAlert("메뉴 주소를 입력해주세요!", 2);
			return false;
		}
		return true;
		
	}
	
	function insMenu(obj) {
		$.ajax({
			method : 'POST',
			url : '/manage/insMenu.do',
			data : obj,
			success : function(msg) {
				if (msg == 'success') {
					fireAlert("메뉴 추가가 완료되었습니다!", 7);
				} 
			}
		})
	}
	
	function modifyMenu(idx) {
		let tr = $("#menu_" + idx);
		$(tr).find("input").not(".no-change").attr("disabled", false);
		$(tr).find("select").not(".no-change").attr("disabled", false);
		$(tr).find("button:first-child")
			.text("변경 완료")
			.addClass("update-btn")
			.removeAttr("onclick")
			.attr("onclick", "updMenu(" + idx + ")");
	}
	
	function updMenu(idx) {
		let tr = $("#menu_" + idx);
		if (checkMenu(tr)) {
			updAjax([menuObj(idx)]);	
		}
	}
	
	function updAjax(obj) {
		$.ajax({
			method : 'POST',
			url : '/manage/updMenu.do',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(msg) {
				fireAlert("변경이 완료되었습니다!", 7);
			}
		})
	}
	
 	function menuObj(idx) {
 		let tr = $("#menu_" + idx);
 		let authArray = ['USER', 'MEMBER', 'ADMIN', 'SUPERADMIN'];
 		let i = $(tr).find("[name='menuPath']").val().indexOf("&");
		let obj = {
			menuNo : $(tr).data("menu-no"),
			menuNm : $(tr).find("[name='menuNm']").val(),
			menuOrder : $(tr).find("[name='menuOrder']").val(),
			menuPath : (i > 0) ? $(tr).find("[name='menuPath']").val().substring(0, i) : $(tr).find("[name='menuPath']").val(),
			menuParameter : (i > 0) ? $(tr).find("[name='menuPath']").val().substring(i + 1) : null,
			menuDelyn : $(tr).find("[name='menuDelyn']").val(),
			menuTarget : $(tr).find("[name='menuTarget']").val(),
			userAuthCode : authArray.splice($(tr).find("[name='userAuthCode']").val() - 1).join(",")
		}
		return obj;
	}
	
</script>