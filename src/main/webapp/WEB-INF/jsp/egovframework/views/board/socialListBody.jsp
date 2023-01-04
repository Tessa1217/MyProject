<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="social-board-body">
	<div id="endPage-1"></div>
</div>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.microsoft.com/ajax/jquery.templates/beta1/jquery.tmpl.min.js"></script>
<script src="/js/template.js"></script>
<script>

	let pageIndex = 1;
	
	// Paging
	const option = {
			root: null,
			rootMargin: "20px 20px 20px 20px",
			threshold: 1
		}
		
	const io = new IntersectionObserver((entries, observer) => {
		entries.forEach((entry) => {
			if (entry.isIntersecting) {
				io.unobserve(entry.target); 
				getBoard();
			}
		})
	}, option);

	if (document.querySelector("#endPage-1")) {
		let target= document.querySelector("#endPage-1"); 
		io.observe(target);
	}
	
  	// BOARD
  	
  	function getBoard() {
  		let data = makeSearchObj();
  		data.pageIndex = pageIndex;
  		$.ajax({
  			method : 'POST',
  			url : '/board/boardList.do',
  			data : data,
  			dataType : 'json',
  			success : function(boardList) {
  				$("#endPage-" + (pageIndex)).attr("class", "text-center").append($("<i/>").attr("class", "fas fa-spinner fa-3x m-2"));
  			setTimeout(() => {
  				$("#endPage-" + (pageIndex)).empty();
  				let watchNeed = makeList(boardList);
  	    		if (watchNeed) {
  	    			io.observe(document.querySelector("#endPage-" + pageIndex));  
  	    		}
  			}, 1000)
  			}
  		});
  	}
  	
  	function makeList(list) {
  		$(list).each((idx, val) => {
  			val.idx = idx + 1;
  			val.boardContent = parseContent(val.boardContent);
			val = userCheck(val);
  		});
  		$("#boardTemplate").tmpl(list).appendTo(".social-board-body");
  		if (list.length == 5) {
  			$("<div/>").attr("id", "endPage-" + ++pageIndex).appendTo(".social-board-body");
  			return true;
  		}
  		return false;
  	 }
  	
  	function getBoardPost(btn) {
  		if (CKEDITOR.instances['boardModEditor'] != undefined) {
  			if ($("#cke_boardModEditor").length > 0) {
  				let card = $("#cke_boardModEditor").parents(".card");
  				let currentCard = $(btn).parents(".card");
  				if (card.data("board-no") != currentCard.data("board-no")) {
  					let data = {boardNo : $(card).data("board-no")};
  	  				getBoardPostAjax(data, card);
	  	  			if (CKEDITOR.instances['boardModEditor'] != undefined) {
	  					CKEDITOR.instances['boardModEditor'].destroy();
	  				}
  				}
  			}
  		}
  		let card = $(btn).parents(".card");
  		let boardNo = $(card).data("board-no");
  		let data = {boardNo : boardNo};
  		getBoardPostAjax(data, card);
  	}
  	
  	function getBoardPostAjax(data, card) {
  		$.ajax({
  			method : 'POST',
  			url : '/board/boardSelect.do',
  			data : data,
  			dataType : 'json',
  			success : function(board) {
  				if (board.boardNo == 0) {
  					msgAlert("존재하지 않는 게시물입니다.");	
					$(card).remove();
  				} else {
  					board = userCheck(board);
  	  				boardMode(board, card);
  				}
  			}
  		});
  	}
  	
  	function boardMode(board, card) {
  		$(card).empty();
  		board.boardContent = parseContent(board.boardContent);
		if ($(card).attr("data-mode") == "SELECT") {
			$("#boardModTemplate").tmpl(board).appendTo(card);
			generateEditor("boardModEditor");
			$(card).attr("data-mode", "UPDATE");
		} else if ($(card).attr("data-mode") == "UPDATE") {
			$("#boardTemplate").tmpl(board).appendTo(card);
			$(card).attr("data-mode", "SELECT");
		}
  	}
  	
  	function updateBoard(btn) {
  		CKEDITOR.instances['boardModEditor'].updateElement();
  		let form = $(btn).parents("form");
  		if (validateForm(form)) {
  	  		let data = $(form).serialize();
  	  		$.ajax({
  	  			method : 'POST',
  	  			url : '/board/boardUpdate.do',
  	  			data : data,
  	  			success : function(msg) {
  	  				if (msg == "success") {
  	  					msgAlert("게시글 수정을 완료하였습니다.");
  	  					getBoardPost(btn);
  	  				}
  	  			}
  	  		});		
  		}
  	}	
  	
  	function deleteBoard(btn) {
  		let card = $(btn).parents(".card");
  		let boardNo = $(btn).parents(".card").data("board-no");
  		$.ajax({
  			method : 'POST',
  			url : '/board/boardDelete.do',
  			data : {boardNo : boardNo},
  			success : function(msg) {
  				if (msg == "success") {
  					msgAlert("게시글 삭제를 완료하였습니다.");
  					$(card).remove();
  				}
  			}
  		});
  	}
  	
  	// Comment
  	
  	function getCommentList(btn) {
  		let card = $(btn).parents(".card");
  		let boardNo = $(card).data("board-no");
  		getCommentListAjax(boardNo, card);
  	}
  	
  	function getCommentListAjax(boardNo, card) {
  		$.ajax({
  			method : 'POST',
  			url : '/comment/commentList.do',
  			data : {boardNo : boardNo},
  			dataType : 'json',
  			success : function(commentList) {
  				$(card).find(".card-footer .upd-btn.get-comment").addClass("d-none");
  				$(card).find(".card-footer .upd-btn.hide-comment").removeClass("d-none");
  				$(card).find(".comment-container").remove();
  				$("#boardCommentTemplate").tmpl().appendTo($(card).find(".card-footer"));
  				let board = {};
  				board = userCheck(board);
  				if (board.loginUser == 1) {
  					board.boardNo = boardNo;
  					board.userNo = $("#insertForm input[name='userNo']").val();
  					$("#commentInsertTemplate").tmpl(board).appendTo($(card).find(".comment-container"));
  				}
  				$(commentList).each((idx, val) => {
  					console.log(val);
  					val = userCheck(val);
  				});
  				board.commentList = commentList;
  				$("#commentListTemplate").tmpl(board).appendTo($(card).find(".comment-container"));
  			}
  		})
  	}
  	
  	function hideCommentList(btn) {
  		$(btn).parents(".card-footer").find(".comment-container").remove();
  		$(btn).parents(".card-footer").find(".upd-btn").toggleClass("d-none");
  	}
  	
  	function insertComment(btn) {
  		let card = $(btn).parents(".card");
  		let form = $(btn).parents(".commentForm");
  		let data = $(form).serialize();
  		if (validateForm(form)) {
  			insertCommentAjax(data, card);	
  		}
  	}
  	
  	function insertCommentAjax(data, card) {
  		$.ajax({
  			method : 'POST',
  			url : '/comment/insComment.do',
  			dataType : 'json',
  			data : data,
  			success : function(msg) {
  				if (msg == "success") {
  					msgAlert("댓글 등록을 완료하였습니다.");
  					let boardNo = $(card).data("board-no");
  					getCommentListAjax(boardNo, card);
  				}
  			}
  		})
  	}
  	
  	function updateComment(btn) {
  		let area = $(btn).parents(".comment-area");
  		area.find(".upd-btn").toggleClass("d-none");
  		area.find(".btn").not(".upd-btn").attr("disabled", true);
  		area.find("textarea[name='commentContent']").prop("readonly", false).focus();
  	}
  	
  	function updateResetComment(btn) {
  		let area = $(btn).parents(".comment-area");
  		let data = {commentNo : $(area).data('comment-no')};
  		getCommentAjax(data, area);
  	}
  	
  	function updateDoneComment(btn) {
  		let area = $(btn).parents(".comment-area");
  		if (validateForm(area)) {
  	  		let data = {
  	  				commentNo : $(area).data("comment-no"),
  	  				commentContent : area.find("textarea[name='commentContent']").val(),
  	  		}
  	  		updateCommentAjax(data, area);
  		}
  	}
  	
  	function updateCommentAjax(data, area) {
  		$.ajax({
  			method : 'POST',
  			url : '/comment/updComment.do',
  			data : data,
  			success : function(comment) {
  				if (comment.commentNo != null) {
  					msgAlert("댓글 수정을 완료했습니다.");
  					getCommentAjax(data, area);
  				}
  			}
  		});
  	}
  	
  	function getCommentAjax(data, area) {
  		$.ajax({
  			method : 'POST',
  			url : '/comment/selComment.do',
  			data : data,
  			success : function(comment) {
  				$(area).find(".upd-btn").toggleClass("d-none");
  				area.find(".btn").not(".upd-btn").attr("disabled", false);
  				$(area).find(".comment-mod-date").text("수정일: " + getKoDate(comment.commentModDate));
  				$(area).find("textarea[name='commentContent']").val(comment.commentContent).attr("readonly", true);
  			}
  		});
  	}
  	
  	function deleteComment(btn) {
  		let area = $(btn).parents(".comment-area");
  		let commentNo = $(area).data("comment-no");
  		deleteCommentAjax(commentNo, area);
  	}
  	
  	function deleteCommentAjax(commentNo, area) {
  		let card = $(area).parents(".card");
  		let boardNo = card.data("board-no");
  		$.ajax({
  			method : 'POST',
  			url : '/comment/delComment.do',
  			data : {commentNo : commentNo},
  			success : function(comment) {
  				if (comment.commentNo != null) {
  					msgAlert("댓글 삭제를 완료하였습니다.");
  					/* $(area).remove(); */
  					getCommentListAjax(boardNo, card);
  				}
  			}
  		});
  	}
  	
  	function addComment(btn) {
		let card = $(btn).parents(".card");
		let boardNo = $(card).data("board-no");
		let userNo = $("#insertForm input[name='userNo']").val();
		let commentNo = $(btn).parents(".comment-area").data("comment-no");
		let userName = $(btn).parents(".comment-area").find(".name").text();
		let data = {boardNo : boardNo, userNo : userNo, commentNo : commentNo, userName : userName};
		$("#commentAddTemplate").tmpl(data).appendTo($(btn).parents(".comment-area"));
		$(btn).attr("disabled", true);
  	}
  	
  	function resetComment(btn) {
  		$(btn).parents(".comment-area").find(".add-btn").attr("disabled", false);
		$(btn).parents(".comment-add-box").remove();
  	}
  	
  	// Like
  	
  	function boardLike(btn) {
  		let boardNo = $(btn).parents(".card").data("board-no");
  		let data = {
			likesBoardNo : boardNo,
			command : $(btn).hasClass("liked") ? 2 : 1
  		}
  		boardLikeAjax(data, btn);
  	}
  	
	function boardLikeAjax(data, btn) {
		$.ajax({
			method : 'POST',
			url : '/board/likeBoard.do',
			data : data
		}).done((result) => {
			if (result == "liked") {
				$(btn).removeClass("disliked").addClass("liked");
				let cntTag = $(btn).siblings("span").find(".likeCnt");
				cntTag.text(parseInt(cntTag.text()) + 1);
			} else if (result == "disliked") {
				$(btn).removeClass("liked").addClass("disliked");
				let cntTag = $(btn).siblings("span").find(".likeCnt");
				cntTag.text(parseInt(cntTag.text()) -1);
			}
		});
	}
	
	/*
  	* Data Formats
  	*/
  	
  	// Date formatter(Intl)
  	
	function getKoDate(data) {
  		if (data != null) {
  			const koDtf = new Intl.RelativeTimeFormat('ko', {numeric:'always'});
  			const startDate = new Date(data);
  			const today = new Date();
  			const dayPassed = Math.ceil((startDate - today)/(1000 * 60 * 60 * 24));
  			if (dayPassed > -1) {
  				const timePassed = Math.ceil((startDate - today)/(1000 * 60 * 60));
  				if (timePassed > -1) {
  					const minutePassed = Math.ceil((startDate - today)/(1000 * 60));
  					return koDtf.format(minutePassed, 'minutes');
  				}
  				return koDtf.format(timePassed, 'hours');
  			}
  	  		return koDtf.format(dayPassed, 'day');
  		} else {
  			return "-";
  		}
  	}
 	
	
  	// Owner & Login User check
  	function userCheck(obj) {
		if ($("input[name='userNo']").val() == "-1") {
  			obj.myBoard = 0;
  			obj.loginUser = 0;
  		} else {
  			obj.myBoard = (obj.userNo == $("input[name='userNo']").val() || $("input[name='userAuth']").val().includes("ADMIN")) ? 1 : 0;
  			obj.loginUser = 1;
  		}
		return obj;
  	}
  	
  	// <, > parse
  	
  	function parseContent(boardContent) {
  		let text = $.parseHTML(boardContent)[0].data.replaceAll("&lt;", "<")
  													.replaceAll("&gt;", ">");
  		return text;
  	}
	
</script>

<!-- Board -->
<script id="boardTemplate" type="text/x-jquery-tmpl">
<div class="card my-3" data-mode="SELECT" data-board-no="\${boardNo}">
	<div class="card-header d-flex flex-row justify-content-between align-items-end">
		<h3><i class="fab fa-facebook"></i></h3>
		<div class="d-flex flex-column justify-content-end align-items-center">
			<span class="me-3 date board_reg_date">등록일: \${getKoDate(boardRegDate)}</span>
			<span class="date board_mod_date">수정일: \${getKoDate(boardModDate)}</span>
		</div>
	</div>
	<div class="card-body">
		<div class="d-flex flex-row justify-content-between p-3 m-2">
			<h4><i class="fas fa-user-circle"></i> \${userName}</h4>
			<div class="d-flex flex-row justify-content-end align-items-center">
				{{if myBoard == 1}}
				<button type="button" class="btn rounded-pill btn-sm btn-primary me-2" onclick="getBoardPost(this)">수정</button>
				<button type="button" class="btn rounded-pill btn-sm btn-danger me-2" onclick="deleteBoard(this)">삭제</button>
				{{/if}}
			</div>
		</div>
		<div class="content">{{html boardContent}}</div>
	</div>
	<div class="card-footer">
		<div class="d-flex flex-row justify-content-between">
			<div class="d-flex flex-row justify-content-start align-items-center">
				{{if loginUser == 1}}
					{{if boardLikeYn == 1}}
						<button type="button" class="likeBtn liked btn rounded-pill" onclick="boardLike(this)"><i class="fa fa-regular fa-heart"></i></button>
					{{else}}
						<button type="button" class="likeBtn disliked btn rounded-pill" onclick="boardLike(this)"><i class="fa fa-regular fa-heart"></i></button>
					{{/if}}
				{{/if}}
				<span><span class="likeCnt">\${boardLikeCnt}</span><span> 좋아요</span></span>
			</div>
			<button type="button" class="btn upd-btn get-comment rounded-pill btn-primary me-2" onclick="getCommentList(this)"><i class="fas fa-comment"></i></button>
			<button type="button" class="btn upd-btn hide-comment rounded-pill btn-secondary d-none" onclick="hideCommentList(this)"><i class="fas fa-comment-slash"></i></button>
		</div>
	</div>
</div>
</script>

<script id="boardModTemplate" type="text/x-jquery-tmpl">
	<form> 
	<div class="card-header">
		<div class="form-group">
			<label>게시글 내용</label>
			<textarea class="form-control" name="boardContent" id="boardModEditor">\${boardContent}</textarea>
		</div>
		<input type="hidden" name="boardNo" value="\${boardNo}">
		<input type="hidden" name="boardParentNo" value="\${boardParentNo}">
		<div class="d-flex justify-content-end flex-row mt-2">
			<button type="button" id="reset-btn" class="btn rounded-pill btn-secondary me-2" onclick="getBoardPost(this)">취소</button>
			<button type="button" class="btn rounded-pill btn-primary" onclick="updateBoard(this)">수정</button>
		</div>
	</div>
	</form>
</script>

<!-- Comment -->
<script id="boardCommentTemplate" type="text/x-jquery-tmpl">
<div class="comment-container p-3 my-2">
</div>
</script>

<script id="commentInsertTemplate" type="text/x-jquery-tmpl">
	<div class="comment-insert-box">
		<form class="commentForm">
			<div class="d-flex flex-row justify-content-between">
				<label class="form-input-label">댓글</label>
				<div class="text-end">
					<button type="button" class="btn btn-link" onclick="insertComment(this)">댓글 달기</button>
				</div>
			</div>
			<textarea class="form-control" rows="4" name="commentContent"></textarea>
			<input type="hidden" name="boardNo" value="\${boardNo}">
			<input type="hidden" name="userNo" value="\${userNo}">
		</form>
	</div>
</script>

<script id="commentAddTemplate" type="text/x-jquery-tmpl">
	<div class="comment-insert-box comment-add-box px-4 py-2 mt-2">
		<form class="commentForm">
			<div class="d-flex flex-row justify-content-between">
				<label class="form-input-label">\${userName}님에게 댓글달기</label>
				<div class="text-end">
					<button type="button" class="btn btn-link btn-sm" onclick="resetComment(this)">취소</button>
					<button type="button" class="btn btn-link btn-sm" onclick="insertComment(this)">댓글 달기</button>
				</div>
			</div>
			<textarea class="form-control" rows="4" name="commentContent"></textarea>
			<input type="hidden" name="boardNo" value="\${boardNo}">
			<input type="hidden" name="userNo" value="\${userNo}">
			<input type="hidden" name="commentParentNo" value="\${commentNo}">
		</form>
	</div>
</script>

<script id="commentListTemplate" type="text/x-jquery-tmpl">
	<div class="comment-box">
		{{if commentList.length == 0}}
			<p class="no-comment-box">작성된 댓글이 없습니다.</p>
		{{else}}
			{{each(i, comment) commentList}}
				<div class="comment-area" data-comment-no="\${commentNo}" style="margin-left:\${(commentLevel - 1) * 30}px;">
					{{if commentDelyn == 'N'}}
					<div class="d-flex flex-row justify-content-between align-items-center">
						<span>
							{{if commentLevel > 1}}
								<i class="fas fa-hand-point-right"></i>
							{{/if}}
							<i class="fas fa-user-circle"></i> 
							<span class="name">\${userName}</span>
						</span>
						<div class="d-flex flex-column justify-content-end align-items-center">
							<span class="date comment-reg-date">등록일: \${getKoDate(commentRegDate)}</span>
							<span class="date comment-mod-date">수정일: \${getKoDate(commentModDate)}</span>
						</div>
					</div>
					<textarea class="form-control" readonly name="commentContent">\${commentContent}</textarea>
					<div class="d-flex justify-content-end align-items-center">
						{{if loginUser}}
							<button type="button" class="btn btn-sm btn-link add-btn" onclick="addComment(this)">댓글달기</button>
						{{/if}}
						{{if myBoard}}
							<button type="button" class="btn btn-sm btn-link" onclick="deleteComment(this)">삭제하기</button>
							<button type="button" class="btn upd-btn btn-sm btn-link" onclick="updateComment(this)">수정하기</button>
							<button type="button" class="btn upd-btn btn-sm btn-link d-none" onclick="updateResetComment(this)">수정취소</button>
							<button type="button" class="btn upd-btn btn-sm btn-link d-none" onclick="updateDoneComment(this)">수정완료</button>
						{{/if}}
					</div>
					{{else commentDelyn == 'Y' && commentIsLeaf == 0}}
					<div class="bg bg-light p-2 mt-3 rounded">
						<p>삭제된 댓글입니다.</p>
					</div>
					{{/if}}
				</div>
			{{/each}}
		{{/if}}
	</div>
</script>

