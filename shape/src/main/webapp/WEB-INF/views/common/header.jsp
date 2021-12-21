<%@ page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% Date now = new Date(); %>

<script>

	var today = new Date();

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

<fmt:formatDate value="<%=now %>" pattern="yyyy-MM-dd" var="todo_day"/>
    	<div class="container-fluid">
			<div class="row bg-dark py-3">
				<div class="col-2"></div>
				<div class="col-1">
					<a class="btn btn-dark text-white" href="/shape/wish/index.do">
						<img src="/shape/resources/logo1.png" width="50px">
					</a>
				</div>
				<div class="col">
					<div class="row">
						<div class="col text-center">
							<a class="btn btn-dark text-white fw-bold" href="/shape/wish/index.do">
								Home
							</a>
						</div>
						<div class="col text-center">
							<a class="btn btn-dark text-white fw-bold" href="/shape/wish/readTodoRun.do?todo_day=${todo_day }" onclick="checkDate()">
								Today
							</a>
						</div>
						<div class="col text-center">
							<a class="btn btn-dark text-white fw-bold" href="/shape/wish/otherWishList.do">Other Wish</a>
						</div>
						<div class="col text-center">
							<a class="btn btn-dark text-white fw-bold" href="/shape/freeboard/mainPage.do">Free Board</a>
						</div>
						<div class="col text-center">
							<a class="btn btn-dark text-white fw-bold" href="/shape/story/storyHome.do">Story</a>
						</div>
					</div>
				</div>
				<div class="col-1">
					<div class="dropdown" align="center">
						<button class="btn btn-dark dropdown-toggle fw-bold" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
					    	My Wish
						</button>
						<ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="dropdownMenuButton2">
						    <li><a class="dropdown-item active" href="/shape/wish/getWishAndToDoByMemberNo.do">계획중인 위시</a></li>
						    <li><a class="dropdown-item" href="/shape/wish/myWishList.do">진행중인 위시</a></li>
						    <li><a class="dropdown-item" href="/shape/wish/myEndWishList.do">일정이 끝난 위시</a></li>
						</ul>
					</div>
				</div>
				<div class="col-2"></div>
			</div>
		</div>