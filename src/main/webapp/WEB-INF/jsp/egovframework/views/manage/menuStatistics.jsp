<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<title>Insert title here</title>
<style>
	.stat-wrapper {
		overflow-x:auto;
	}
</style>
</head>
<body>
	<div class="mt-2 pt-2">
		<div class="px-4">
			<nav class="stat-tabs nav nav-pills">
			  <li class="nav-item">
			  	<a class="nav-link active" href="javascript:changeTab();">통계테이블</a>
			  </li>
			  <li class="nav-item">
			  	<a class="nav-link" href="javascript:changeTab();">통계차트</a>
			  </li>
			</nav>
		</div>
		<div class="container-fluid px-4">
			<div class="chart-wrapper d-flex flex-row justify-content-center align-items-center d-none">
				<div id="chart"></div>
			</div>
			<div class="stat-wrapper card">
				<div class="card-header">
					<div class="col-2">
						<form id="statForm">
							<select class="form-select" name="menuStatType">
								<option value="year"
									<c:if test="${menu.menuStatType eq 'year'}">selected = selected</c:if>>연도별</option>
								<option value="month"
									<c:if test="${menu.menuStatType eq 'month'}">selected = selected</c:if>>월별</option>
								<option value="day"
									<c:if test="${menu.menuStatType eq 'day'}">selected = selected</c:if>>일별</option>
								<option value="time"
									<c:if test="${menu.menuStatType eq 'time'}">selected = selected</c:if>>시간대별</option>
							</select>
						</form>
					</div>
				</div>
				<div class="card-body">
					<table class="statTable table table-striped">
						<thead class="text-center">
							<tr>
								<th>메뉴 이름</th>
								<c:choose>
									<c:when
										test="${empty menu.menuStatType or menu.menuStatType eq 'year'}">
										<th>2022년</th>
										<th>2021년</th>
										<th>2020년</th>
									</c:when>
									<c:when test="${menu.menuStatType eq 'month'}">
										<c:forEach var="i" begin="1" end="12">
											<th>${i}월</th>
										</c:forEach>
									</c:when>
									<c:when test="${menu.menuStatType eq 'day'}">
										<c:forEach var="i" begin="1" end="31">
											<th>${i}일</th>
										</c:forEach>
									</c:when>
									<c:when test="${menu.menuStatType eq 'time'}">
										<c:forEach var="i" begin="0" end="23">
											<th><c:if test="${i lt 10}">0</c:if>${i}시</th>
										</c:forEach>
									</c:when>
								</c:choose>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${statList}" var="stat" varStatus="status">
								<c:choose>
									<c:when
										test="${empty menu.menuStatType or menu.menuStatType eq 'year'}">
										<tr>
											<td>${stat.menuNm}</td>
											<td>${stat.year1}</td>
											<td>${stat.year2}</td>
											<td>${stat.year3}</td>
										</tr>
									</c:when>
									<c:when test="${menu.menuStatType eq 'month'}">
										<tr>
											<td>${stat.menuNm}</td>
											<td>${stat.num1}</td>
											<td>${stat.num2}</td>
											<td>${stat.num3}</td>
											<td>${stat.num4}</td>
											<td>${stat.num5}</td>
											<td>${stat.num6}</td>
											<td>${stat.num7}</td>
											<td>${stat.num8}</td>
											<td>${stat.num9}</td>
											<td>${stat.num10}</td>
											<td>${stat.num11}</td>
											<td>${stat.num12}</td>
										</tr>
									</c:when>
									<c:when test="${menu.menuStatType eq 'day'}">
										<tr>
											<td>${stat.menuNm}</td>
											<td>${stat.num1}</td>
											<td>${stat.num2}</td>
											<td>${stat.num3}</td>
											<td>${stat.num4}</td>
											<td>${stat.num5}</td>
											<td>${stat.num6}</td>
											<td>${stat.num7}</td>
											<td>${stat.num8}</td>
											<td>${stat.num9}</td>
											<td>${stat.num10}</td>
											<td>${stat.num11}</td>
											<td>${stat.num12}</td>
											<td>${stat.num13}</td>
											<td>${stat.num14}</td>
											<td>${stat.num15}</td>
											<td>${stat.num16}</td>
											<td>${stat.num17}</td>
											<td>${stat.num18}</td>
											<td>${stat.num19}</td>
											<td>${stat.num20}</td>
											<td>${stat.num21}</td>
											<td>${stat.num22}</td>
											<td>${stat.num23}</td>
											<td>${stat.num24}</td>
											<td>${stat.num25}</td>
											<td>${stat.num26}</td>
											<td>${stat.num27}</td>
											<td>${stat.num28}</td>
											<td>${stat.num29}</td>
											<td>${stat.num30}</td>
											<td>${stat.num30}</td>
										</tr>
									</c:when>
									<c:when test="${menu.menuStatType eq 'time'}">
										<tr>
											<td>${stat.menuNm}</td>
											<td>${stat.num0}</td>
											<td>${stat.num1}</td>
											<td>${stat.num2}</td>
											<td>${stat.num3}</td>
											<td>${stat.num4}</td>
											<td>${stat.num5}</td>
											<td>${stat.num6}</td>
											<td>${stat.num7}</td>
											<td>${stat.num8}</td>
											<td>${stat.num9}</td>
											<td>${stat.num10}</td>
											<td>${stat.num11}</td>
											<td>${stat.num12}</td>
											<td>${stat.num13}</td>
											<td>${stat.num14}</td>
											<td>${stat.num15}</td>
											<td>${stat.num16}</td>
											<td>${stat.num17}</td>
											<td>${stat.num18}</td>
											<td>${stat.num19}</td>
											<td>${stat.num20}</td>
											<td>${stat.num21}</td>
											<td>${stat.num22}</td>
											<td>${stat.num23}</td>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script>
		google.charts.load('current', {packages: ['corechart']});
		google.charts.setOnLoadCallback(drawChart);
		
		function drawChart() {
			let data = new google.visualization.DataTable();
			$(".statTable th").each((idx, val) => {
				if (idx == 0) {
					data.addColumn('string', $(val).text());
				} else {
					data.addColumn('number', $(val).text());
				}
			})
			
			let dataRows = [];
			
 			$(".statTable tbody tr").each((idx, val) => {
				let row = makeRow(val);
				dataRows.push(row);
			}) 

			data.addRows(dataRows);
 			
 			let options = { 'title' : 'Menu Statistics',
 							/* 'chartArea' : {'left' : 0, 'top':0, 'width':'85%', 'height':'90%'}, */
 							'width' : window.screen.width, 
 							'height' : window.screen.height
 						  };
 			
			let chart = new google.visualization.ColumnChart(document.getElementById("chart"));
			chart.draw(data, options);
		}
		
		function makeRow(elem) {
			let row = [];

			$(elem).find("td").each((idx, val) => {
				if (idx == 0) {
					row.push($(val).text());
				} else {
					row.push(parseInt($(val).text()));
				}
			})
			
			return row;
		}
		
		$(document).ready(function() {
			$("select[name='menuStatType']").change(() => {
				$("#statForm").submit();
			})
		})
		
		function changeTab() {
			$(".stat-tabs a.nav-link").toggleClass("active");
			$(".chart-wrapper").toggleClass("d-none");
			$(".stat-wrapper").toggleClass("d-none");
		}
	</script>
</body>
</html>