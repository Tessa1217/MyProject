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
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퓨전 게시판(목록)</title>
</head>
<body>
	<main id="board" class="mt-2 pt-2">
		<div class="container-fluid px-4">
			<div class="d-flex justify-content-between align-items-end flex-row my-3">
				<h1>게시판</h1>
				<div v-if="user">
					<div>
						<button class="btn btn-primary" v-on:click="openNewWindow('boardInsert', 0, ', ')"><i class="fas fa-edit"></i>글작성</button>
					</div>
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header d-flex flex-row justify-content-between">
					<form class="pageSearchForm w-50">
						<input type="hidden">
						<input type="hidden">
						<select class="form-select d-inline w-25" name="searchCnd">
							<option value=""></option>
							<option value=""></option>
							<option value=""></option>
							<option value=""></option>
							<option value=""></option>
						</select>
					</form>
				</div>
				<div class="card-body boardList">
					<table class="table table-hover table-striped">
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<template v-for="post in boardList">
								<tr v-if="post.boardDelyn == 'N'">
									<td>{{post.boardLevel}}</td>
									<td class="title">
										<div>
											<span v-if="post.boardParentNo > 0">
												<span class="material-symbols-outlined red">subdirectory_arrow_right</span>답글: 
											</span>										
											<span>{{post.boardTitle}}</span>
										</div>
									</td>
									<td>{{post.userName}}</td>
									<td>{{post.boardViewCnt}}</td>
									<td>{{post.boardRegDate | dateString}}</td>
								</tr>
								<tr v-else>
									<td>${post.boardLevel}</td>
									<td class="grey">삭제된 게시글입니다.</td>
									<td>-</td>
									<td>-</td>
								</tr>
							</template>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
</body>
 <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript">
	new Vue({
		el : '#board',
		data : {
			boardList : [],
			user : null,
			recordCountPerPage : 10,
			titleSpace : 10
		},
		created : function() {
			axios.post("/board/boardList.do", null, {params:{boardTypeNo : 'DEFAULT', pageIndex : 1, bulletinNo : 1}}).then((res) => {
				console.log(res);
				this.boardList = res.data;
			})
			.catch(err => console.error(err));
			console.log(this.boardList);
		},
		filters : {
			dateString : function(value) {
				if (value == '') {
					return '';
				}
				
				let date = new Date(value);
				
				const year = date.getFullYear();
				const month = date.getMonth() + 1;
				const day = date.getDate();
				
				if (month < 10) {
					month = "0" + month;
				}
				
				if (day < 10) {
					day = "0" + day;
				}
				
				return year + '년 ' + month + '월 ' + day + "일 ";
			}
		},
		methods: {
			getBoardList(idx) {
				axios.post("/board/boardList.do", null, {params:{boardType : 'DEFAULT',pageIndex : idx, bulletinNo : 1}})
				.then((res) => {
					this.boardList = res.data;
				})
				.catch(err => console.log(err))
			},
			openNewWindow(pageNm, idx, split) {
				console.log(pageNm);
			}
		},
	});

</script>
</html>