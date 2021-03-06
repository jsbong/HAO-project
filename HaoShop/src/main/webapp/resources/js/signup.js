var checkID = false;
var checkPWD = false;
var checkYEAR = false;
var checkNAME = false;
var checkEMAIL = false;

$(document).ready(function() {
	$("#m_id").blur(function() {
		var m_id = $("#m_id").val();
		var oMsg = $("#idchk");
		if (!m_id) {
			swal("", "아이디를 입력해주세요.", "error");
			$("#idchk").text("");
		} else {
			$.ajax({
				type : "POST",
				url : "checkID",
				data : {
					"m_id" : m_id
				},
				success : function(data) {
					if (data == 0) {
						oMsg.css("color", "green");
						oMsg.text("사용 가능한 아이디입니다.");
						checkID = true;
					} else if (data != 0) {
						$("#idchk").css("color", "red");
						$("#idchk").text("이미 존재하는 아이디입니다.");
						checkID = false;
					} else { console.log('ERROR'); }
				}, error : function(error) { swal("", m_id, "error"); }
			});
		}
	});
	
	$("#m_pwd").keyup(function() {
		$("#checkPasswd").text("");
	});
	
	$("#chk_m_pwd").keyup(function() {
		var checkText = $("#checkPasswd");
		if ($("#m_pwd").val() == "" || $("#chk_m_pwd").val() == "") {
			checkText.css("color", "red");
			checkText.text("필수정보입니다.");
			checkPWD = false;
		} else if ($("#m_pwd").val() != $("#chk_m_pwd").val()) {
			checkPWD = false;
			checkText.text("패스워드가 동일하지 않습니다.");
			checkText.css("color", "red");
		} else {
			checkPWD = true;
			checkText.text("패스워드가 동일합니다.");
			checkText.css("color", "green");
		}
	});
	
	$("#email_select").change(function() {
		if ($("#email_select").val() == "1") {
			$("#email_addr").val("");
			$("#email_addr").prop("disabled", false);
		} else if ($("#email_select").val() == "") {
			$("#email_addr").val("");
			$("#email_addr").prop("disabled", true);
		} else {
			$("#email_addr").val($("#email_select").val());
			$("#email_addr").prop("disabled", true);
		}
	});
	
	if ($("#birth_year").val() != "") {
		checkBirth();
	};
	
	$("#birth_year").blur(function() {
		checkBirth();
	});
	
	$("#birth_month").blur(function() {
		checkBirth();
	});
	
	$("#birth_day").blur(function() {
		checkBirth();
	});
	
	$("#m_name").blur(function() {
		checkName();
	});
})

function doSignup() {
	var m_id = $("#m_id").val();
	var m_pwd = $("#m_pwd").val();
	var m_name = $("#m_name").val();
	var m_birth = $("#birth_year").val() + "-" + $("#birth_month").val() + "-" + $("#birth_day").val();
	var m_email = $("#email_id").val() + "@" + $("#email_addr").val(); 
	var m_phone = $("#NUMst").val() + "-" + $("#NUMnd").val() + "-" + $("#NUMrd").val();
	var m_addr = $("#m_zipcode").val() + "*" + $("#m_faddr").val() + "*" + $("#m_laddr").val();
	var authkey = $("#authkey").val();
	var patt_pwd = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;
	if (checkID == false) { console.log("아이디 중복검사 안함"); }
	if (checkPWD == false) { console.log("비밀번호 다름"); }
	if (checkNAME == false) { console.log("이름이 비어있음"); }
	if (checkYEAR == false) { console.log("생일이 비어있음"); }
	if (checkEMAIL == false) { console.log("이메일 인증 안함"); }
	if (!m_id || checkID == false || checkPWD == false || checkNAME == false || checkYEAR == false || checkEMAIL == false) {
		swal("", "필수항목이 비어있습니다. 입력해주세요.", "warning");
	} else {
		if(patt_pwd.test(m_pwd)) {
			$.ajax({
				type : "POST",
				url : "join",
				data : {
					"m_id" : m_id,
					"m_pwd" : m_pwd,
					"m_name" : m_name,
					"m_email" : m_email,
					"m_birth" : m_birth,
					"m_phone" : m_phone,
					"m_addr" : m_addr,
					"authkey" : authkey
				},
				success : function(data) {
					swal("", "회원가입을 축하합니다.", "success").then(function(isConfirm) {
						window.location.href="main";
					});
				}
			});
		} else {
			swal("", "회원가입 양식에 맞춰 입력해주세요.", "warning");			
		}
	}
}

function emailChk() {
	var m_email = $("#email_id").val() + "@" + $("#email_addr").val();
	if (m_email.length == 1) {
		swal("", "이메일을 입력해주세요.", "error");
	} else {
		$(".input_title").removeClass("hideme");
		$(".input_content").removeClass("hideme");
		swal("", "이메일이 발송되었습니다", "success");
		$.ajax({
			type : "POST",
			url : "joinPost",
			data : {"m_email" : m_email}, 
			error : function(error) {}
		});
	}
}

function matchCode() {
	var authkey = $("#authkey").val();
	var oMsg = $("#mailChk");
	if (!authkey) {
		swal("", "인증번호를 입력하세요", "error");
	} else {
		oMsg.text("");
		$.ajax({
			type : "POST",
			url : "joinConfirm",
			success : function(data) {
				if (data == authkey) {
						oMsg.css("color", "green");
						oMsg.text("인증 완료");
						checkEMAIL = true;
				} 
				else { 
					oMsg.css("color", "red");
					oMsg.text("인증 실패");
					checkEMAIL = false;
				}
			}, error : function(error) { swal("", "오류 발생", "error"); }
		});
	}
}



function checkBirth() {
	var birthDay;
	var yy = $("#birth_year").val();
	var mm = $("#birth_month").val();
	var dd = $("#birth_day").val();
	var oMsg = $("#birchk");
	
	if (yy == "" && mm == "" && dd == "") {
		oMsg.css("color", "red");
		oMsg.text("태어난 년도 4자리를 정확히 입력해주세요");
		return false;
	}
	
	if (mm.length == 1) {
		mm = "0" + mm;
	}
	
	if (dd.length == 1) {
		dd = "0" + dd;
	}
	
	if(yy == "") {
		oMsg.css("color", "red");
		oMsg.text("태어난 년도를 선택하세요");
		return false;
	}
	
	if(mm == "") {
		oMsg.css("color", "red");
		oMsg.text("태어난 월을 선택하세요");
		return false;
	}
	
	if(dd == "") {
		oMsg.css("color", "red");
		oMsg.text("태어난 일(날짜) 2자리를 정확히 입력하세요.");
		return false;
	}
	
	if(dd.length != 2 || dd.indexOf('e') != -1 || dd.indexOf('E') != -1) {
		oMsg.css("color", "red");
		oMsg.text("태어난 일(날짜) 2자리를 정확히 입력하세요.");
		return false;
	}
	
	birthDay = yy + mm + dd;
	if(!isValidDate(birthDay)) {
		oMsg.css("color", "red");
		oMsg.text("생년월일을 다시 확인해주세요.");
		return false;
	}
	
	var age = calcAge(birthDay);
	
	if(age < 0) {
		oMsg.css("color", "red");
		oMsg.text("외계인이신가요");
		return false;
	} else if (age >= 100) {
		oMsg.css("color", "red");
		oMsg.text("정말이신가요?");
		return false;
	} else if (age < 14) {
		oMsg.css("color", "red");
		oMsg.text("만 14세 미만의 어린이는 가입할 수 없습니다.");
		return false;
	} else {
		checkYEAR = true;
		oMsg.text("");
		return true;
	}
	checkYEAR = true;
	return true;
}

function calcAge(birth) {
	var date = new Date();
	var year = date.getFullYear();
	var month = (date.getMonth() + 1);
	var day = date.getDate();
	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	var monthDay = month + "" + day;
	
	birth = birth.replace("-", "").replace("-", "");
	var birthdayy = birth.substr(0, 4);
	var birthdaymd = birth.substr(4, 4);
	
	var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
	console.log("age: " + age);
	return age;
}

function isValidDate(param) {
	try {
		param = param.replace(/-/g, "");
		
		if(isNaN(param) || param.length != 8) {
			return false;
			checkYEAR = false;
		}
		
		var year = Number(param.substring(0, 4));
		var month = Number(param.substring(4, 6));
		var day = Number(param.substring(6, 8));
		
		if (month < 1 || month > 12) {
			return false;
			checkYEAR = false;
		}
		
		var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var maxDay = maxDaysInMonth[month - 1];
		
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
			maxDay = 29;
		}
		
		if (day <= 0 || day > maxDay) {
			return false;
			checkYEAR = false;
		}
		return true;
		checkYEAR = true;
	} catch (err) {
		checkYEAR = false;
	}
}

function checkName() {
	var oMsg = $("#chkname");
	var nonchar = /[^가-힣a-zA-Z0-9]/gi;
	
	var name = $("#m_name").val();
	if (name == "") {
		oMsg.css("color", "red");
		oMsg.text("필수정보입니다.");
		return false;
	}
	
	if (name != "" && nonchar.test(name)) {
		oMsg.css("color", "red");
		oMsg.text("한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
		return false;
	}
	checkNAME = true;
	oMsg.text("");
	return true;
}

function searchPost() {
	new daum.Postcode({
		oncomplete : function(data) {
			var fullAddr = '';
			var extraAddr = '';

			if (data.userSelectedType == 'R') {
				fullAddr = data.roadAddress;
			} else {
				fullAddr = data.jibunAddress;
			}
			if (data.userSelectedType == 'R') {
				if (data.bname !== '') {
					extraAddr += data.bname;
				}
				if (data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				fullAddr += (extraAddr !== '' ? '(' + extraAddr + ')' : '');
			}
			document.getElementById('m_zipcode').value = data.zonecode;
			document.getElementById('m_faddr').value = fullAddr;
			document.getElementById('m_laddr').focus();
		}
	}).open();
}