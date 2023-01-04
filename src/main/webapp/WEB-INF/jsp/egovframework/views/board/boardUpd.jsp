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
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퓨전 게시판(수정)</title>
<script src="/js/main-script.js"></script>
</head>
<body>
	<div class="boardUpdate mt-2 pt-2">
		<div class="container-fluid px-4">
			<h1 class="my-3">게시글 수정</h1>
			<div class="card mb-4">
				<div class="card-body">
					<form id="updForm" onsubmit="return false">
						<input type="hidden" name="boardNo" value="${board.boardNo}">
						<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
						<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
						<div class="mb-3">
							<label for="boardTitle" class="form-label">제목</label>
							<input class="form-control" id="boardTitle" name="boardTitle" required maxlength="100" value="${board.boardTitle}">
						</div>
						<div class="mb-3">
							<label for="boardContent" class="form-label">내용</label>
							<textarea class="form-control" id="boardContent" name="boardContent" rows="10">${board.boardContent}</textarea>
						</div>
						<c:if test="${board.boardTypeNo eq 'NOTICE' and fn:contains(user.userAuth, 'ADMIN')}">
							<div class="mb-3">
								<label for="boardPopupyn" class="form-label">팝업 처리</label>
								<select class="form-select" id="boardPopupyn" name="boardPopupyn" value="${board.boardPopupyn}">
									<option value="N" selected>띄우지 않음</option>
									<option value="Y">띄움</option>
								</select>
							</div>
						</c:if>
						<c:if test="${board.boardTypeNo eq 'GALLERY'}">
							<div class="mb-3">
								<input class="form-control" type="file" multiple id="files" name="files" accept="image/gif, image/jpeg, image/png, image/jpg" onchange="loadFile(this)">
								<input type="hidden" name="fileCnt" value="${not empty board.boardFiles ? fn:length(board.boardFiles) : 0}">
								<input type="hidden" name="thumbnailIdx" value="-1">
							</div>
								<div class="mb-3">
									<h6 class="px-2"><i class="fas fa-file-image"></i> 현재 첨부파일</h6>
									<ul class="file-list list-group bg-secondary">
									<c:if test="${not empty board.boardFiles}">
										<c:forEach items="${board.boardFiles}" var="file" varStatus="status">
											<li class="list-group-item bg-light" name="original-file" data-order="${status.index}">
												<input class="form-check-input me-1 original" type="radio" name="thumbnail" value="${file.fileNo}" ${file.fileIsThumbnail eq 'Y' ? "checked" : ""}>
												<a href="/board/${file.fileNo}/download.do" download="${file.fileOriName}">${file.fileOriName}</a>
												<button type="button" class="mx-2 btn btn-sm btn-close btn-danger float-end" name="fileDelBtn" 
												aria-label="Close" data-fileNo="${file.fileNo}" data-file-ori-order="${status.index}"></button>
											</li>
										</c:forEach>
									</c:if>
									</ul>
								</div>
								<div class="mb-4 preview d-flex flex-row">
									<c:if test="${not empty board.boardFiles}">
										<c:forEach items="${board.boardFiles}" var="file" varStatus="status">
											<div class="px-1" id="original-file-preview-${status.index}">
												<span class="d-block">${file.fileOriName}</span>
												<img src="${file.filePath}" width="300px" height="200px">
											</div>
										</c:forEach>
									</c:if>
								</div>
							<div class="mb-3">
								<input class="form-control" type="text" name="tags" placeholder="태그를 입력해주세요.">
								<input type="hidden" name="tagCnt" value="${not empty board.boardTags ? fn:length(board.boardTags) : 0}">
							</div>
							<div class="mb-3">
								<ul class="list-group-horizontal list-group bg-light tagList">
									<c:if test="${not empty board.boardTags}">
										<c:forEach items="${board.boardTags}" var="tag">
											<li class="list-group-item border-light bg-light d-flex align-items-center" name="original-tag">
												<button type="button" name="tagDeleteBtn" class="btn-sm btn-close px-2" aria-label="Close"></button>
												<span class="badge rounded-pill bg-primary text-white p-2">${tag.tagContent}</span>
											</li>
										</c:forEach>
									</c:if>
								</ul>
							</div>
						</c:if>
						<div class="float-end">
							<a href="javascript:history.back();" class="btn btn-outline rounded-pill btn-outline-secondary btn-sm">뒤로가기</a>
							<button class="btn btn-outline-danger rounded-pill btn-sm" type="button" onclick="submitModifyForm()">수정하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	
	let fileNo = $("input[name='fileCnt']").val();
	let fArray = new Array();

	let tagString = $.map($("li[name='original-tag'] > span"), function(val) {
		return $(val).text().trim();
	});
	let tagCnt = tagString.length;
	 
	let oriFileArray = new Array();
	 
	$(document).ready(function() {
		makeTag();
		$("input[name='thumbnail'].original").change(function() {
			$("input[name='thumbnailIdx']").val("fileNo=" + $(this).val());
		});
		$(window).on("unload", function() {
			opener.parent.location.reload();
		});
	});
	
	$("button[name='fileDelBtn']").on("click", function(e) {
		oriFileArray.push($(this).data("fileno"));
		$("#original-file-preview-" + $(this).data("file-ori-order")).remove();
		if ($(this).siblings("input[name='thumbnail']").is(":checked")) {
			$("input[name='thumbnailIdx']").val('-1');
		}
		$(this).parents("li[name='original-file']").remove();
	});
	
	$("button[name='tagDeleteBtn']").on("click", function(e) {
		tagString.splice(tagString.indexOf($(this).siblings("span").text().trim()), 1);
		tagCnt--;
		$(this).parents("li[name='original-tag']").remove();
	})
	
	function submitModifyForm() {
		if ($("input[name='thumbnailIdx']").val() == "-1" && !$("input[name='thumbnail']:checked").val()) {
			$(".file-list li:first-child input[name='thumbnail']").trigger("click");
		}
		
		if (contentValidation()) {
			let boardTypeNo = $("input[name='boardTypeNo']").val();
			let form = $("#updForm")[0];
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
			
			formData.append("originalFiles", oriFileArray.join(","));

		 	$.ajax({
				method : "POST",
				url : "/board/boardUpdate.do",
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				cache : false,
				data : formData, 
				success : function(msg) {
					alert("게시글이 수정되었습니다.");
					window.close();
				},
				error : function(e) {
					console.log(e);
					alert("게시글 수정이 완료되지 못했습니다.");
				}
			});
		}
	}
	
</script>
</html>