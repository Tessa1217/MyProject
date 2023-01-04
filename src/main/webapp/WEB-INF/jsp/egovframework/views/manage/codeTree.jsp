<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<ul class="list-group gp-list">
							<c:forEach items="${gpList}" var="gp" varStatus="status">
								<li class="list-group-item gp-code <c:if test="${empty gp.codeList}">ps-5</c:if>"><c:if test="${not empty gp.codeList}"><i class="fas fa-plus me-2"></i></c:if><span>${gp.gpCode}</span>
									<button class="tree-upd-start me-2 float-end d-none btn btn-sm rounded-pill btn-outline-primary" type="button" onclick="changeTreeOrder(this)">순서 변경</button>
									<button class="tree-upd-end me-2 float-end d-none btn btn-sm rounded-pill btn-outline-danger" type="button" onclick="updateTreeOrder(this)">변경 완료</button></li>
								<c:if test="${not empty gp.codeList}">
									<ul class="list-group cd-list d-none">
										<c:forEach items="${gp.codeList}" var="cd" varStatus="status">
											<li class="cd-code px-5 list-group-item"><i class="far fa-hand-point-right me-3"></i><span>${cd.cdCode}</span></li>
										</c:forEach>
									</ul>
								</c:if>
							</c:forEach>
						</ul>