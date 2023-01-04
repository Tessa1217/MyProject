
const codeRegex = /[~!@#$%^&*()+|<>?:{}\s]/g; 

function searchFormCheck(form) {
	if ($(form).find("select[name='searchCnd']").val() != "") {
		let input = $(form).find("input[name='searchKeyword']").val();
		if ($(input).val().trim() == '') {
			fireAlert("검색어를 입력해주세요.", 2);
			$("input[name='searchKeyword']").val('');
			return false;
		}
	}
	return true;
}

function insertFormCheck(form) {
	let reqInputList = $(form).find("input").not("[name$='Desc']").not("[name$='Date']");
	let flag = true;
	$(reqInputList).each((idx, input) => {
		
		if ($(input).attr("type") == "text" && $(input).attr("name").endsWith("Code")) {
			if ($(input).val().trim().match(codeRegex)) {
				fireAlert("밑줄 문자(_)를 제외한 공백, 특수문자는 들어갈 수 없습니다.", 2);
				flag = false;
				return;
			}
		}
		
		if ($(input).attr("name") == "gpCode" && $(form).attr("id") == "insertGpForm") {
			if ($(form).find("input[name='gpCode']").val() != $(form).find("input[name='oriGpCode").val()) {
				flag = duplicateGpName($(input).val().trim());
				if (!flag) {
					return;
				}
			}
		}
		
		if ($(input).attr("name") == "cdCode" && $(form).attr("id") == "insertCdForm") {
			if ($(form).find("input[name='cdCode']").val() != $(form).find("input[name='oriCdCode']").val()) {
				let data  = {
					cdCode : $(input).val().trim(),
					gpCode : $(input).parents("form").find("select[name='gpCode']").val()
				}
				flag = duplicateCdName(data);
				if (!flag) {
					return;
				}
			}
		}
		
		if ($(input).val().trim() == "") {
			fireAlert($(input).siblings("label").text() + "를 입력해주세요", 2);
			$(input).val('');
			flag = false;
			return;
		} 
		
	});
	
	if ($(form).find("textarea").val().trim() == '') {
		$(form).find("textarea").val('');
	}
	
	return flag;
}

function insertTdCheck(tr) {
	
	let flag = true;
	$(tr).find(".editable").not(".desc").each((idx, val) => {
		if ($(val).hasClass("code") && $(val).text().trim() != $(tr).data("code")) {
			if ($(val).text().trim().match(codeRegex) != null) {
				fireAlert("밑줄 문자(_)를 제외한 공백, 특수문자는 들어갈 수 없습니다.", 2);
				flag = false;
				return;
			}
			if ($(tr).hasClass("gp-code")) {
				flag = duplicateGpName($(val).text().trim());
			} else if ($(tr).hasClass("cd-code")) {
				let data = {
						cdCode : $(val).text().trim(),
						gpCode : $(tr).parents("table").find("input[name='gpCode']").val()
				}
				flag = duplicateCdName(data);
			}
			if (!flag) {
				return;
			}
		}
		
		if ($(val).text().trim() == '') {
			fireAlert($(tr).parents("table").find("th").eq(idx + 1).text() + "를 입력해주세요.", 2);
			flag = false;
			return;
		}
		
	});
	
	return flag;
	
}