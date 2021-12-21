<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>

.target{ display: inline-block;
		 width: 200px;
		 white-space: nowrap;
		 overflow: hidden;
		 text-overflow: ellipsis; }
 
</style>
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<div class="container-fluid">
		<div class="row">
			<div class="col-3">
				<jsp:include page="../common/aside2.jsp"/>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">				
			</div>
			<div class="col card mx-5">
				<div class="row mt-5">
					<div class="col-4">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-1"><i class="bi bi-people-fill fs-5 text-primary"></i></div>
							<div class="col-7 fw-bold text-secondary fs-5">그룹 추가<hr/></div>							
						</div>
					</div>					
				</div>				
				<div class="row mt-3">
					<div class="col-1"></div>
					<div class="col">						
						<div class="row">
							<div class="col-8">
								<div class="row">
									<c:forEach items="${FG}" var="data">																														
										<div class="col-1 target fst-italic text-primary"><i class="bi bi-people-fill"></i> ${data.name} (${data.content})<hr/></div>																																		
									</c:forEach>
								</div>									
							</div>														
						</div>						
					</div>					
				</div>
				<form action="./groupProcess.do">
				<div class="row mt-3">
					<div class="col-8">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-1"><i class="bi bi-card-text text-secondary fs-4"></i></div>
							<div class="col"><input class="btn btn-outline-secondary" type="text" name="name" placeholder="그룹 이름 설정 입력"></div>
							
							
						</div>
					</div>
					<div class="col-2"></div>
					<div class="col-2"></div>
				</div>				
				<div class="row mt-3">
					<div class="col-8">
						<div class="row mt-2">
							<div class="col-1"></div>
							<div class="col-1"><i class="bi bi-card-text text-secondary fs-4"></i></div>
							<div class="col"><input class="btn btn-outline-secondary" type="text" name="content" placeholder="그룹 설명 입력"></div>							
						</div>
					</div>
					<div class="col-2"></div>
					<div class="col-2"></div>
					
				</div>
				<div class="row mt-5 mb-3">
					<div class="col-1"></div>
					<div class="col-3"><a class="fst-italic text-primary text-opacity-75 fs-6" href="./friends.do">Friends 페이지</a></div>					
					<div class="col"> <button type="submit" class="btn-sm btn-secondary fs-7"><i class="bi bi-people fs-7"></i> 그룹 생성</button></div>					
				</div>
				
				</form>
				</div>
			<div class="col-1">
				
			<aside>
				<jsp:include page="../common/aside.jsp"/>
			</aside>
			
			</div>
			<div class="col-2"></div>
			<footer>
				<jsp:include page="../common/footer.jsp"/>
			</footer>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		
</body>
</html>