<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script>

	var today = new Date();


	function allCheck(no){
		
		console.log(no);
		
		var allCheckBox = document.getElementById("all"+no);
		
		console.log(allCheckBox);
		
		console.log(allCheckBox.checked);
		
		if(allCheckBox.checked == true) {
			
			document.getElementById("mon"+no).checked = true;
			document.getElementById("tue"+no).checked = true;
			document.getElementById("wed"+no).checked = true;
			document.getElementById("thur"+no).checked = true;
			document.getElementById("fri"+no).checked = true;
			document.getElementById("sat"+no).checked = true;
			document.getElementById("sun"+no).checked = true;
		
		} else {
			
			document.getElementById("mon"+no).checked = false;
			document.getElementById("tue"+no).checked = false;
			document.getElementById("wed"+no).checked = false;
			document.getElementById("thur"+no).checked = false;
			document.getElementById("fri"+no).checked = false;
			document.getElementById("sat"+no).checked = false;
			document.getElementById("sun"+no).checked = false;
			
		}
		
	}

	
	
	// header today 예외처리.
	function checkDate() {
		
		if(${empty user}){
			return;
		};

		console.log(today);
		if(today == null){
			return;
		};
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(mapList of data.wishRunTodoRunDateList) {
					for(todoRunDay of mapList.todoRunDateList) {
				
						console.log(todoRunDay);
						
						var formatDate = new Date(todoRunDay);
						var todoRunDate = getFormatDate(formatDate);
						
						var now = getFormatDate(today)
						
						console.log(todoRunDate);
						console.log(now);
						if(todoRunDate === now){
							return;
						};
					};
					
				};
				
				alert("오늘 일정이 없습니다.");
				window.location.href = "/shape/wish/index.do";
			}
		};
		
		xmlhttp.open("get" , "./getTodoRunDate.do");
		xmlhttp.send();
		
	}
	// header today 예외처리.
	function getFormatDate(date){
		
		// console.log(date);
		var year = date.getFullYear();
		var month = (date.getMonth()+1);
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		
		return year + "-" + month + "-" + day;
		
	}
	
	
	
	
	
	
</script>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>wishTodoRun Page</title>
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>

	<div class="container-fluid">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-2 px-5">
				<aside>
					<jsp:include page="../common/aside2.jsp"></jsp:include>
				</aside>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>
			<div class="col mx-5">
		
				<article>
					<div class="row">
						<div class="col text-center fs-4 fw-bold">
							<div class="shadow card card-body py-4">
								${map.wishVo.title} - 위시 실행하기
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="shadow card card-body p-5">
								<form action="/shape/wish/wishTodoRunProcess.do">
									<div class="card shadow-sm mx-5">
										<div class="row mt-4">
											<div class="col text-center fw-bold mt-2">
												일정 설정
											</div>
										</div>
										<div class="row mt-5">
											<div class="col-2"></div>
											<div class="col-4 text-center mt-1">
												위시 시작일
											</div>
											<div class="col-4 text-center">
												<input class="form-control btn-sm" type="date" name="start_date">
											</div>
											<div class="col-1"></div>
										</div>
										<div class="row mt-2">
											<div class="col-2"></div>
											<div class="col-4 text-center mt-1">
												위시 종료일
											</div>
											<div class="col-4 text-center">
												<input class="form-control btn-sm" type="date" name="end_date">
											</div>
											<div class="col-1"></div>
										</div>
										<div class="row mt-5"></div>
										<div class="row mt-5">
											<div class="col-1"></div>
											<div class="col text-center fw-bold">
												위시 실행 각오
											</div>
											<div class="col-1"></div>
										</div>
										<div class="row mt-5 mb-3">
											<div class="col-2"></div>
											<div class="col text-center mt-2">
												<textarea class="form-control" name="content" rows="4" placeholder="각오를 적어주세요!!"></textarea>
											</div>
											<div class="col-2"></div>
										</div>
										<div class="row mb-4"></div>
									</div>
									<c:forEach items="${map.todoVoList }" var="data">
										<div class="row mt-3"></div>
										<div class="row my-4">
											<hr>
										</div>
										<div class="card shadow-sm mx-5 py-3">
											<div class="row mt-4">
												<div class="col"></div>
												<div class="col-10">
													<div class="text-center fw-bold">
														투두 - ${data.title }
													</div>
													<input type="hidden" name="wish_no" value="${map.wishVo.no }">
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-5"></div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-end">
													<input class="form-check-input" type="checkbox" role="switch" id="mon${data.no }" name="mon" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 월요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="tue${data.no }" name="tue" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 화요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="wed${data.no }" name="wed" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 수요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="thur${data.no }" name="thur" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 목요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="fri${data.no }" name="fri" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 금요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="sat${data.no }" name="sat" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 토요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" type="checkbox" role="switch" id="sun${data.no }" name="sun" value="${data.no }">
												</div>
												<div class="col-2 text-end">
													매주 일요일
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-1">
												<div class="col"></div>
												<div class="col-1 form-check form-switch text-center">
													<input class="form-check-input" id="all${data.no }" type="checkbox" role="switch" onclick="allCheck(${data.no })">
												</div>
												<div class="col-2 text-end">
													<div class="me-2">모두 선택</div>
												</div>
												<div class="col"></div>
											</div>
											<div class="row mt-4"></div>
										</div>
									</c:forEach>
									<div class="row mt-3"></div>
									<div class="row mt-5">
										<div class="col-3"></div>
										<div class="col">
											<input class="btn btn-primary form-control" type="submit" value="위시 시작하기">
										</div>
										<div class="col-3"></div>
									</div>
									<div class="row mt-2">
										<div class="col-3"></div>
										<div class="col">
											<input class="btn btn-secondary form-control" type="reset" value="다시 작성하기">
										</div>
										<div class="col-3"></div>
									</div>
									<div class="row mb-3"></div> 
								</form>
							</div>
						</div>
					</div>
					<div class="row mb-5"></div>
					<div class="row mb-5"></div>
				</article>
			</div>
			<div class="col-1">
				<div class="row mt-5"></div>
				<div class="row mt-5"></div>
				<div class="row mt-3"></div>
				<div class="row mt-3"></div>
				<div class="row mt-1"></div>
				<div class="row mt-1"></div>
				<c:if test="${!empty user}">
					<div class="row sticky-top">
						<aside class="card shadow">
							<jsp:include page="../common/aside.jsp"/>
						</aside>
					</div>
				</c:if>
			</div>
			<div class="col-2">
			</div>
		</div>
	</div>
	
	
	
	<!-- 줄맞추기 -->
	<div style="width:1200px" class="row">
		<div class="col mt-5"></div>
	</div>
	
	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>