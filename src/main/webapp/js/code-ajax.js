/* 
 * 소분류 코드 리트스 불러오기
 */
function getCdList(gpCode) {
	$.ajax({
		method : 'POST',
		url : '/manage/codeList.do',
		data : {gpCode : gpCode},
		success : (list) => {
			$(".code-table input[name='gpCode']").val(gpCode);
			let tbody = $(".code-table tbody");
			tbody.empty();
			if (list.length > 1) {
				$("button.update-start").removeClass("disabled");
			} else {
				$("button.update-start").addClass('disabled');
			}
			for (let i = 0; i < list.length; i++) {
				$(tbody).append(makeCdRow(list[i], i));
			}
		}
	})	
};

/*
 * 대분류 코드 정보 불러오기
 */

function getCommonGp(data) {
	$.ajax({
		method : 'POST',
		url : '/manage/getCommonGp.do',
		data : data,
		dataType : 'json',
		success : (obj) => {
			makeForm(obj);
		}
	})
}

/*
 * 중복 이름 체크
 */
function duplicateGpName(gpCode) {
	let flag = true;
	$.ajax({
		method : 'POST',
		url : '/manage/getCommonGp.do',
		data : {gpCode : gpCode},
		async : false,
		dataType : 'json',
		success : function(obj) {
			if (obj != null) {
				fireAlert("중복된 코드명이 있습니다.", 2);
				flag = false;
			}
		}
	})
	return flag;
}

function duplicateCdName(data) {
	let flag = true;
	$.ajax({
		method : 'POST',
		url : '/manage/getCommonCd.do',
		data : data,
		async : false,
		dataType : 'json',
		success : function(obj) {
			if (obj != null) {
				fireAlert("동일 대분류 내에<br> 중복된 코드명이 있습니다.", 2);
				flag = false;
			}
		}
	});
	return flag;
}



/*
 * 소분류 코드 정보 불러오기
 */

function getCommonCd(data) {
	$.ajax({
		method : 'POST',
		url : '/manage/getCommonCd.do',
		data : data,
		dataType : 'json',
		success : (obj) => {
			makeForm(obj);
		}
	})
}



/*
 * 코드 생성
 */
function insertCodeAjax(elem) {
	$.ajax({
		method : 'POST',
		url : (elem.hasOwnProperty("cdCode")) ? '/manage/insCode.do' : '/manage/insGroup.do',
		data : JSON.stringify(elem),
		contentType : 'application/json',
		dataType : 'json',
		success : (msg) => {
			if (msg == "success") {
				fireAlert("코드 생성이 완료되었습니다.", 8);
				loadFragment();
				clearInsForm();
				if ($("#insertModal").find("form").not(".d-none").attr("id") == "insertGpForm") {
					closeInsertModal();
				}
				let gpCode = $(".code-table input[name='gpCode']").val();
				if (gpCode != null) {
					getCdList(gpCode);
				}
				
			}
		}
	})
}

/*
 * 소분류 코드 순서 변경
 */
function updateOrderAjax(arr) {
	$.ajax({
		method : 'POST',
		url : '/manage/updCode.do',
		data : JSON.stringify(arr),
		contentType : 'application/json',
		dataType : 'json',
		success : (msg) => {
			if (msg == "success") {
				fireAlert("변경이 완료되었습니다!", 8);
				loadFragment();
				let gpCode = $(".code-table input[name='gpCode']").val();
				if (gpCode != null) {
					getCdList(gpCode);
				}
			} 
		}
	})
}

/*
 * 대분류 코드 변경
 */
function updGpAjax(tr, elem) {
	$.ajax({
		method : 'POST',
		url : '/manage/updGroup.do',
		data : JSON.stringify(elem),
		contentType : 'application/json',
		dataType : 'json',
		success : (msg) => {
			if (msg == 'success') {
				fireAlert("변경이 완료되었습니다!", 8);
				loadFragment();
			}
		}
	})
}

/*
 * 종속 소분류 코드 찾기
 */
function getCommonCdCnt(data) {
	let cntList = null;
	$.ajax({
		method : 'POST',
		url : '/manage/getCommonCdCnt.do',
		data : JSON.stringify(data),
		async : false,
		contentType : 'application/json',
		dataType : 'json',
		success : function(list) {
			cntList = list;
		}
	});
	return cntList;
}

/*
 * 코드 삭제
 */
function delCodeAjax(data) {
	$.ajax({
		method : 'POST',
		url : (data[0].hasOwnProperty('cdCode')) ? '/manage/delCode.do' : '/manage/delGroup.do',
		data : JSON.stringify(data),
		contentType : 'application/json',
		dataType : 'json',
		success : function(deleteRow) {
			if (deleteRow == data.length) {
				fireAlert("삭제가 완료되었습니다!", 8);
				loadFragment();
				clearUpdForm();
				let gpCode = $(".code-table input[name='gpCode']").val();
				if (gpCode != null) {
					getCdList(gpCode);
				}
			} 
		}
	});
}

function loadFragment() {
	$("#common-code-table").load(location.href + ' #common-code-table');
	$("#common-code-tree").load(location.href + ' #common-code-tree');
	$("#common-modal").load(location.href + " #common-modal");
}

function clearInsForm() {
	$("#insertGpForm")[0].reset();
	$("#insertCdForm")[0].reset();
}

function clearUpdForm() {
	$("#groupForm")[0].reset();
	$("#codeForm")[0].reset();
}
