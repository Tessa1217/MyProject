function linkPage(pageIndex) {
	let pageURL = '/board/boardList.do' + baseQueryString() + '&pageIndex=' + pageIndex;
	if (location.search.indexOf("&recordCountPerPage") > 0) {
		pageURL += location.search.substr(location.search.indexOf("&recordCountPerPage")); 
	} else {
		pageURL += '&recordCountPerPage=10&searchCnd=&searchKeyword=';
	}
	location.href=pageURL;
}

function baseQueryString() {
	let variable = new Object({
		boardTypeNo : $("input[name='boardTypeNo").val(),
		bulletinNo : $("input[name='bulletinNo").val()
	})
	return "?" + decodeURI($.param(variable)); 
}
	
function searchPage(pageIndex) {
	const form = $(".pageSearchForm");
	if ($(form).find("select[name='searchCnd']").val() != '' && $(form).find("input[name='searchKeyword']").val().trim() == '') {
		fireAlert("검색어를 입력해주세요!", 2);
		return;
	}
	if ($(form).find("select[name='searchCnd']").val() == 'USER_ID' && $(form).find("input[name='searchKeyword']").val().indexOf(' ') > -1) {
		fireAlert("작성자 검색 시 공백 없이 입력해주세요!", 2);
		return;
	}
	location.href='/board/boardList.do' + baseQueryString() + "&" + queryString(pageIndex);
}

function searchCondition() {
	if ($(".pageSearchForm").find("select[name='searchCnd']").val() == '') {
		$(".pageSearchForm").find("input[name='searchKeyword']").addClass("d-none");
	} 

	$(".pageSearchForm").find("select[name='searchCnd']").change(function() {
		let input = $(".pageSearchForm").find("input[name='searchKeyword']");
		
		if ($(input).val() != '') {
			$(input).val('');
		}
		
		if ($(this).val() == '') {
			$(input).addClass("d-none");
			return;
		} 
		
		if ($(this).val() != '') {
			$(input).removeClass("d-none");
			return;
		}
		
	})
};
	
function loadFile(list) {
	let maxFileCnt = 5;
	let attFileCnt = $(".file-list li").length;
	let curFileCnt = list.files.length;
	let fileList = list.files;

	if (curFileCnt > (maxFileCnt - attFileCnt)) {
		alert("첨부파일은 최대 " + maxFileCnt + "개까지 첨부 가능합니다.");
		$("input[name='files']").val('');
		return;
	}

	for (let i = 0; i < fileList.length; i++) {
		
		let file = fileList[i];
		if (fileValidation(file)) {

			let reader = new FileReader();

			reader.onload = function(event) {
				fArray.push(file);
				let div = $("<div/>").attr("id", "file-preview-" + i).attr(
						"class", "px-1");
				let imgTitle = $("<span/>").text(file.name).attr("class",
						"d-block");
				let img = $("<img/>").attr({
					"src" : event.target.result,
					"height" : "200px",
					"width" : "300px"
				})
				$(div).append(imgTitle).append(img).appendTo($(".preview"));
			}

			reader.readAsDataURL(file);

			let span = $("<span/>").text(file.name);

			let radio = $("<input/>").attr("class",
					"form-check-input me-1 new-file").attr("type", "radio")
					.attr("name", "thumbnail").attr("value", fileNo);

			$(radio).change(
					function() {
						$("input[name='thumbnailIdx']").val(
								"newOrder="
										+ $("input[name='thumbnail'].new-file")
												.index(this));
					})

			let button = $("<button/>").attr("type", "button").attr("class",
					"mx-2 btn btn-sm btn-close btn-danger float-end").text("");

			$(button).on("click", function() {
				deleteFile(i);
			});

			let li = $("<li/>").attr("id", "file-" + (i + 1)).attr("class",
					"list-group-item bg-light").append(radio).append(span)
					.append(button).appendTo(".file-list");

			fileNo++;

		} else {
			$("input[name='files']").val('');
			return;
		}
	}

	$("input[name='files']").val('');

}

function contentValidation() {
	if ($("input[name='boardTitle']").val() == '') {
		alert("제목을 입력해주세요.");
		return false;
	}
	if ($("input[name='boardTitle']").val().length > 100) {
		alert("제목은 100자 이내로 입력 가능합니다.");
		return false;
	}
	if ($("textarea[name='boardContent']").val() == '') {
		alert("내용을 입력해주세요.");
		return false;
	}
	return true;
}

function fileValidation(file) {
	const imageTypes = [ 'image/gif', 'image/jpeg', 'image/png', 'image/jpg' ];
	if (file.name.length > 150) {
		alert("파일명은 최대 150자입니다.");
		return false;
	} else if (file.size > (100 * 1024 * 1024)) {
		alert("업로드 가능한 최대 용량은 100MB 입니다.");
		return false;
	} else if (file.name.lastIndexOf('.') < 0) {
		alert("확장자가 없는 파일은 첨부하실 수 없습니다.");
		return false;
	} else if (!imageTypes.includes(file.type)) {
		alert("이미지 파일만 첨부 가능합니다.");
		return false;
	}
	return true;
}

function deleteFile(fileNum) {
	if ($("#file-" + (fileNum + 1)).find("input[name='thumbnail']").is(":checked")) {
		$("input[name='thumbnailIdx']").val('-1');
	}
	$("#file-" + (fileNum + 1)).remove();
	$("#file-preview-" + fileNum).remove();
	fArray[fileNum].is_deleted = true;
}

function queryString(searchIndex) {
	let variable = new Object({
		pageIndex : searchIndex,
		recordCountPerPage : $("select[name='recordCountPerPage']").val(),
		searchCnd : $(".pageSearchForm").find("select[name='searchCnd']").val(),
		searchKeyword : $(".pageSearchForm").find("input[name='searchKeyword']").val()
	})
	let str = decodeURI($.param(variable));
	console.log(str);
	return str;
}

function makeTag() {
	$("input[name='tags").on("keyup", function (e) {
        if (e.keyCode == 32) {
          if (tagCnt > 4) {
            alert("태그는 최대 5개까지만 입력 가능합니다.");
            $(this).val("");
            return;
          }
          if ($(this).val() == "") {
            alert("태그 내용을 입력해주세요.");
            return;
          }

          let span = $("<span/>")
            .text("#" + $(this).val().trim())
            .attr("class", "badge rounded-pill bg-primary text-white p-2");
          let button = $("<button/>")
            .attr("class", "btn-sm btn-close")
            .attr("aria-label", "Close")
            .attr("type", "button")
            .on("click", function () {
              let removeIdx = $(this).parents("li").attr("id").substring(4);
              tagString.splice(removeIdx, 1);
              tagCnt--;
              $(this).parents("li").remove();
            });

          let idx = tagCnt;

          let li = $("<li/>")
            .attr(
              "class",
              "list-group-item border-light bg-light d-flex align-items-center"
            )
            .attr("id", "tag-" + idx)
            .append(button)
            .append(span)
            .appendTo(".tagList");

          tagString.push($(this).val().trim());
          tagCnt++;

          $(this).val("");
        }
      });
}

/*
 * iconType : 1번, 6번 (success), 2번, 3번, 4번(warning), 2번은 문항 체크 오류/3번은 설문조사 기간 아닐
 * 때 /4번은 비회원이 회원 설문조사 접근
 */
function fireAlert(msg, iconType) {
	let timeInterval;
	Swal.fire({
		html : '<h3>' + msg + '</h3>',
		icon : ((iconType == 1) || (iconType == 6) || (iconType == 7) || (iconType == 8)) ? 'success' : ((iconType == 2) ? 'warning' : 'error'),
		timer : 1000,
		showConfirmButton : false
	}).then((result) => {
		if (result.dismiss === Swal.DismissReason.timer) {
			if (iconType == 1 || iconType == 3) {
				location.href="/survey/surveyList.do";
			} else if (iconType == 4) {
				location.href="/login.do";
			} else if (iconType == 5 || iconType == 6) {
				location.href="/home/home.do";
			} else if (iconType == 7) {
				location.reload();
			} 
			
		}
	});
}

function openNewWindow(page, boardNo, boardTypeNo, bulletinNo) {
	window.name = "boardList";
	let popupName = "boardRegister";
	
	let requestURL = ""; 
	if (boardTypeNo == '' && bulletinNo == '') {
		requestURL = "/board/" + page + ".do" + baseQueryString();
	} else {
		requestURL = "/board/" + page + ".do?boardTypeNo=" + boardTypeNo + "&bulletinNo=" + bulletinNo;
	}
	if (boardNo > 0) {
		requestURL += "&boardNo=" + boardNo;
	}
	let popupX = (window.screen.width/2) - 400;
	let popupY = (window.screen.height/2) - 400;
	window.open(requestURL, popupName, 'status=yes, height=800, width=1000, left=' + popupX + ', top=' + popupY + ', screenX=' + popupX + ', screenY=' + popupY);
}

let editor;

function generateEditor(id) {
	CKEDITOR.replace(id, {
		'filebrowserImageUploadUrl' : '/board/editorFileUpload.do',
		'extraPlugins' : 'image2,uploadimage',
		'uploadUrl' : '/board/editorFileUpload.do'
	});
}

function editorOption(id) {
/*	return {
		filebrowserImageUploadUrl : '/board/editorFileUpload.do'
	}*/
	/*
	 * return { language : "ko", updateSourceElementOnDestroy: true, plugins:
	 * ['CKbox'], toolbar: { items : ['heading', '|', 'bold', 'italic', 'link',
	 * 'bulletedList', 'numberedList', '|', 'outdent', 'indent', '|',
	 * 'blockQuote', 'insertTable', 'undo', 'redo', '|', 'ckbox'] }, ckbox : {
	 * defaultUploadCategories : { Bitmaps: ['bmp'], Pictures : ['jpg', 'jpeg'],
	 * Scans: ['png', 'tiff'] }, ignoreDataId: true } }
	 */
}
