<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ page import="egovframework.fusion.user.vo.UserVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Insert title here</title>
</head>
<body>
	<input type="hidden" value="${paginationInfo.totalPageCount}" name='lastPage'>
	<input type="hidden" value="${board.boardTypeNo}" name="boardTypeNo">
	<div class="galleryList mt-2 pt-2">
		<div class="topBtn d-flex flex-row align-items-center justify-content-center">
			<i class="fas fa-arrow-up"></i>
		</div>
		<div class="container-fluid px-4">
			<div
				class="d-flex justify-content-between aligh-itemds-end flex-row my-3">
				<h1>갤러리</h1>
				<c:if test="${not empty user}">
					<div>
						<button class="btn btn-primary" onclick="openNewWindow('boardInsert', 0, '', '')"><i class="fas fa-edit"></i> 글 작성</button>
					</div>
				</c:if>
			</div>
			<div class="my-5 mx-4">
				<form id="submitForm" class="pageSearchForm d-flex flex-row justify-content-between align-items-center" onsubmit="return submitForm()">
					<input type="hidden" name="boardTypeNo" value="${board.boardTypeNo}">
					<input type="hidden" name="bulletinNo" value="${board.bulletinNo}">
					<input type="hidden" name="pageIndex" value="${cri.pageIndex}">
					<div class="col-10 d-flex flex-row flex-wrap justify-content-start align-items-center">
							<select class="form-select mx-2" name="searchCnd">
								<option value="" <c:if test="${empty cri.searchCnd}">selected</c:if>>전체</option>
								<option value="BOARD_TAG" <c:if test="${cri.searchCnd eq 'BOARD_TAG'}">selected</c:if>>태그</option>
								<option value="USER_NAME" <c:if test="${cri.searchCnd eq 'USER_NAME'}">selected</c:if>>작성자</option>
								<option value="BOARD_TITLE" <c:if test="${cri.searchCnd eq 'BOARD_TITLE'}">selected</c:if>>제목</option>
								<option value="BOARD_CONTENT" <c:if test="${cri.searchCnd eq 'BOARD_CONTENT'}">selected</c:if>>내용</option>
								<option value="ALL" <c:if test="${cri.searchCnd eq 'ALL'}">selected</c:if>>전체 검색</option>
							</select>
							<input class="mx-2 form-control <c:if test="${empty cri.searchCnd}">d-none</c:if>" type="text" placeholder="검색어를 입력해주세요." name="searchKeyword" value="${cri.searchKeyword}">
							<button type="submit" class="mx-2 btn btn-sm rounded-pill btn-primary">검색</button>
							<button type="button" class="mx-2 btn btn-sm rounded-pill btn-secondary" onclick="resetForm()">초기화</button>
					</div>
					<div class="col-2 d-flex flex-row justify-content-end align-items-center">
						<select class="form-select" name="recordCountPerPage">
							<option value="20" <c:if test="${cri.recordCountPerPage == 20}">selected</c:if>>20개</option>
							<option value="40" <c:if test="${cri.recordCountPerPage == 40}">selected</c:if>>40개</option>
							<option value="100" <c:if test="${cri.recordCountPerPage == 100}">selected</c:if>>100개</option>
						</select>
					</div>
				</form>
			</div>					
			<div class="d-flex flex-row justify-content-end">
				<button class="tagCloseBtn btn btn-outline btn-outline-secondary"><i class="fas fa-angle-up"></i></button>
			</div>
			<div class="tagTypeList flex-row mb-5 mx-4">
				<div class="col-6 me-2">
					<div class="d-flex flex-row justify-content-start align-items-center mb-2">
						<h5 class="fw-bold tagTitle blue-title p-1"><i class="far fa-kiss-wink-heart"></i> 최신 태그 추천</h5>
					</div>
					<c:if test="${not empty recentTags}">
						<div class="recentTagList flex-wrap align-items-center p-2">
							<c:forEach items="${recentTags}" var="tag">
								<a class="d-inline-block my-1" href="javascript:void(0)" onclick="searchTag('${tag.tagContent}')"><span class="badge bg-info rounded-pill me-1 py-2 px-3">#${tag.tagContent}</span></a>				
							</c:forEach>
						</div>
					</c:if>
				</div>
				<div class="col-6">
					<div class="d-flex flex-row justify-content-start align-items-center mb-2">
						<h5 class="fw-bold tagTitle p-1 red-title"><i class="fas fa-fire"></i> 상위 태그 추천</h5>
					</div>
					<c:if test="${not empty topTags}">
						<div class="recentTagList flex-wrap align-items-center p-2">
							<c:forEach items="${topTags}" var="tag">
								<a class="d-inline-block my-1" href="javascript:void(0)" onclick="searchTag('${tag.tagContent}')"><span class="badge bg-danger rounded-pill me-1 py-2 px-3">#${tag.tagContent}</span></a>					
							</c:forEach>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<div class="container mb-4">
			<div
				class="row row-cols-sm-2 row-cols-md-2 row-cols-lg-4 row-cols-xl-4 row-cols-xxl-4 g-sm-2 g-md-2 g-lg-2 g-xl-2 g-xxl-2 mb-2">
				<c:forEach items="${galleryList}" var="gallery">
					<div class="col card">
						<a class="selectLink" href="/board/boardSelect.do?boardTypeNo=${board.boardTypeNo}&boardNo=${gallery.boardNo}"></a>
						<div class="card-body"
							style="background-image: url('${gallery.thumbnailPath != null ? gallery.thumbnailPath : '/images/egovframework/no-image-icon-23485.png'}'); background-size: cover;">
						</div>
						<div class="card-footer">
							<div class="d-flex flex-row justify-content-between align-items-center">
								<span>${gallery.boardTitle}</span>
								<div>
									<span class="px-1"><i class="far fa-eye"></i><span>${gallery.boardViewCnt}</span></span><span><i class="fas fa-heart"></i><span>${gallery.boardLikeCnt}</span></span>
								</div>
							</div>
							<div class="d-flex flex-row justify-content-start tagList flex-wrap">
								<c:if test="${not empty gallery.boardTags}">
									<c:forEach items="${gallery.boardTags}" var="tag">
										<a href="javascript:void(0)" onclick="searchTag('${tag.tagContent}')"><span class="badge bg-warning rounded-pill me-1">#${tag.tagContent}</span></a>
									</c:forEach>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${fn:length(galleryList) == cri.recordCountPerPage}">
			<div id="endPage-1" class="align-center d-flex flex-row justify-content-center align-items-center"></div>
			</c:if>
		</div>
	</div>
	<script>
	
		$('.topBtn').click(function(){
			$('html, body').animate({scrollTop:0});
			return false;
		});
			
		$(document).ready(function() {
			
			searchCondition();
			
			$("select[name='recordCountPerPage']").on("change", function() {
				location.href="/board/boardList.do" + baseQueryString() + queryString(1);
			})
			
			$(".tagCloseBtn").on("click", function() {
				$(".tagTypeList").slideToggle();
				$(this).find("i").toggleClass("fa-angle-up fa-angle-down");
			})
		})
		

		
		let pageIndex = 1;
		
		const option = {
				root: null,
				rootMargin: "20px 20px 20px 20px",
				threshold: 1
			}
			
		const io = new IntersectionObserver((entries, observer) => {
			entries.forEach((entry) => {
				if (entry.isIntersecting) {
						io.unobserve(entry.target); 
						pageIndex++;
					bringPage();
				}
			})
		}, option);

		if (document.querySelector("#endPage-1")) {
			let target= document.querySelector("#endPage-1"); 
			io.observe(target);
		}
		
		function bringPage() {
			$.ajax({
	    		method : 'POST',
	    		url : '/board/boardList.do' + baseQueryString(),
	    		data : queryString(pageIndex)
	    	}).done(function(galleryList) {
	    		$("#endPage-" + (pageIndex-1)).append($("<i/>").attr("class", "fas fa-spinner fa-3x m-2"));
	    		setTimeout(() => {
	    			let watchNeed = makeGallery(galleryList);
		    		if (watchNeed) {
		    			io.observe(document.querySelector("#endPage-" + pageIndex));  
		    		}
		    		$("#endPage-" + (pageIndex-1)).empty();
	    		}, 1000)
	    		
	    	})
		}
		
		function searchTag(keyword) {
			location.href="/board/boardList.do" + baseQueryString() + "&searchCnd=BOARD_TAG&searchKeyword=" + keyword;
		}
		
		function makeGallery(galleryList) {
    		let page = $("<div/>").attr("class", "row row-cols-sm-2 row-cols-md-2 row-cols-lg-4 row-cols-xl-4 row-cols-xxl-4 g-sm-2 g-md-2 g-lg-2 g-xl-2 g-xxl-2 mb-2");
    		for (let i = 0; i < galleryList.length; i++) {
    			let card = $("<div/>").attr("class", "col card");
    			let tagLink = $("<a/>").attr({
    				"class" : "selectLink",
    				"href" : "/board/boardSelect.do?boardTypeNo=" + $("input[name='boardTypeNo']").val() + "boardNo=" + galleryList[i].boardNo
    			})
    			let cBody = $("<div/>").attr({
    				"class" : "card-body"
    			}).css({
    				"background-image" : "url('" + (galleryList[i].thumbnailPath != null ? galleryList[i].thumbnailPath : '/images/egovframework/no-image-icon-23485.png') + "')",
					"background-size" : "cover"
    			})
    			let cFooter = $("<div/>").attr("class", "card-footer");
    			let topContent = $("<div/>").attr("class", "d-flex flex-row justify-content-between align-items-center").append($("<span/>").text(galleryList[i].boardTitle))
    										.append($("<div/>")
    												.append($("<span/>").attr("class", "px-1")
    														.append($("<i/>").attr("class", "far fa-eye"))
    												.append($("<span/>").text(galleryList[i].boardViewCnt)))
    													.append($("<span/>").append($("<i/>").attr("class", "fas fa-heart"))
    															.append($("<span/>").text(galleryList[i].boardLikeCnt)))); 
    			let bottomContent = $("<div/>").attr("class", "d-flex flex-row justify-content-start tagList flex-wrap");
    			for (let idx = 0; idx < galleryList[i].boardTags.length; idx++) {
    				 let badgeElement = $("<a/>").attr("href", "javascript:void(0)").append($("<span/>").attr("class", "badge rounded-pill bg-warning me-1").text("#" + galleryList[i].boardTags[idx].tagContent));
    				 $(badgeElement).click(function() {
							 searchTag(galleryList[i].boardTags[idx].tagContent);
					 })
    				 bottomContent.append(badgeElement);
    			}
    			cFooter.append(topContent).append(bottomContent);
    			card.append(tagLink).append(cBody).append(cFooter).appendTo(page);
    		}
			$(".container.mb-4").append(page);		
			if (galleryList.length == 20 && pageIndex < $("input[name='lastPage']").val()) {
				$(".container.mb-4").append($("<div/>").attr("id", "endPage-" + pageIndex).attr("class", "my-2 align-center d-flex flex-row justify-content-center align-items-center"));
				return true;
			}
			return false;
		}
		
		function submitForm() {
			let searchCnd = $("select[name='searchCnd']").val();
			let searchKeyword = $("input[name='searchKeyword']").val();
			if (searchCnd != "" && searchKeyword == "") {
				alert("검색어를 입력해주세요.");
				return false;
			}
			$("#submitForm").submit();
			return false;
		}
		
		function resetForm() {
			$("select[name='searchCnd']").val('');
			$("input[name='searchKeyword']").val('');
			$("select[name='searchCnd']").trigger("change");
		}
	</script>
</body>
</html>