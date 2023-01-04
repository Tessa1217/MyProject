<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mt-2 pt-2">
	<div class="container-fluid px-4">
		<div class="card mb-4">
			<div class="card-header d-flex flex-row justify-content-between">
				<h2>요청 사항 등록</h2>
			</div>
			<div class="card-body">
				<form id="req-form-insert" onsubmit="return insRequest(this);">
					<div class="form-group mb-2">
						<label class="form-label">요청 사항 제목</label>
						<input class="form-control" type="text" name="reqTitle" maxlength="100">
					</div>
					<div class="form-group mb-2">
						<label class="form-label">요청 사항 내용</label>
						<textarea class="form-control" name="reqContent" rows="5" maxlength="4000" id="insEditor"></textarea>
					</div>
					<div class="form-group mb-2">
						<label class="form-label">요청자</label>
						<input class="form-control" type="text" value="${user.userName}" readonly>
						<input type="hidden" name="requesterNo" value="${user.userNo}">
					</div>
					<div class="mb-2 d-flex justify-content-center align-items-center">
						<button type="button" class="btn rounded-pill btn-outline-secondary me-2" onclick="history.back();">목록</button>
						<button type="submit" class="btn rounded-pill btn-outline-danger">신청</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script src="/js/request-ajax.js"></script>
<script>
	$(document).ready(function() {
		generateEditor("#insEditor");
	})
	
</script>