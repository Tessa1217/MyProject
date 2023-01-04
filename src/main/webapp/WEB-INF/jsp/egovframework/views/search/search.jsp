<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<title>통합 검색</title>
<style>
	
	.result:first-child {
		margin-top: 10px;
	}
	
	.result {
		height: 190px;
		border: 1px solid #bbb;
		padding: 20px;
		margin-bottom: 10px;
		border-radius: 10px;
		position: relative;
	}
	
	.result > a {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
	
	.result-title {
		font-weight: bold;
		font-size: 16px;
	}
	
	.result-info {
		font-size: 13px;
		color: gray;
	}
	
	.link {
		font-size: 14px;
		text-decoration: none;
		color: gray;
		font-weight: bold;
	}
	
	.total-cnt {
		font-size: 17px;
		font-weight: bold;
		font-color: gray;
	}
	
	.result-content {
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp : 3;
		overflow: hidden;
	}
</style>
</head>
<body>
	<div class="mt-2 pt-2">
		<div class="container fluid px-4">
			<div class="card">
				<div class="card-header p-4">
					<div class="d-flex flex-row justify-content-between align-items-center">
						<h3><i class="fas fa-search"></i> "${cri.searchKeyword}" 검색 결과 <span class="total-cnt">(${totalCnt}건)</span></h3>
					</div>
				</div>
				<div class="card-body">
					<c:if test="${totalCnt eq 0}">
						<h5 class="m-3">검색어 "${cri.searchKeyword}"에 대한 검색 결과를 찾을 수 없습니다.</h5>
					</c:if>
					<c:if test="${totalCnt > 0}">
						<c:forEach items="${mapList}" var="map">
							<c:if test="${map.listCnt gt 0}">
							<div class="bulletin card my-3">
									<div class="card-header bulletin-title p-3">
										<h5 class="fw-bold">${map.menu.menuNm} <span class="total-cnt">(${map.listCnt}건)</span></h5>
									</div>
									<div class="card-body">
										<c:if test="${not empty map.list}">
											<c:forEach items="${map.list}" var="elem" varStatus="status">
												<c:if test="${status.index < cri.recordCountPerPage}">
													<div class="result">
														<div class="d-flex justify-content-between">
															<span class="result-title">${elem.boardTitle}</span>
															<div class="d-flex flex-column align-items-end">
																<span class="result-info">작성자: ${elem.userName}</span>
																<span class="result-info">작성일자: <fmt:formatDate pattern="YYYY년  MM월 dd일" value="${elem.boardRegDate}"/></span>
															</div>
														</div>
														<div class="d-flex justify-content-between">
															<c:if test="${elem.boardTypeNo eq 3}">
																<div><img src="${elem.thumbnailPath}" width="130px" height="100px"></div>
															</c:if>
															<div class="col-10 p-2 border-none">
																<p class="result-content">${elem.boardContent}</p>
															</div>
														</div>
														<a href="javascript:selBoardLink('${elem.boardTypeNo}', '${elem.bulletinNo}', '${elem.boardNo}')"></a>
													</div>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${not empty map.surveyList}">
											<c:forEach items="${map.surveyList}" var="elem">
												<div class="result">
													<div class="d-flex justify-content-between">
														<span>${elem.surveyTitle}</span>
														<span>작성자: ${elem.surveyOwnerName}</span>
													</div>
													<a href="javascript:selSurveyLink('${user.userAuth}', '${elem.surveyNo}')"></a>
												</div>
											</c:forEach>
										</c:if>
									</div>
									<c:if test="${map.listCnt gt cri.recordCountPerPage}">
										<div class="card-footer text-end p-3">
											<a class="link" href="${map.menu.fullPath}<c:choose><c:when test="${fn:contains(map.menu.fullPath, '?')}">&</c:when><c:otherwise>?</c:otherwise></c:choose>pageIndex=1&recordCountPerPage=10&searchCnd=ALL&searchKeyword=${cri.searchKeyword}"><i class="fas fa-search-plus"></i> ${map.menu.menuNm} 더보기</a>
										</div>
									</c:if>
							</div>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<script>
	
		function selBoardLink(type, bulletin, boardNo) {
			openNewWindow('boardSelect', boardNo, type, bulletin);
		}
		
		function selSurveyLink(auth, surveyNo) {
			if (auth == '' || auth == 'USER') {
				location.href="/survey/selSurvey.do?surveyNo=" + surveyNo;	
			} else if (auth == 'ADMIN' || auth == 'SUPERADMIN') {
				location.href="/survey/surveyResult.do?surveyNo=" + surveyNo;
			}
		}
		
	</script>
</body>
</html>