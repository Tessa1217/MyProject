<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="modal" tabindex="-1" id="insertModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">공통 코드 생성</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeInsertModal()"></button>
	      </div>
	      <div class="modal-body">
	      	<select class="form-select codeType">
	      		<option value="insertGpForm">대분류 코드</option>
	      		<option value="insertCdForm">소분류 코드</option>
	      	</select>
	        <form id="insertGpForm">
	        	<div>
					<label class="form-input-label" id="gpCode">대분류 코드</label>
					<input class="form-control" type="text" name="gpCode" id="gpCode" required maxlength="40" pattern="" title="공백은 입력할 수 없습니다.">
				</div>
				<div>
					<label class="form-input-label" id="gpNm">대분류 코드명</label>
					<input class="form-control" type="text" name="gpNm" id="gpNm" required maxlength="50">
				</div>
				<div>
					<label class="form-input-label" id="gpDesc">대분류 설명</label>
					<textarea class="form-control" rows="5" name="gpDesc" maxlength="150"></textarea>
				</div>
	        </form>
	        <form id="insertCdForm" class="d-none">
				<div>
					<label class="form-input-label" id="gpCode">대분류 코드</label>
					<select class="form-select" name="gpCode">
						<c:forEach items="${gpList}" var="gp">
							<option value="${gp.gpCode}">${gp.gpCode}</option>
						</c:forEach>
					</select>
				</div>
				<div>
					<label class="form-input-label" id="cdCode">소분류 코드</label>
					<input class="form-control" type="text" name="cdCode" id="cdCode" pattern="" title="공백은 입력할 수 없습니다.">
				</div>
				<div>
					<label class="form-input-label" id="cdNm">소분류 코드명</label>
					<input class="form-control" type="text" name="cdNm" id="cdNm">
				</div>
				<div>
					<label class="form-input-label" id="cdDesc">소분류 설명</label>
					<textarea class="form-control" rows="5" name="cdDesc"></textarea>
				</div>	        	
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeInsertModal()">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="insertTreeCode()">생성</button>
	      </div>
	    </div>
	  </div>
	</div>