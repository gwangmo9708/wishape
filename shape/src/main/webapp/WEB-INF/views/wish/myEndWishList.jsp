<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
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
				window.location.href = "/shape/wish/myEndWishList.do";
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<title>My WishList page</title>
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
<!-- 					<div class="row mt-5">
						<div class="col">
							<div class="text-center fs-1 fw-bold" style="color:#0064FF; text-shadow: 1.5px 1.5px 5px #87CEEB;">WISHAPE</div>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<hr>
						</div>
					</div> -->
					<div class="row mt-5"></div>
					<c:if test="${!empty endWishDate}">
						<div class="row">
							<div class="col">
						  		<div class="card shadow-sm py-2">
						  			<div class="card-body fs-5 text-center fw-bold">
							    		일정이 끝난 위시리스트
									</div>
						  		</div>
							</div>
						</div>	
					</c:if>				
					<c:if test="${empty endWishDate}">
						<div class="row">
							<div class="col">
						  		<div class="card shadow-sm py-2">
						  			<div class="card-body fs-5 text-center fw-bold">
							    		일정이 끝난 위시리스트가 없습니다.
									</div>
						  		</div>
							</div>
						</div>
						<div class="row">
							<div class="col text-center">
						  		<img class="shadow-sm" src="/shape/resources/dumy1.jpg" width="828px" style="border-radius: 5px/5px">
							</div>
						</div>

					</c:if>
					
					<c:if test="${!empty endWishDate}">
						<div id="carouselExampleControlsNoTouching" class="carousel slide" data-bs-touch="false" data-bs-interval="false">
							<div class="carousel-inner">
								<c:forEach items="${endWishDate}" var="data" varStatus="status">
									<c:choose>
										<c:when test="${status.index == 0}">
											<div class="carousel-item active" data-bs-interval="5000">
										</c:when>
										<c:otherwise>
											<div class="carousel-item">
										</c:otherwise>
									</c:choose>
									<div class="row">
										<div class="col">
									  		<div class="card shadow-sm px-5 py-3">
									  			<div class="card-body  px-5">
													<div class="card shadow-sm" >
														<div class="row mt-2">
															<div class="col text-center fs-5 fw-bold">
																${data.wishVo.title }
															</div>
														</div>
														<div class="row mt-2 mb-2">
															<div class="col text-center">
																${data.wishVo.content }
															</div>
														</div>
													</div>
													<c:forEach items="${data.todoAndCheckList }" var="map">
														<div class="card shadow-sm py-3 px-5">
															<div class="row">
																<div class="col fw-bold">
																	${map.todoVo.title }
																</div>
															</div>
															<div class="row mt-1">
																<div class="col">
																	<i class="bi bi-check2-circle" style="color:#00008B"></i> ${map.todoVo.content }
																</div>
																<div class="col-4 text-center ">
																	<c:choose>
																		<c:when test="${map.todoCount != '결과 없음'}">
																			<div class="progress">
																				<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${map.todoCount }%" aria-valuenow="${map.todoCount }" aria-valuemin="0" aria-valuemax="100">
																					${map.todoCount }%
																				</div>
																			</div>
																		</c:when>
																		<c:otherwise>
																			실행 하지 않음
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</c:forEach>
													<div class="row mt-4">
														<div class="col-3"></div>
														<div class="col">
															<form action="/shape/wish/readWishRun.do">
																<input type="hidden" name="wish_run_no" value="${data.wishRunVo.no }">
																<input class="shadow-sm btn btn-primary form-control" type="submit" value="위시 상세보기">
															</form>
														</div>
														<div class="col-3"></div>
													</div>
												</div>
									  		</div>
										</div>
									</div>
									</div>
								</c:forEach>
							</div>
					    	<div class="row">
					    		<div class="col">
									<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually text-secondary mx-5">Prev</span>
									</button>
								</div>
								<div class="col">
									<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually text-secondary mx-5">Next</span>
								  	</button>
							  	</div>
						  	</div>
						</div>
					</c:if>
					<c:if test="${!empty endWishDate}">
						<div class="row mt-5"></div>
						<div class="row px-3">
							<hr>
						</div>
					</c:if>
					<c:if test="${!empty quitWishList}">
						<div class="row mt-4">
							<div class="col">
						  		<div class="card shadow-sm py-2">
						  			<div class="card-body fs-5 text-center fw-bold">
							    		포기한 위시리스트
									</div>
						  		</div>
							</div>
						</div>
					</c:if>
					<c:if test="${empty quitWishList}">
						<div class="row mt-4">
							<div class="col">
						  		<div class="card shadow-sm py-2">
						  			<div class="card-body fs-5 text-center fw-bold">
							    		포기한 위시리스트가 없습니다.
									</div>
						  		</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="col text-center">
						  			<img class="shadow-sm" src="/shape/resources/dumy3.jpg" width="828px" style="border-radius: 5px/5px">
								</div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${!empty quitWishList}">
						<div id="carousel2" class="carousel slide" data-bs-touch="false" data-bs-interval="false">
							<div class="carousel-inner">
								<c:forEach items="${quitWishList}" var="data" varStatus="status">
									<c:choose>
										<c:when test="${status.index == 0}">
											<div class="carousel-item active" data-bs-interval="5000">
										</c:when>
										<c:otherwise>
											<div class="carousel-item">
										</c:otherwise>
									</c:choose>
									<div class="row">
										<div class="col">
									  		<div class="card shadow-sm px-5 py-3">
									  			<div class="card-body  px-5">
													<div class="card shadow-sm p-1" >
														<div class="row mt-2">
															<div class="col text-center fs-5 fw-bold">
																${data.wishVo.title }
															</div>
														</div>
														<div class="row mt-2 mb-2">
															<div class="col text-center">
																${data.wishVo.content }
															</div>
														</div>
													</div>
													<c:forEach items="${data.relatedTodoList}" var="map">
														<div class="card shadow-sm py-3 px-5">
															<div class="row">
																<div class="col fw-bold">
																	${map.todoVo.title }
																</div>
															</div>
															<div class="row mt-1">
																<div class="col">
																	<i class="bi bi-check2-circle" style="color:#00008B"></i> ${map.todoVo.content }
																</div>
																<div class="col-4 text-center">
																	<c:choose>
																		<c:when test="${map.totalCount != '결과 없음'}">
																			<div class="progress">
																				<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${map.totalCount }%" aria-valuenow="${map.totalCount }" aria-valuemin="0" aria-valuemax="100">
																					${map.totalCount }%
																				</div>
																			</div>
																		</c:when>
																		<c:otherwise>
																			실행 하지 않음
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</c:forEach>
													<div class="row mt-4">
														<div class="col-3"></div>
														<div class="col">
															<form action="/shape/wish/readWishRun.do">
																<input type="hidden" name="wish_run_no" value="${data.wishRunVo.no }">
																<input class="shadow-sm btn btn-primary form-control" type="submit" value="위시 상세보기">
															</form>
														</div>
														<div class="col-3"></div>
													</div>
												</div>
									  		</div>
										</div>
									</div>
									</div>
								</c:forEach>
							</div>
					    	<div class="row">
					    		<div class="col">
									<button class="carousel-control-prev" type="button" data-bs-target="#carousel2" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually text-secondary mx-5">Prev</span>
									</button>
								</div>
								<div class="col">
									<button class="carousel-control-next" type="button" data-bs-target="#carousel2" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually text-secondary mx-5">Next</span>
								  	</button>
							  	</div>
						  	</div>
						</div>
					</c:if>
					
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
	<div style="width:1200px" class="row">
		<div class="col mt-5"></div>
	</div>
	
	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>