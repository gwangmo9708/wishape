<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script>

	function categoryReset(){
		allSmallCategory();
	}
	
	function sortSmallCategory(){
		
		var bigCategory = document.getElementById("bigCategoryBox").value;
		var smallCategoryBox = document.getElementById("smallCategoryBox");
		
		if(bigCategory == "대분류"){
			smallCategoryBox.innerHTML = "";
			
			var smallOption = document.createElement("option");
			smallOption.setAttribute("selected", "selected");
			smallOption.innerText = "소분류";
			smallCategoryBox.appendChild(smallOption);
			return;
				
		}
		console.log(bigCategory);
		
		// Ajax 사용.
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var smallCategoryBox = document.getElementById("smallCategoryBox");
				
				smallCategoryBox.innerHTML = "";
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(smallCategory of data.smallCategoryList){
					
					var smallOption = document.createElement("option"); 
					smallOption.setAttribute("value", smallCategory.no);
					smallOption.innerText = smallCategory.small_name;
					
					smallCategoryBox.appendChild(smallOption);
					
				};
			}
		};
		
		xmlhttp.open("get" , "../member/sortSmallCategory.do?big_category_no="+bigCategory); 
		xmlhttp.send();
		
	}
	
	function allSmallCategory(){
		
		// Ajax 사용.
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var smallCategoryBox = document.getElementById("smallCategoryBox");
				
				smallCategoryBox.innerHTML = "";
				
				var smallOption = document.createElement("option");
				smallOption.setAttribute("selected", "selected");
				smallOption.innerText = "소분류";
				smallCategoryBox.appendChild(smallOption);
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(smallCategory of data.allSmallCategoryList){
					
					var smallOption = document.createElement("option"); 
					smallOption.setAttribute("value", smallCategory.no);
					smallOption.innerText = smallCategory.small_name;
					
					smallCategoryBox.appendChild(smallOption);
					
				};
			}
		};
		
		xmlhttp.open("get" , "../member/allSmallCategory.do"); 
		xmlhttp.send();
		
	}

	
	
	// 회원가입 버튼 눌렀을 때 예외처리.
	function joinMemberProcess() {
		
		
		// 아이디 중복 체크 확인.
		var idCheck = /^[가-힝a-zA-Z0-9]{3,12}$/;
		var idBox = document.getElementById("idBox");
		var id = document.getElementById("id");
		
		if(idBox.innerText == "이미 존재하는 아이디 입니다.") {
			
			alert("아이디 중복을 확인해주세요.");
			idBox.scrollIntoView();
			id.focus();
			return;
		}
		
		if(id.value == "" || id.value == null){
			
			alert("아이디를 입력해 주세요.")
			idBox.scrollIntoView();
			id.focus();
			return;
		}
		
		if(!idCheck.test(id.value)) {
			
			alert("아이디 형식이 잘못됐습니다 - 특수문자 사용금지, 3~12글자 사용.")
			idBox.scrollIntoView();
			id.focus();
			return;
		}
	
		
		
	
		// 비밀번호 일치 확인.
		var pwCheck = /^[a-zA-Z0-9]{4,12}$/;
		var pw = document.getElementById("pw1");
		var pw2 = document.getElementById("pw2");

		if(pw.value != pw2.value) {
			
			alert("비밀번호가 일치하지 않습니다.")
			pw.value = "";
			pw2.value = "";
			pw.focus();
			pw.scrollIntoView();
			return;
			
		} else if(pw.value == "" || pw.value == null) {
			
			alert("비밀번호를 입력해주세요.")
			pw.value = "";
			pw2.value = "";
			pw.focus();
			pw.scrollIntoView();
			return;
			
		}
		
		if(!pwCheck.test(pw.value)){
			
			alert("비밀번호 형식이 잘못됐습니다 - 특수문자 사용금지, 3~12글자 사용.")
			pw.focus();
			pw.scrollIntoView();
			return;
			
		}
		
		
		
		
		// 이름 확인.
		var nameCheck = /^[가-힝a-zA-Z]{2,}$/;
		var name = document.getElementById("name");
		
		if(!nameCheck.test(name.value)) {
			
			alert("이름이 잘못 입력되었습니다.");
			name.focus();
			name.scrollIntoView();
			return;
		}
		
		
		
		// phone 체크.
		var phoneCheck = /^\d{3}-\d{3,4}-\d{4}$/;
		var phone = document.getElementById("phone");
		
		
		if(!phoneCheck.test(phone.value)){
			
			alert("핸드폰 형식이 잘못됐습니다 - 예 : 010-1234-5678")
			phone.focus();
			phone.scrollIntoView();
			return;
			
		}
		

		
		
		// 이메일 체크.
		var mailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
		
		var email = document.getElementById("email");
		
		if(!mailCheck.test(email.value)) {
			
			alert("이메일 형식이 잘못 입력되었습니다.");
			email.focus();
			email.scrollIntoView();
			return false;
		
		}
		
		
		
		// 성별 체크.
		var woman = document.getElementById("woman");
		var man = document.getElementById("man");
		var gender = null;
		
		var womanChecked = woman.checked
		var manChecked = man.checked
		//console.log(womanChecked);
		//console.log(manChecked);
		
		if(womanChecked == false && manChecked == false) {
			
			alert("성별을 선택해주세요.");
			woman.focus();
			woman.scrollIntoView();
			return;
			
		} else if(womanChecked == true){
			
			gender = woman.value;
			//console.log(gender);
			
		} else if(manChecked == true) {
			
			gender = man.value;
			//console.log(gender);
		} 
	
		
		
		
		// birth 체크.
		var birthCheck = /^[0-9]{6}$/
		var birth = document.getElementById("birth");
		
		if(!birthCheck.test(birth.value)){
			
			alert("주민번호 형식이 잘못됐습니다 - 예 : 951231")
			birth.focus();
			birth.scrollIntoView();
			return;
		}
		
		
		
		// category 체크.
		var smallCategoryBox = document.getElementById("smallCategoryBox");
		var small_category_no = null;
		
		if(smallCategoryBox.value == "소분류"){
			
			alert("카테고리를 선택해주세요(필수)")
			smallCategoryBox.focus();
			smallCategoryBox.scrollIntoView();
			return;
			
		} else {
			
			small_category_no = smallCategoryBox.value;
			// console.log(small_category_no);
		}
		
		
		
		// 약관 동의 체크.
		var confirmTOS = document.getElementById("confirmTOS");
		
		if(confirmTOS.checked == false){
			
			alert("약관을 읽어보신 후 체크를 눌러주세요.")
			confirmTOS.focus();
			confirmTOS.scrollIntoView();
			return;
			
		}
		
		
		var joinProcessForm = document.getElementById("joinProcessForm");
		
		joinProcessForm.submit();
		
		
	}
	
	
	// 아이디 중복 확인.
	function checkId() {
		
		
		var idInput = document.getElementById("id"); 
		var idBox = document.getElementById("idBox");

		var idCheck = /^[가-힝a-zA-Z0-9]{3,12}$/;
		
		
		if(!idCheck.test(idInput.value)) {
			
			idBox.innerText = "";
			idBox.innerText = "아이디 오류 - 3~12글자, 특수문자 사용금지."
			idBox.setAttribute("style", "color:#DC143C;");
			return;
			
		}
		
		
		var xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function(){
			
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				idBox.innerText = "";
				
				var data = JSON.parse(xmlhttp.responseText);
				
				if(data.memberVo == null || data.memberVo == ""){
					
					idBox.innerText = "사용가능한 아이디입니다."
					idBox.setAttribute("style", "color:blue;");
					
				} else {
					
					
					idBox.innerText = "이미 존재하는 아이디 입니다."
					idBox.setAttribute("style", "color:#DC143C");
					idInput.focus();
					idInput.scrollIntoView();
					return;
					
				}
			
			}
		};
		
		xmlhttp.open("get" , "./checkId.do?id="+idInput.value);
		xmlhttp.send();
		
	}
	
	
	
	function init(){
		
		var bigCategory = document.getElementById("bigCategoryBox").value;
		var smallCategoryBox = document.getElementById("smallCategoryBox");
		
		if(bigCategory == "대분류"){
			smallCategoryBox.innerHTML = "";
			
			var smallOption = document.createElement("option");
			smallOption.setAttribute("selected", "selected");
			smallOption.innerText = "소분류";
			smallCategoryBox.appendChild(smallOption);
			return;
			
		}	
	
			
	}
		
	// 문서 onload API.
	window.addEventListener('DOMContentLoaded', init);
	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
	<div style="width:900px; margin:0 auto;">
		<div class="container-fluid">
			<div class="row mt-5">
				<div class="col mt-4">
					<div class="row">	
						<div class="col">	
							<div class="text-center fs-1 fw-bold" style="color:#0064FF; text-shadow: 1.5px 1.5px 5px #87CEEB;">WISHAPE</div>
							<div class="pt-3">
								<hr>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col"></div>
						<div class="col-5 mt-3">
							<div class="col" id="idBox"></div>
							<div class="card shadow-sm mt-2 bg-secondary p-1">
								<div class="row">
									<div class="col text-center text-white">
										아이디
									</div>
								</div>
							</div>
							<form action="./joinMemberProcess.do" id="joinProcessForm" method="post">
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm"  type="text" name="id" id="id" placeholder="아이디" onblur="checkId()">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											비밀번호
										</div>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm" type="password" name="pw" id="pw1" placeholder="비밀번호">
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm" type="password" id="pw2" placeholder="비밀번호 확인">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											이름
										</div>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm" type="text" name="name" id="name" placeholder="본명을 입력해주세요">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											휴대폰 번호
										</div>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm" type="text" name="phone" id="phone" placeholder="핸드폰 번호를 입력해주세요">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											이메일
										</div>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="form-control shadow-sm" type="email" name="email" id="email" placeholder="이메일 주소를 입력해주세요">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											성 별
										</div>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<div class="form-control shadow-sm">
											<div class="row">
												<div class="col text-center">
													<input class="form-check-input" type="radio" name="gender" id="woman" value="w" placeholder="여자"> 여자
												</div>
												<div class="col text-center">
													<input class="form-check-input" type="radio" name="gender" id="man" value="m" placeholder="남자"> 남자
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											주민등록번호 앞자리
										</div>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col">
										<input class="form-control shadow-sm" type="text" name="birth" id="birth" placeholder="주민번호 6자리를 입력해주세요">
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-4">
									<div class="row">
										<div class="col text-center text-white">
											선호 카테고리
										</div>
									</div>
								</div>
								<div class="row mt-2">
									<div class="col">
										<select id="bigCategoryBox" class="form-select shadow-sm" aria-label="Default select example" onchange="sortSmallCategory()">
											<option selected value="대분류">대분류</option>
											<c:forEach items="${bigList }" var="data">
												<option value="${data.no }">${data.big_name }</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<select id="smallCategoryBox" name="small_category_no" class="form-select shadow-sm"  aria-label="Default select example"><!-- 아직 구현 안함 -->
												<option selected value="소분류">소분류</option>
												<c:forEach items="${smallList }" var="data">
													<option value="${data.no }">${data.small_name }</option>
												</c:forEach>
										</select>
									</div>
								</div>
								<div class="card shadow-sm mt-2 bg-secondary p-1 mt-5">
									<div class="row">
										<div class="col text-center text-white">
											개인정보 수집 및 이용 동의 (필수)
										</div>
									</div>
								</div>
								<div class="card shadow-sm mt-2 p-2">
									<div class="row p-3">
										<div class="col">
											개인정보보호법에 따라 WISHAPE에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
										</div>
									</div>
									<div class="row px-3 pb-2 pt-1">
										<div class="col text-end">
											<input id="confirmTOS" type="checkbox"> 약관 동의
										</div>
									</div>
								</div>
								<div class="row mt-5">
									<div class="col">
										<input class="btn btn-primary form-control shadow-sm" type="button" value="회원가입" onclick="joinMemberProcess()">
									</div>
								</div>
								<div class="row mt-1">
									<div class="col">
										<input class="btn btn-secondary form-control shadow-sm" type="button" value="다시 작성하기" onclick="resetWrite()">
									</div>
								</div>
							</form>
							<div class="row mt-3 mb-5">
								<div class="col">
									<a href="/shape/member/login.do">로그인 페이지로 이동</a>
								</div>
							</div>
							
						</div>
						<div class="col"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 줄맞추기 -->
	<div style="width:1200px;" class="row">
		<div class="col mt-5"></div>
	</div>
	
	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>