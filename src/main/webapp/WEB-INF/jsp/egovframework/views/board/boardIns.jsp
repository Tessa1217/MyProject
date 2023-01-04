<%
/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="egovframework.fusion.user.vo.UserVO" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.file-list {
		min-height: 100px;
	}
</style>
<script src="/js/main-script.js"></script>
<title>퓨전 게시판(작성)</title>
</head>
<body>
	<div class="boardInsert mt-2 pt-2">
		<div class="container-fluid px-4">
			<h1 class="my-3">게시글 작성</h1>
			<div class="card mb-4">
				<div class="card-body">
					<form id="insForm" method="POST" action="/board/boardInsert.do" onsubmit="return false">
						<input type="hidden" name="boardParentNo" value="${board.boardNo}">
						<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
						<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
						<div class="mb-3">
							<label for="boardTitle" class="form-label">제목</label>
							<input class="form-control" id="boardTitle" name="boardTitle" required maxlength="100" placeholder="제목은 100자 이내로 입력해주세요.">
						</div>
						<div class="mb-3">
							<label for="boardContent" class="form-label">내용</label>
							<textarea class="form-control" id="boardContent" name="boardContent" rows="10"></textarea>
						</div>
						<c:if test="${board.boardTypeNo eq 'NOTICE' and fn:contains(user.userAuth, 'ADMIN')}">
							<div class="mb-3">
								<label for="boardPopupyn" class="form-label">팝업 처리</label>
								<select class="form-select" id="boardPopupyn" name="boardPopupyn">
									<option value="N" selected>띄우지 않음</option>
									<option value="Y">띄움</option>
								</select>
							</div>
						</c:if>
						<c:if test="${board.boardTypeNo eq 'GALLERY'}">
							<div class="mb-3">
								<label for="files">첨부파일</label>
								<input class="form-control" type="file" multiple id="files" name="files" accept="image/gif, image/jpeg, image/png, image/jpg" onchange="loadFile(this);">
								<input type="hidden" name="thumbnailIdx" value="-1">
							</div>
							<div class="mb-4 p-2 border border-white rounded bg-light">
								<ul class="file-list list-group list-group-flush">
								</ul>
							</div>
							<div class="mb-4 preview d-flex flex-row">
							</div>
							<div class="mb-3">
							      <input type="text" class="form-control" placeholder="관련 태그를 입력해주세요." name="tags" maxlength="20" />
							</div>
							<div class="mb-4 border border-light bg-light">
							      <ul class="tagList list-group list-group-horizontal"></ul>
							</div>
						</c:if>
						<div class="float-end">
							<a href="javascript:history.back();" class="btn btn-outline rounded-pill btn-outline-secondary btn-sm">뒤로가기</a>
							<button class="btn btn-outline-danger rounded-pill btn-sm" type="button" onclick="submitForm()">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	let fArray = new Array();
	let fileNo = 0;
	
	let tagString = [];
	let tagCnt = 0;
	
	$(document).ready(function() {
		makeTag();
		$(window).on("unload", function() {
			opener.parent.location.reload();
		})
	})
	
	function submitForm() {
	
		if ($("input[name='thumbnailIdx']").val() == "-1") {
			$("input[name='thumbnailIdx']").val("newOrder=0");
		}
		
		if (contentValidation()) {
			let boardTypeNo = $("input[name='boardTypeNo']").val();

			let form = $("#insForm")[0];
			let formData = new FormData(form);
			
			if (fArray.length != 0) {
				for (let file of fArray) {
					if (!file.is_deleted) {
						formData.append("fileList", file);
					}
				}
			}
			
			if (tagString.length != 0) {
				formData.append("tagString", tagString.join(','));
			}
			
			insertForm(boardTypeNo, formData);
		}
	}
	
	function insertForm(boardTypeNo, formData) {
		$.ajax({
			method : "POST",
			url : "/board/boardInsert.do",
			enctype : 'multipart/form-data',
			processData : false,
			contentType : false,
			cache : false,
			data : formData,
			success : function(msg) {
				alert("게시글이 등록되었습니다.");
				window.close();
			},
			error : function(e) {
				console.log(e);
				alert("게시글 등록이 완료되지 못했습니다.");
			}
		})
	}
	
</script>
</html>