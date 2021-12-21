<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<script>

	
	
/* 	function categoryReset(){
		allSmallCategory();
	} */
	function sortSmallCategory(){
		
		var bigCategory = document.getElementById("bigCategoryBox").value;
		var smallCategoryBox = document.getElementById("smallCategoryBox");
		
		if(bigCategory == "대분류"){
			smallCategoryBox.innerHTML = "";
			
			var smallOption = document.createElement("option");
			smallOption.setAttribute("selected", "selected");
			smallOption.setAttribute("class", "text-center");
			smallOption.innerText = "소분류";
			smallCategoryBox.appendChild(smallOption);
			sortWish();
			return;
		}
		
		
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
					smallOption.setAttribute("class", "text-center");
					smallOption.innerText = smallCategory.small_name;
					
					smallCategoryBox.appendChild(smallOption);
					
					
				};
				
				sortWish();
				
			}
		};
		
		xmlhttp.open("get" , "../member/sortSmallCategory.do?big_category_no="+bigCategory); 
		xmlhttp.send();
		
	}
	
	
	
/* 	function allSmallCategory(){
		
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
		
	} */
	

	
	
	
	// 랭킹 관련...
	// 실행하고 있는 위시 랭킹.
	function getRunningWishRank(){
		
		var xmlhttp = new XMLHttpRequest();
		var runningWish = document.getElementById("runningWish");
		
		runningWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				runningWish.appendChild(rowOuter);
				
				for(rankWish of data.runningWishRankList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle ");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);

					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getRunningWishRank.do");
		xmlhttp.send();
		
	}
	// 좋아요 위시 랭킹.
	function getLikeWishRank(){
		
		var xmlhttp = new XMLHttpRequest();
		var likeWish = document.getElementById("likeWish");
		
		likeWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				likeWish.appendChild(rowOuter);
				
				for(rankWish of data.likeWishRankList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle ");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getLikeWishRank.do");
		xmlhttp.send();
		
	}
	// 조회수 위시 랭킹.
	function getReadCountWish(){
		
		var xmlhttp = new XMLHttpRequest();
		
		var readCountWish = document.getElementById("readCountWish");
		readCountWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				readCountWish.appendChild(rowOuter);
				
				for(rankWish of data.readCountWishRankList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getReadCountWishRank.do");
		xmlhttp.send();
		
	}
	// 포기 위시 랭킹.
	function getQuitWish(){
		
		var xmlhttp = new XMLHttpRequest();
		var quitWish = document.getElementById("quitWish");
		
		quitWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				quitWish.appendChild(rowOuter);
				
				for(rankWish of data.quitWishRankList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getQuitWishRank.do");
		xmlhttp.send();
		
	}
	// 카테고리별 실행하고 있는 위시 랭킹.
	function getCategoryRunningWishRank(smallCategoryNo){
		
		var xmlhttp = new XMLHttpRequest();
		var runningWish = document.getElementById("runningWish");
		
		runningWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				runningWish.appendChild(rowOuter);
				
				for(rankWish of data.runningWishList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle ");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);

					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getCategoryRunningWishRank.do?small_category_no="+smallCategoryNo);
		xmlhttp.send();
		
	}
	// 카테고리별 좋아요 위시 랭킹.
	function getCategoryLikeWishRank(smallCategoryNo){
		
		var xmlhttp = new XMLHttpRequest();
		var likeWish = document.getElementById("likeWish");
		
		likeWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				likeWish.appendChild(rowOuter);
				
				for(rankWish of data.likeWishList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle ");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getCategoryLikeWishRank.do?small_category_no="+smallCategoryNo);
		xmlhttp.send();
		
	}
	// 카테고리별 조회수 위시 랭킹.
	function getCategoryReadCountWish(smallCategoryNo){
		
		var xmlhttp = new XMLHttpRequest();
		
		var readCountWish = document.getElementById("readCountWish");
		readCountWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				readCountWish.appendChild(rowOuter);
				
				for(rankWish of data.readCountWishList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getCategoryReadCountWishRank.do?small_category_no="+smallCategoryNo);
		xmlhttp.send();
		
	}
	// 카테고리별 포기 위시 랭킹.
	function getCategoryQuitWish(smallCategoryNo){
		
		var xmlhttp = new XMLHttpRequest();
		
		var quitWish = document.getElementById("quitWish");
		quitWish.innerHTML = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				var rowOuter = document.createElement("div");
				rowOuter.setAttribute("class", "row");
				quitWish.appendChild(rowOuter);
				
				for(rankWish of data.readQuitWishList){
					
			
					var colOuter = document.createElement("div");
					colOuter.setAttribute("class", "col center-text");
					rowOuter.appendChild(colOuter);
					
					var cardOuter = document.createElement("div");
					cardOuter.setAttribute("class", "card shadow bg-body rounded form-control");
					colOuter.appendChild(cardOuter);
					
					var cardBody = document.createElement("div");
					cardBody.setAttribute("class", "card-body");
					cardOuter.appendChild(cardBody);
		
					var cardTitle = document.createElement("div");
					cardTitle.setAttribute("class", "card-text fw-bold text-center");
					cardTitle.innerText = rankWish.wishVo.title;
					cardBody.appendChild(cardTitle);
			
					var memberId = document.createElement("div");
					memberId.setAttribute("class", "card-text mb-3 text-center");
					memberId.innerText = rankWish.memberVo.id;
					cardBody.appendChild(memberId);
					
					
					// todo 관련..
					for(todo of rankWish.todoList){
						
						var memberId = document.createElement("div");
						memberId.setAttribute("class", "card-text mt-1");
						cardBody.appendChild(memberId);
						
						var checkIcon = document.createElement("i");
						checkIcon.setAttribute("class", "bi bi-check2-circle");
						checkIcon.innerText = " "+todo.title;
						memberId.appendChild(checkIcon);
						
					}
					
					var wishButton = document.createElement("a");
					wishButton.setAttribute("class", "btn btn-sm btn-secondary form-control mt-4");
					wishButton.setAttribute("style", "background-color: #696969");
					wishButton.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+rankWish.wishVo.no);
					wishButton.innerText = "상세보기";
					cardBody.appendChild(wishButton);
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getCategoryQuitWishRank.do?small_category_no="+smallCategoryNo);
		xmlhttp.send();
		
	}
	
	function sortWish(){
		
		var smallCategoryBox = document.getElementById("smallCategoryBox");
		var smallCategoryNo = smallCategoryBox.value;
		console.log(smallCategoryNo);
		
		
		if(smallCategoryNo == "소분류"){
			
			getRunningWishRank();
			getLikeWishRank();
			getReadCountWish();
			getQuitWish();
			
		} else {
			
			getCategoryRunningWishRank(smallCategoryNo);
			getCategoryLikeWishRank(smallCategoryNo);
			getCategoryReadCountWish(smallCategoryNo);
			getCategoryQuitWish(smallCategoryNo);
			
		}
	}
	

	function init(){
		
		sortWish();
		
	}
	
	// 문서 onload API.
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
					<div class="row mt-5">
						<div class="col">
							<div class="text-center fs-1 fw-bold" style="color:#0064FF;">
								<img src="/shape/resources/dumy10.png" width="830px;" style="text-shadow: 1.5px 1.5px 5px #87CEEB;">
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<hr>
						</div>
					</div>
					<div class="row mt-1">
						<c:choose>
							<c:when test="${empty user}">
								<div class="col">
									<select id="bigCategoryBox" class="shadow-sm rounded form-select"  onchange="sortSmallCategory()">
										<option class="text-center" selected>대분류</option>
										<c:forEach items="${bigList }" var="data">
											<option class="text-center" value="${data.no }">${data.big_name }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col">
									<select id="smallCategoryBox" name="small_category_no" class="shadow-sm rounded form-select" onchange="sortWish()" aria-label="Default select example"><!-- 아직 구현 안함 -->
										<option class="text-center" selected>소분류</option>
									</select>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col">
									<select id="bigCategoryBox" class="shadow-sm rounded form-select"onchange="sortSmallCategory()">
										<option class="text-center">대분류</option>
										<c:forEach items="${bigList }" var="data">
											<c:choose>
												<c:when test="${data.no ==  myAllCategory.bigCategoryVo.no}">
													<option class="text-center" selected="selected" value="${data.no }">${data.big_name }</option>
												</c:when>
												<c:otherwise>
													<option class="text-center" value="${data.no }">${data.big_name }</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="col">
									<select id="smallCategoryBox" name="small_category_no" class="shadow-sm rounded form-select" onchange="sortWish()" aria-label="Default select example"><!-- 아직 구현 안함 -->
										<c:if test="${!empty user}">
											<c:forEach items="${smallList }" var="data">
													<c:choose>
														<c:when test="${data.no == myAllCategory.smallCategoryVo.no}">
															<option class="text-center" selected="selected" value="${data.no }">${data.small_name }</option>
														</c:when>
														<c:when test="${data.big_category_no ==  myAllCategory.smallCategoryVo.big_category_no }">
															<option class="text-center" value="${data.no }">${data.small_name }</option>
														</c:when>
													</c:choose>
											</c:forEach>
										</c:if>
										<c:if test="${empty user}">
											<option class="text-center" selected>소분류</option>
										</c:if>
									</select>
								</div>
							</c:otherwise>
						</c:choose>
						<!-- <div class="col-2">
							<button class="shadow btn btn-primary" onclick="sortWish()">정렬</button>
						</div> -->
					</div>
					<div class="row mt-5">
						<div class="col text-center fs-5 fw-bold ">
							<div class="card shadow-sm rounded py-4">
								<div class="row">
									<div class="col">
										많은 사람들이 실행한 위시 <i class="bi bi-trophy-fill" style="color:#DAA520;"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm bg-body rounded p-4">
								<div id="runningWish"></div>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col text-center fs-5 fw-bold ">
							<div class="card shadow-sm rounded py-4">
								<div class="row">
									<div class="col">
										많은 사람들이 좋아요를 누른 위시 <i class="bi bi-suit-heart-fill" style="color:#CD5C5C"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm bg-body rounded p-4">
								<div id="likeWish"></div>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col text-center fs-5 fw-bold ">
							<div class="card shadow-sm rounded py-4">
								<div class="row">
									<div class="col">
										조회수가 가장 높은 위시 <i class="bi bi-eye-fill" style="color:#008000;"></i>
									</div>
								</div>
							</div> 
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card text-white shadow-sm bg-body rounded p-4">
								<div id="readCountWish"></div>
							</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col text-center fs-5 fw-bold">
							<div class="card shadow-sm rounded py-4">
								<div class="row">
									<div class="col">
										많은 사람들이 포기한 위시 <i class="bi bi-hand-thumbs-down-fill" style="color:#4B0082;"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm bg-body rounded p-4">
								<div id="quitWish"></div>
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
	
	<div class="row mt-5"></div>
	<!-- 줄맞추기 -->
	<div style="width:1200px" class="row">
		<div class="col mb-5"></div>
	</div>

	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>