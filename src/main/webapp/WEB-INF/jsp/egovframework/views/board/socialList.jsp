<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="socialList p-3 my-3">
	<div class="topBtn d-flex flex-row align-items-center justify-content-center">
		<i class="fas fa-arrow-up"></i>
	</div>
	<div class="sns-search-container d-flex flex-row justify-content-start align-items-center p-3">
		<h4 class="me-3"><i class="fas fa-search"></i></h4>
		<form id="sns-search-form" class="d-flex flex-row justify-content-start align-items-center col-8">
			<div class="form-group col-3 me-2">
				<select class="form-select" name="searchCnd">
					<option value="">전체</option>
					<option value="USER_NAME">작성자</option>
					<option value="BOARD_CONTENT">내용</option>
					<option value="ALL">전체 검색</option>
				</select>
			</div>
			<div class="form-group col-7 me-2">
				<input class="form-control w-100" type="text" 
				name="searchKeyword" <c:if test="${empty cri.searchCnd or cri.searchCnd eq ''}">disabled</c:if>>
				<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
				<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
			</div>
			<div class="form-group col-3">
				<button type="button" class="search-btn btn rounded-pill" onclick="searchFilter()">검색</button>
			</div>
		</form>
	</div>
	<c:if test="${not empty user}">
	<div id="insert-form">
		<h4 class="insert-form-header p-2">게시글 등록</h4>
		<div class="insert-form-body p-4">
			<input type="hidden" name="userAuth" value="${user.userAuth}">
			<form id="insertForm">
				<div class="form-group">
					<textarea class="form-control" name="boardContent" id="boardEditor"></textarea>
				</div>
				<input type="hidden" name="userNo" value="${user.userNo}">
				<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
				<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
				<input type="hidden" name="boardParentNo" value="0">
				<div class="d-flex justify-content-end flex-row mt-2 btn-container">
					<button type="button" id="reset-btn" class="btn rounded-pill me-2" onclick="resertForm(this)">초기화</button>
					<button type="button" class="btn rounded-pill" onclick="insertBoard()">개시</button>
				</div>
			</form>
		</div>
	</div>
	</c:if>
	<c:if test="${empty user}">
		<form id="insertForm">
			<input type="hidden" name="userNo" value="-1">
			<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
			<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
		</form>
	</c:if>
	<div id="social-list-body">
		<jsp:include page="socialListBody.jsp"></jsp:include>
	</div>
</div>
<script>
	$(document).ready(function() {
		
		$('.topBtn').click(function(){
			$('html, body').animate({scrollTop:0});
			return false;
		});
		
		if ($("#boardEditor").length > 0) {
			generateEditor("boardEditor");
		}
		$("#sns-search-form").find("select[name='searchCnd']").on("change", function(e) {
			if ($(e.target).val() == '') {
				$("#sns-search-form").find("input[name='searchKeyword']").attr("disabled", true).val('');
			} else {
				$("#sns-search-form").find("input[name='searchKeyword']").attr("disabled", false);
			}
		});
		
	});
	
	// Search 
	
	function searchFilter() {
		let obj = makeSearchObj();
		if (obj.searchCnd != '' && obj.searchKeyword == '') {
			warningAlert("검색어를 입력해주세요.", $("#sns-search-form input[name='searchKeyword']"));
			return;
		}
		pageIndex = 1;
		$(".social-board-body").empty().append($("<div/>").attr("id", "endPage-1"));
		if (document.querySelector("#endPage-1")) {
			let target= document.querySelector("#endPage-1"); 
			io.observe(target);
		}
	}
	
	function makeSearchObj() {
		return {
			boardTypeNo : $("#sns-search-form input[name='boardTypeNo']").val(),
			bulletinNo : $("#sns-search-form input[name='bulletinNo']").val(),
			searchCnd : $("#sns-search-form select[name='searchCnd']").val(),
			searchKeyword : $("#sns-search-form input[name='searchKeyword']").val()
		}
	}
	
	// Form
	function resertForm(btn) {
		$(btn).parents("form")[0].reset();
		CKEDITOR.instances['boardEditor'].setData('');
	}
	
	function insertBoard() {
		CKEDITOR.instances['boardEditor'].updateElement();
		let form = $("#insertForm");
		if (validateForm(form)) {
			let data = $("#insertForm").serialize();
			insertBoardAjax(data);	
		}
	}
	
	function insertBoardAjax(data) {
		$.ajax({
			method : 'POST',
			url : '/board/boardInsert.do',
			data : data,
			dataType : 'json',
			success : function(msg) {
				if (msg == "success") {
					msgAlert("게시글 등록을 완료하였습니다.");
					pageIndex = 1;
					$("button#reset-btn").trigger("click");
					$("#sns-search-form")[0].reset()
					$("#sns-search-form").find("input[name='searchKeyword']").attr("disabled", true);
					pageIndex = 1;
					$(".social-board-body").empty().append($("<div/>").attr("id", "endPage-1"));
					if (document.querySelector("#endPage-1")) {
						let target= document.querySelector("#endPage-1"); 
						io.observe(target);
					}
				}
			}, error : function(err) {
				console.log(err);
			}
		});
	}
	
	// Validation 
	
	function validateForm(form) {
		let textarea = $(form).find("textarea");
		let id = $(textarea).attr("id");
		if (id != undefined && id.endsWith("Editor")) {
			let data = CKEDITOR.instances[id].getData();
			if (replaceSpace(data) == '') {
				warningAlert("내용을 입력해주세요.", textarea);
				return false;
			}
		} else {
			let data = $(textarea).val().trim();
			if (data == '') {
				warningAlert("내용을 입력해주세요.", textarea);
				return false;
			}
		}
		return true;
	}
	
	function replaceSpace(content) {
		if (content.includes("img")) {
			return content;
		}
		return content.replace(/(<([^>]+)>)|&nbsp;|&nbsp|\s/ig,"");
	}
	
	// Alert
	
  	function warningAlert(msg, focusArea) {
  		let timeInterval;
		Swal.fire({
			html: '<h3>' + msg + '</h3>',
			icon : "warning",
			timer : 1000,
			showConfirmButton : false,
			didClose : () => {
				getFocus(focusArea);
			}
		});
  	}
	
  	function msgAlert(msg) {
		let timeInterval;
		Swal.fire({
			html: '<h3>' + msg + '</h3>',
			icon : "success",
			timer : 1000,
			showConfirmButton : false
		});
  	}
  	
	function getFocus(textarea) {
		let id = $(textarea).attr("id");
 		if (id != undefined && id.endsWith("Editor")) {
 			CKEDITOR.instances[id].focus();
		} else { 
			$(textarea).focus();
		} 
	}
  	
</script>
