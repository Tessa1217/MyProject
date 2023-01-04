
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퓨전 게시판(상세보기)</title>
</head>
<body>
	<div class="boardSelect mt-2 pt-2">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
		<div class="container-fluid px-4">
			<h1 class="my-3">게시글 조회</h1>
			<div class="card mb-4">
				<div class="card-header d-flex flex-row justify-content-between align-items-center py-4">
					<h2>${board.boardTitle}</h2>
					<div class="d-flex flex-column justify-content-start align-items-end">
						<div class="d-flex flex-row justify-content-end align-items-center">
							<i class="far fa-eye"></i><span class="mx-1 count-title">${board.boardViewCnt}</span>
							<i class="fas fa-heart"></i><span class="mx-1 count-title likeCnt">${board.boardLikeCnt}</span>
							<div class="ms-2 d-flex flex-column justify-content-end">
							<span class="me-2 date-text">등록일: <fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.boardRegDate}"/></span>
							<c:if test="${not empty board.boardModDate}">
								<span class="me-2 date-text">수정일: <fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.boardModDate}"/></span>
							</c:if>
							</div>
						</div>
						<c:if test="${not empty user}">
							<div class="mt-2">
								 <span class="<c:if test="${empty boardLike}">disliked</c:if><c:if test="${not empty boardLike}">liked</c:if> likeBtn me-2"><i class="fa fa-regular fa-heart"></i></span>
							</div>
						</c:if>
					</div>
				</div>
				<div class="card-body">
					<div class="">
						<c:if test="${not empty board.boardFiles}">
							<div class="my-4">
								<ol class="list-group list-group-numbered">
									<c:forEach items="${board.boardFiles}" var="file" varStatus="status">
										<li class="list-group-item d-flex justify-content-between align-items-center">
											<div class="ms-2 me-auto">
												<i class="fas fa-file-image"></i> 
												<a class="downloadLink" href="/board/${file.fileNo}/download.do"
											download="${file.fileOriName}">${file.fileOriName}</a>
												<c:if test="${file.fileIsThumbnail eq 'Y'}">
													<span class="thumbnailSign">썸네일!</span>
												</c:if>
											</div>
											<span class="badge bg-primary rounded-pill" id="download-${status.index}">${file.fileDownCnt}</span>
										</li>
									</c:forEach>
								</ol>
							</div>
							<div class="d-flex justify-content-center align-items-center p-3 m-2">
								<c:if test="${not empty board.boardFiles}">
									<div id="owl-banner" class="owl-carousel owl-theme">
									<c:forEach items="${board.boardFiles}" var="file" varStatus="status">
											<div class="item"><img src="${file.filePath}">
												<a class="btn downloadBtn" href="/board/${file.fileNo}/download.do"
												download="${file.fileOriName}" data-file-order="${status.index}"><i class="fas fa-download"></i>다운로드</a>
												<div class="lettering-box d-flex flex-row justify-content-center align-items-end d-none"><span>${file.fileOriName}</span></div>
											</div>
									</c:forEach>
									</div>
								</c:if>
							</div>
						</c:if>
					</div>
					<div class="my-4">
						<div>${board.boardContent}</div>
					</div>
					<div class="card-footer d-flex flex-row justify-content-between align-items-center">
						<div>
							<c:if test="${not empty board.boardTags}">
								<ul class="list-group-horizontal list-group bg-light border-light">
									<c:forEach items="${board.boardTags}" var="tag">
										<li class="list-group-item bg-light border-light"><a href="/board/boardList.do?boardTypeNo=${board.boardTypeNo}&bulletinNo=${board.bulletinNo}&searchCnd=BOARD_TAG&searchKeyword=${tag.tagContent}"><span class="badge bg-primary p-2">#${tag.tagContent}</span></a></li>
									</c:forEach>
								</ul>
							</c:if>
						</div>
						<div>
							<a href="javascript:void(0);" class="btn btn-outline rounded-pill btn-outline-secondary"
								onclick="goBackToMain(${board.boardTypeNo})">목록</a>
							<c:if test="${not empty user}">
								<c:if test="${board.boardTypeNo eq 'DEFAULT'}">
									<a class="btn btn-outline rounded-pill btn-outline-success" href="/board/boardInsert.do?boardTypeNo=${board.boardTypeNo}&boardNo=${board.boardNo}">답글달기</a>
								</c:if>
								<c:if test="${board.userNo eq user.userNo}">
									<a class="btn btn-outline rounded-pill btn-outline-primary" href="/board/boardUpdate.do?boardTypeNo=${board.boardTypeNo}&boardNo=${board.boardNo}">수정하기</a>
								</c:if>
								<c:if test="${board.userNo eq userNo or user.userAuth eq 'ADMIN'}">
									<button class="btn btn-outline rounded-pill btn-outline-danger" type="button" onclick="deleteBoard(${board.boardNo})">삭제하기</button>
								</c:if>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		<div class="container-fluid">
			<c:if test="${not empty user}">
				<div class="card my-4 p-4">
				 	<h5><i class="far fa-comments"></i> 댓글 등록하기</h5>
					<form method="POST" action="/comment/insComment.do" onsubmit="return insComment('this')">
						<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
						<textarea class="form-control h-25 w-100" id="commentContent" name="commentContent" rows="5" required></textarea>
						<span><span class="content-limit">0</span>/1000</span>
						<button class="btn btn-sm btn-primary float-end mt-2" type="submit"><i class="fa fa-solid fa-plus"></i> 등록</button>
					</form>
				</div>
			</c:if>
			<c:if test="${commentList.size() != 0}">
				<div class="commentList card my-4 bg-light">
					<div class="card-body">
						<div>
							<c:forEach items="${commentList}" var="comment">
									<div class="py-2" style="padding-left:${(comment.commentLevel - 1) * 20}px;">
									<c:if test="${comment.commentDelyn == 'N'}">
											<div class="d-flex flex-row justify-content-between">
												<div>
													<c:if test="${comment.commentLevel > 1}">
														<span class="material-symbols-outlined">subdirectory_arrow_right</span>
													</c:if>
													<span class="writer">작성자: ${comment.userName}</span>
												</div>
												<div>
													<c:if test="${not empty user}">
														<button class="btn btn-sm btn-link" type="button" onclick="openInsertForm(${comment.commentNo})">댓글</button>
														<c:if test="${comment.userNo eq user.userNo}">
															<button class="btn btn-sm btn-link" type="button" onclick="modifyCommentForm(${comment.commentNo})">수정</button>
														</c:if>
														<c:if test="${comment.userNo eq user.userNo || user.userAuth eq 'ADMIN'}">
															<button class="btn btn-sm btn-link" type="button" onclick="deleteComment(${comment.commentNo})">삭제</button>
														</c:if>
													</c:if>
												</div>
											</div>
											<form id="modForm-${comment.commentNo}" action="/comment/updComment.do?boardTypeNo=${board.boardTypeNo}" method="POST">
												<input type="hidden" value="${comment.commentNo}" name="commentNo">
												<input type="hidden" value="${comment.boardNo}" name="boardNo">
												<p class="comment-content">${comment.commentContent}</p>
												<div class="modForm-btn d-flex flex-row mt-2 justify-content-between d-none">
													<span><span class="content-limit"></span>/1000</span>
													<div>
														<button type="submit" class="mx-2 btn btn-sm btn-primary">수정하기</button>
														<button type="button" class="btn btn-sm btn-secondary" onclick="cancelModify(${comment.commentNo})">취소</button>
													</div>
												</div>
											</form>
											<div id="insertForm-${comment.commentNo}">
												<form id="commentForm" method="POST" action="/comment/insComment.do?boardTypeNo=${board.boardTypeNo}" onsubmit="return commentFormCheck()">
													<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
													<input type="hidden" id="commentParentNo" name="commentParentNo" value="${comment.commentNo}">
													<textarea class="form-control h-25" id="commentContent" name="commentContent" rows="5"></textarea>
													<span><span class="content-limit">0</span>/1000</span>
													<div class="mt-2 d-flex flex-row justify-content-end">
														<button class="btn btn-sm btn-primary mx-2" type="submit"><i class="fa fa-solid fa-plus"></i> 등록</button>
														<button class="btn btn-sm btn-secondary" type="button" onclick="closeInsertForm(${comment.commentNo})">취소</button>
													</div>
												</form>
											</div>
										</c:if>
										<c:if test="${comment.commentDelyn == 'Y'}">
											<div>
												<c:if test="${comment.commentLevel > 1}">
														<span class="material-symbols-outlined">subdirectory_arrow_right</span>
												</c:if>
												<p>삭제된 댓글입니다.</p>
											</div>
										</c:if>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</c:if>	
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	$(document).ready(function() {
		$(".owl-carousel").owlCarousel({
			items: 1,
			loop: true,
			margin: 10,
			nav: true
		})
		
		$(".owl-carousel").on('mousewheel', '.owl-stage', function (e) {
		    if (e.deltaY>0) {
		        $(".owl-carousel").trigger('prev.owl');
		    } else {
		        $(".owl-carousel").trigger('next.owl');
		    }
		    e.preventDefault();
		});
		
		$(".owl-item").on("mouseover", ()=> {
			$(this).find(".lettering-box").removeClass("d-none");
		}).on("mouseout", () => {
			$(this).find(".lettering-box").addClass("d-none");
		});
		
		$(".likeBtn").on("click", function() {
			$(this).toggleClass("liked disliked");
			let command = $(this).hasClass("liked") ? 1 : 2;
			let boardNo = $("input[name='boardNo']").val();
			$.ajax({
				method : 'POST',
				url : '/board/likeBoard.do',
				data : {command : command, likesBoardNo : boardNo} 
			}).done(function(result) {
				if (result == "liked") {
					$("span.likeCnt").text(parseInt($("span.likeCnt").text()) + 1);
				} else if (result == "disliked") {
					$("span.likeCnt").text(parseInt($("span.likeCnt").text()) - 1);
				}
			})
		});	
		
		$("[id*='insertForm-']").hide();
		
		$(window).on("unload", function() {
			opener.parent.location.reload();
		})
		
		$("textarea[name='commentContent']").on("input", function() {
			if ($(this).val().length > 1000) {
				alert("댓글은 최대 1,000자까지만 입력 가능합니다.");
				$(this).val($(this).val().substring(0, 1000));
			}
			const contentLimitCheck = $(this).siblings("span").find(".content-limit");
			contentLimitCheck.text($(this).val().length);
		})
		
		$(".downloadLink").on("click", function() {
			let currentCnt = $(this).parents("div").siblings("span.badge");
			$(currentCnt).text(parseInt(currentCnt.text()) + 1);
		})
		
		$(".downloadBtn").on("click", function() {
			let countSpan = $("span#download-" + $(this).data("file-order"));
			$(countSpan).text(parseInt($(countSpan).text()) + 1);
		})
	})
	
	function insComment(form) {
		console.log(form);
		return false;
	}
	
	function modifyCommentForm(commentNo) {
		const commentLength = $("#modForm-" + commentNo + " .comment-content").text().length;
		$("#modForm-" + commentNo + " .comment-content").contents().unwrap()
			.wrap(`<textarea class="form-control" rows="3" name="commentContent" required></textarea>`);
		$("#modForm-" + commentNo + " textarea[name='commentContent']").on("input", function() {
			if ($(this).val().length > 1000) {
				alert("댓글은 최대 1,000자까지만 입력 가능합니다.");
				$(this).val($(this).val().substring(0, 1000));
			}
			const contentLimitCheck = $(this).siblings(".modForm-btn").find(".content-limit");
			contentLimitCheck.text($(this).val().length);
		});
		$("#modForm-" + commentNo + " .content-limit").text(commentLength);
		$("#modForm-" + commentNo + " .modForm-btn").toggleClass("d-none d-block");
	}
	
	function cancelModify(commentNo) {
		$("#modForm-" + commentNo + " textarea[name='commentContent']").contents()
			.unwrap().wrap(`<p class='comment-content'></p>`);
		$("#modForm-" + commentNo + " .modForm-btn").toggleClass("d-none d-block");
	}

	function deleteComment(commentNo) {
		$.ajax({
			method : 'POST',
			url : '/comment/delComment.do',
			data : {'commentNo' : commentNo}
		}).done(function(result) {
			if (result == 'success') {
				alert("댓글 삭제가 완료되었습니다.");
				location.reload();
			}
		})
	}
	
	function deleteBoard(boardNo) {
		$.ajax({
			method: 'POST',
			url: "/board/boardDelete.do",
			data: {'boardNo': boardNo}
		}).done(function(result) {
			if (result == 'success') {
				alert("삭제가 완료되었습니다.");
				goBackToMain();
			}
		})
	}
	
	function openInsertForm(formId) {
		$("#insertForm-" + formId).show();
	}
	
	function closeInsertForm(formId) {
		const targetForm = ("#insertForm-" + formId);
		$(targetForm).find("textarea[name='commentContent']").val('');
		$(targetForm).find(".content-limit").text('0');
		$(targetForm).hide();
	}
	
	function goBackToMain(command) {
		let requestURL = '/board/boardList.do?boardTypeNo=' + $("input[name='boardTypeNo']").val();
		location.href = requestURL;
	}
	
</script>
</html>