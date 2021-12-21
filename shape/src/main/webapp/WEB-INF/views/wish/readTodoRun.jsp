<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

	var nowDate = getFormatDate(new Date());
	var today = new Date();
	
/* 	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(getCountGender);
	
	// 그래프 관련..
	// 남녀 성비 그래프.
	function getCountGender(){
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				console.log(data.getCountGender.GENDER);
				
				drawChart(data);
				
			}
		};
		
		xmlhttp.open("get" , "./getCountWishGender.do");
		xmlhttp.send();
		
	}
	// 도넛 그래프 그리기.
  	function drawChart(data) {

		/*
		var tempData = [];
		tempData.push(['gender', 'aefefwef']);
		
		for(x of data.getCountGender){
			tempData.push([x.GENDER , x.CNT ]);
		}
		
    	var chartData = google.visualization.arrayToDataTable(tempData);
		*/
		
/* 		var chartData = new google.visualization.DataTable();
		
		chartData.addColumn('string' , 'gender');
		chartData.addColumn('number' , 'cnt');
		
		for(x of data.getCountGender){
			chartData.addRow([x.GENDER , x.CNT ]);
		}
		
    	
        var options = {
        	title: '위시 실행 성별',
        	is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('graph1'));
        chart.draw(chartData, options);
        
 	} */
	


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
	
	
	
	// 날짜 확인.
	function checkRunDate() {
		
		var todo_day = document.getElementById("todo_day").value;
		
		if(${empty user}){
			return;
		};

		console.log(todo_day);
		if(todo_day == null){
			return;
		};
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(mapList of data.wishRunTodoRunDateList) {
					for(todoRunDay of mapList.todoRunDateList) {
				
						var formatDate = new Date(todoRunDay);
						var todoRunDate = getFormatDate(formatDate);
						if(todoRunDate == todo_day){
							moveTodoRunDate()
							return;
						};
					};
					
				};
				
				document.getElementById("todo_day").value = "";
				alert("일정이 없습니다.");
			}
		};
		
		xmlhttp.open("get" , "./getTodoRunDate.do");
		xmlhttp.send();
		
	}
	
	function moveTodoRunDate(){
		
		var todo_day = document.getElementById("todo_day").value;
		
		console.log(todo_day);
		
		if(todo_day == ""){
			alert("날짜를 선택해주세요");
			return;
		}
		
		window.location.href = "./readTodoRun.do?todo_day="+todo_day;
	}
	
	function getFormatDate(date){
		
		console.log(date);
		var year = date.getFullYear();
		var month = (date.getMonth()+1);
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		
		return year + "-" + month + "-" + day;
		
	}
	
	
	// 일지 관련...
	// wish_run_comment 생성하기.
	function createWishComment(wishRunNo) {
		
		var contentBox = document.getElementById("content"+wishRunNo);
		var content = contentBox.value;
		console.log(contentBox);
		
		if(content == null || content == ""){
			alert("일지 내용을 작성해주세요.");
			return;
		}
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
		
				alert("일지가 작성되었습니다");
				getWishRunList();
				
			}
		};
		
		xmlhttp.open("get" , "./createComment.do?wish_run_no="+wishRunNo+"&content="+content);
		xmlhttp.send();
		
	}
	// wish_run_comment 업데이트하기.
	function updateWishComment(wishRunNo, no){
		
		var content = document.getElementById("content"+wishRunNo).value
		
		var xmlhttp = new XMLHttpRequest();
		
		if(content == null || content == ""){
			alert("일지 내용을 작성해주세요.");
			getWishRunList();
			return;
		}
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
		
				alert("일지가 수정되었습니다.");
				getWishRunList();
				
			}
		};
		
		xmlhttp.open("get" , "./updateComment.do?wish_run_no="+wishRunNo+"&content="+content+"&no="+no);
		xmlhttp.send();
		
	}
	// 파일 업로드 관련..
	// wish_run_image 생성하기.
	function createImage(wishRunNo){
		
		var formData = new FormData();
		
		if(document.getElementById("file"+wishRunNo).files[0] == null){
			
			alert("선택된 파일이 없습니다.");
			return "";
			
		}
		
		for(x of document.getElementById("file"+wishRunNo).files){
			

			formData.append('uploadFiles', x);
		}
		
		
		var xmlhttp = new XMLHttpRequest();
	

		xmlhttp.onreadystatechange = function(){
					
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
					
				alert("파일이 업로드되었습니다.")
				document.getElementById("file"+wishRunNo).value = "";
				getImageList();
			}		
		}
		formData.append("wish_run_no", wishRunNo);
		console.log(wishRunNo);
		xmlhttp.open("post" , "./createWishRunImage.do");
		
		xmlhttp.send(formData);
		
	}
	// wish_run_image 불러오기.
	function getImageList() {
		
		var imageBox = document.getElementById("imageBox");
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
		
				if(imageBox != null){
					imageBox.innerHTML = "";
				}
				
				var data = JSON.parse(xmlhttp.responseText);
				
				if(data.wishRunImageList[0] == null){
					
					var IamgeRow = document.createElement("div");
					IamgeRow.setAttribute("class", "row");
					imageBox.appendChild(IamgeRow);
					
					var imageCol1 = document.createElement("div");
					imageCol1.setAttribute("class", "col-1");
					IamgeRow.appendChild(imageCol1);
					var imageCol11 = document.createElement("div");
					imageCol11.setAttribute("class", "col");
					IamgeRow.appendChild(imageCol11);
					var imageCol12 = document.createElement("div");
					imageCol12.setAttribute("class", "col-1");
					IamgeRow.appendChild(imageCol12);
					
					var divTextarea = document.createElement("textarea");
					divTextarea.setAttribute("class", "shadow-sm form-control");
					divTextarea.setAttribute("rows", "1");
					divTextarea.setAttribute("placeholder", "                        ${selectTodoDay} 일에 업로드한 파일이 없습니다.");
					divTextarea.setAttribute("disabled", "disabled");
					imageCol11.appendChild(divTextarea);
					
				}	
				
				
				
				for(image of data.wishRunImageList) {
					
						
					var IamgeRow = document.createElement("div");
					IamgeRow.setAttribute("class", "row");
					imageBox.appendChild(IamgeRow);
					
					var imageCol1 = document.createElement("div");
					imageCol1.setAttribute("class", "col-1");
					IamgeRow.appendChild(imageCol1);
					var imageCol11 = document.createElement("div");
					imageCol11.setAttribute("class", "col");
					IamgeRow.appendChild(imageCol11);
					var imageCol12 = document.createElement("div");
					imageCol12.setAttribute("class", "col-1");
					IamgeRow.appendChild(imageCol12);
					
					var imageSrc = document.createElement("img");
					imageSrc.setAttribute("src", "/uploadWish/"+image.file_link);
					imageSrc.setAttribute("width", "480px");
					imageCol11.appendChild(imageSrc);
						
				}
			
			}
		};

		
		xmlhttp.open("get" , "./getWishRunImageList.do?todo_day=${selectTodoDay}");
		xmlhttp.send();
		

	}
	

	
	// todo_run의 wish_run 불러오기.
	function getWishRunList(){
		
		var commentBox = document.getElementById("commentBox");
		var xmlhttp = new XMLHttpRequest();
		
		var writeDate = new Date(${selectTodoDay});
		
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
		
				var data = JSON.parse(xmlhttp.responseText);
				
				nowDate = getFormatDate(new Date());
				console.log(nowDate);
				
				commentBox.innerHTML = "";
				
				for(map of data.wishAndWishRunList){

					
					// title 관련.
					var rowTitle = document.createElement("div");
					rowTitle.setAttribute("class", "row mt-4");
					commentBox.appendChild(rowTitle);
					
					var colTitle12 = document.createElement("div");
					colTitle12.setAttribute("class","col");
					rowTitle.appendChild(colTitle12);

					
					var cardTitle = document.createElement("div"); 
					cardTitle.setAttribute("class", "card shadow-sm py-3");
					colTitle12.appendChild(cardTitle);
					
					var cardBodyTitle = document.createElement("div"); 
					cardBodyTitle.setAttribute("class","card-body text-center fs-5 fw-bold");
					cardBodyTitle.innerText = map.wishVo.title+" 일지";
					cardTitle.appendChild(cardBodyTitle);
					
					
					
					// textarea 부분.
					var rowOutterComment = document.createElement("div"); 
					rowOutterComment.setAttribute("class", "row");
					commentBox.appendChild(rowOutterComment);
					
					var colOutterComment12 = document.createElement("div");
					colOutterComment12.setAttribute("class","col");
					rowOutterComment.appendChild(colOutterComment12);

					
					var cardComment = document.createElement("div"); 
					cardComment.setAttribute("class", "card shadow-sm py-4 px-5");
					colOutterComment12.appendChild(cardComment);
					
					var rowInnerTextarea = document.createElement("div"); 
					rowInnerTextarea.setAttribute("class", "row");
					cardComment.appendChild(rowInnerTextarea);
					

					var colTextarea1 = document.createElement("div");
					colTextarea1.setAttribute("class","col-1 mb-2");
					rowInnerTextarea.appendChild(colTextarea1);
					var colTextarea11 = document.createElement("div");
					colTextarea11.setAttribute("class","col mb-2");
					rowInnerTextarea.appendChild(colTextarea11);
					var colTextarea12 = document.createElement("div");
					colTextarea12.setAttribute("class","col-1 mb-2");
					rowInnerTextarea.appendChild(colTextarea12);
					

					
					
					// 모든 버튼 관련...
					if("${selectTodoDay}" == nowDate) {
						
						// 일지 작성 버튼 관련.
						if(map.wishRunCommentVo == null){
							
							var divTextarea = document.createElement("textarea");
							divTextarea.setAttribute("class", "shadow-sm form-control");
							divTextarea.setAttribute("rows", "10");
							divTextarea.setAttribute("id", "content"+map.wishRunVo.no);
							colTextarea11.appendChild(divTextarea);
							
							var rowCommentButton = document.createElement("div"); 
							rowCommentButton.setAttribute("class", "row mt-1");
							cardComment.appendChild(rowCommentButton);
							

							var colButton1 = document.createElement("div");
							colButton1.setAttribute("class","col-1");
							rowCommentButton.appendChild(colButton1);
							var colButton8 = document.createElement("div");
							colButton8.setAttribute("class","col-7");
							rowCommentButton.appendChild(colButton8);
							var colButton11 = document.createElement("div");
							colButton11.setAttribute("class","col-3");
							rowCommentButton.appendChild(colButton11);
							var colButton12 = document.createElement("div");
							colButton12.setAttribute("class","col-1");
							rowCommentButton.appendChild(colButton12);

							
							var commentButton = document.createElement("div");
							commentButton.setAttribute("class", "btn btn-primary form-control");
							commentButton.setAttribute("onclick", "createWishComment("+map.wishRunVo.no+")");
							commentButton.innerText = "일지작성";
							colButton11.appendChild(commentButton);
						
							
							// 파일 업로드 버튼 관련.
							var rowOutterUpload = document.createElement("div"); 
							rowOutterUpload.setAttribute("class", "row");
							commentBox.appendChild(rowOutterUpload);
							

							var colOutterUpload12 = document.createElement("div");
							colOutterUpload12.setAttribute("class","col");
							rowOutterUpload.appendChild(colOutterUpload12);

							
							var cardUpload = document.createElement("div");
							cardUpload.setAttribute("class","card shadow-sm px-5 py-3");
							colOutterUpload12.appendChild(cardUpload);
							
							var rowInnerUpload = document.createElement("div"); 
							rowInnerUpload.setAttribute("class", "row my-2");
							cardUpload.appendChild(rowInnerUpload);
							

							var colInnerUpload1 = document.createElement("div");
							colInnerUpload1.setAttribute("class","col-1");
							rowInnerUpload.appendChild(colInnerUpload1);
							var colInnerUpload8 = document.createElement("div");
							colInnerUpload8.setAttribute("class","col-7");
							rowInnerUpload.appendChild(colInnerUpload8);
							var colInnerUpload11 = document.createElement("div");
							colInnerUpload11.setAttribute("class","col-3");
							rowInnerUpload.appendChild(colInnerUpload11);
							var colInnerUpload12 = document.createElement("div");
							colInnerUpload12.setAttribute("class","col-1");
							rowInnerUpload.appendChild(colInnerUpload12);

							
							var inputUpload = document.createElement("input"); 
							inputUpload.setAttribute("class", "form-control");
							inputUpload.setAttribute("type", "file");
							inputUpload.setAttribute("id", "file"+map.wishRunVo.no);
							inputUpload.setAttribute("multiple", "multiple");
							colInnerUpload8.appendChild(inputUpload);
							
							var buttonUpload = document.createElement("button"); 			
							buttonUpload.setAttribute("class", "btn btn-primary form-control");
							buttonUpload.setAttribute("onclick", "createImage("+map.wishRunVo.no+")");
							buttonUpload.innerText = "파일 업로드";
							colInnerUpload11.appendChild(buttonUpload);
							
							
						} else {
							
							var divTextarea = document.createElement("textarea");
							divTextarea.setAttribute("class", "shadow-sm form-control");
							divTextarea.setAttribute("rows", "10");
							divTextarea.setAttribute("id", "content"+map.wishRunVo.no);
							divTextarea.value = map.wishRunCommentVo.content;
							colTextarea11.appendChild(divTextarea);
							
							var rowCommentButton = document.createElement("div"); 
							rowCommentButton.setAttribute("class", "row mt-4");
							cardComment.appendChild(rowCommentButton);
							
							
							var colButton1 = document.createElement("div");
							colButton1.setAttribute("class","col-1");
							rowCommentButton.appendChild(colButton1);
							var colButton8 = document.createElement("div");
							colButton8.setAttribute("class","col-7");
							rowCommentButton.appendChild(colButton8);
							var colButton11 = document.createElement("div");
							colButton11.setAttribute("class","col-3");
							rowCommentButton.appendChild(colButton11);
							var colButton12 = document.createElement("div");
							colButton12.setAttribute("class","col-1");
							rowCommentButton.appendChild(colButton12);

							
							var commentButton = document.createElement("div");
							commentButton.setAttribute("class", "btn btn-secondary form-control");
							commentButton.setAttribute("onclick", "updateWishComment("+map.wishRunVo.no+", "+map.wishRunCommentVo.no+")");
							commentButton.innerText = "일지수정";
							colButton11.appendChild(commentButton);
							
							
							// 파일 업로드 버튼 관련.
							var rowOutterUpload = document.createElement("div"); 
							rowOutterUpload.setAttribute("class", "row");
							commentBox.appendChild(rowOutterUpload);
							

							var colOutterUpload12 = document.createElement("div");
							colOutterUpload12.setAttribute("class","col");
							rowOutterUpload.appendChild(colOutterUpload12);

							
							var cardUpload = document.createElement("div");
							cardUpload.setAttribute("class","card shadow-sm px-5 py-3");
							colOutterUpload12.appendChild(cardUpload);
							
							var rowInnerUpload = document.createElement("div"); 
							rowInnerUpload.setAttribute("class", "row my-2");
							cardUpload.appendChild(rowInnerUpload);
							

							var colInnerUpload1 = document.createElement("div");
							colInnerUpload1.setAttribute("class","col-1");
							rowInnerUpload.appendChild(colInnerUpload1);
							var colInnerUpload8 = document.createElement("div");
							colInnerUpload8.setAttribute("class","col-7");
							rowInnerUpload.appendChild(colInnerUpload8);
							var colInnerUpload11 = document.createElement("div");
							colInnerUpload11.setAttribute("class","col-3");
							rowInnerUpload.appendChild(colInnerUpload11);
							var colInnerUpload12 = document.createElement("div");
							colInnerUpload12.setAttribute("class","col-1");
							rowInnerUpload.appendChild(colInnerUpload12);

							
							var inputUpload = document.createElement("input"); 
							inputUpload.setAttribute("class", "form-control");
							inputUpload.setAttribute("type", "file");
							inputUpload.setAttribute("id", "file"+map.wishRunVo.no);
							inputUpload.setAttribute("multiple", "multiple");
							colInnerUpload8.appendChild(inputUpload);
							
							var buttonUpload = document.createElement("button"); 			
							buttonUpload.setAttribute("class", "btn btn-primary form-control");
							buttonUpload.setAttribute("onclick", "createImage("+map.wishRunVo.no+")");
							buttonUpload.innerText = "파일 업로드";
							colInnerUpload11.appendChild(buttonUpload);
							
						}
						
					} else {
						
						if(map.wishRunCommentVo == null){ 
							
							var divTextarea = document.createElement("textarea");
							divTextarea.setAttribute("class", "shadow-sm form-control");
							divTextarea.setAttribute("rows", "1");
							divTextarea.setAttribute("id", "content"+map.wishRunVo.no);
							divTextarea.setAttribute("placeholder", "                         ${selectTodoDay} 일에 작성한 일지 내용이 없습니다.");
							divTextarea.setAttribute("disabled", "disabled");
							colTextarea11.appendChild(divTextarea);
						
						} else {
							
							var divTextarea = document.createElement("textarea");
							divTextarea.setAttribute("class", "shadow-sm form-control");
							divTextarea.setAttribute("rows", "10");
							divTextarea.setAttribute("id", "content"+map.wishRunVo.no);
							divTextarea.value = map.wishRunCommentVo.content;
							divTextarea.setAttribute("disabled", "disabled");
							colTextarea11.appendChild(divTextarea);
							
						}
					}
					
				};
				
			}
		};
		
		xmlhttp.open("get" , "./getWishRunList.do?todo_day=${selectTodoDay}&member_no=" );
		xmlhttp.send();
		
	}

	
	function init(){
		
		getWishRunList();
		getImageList();
	}
	
	
	// HTML 문서 로딩 후 실행 로직. 
	window.addEventListener('DOMContentLoaded', init);
	
	
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
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
						<div class="col">
					  		<div class="card shadow-sm py-2">
					  			<div class="card-body fs-4 text-center fw-bold" id="today">
						    		<fmt:formatDate value="${todoDay }" pattern="yyyy년 MM월 dd일" var="today"/>
									${today } <i class="bi bi-calendar-check"></i>
								</div>
					  		</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm p-1">
								<div class="row">
									<div class="col-3"></div>
									<div class="col my-2">
										<input class="shadow-sm form-control btn btn-outline-primary" id="todo_day" type="date" onchange="checkRunDate()">
									</div>
									<div class="col-3"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
					  		<div class="card shadow-sm py-3">
					  			<div class="card-body px-5">
									<div class="row mt-1">
										<div class="col-1"></div>
										<div class="col">
											<div class="card shadow-sm p-1">
												<div class="row my-3">
													<div class="col text-center fs-5 fw-bold">
														투두 리스트 <i class="bi bi-ui-checks" style="color:#00008B"></i>
													</div>
												</div>
											</div>
										</div>
										<div class="col-1"></div>
									</div>
									<div class="row mt-3">
										<div class="col-1"></div>
										<div class="col">
											<div class="card shadow-sm p-1">
												<div class="row my-2">
													<div class="col text-center">
														미완료 투두
													</div>
												</div>
											</div>
										</div>
										<div class="col">
											<div class="card shadow-sm p-1">
												<div class="row my-2">
													<div class="col text-center">
														완료 투두
													</div>
												</div>
											</div>
										</div>
										<div class="col-1"></div>
									</div>
									<c:forEach items="${relatedTodoRunList }" var="data0">
										<c:forEach items="${data0.relatedTodoList }" var="data">
											<c:choose>
												<c:when test="${data.todoRun.check == 'n' }">
													<div class="row">
														<div class="col-1"></div>
														<div class="col">
															<div class="card shadow-sm py-4">
																<div class="row mt-2">
																	<div class="col-1"></div>
																	<div class="col fw-bold">
																		${data.todo.title }
																	</div>		
																	<div class="col-1"></div>			
																</div>
																<div class="row mt-2 mb-1">
																	<div class="col-1"></div>
																	<div class="col">
																		<i class="bi bi-check2-circle" style="color:#00008B"></i> ${data.todo.content }
																	</div>
																	<div class="col-1"></div>				
																</div>
																<c:if test="${selectTodoDay == nowDate}">
																	<div class="row mt-4">
																		<div class="col-1"></div>
																		<div class="col text-center">
																			<form action="./checkTodoRunProcess.do">
																				<fmt:formatDate value="${todoDay }" pattern="yyyy/MM/dd" var="checkDay"/>
																				<fmt:formatDate value="${todoDay }" pattern="yyyy-MM-dd" var="todo_day"/>
																				<input type="hidden" name="todo_run_no" value="${data.todoRun.no}">
																				<input type="hidden" name="todo_day" value="${todo_day }">
																				<input class="btn btn-primary form-control" type="submit" value="투두 완료">
																			</form>
																		</div>
																		<div class="col-1"></div>
																	</div>
																</c:if>
															</div>
														</div>
														<div class="col">
															<!-- 어떻게 넣어야 할지 고민되는부분 -->
														</div>
														<div class="col-1"></div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="row">
														<div class="col-1"></div>
														<div class="col">
															<!-- 어떻게 넣어야 할지 고민되는부분 -->
														</div>
														<div class="col">
															<div class="card shadow-sm py-4">
																<div class="row mt-2">
																	<div class="col-1"></div>
																	<div class="col fw-bold">
																		${data.todo.title }
																	</div>
																	<div class="col-1"></div>			
																</div>
																<div class="row my-2">
																	<div class="col-1"></div>
																	<div class="col">
																		<i class="bi bi-check2-circle" style="color:#00008B"></i> ${data.todo.content }
																	</div>
																	<div class="col-1"></div>					
																</div>
															</div>
														</div>
														<div class="col-1"></div>
													</div>
												</c:otherwise>									
											</c:choose>		
										</c:forEach>
									</c:forEach>
								</div>
					  		</div>
						</div>
					</div>
					<div id="commentBox"></div>
					<div class="row mt-4">
						<div class="col">
					  		<div class="card shadow-sm py-3">
					  			<div class="card-body fs-5 text-center fw-bold">
						    		업로드 파일
								</div>
					  		</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm py-3">
								<div class="row mx-4">
								  	<div class="col">
							  			<div class="card-body text-center">
							  				<div id="imageBox">
							  				</div>
							  			</div>
									</div>
								</div>
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
			<div class="col-2"></div>
		</div>
	</div>
	
	<!-- 줄맞추기 -->
	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>