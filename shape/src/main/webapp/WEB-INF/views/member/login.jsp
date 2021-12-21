<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script >


	// 세션시간 연장하기(아직 구현 X)
	function sessionLogin(){
		
		var sessionCheckBox = document.getElementById("sessionLoginBox");
		
		if(sessionCheckBox.getAttribute("class") == "bi bi-check-circle"){
			
			sessionCheckBox.innerHTML = "";
			sessionCheckBox.setAttribute("class", "bi bi-check-circle-fill");
			sessionCheckBox.setAttribute("style", "color:#0064FF");
			sessionCheckBox.setAttribute("id", "sessionLoginBox");
			
			return;
		}
		
		if(sessionCheckBox.getAttribute("class") == "bi bi-check-circle-fill"){
			
			sessionCheckBox.innerHTML = "";
			sessionCheckBox.setAttribute("class", "bi bi-check-circle");
			sessionCheckBox.setAttribute("style", "color:#323232;");
			sessionCheckBox.setAttribute("id", "sessionCheckBox");
			
			return;
		}
		
	}
	
	
	
	// 회원가입이 된 회원인지 확인하는 로직. 맞으면 로그인 완료.
	function checkMember(){
		
		var idBox = document.getElementById("id");
		var pwBox = document.getElementById("pw");
		
		if(idBox.value == "" || idBox.value == null) {
			
			alert("아이디를 입력해주세요.")
			return ;
		}
		if(pwBox.value == "" || pwBox.value == null) {
			
			alert("비밀번호를 입력해주세요.")
			return ;
		}
		
		var xmlhttp = new XMLHttpRequest();
	
		xmlhttp.onreadystatechange = function(){
			
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				if(data.memberVo == null || data.memberVo == ""){
					
					alert("등록되지 않은 아이디, 비밀번호입니다.")
					idBox.value ="";
					pwBox.value ="";
					
					return;
					
				} else {
					
					window.location.href = "./loginProcess.do?id="+idBox.value+"&pw="+ pwBox.value;
					
				}
			
			}
		};
		
		xmlhttp.open("get" , "./checkMember.do?id="+idBox.value+"&pw="+pwBox.value); 
		xmlhttp.send();
		
	}
	
	

</script>


<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
	<div style="width:850px; margin:0 auto;">
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
							<div class="row">
								<div class="col">
									<input class="form-control"  type="text" id="id" placeholder="아이디">
								</div>
							</div>
							<div class="row mt-1">
								<div class="col">
									<input class="form-control" type="password" id="pw" placeholder="비밀번호">
								</div>
							</div>
							<div class="row mt-3 ps-1">
								<div class="col">
									<i class="bi bi-check-circle" id="sessionLoginBox" onclick="sessionLogin()"></i>
									<label onclick="sessionLogin()">로그인 상태 유지하기</label>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<input class="btn btn-primary form-control" type="button" value="로그인" onclick="checkMember()">
								</div>
							</div>
							<div class="row mt-1">
								<div class="col">
									<a class="btn btn-secondary form-control" href="./joinMember.do">
										회원가입
									</a>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col">
									<a href="./findId.do">
										아이디 찾기
									</a>
								</div>
								<div class="col text-end">
									<a href="../wish/index.do">
										메인 페이지로 이동
									</a> 
								</div>
							</div>
						</div>
						<div class="col"></div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>