<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<table class="group-table table table-hover">
							<thead class="text-center">
								<tr>
									<th width="3%"><input class="form-check-input del-check gp-check all" type="checkbox"></th>
									<th width="10%">대분류 코드</th>
									<th width="10%">코드명</th>
									<th width="47%">코드 설명</th>
									<th width="10%">등록일</th>
									<th width="10%">수정일</th>
									<th width="10%">변경</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${gpList}" var="gp" varStatus="status">
									<tr class="gp-code" data-code="${gp.gpCode}">
										<td><input type="checkbox" class="form-check-input gp-check del-check"></td>
										<td class="code editable">${gp.gpCode}</td>
										<td class="nm editable">${gp.gpNm}</td>
										<td class="desc editable">${gp.gpDesc}</td>
										<td class="regDate"><fmt:formatDate value="${gp.gpRegDate}"
												pattern="YYYY. MM. dd." /></td>
										<td class="modDate"><c:choose>
												<c:when test="${not empty gp.gpModDate}">
													<fmt:formatDate value="${gp.gpModDate}" pattern="YYYY. MM. dd." />
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</td>
										<td class="modify">
											<button type="button" 
													class="btn mod-btn btn-sm rounded-pill btn-primary">수정</button>
											<button type="button" 
													class="btn mod-reset-btn btn-sm rounded-pill btn-secondary d-none">취소</button>
											<button type="button" 
													class="btn mod-done-btn btn-sm rounded-pill btn-danger d-none">완료</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						