<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
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
						<div class="col-8 text-secondary fw-bold fs-5"><i class="bi bi-person-plus text-primary"></i> 친구 추가 <hr/></div>						
					</div>
				</div>				
			</div>
			
			<form action="./friendsProcess.do">
				<input type="hidden" name="member_no" value="${member_no}">
			<div class="row mt-3">
				<div class="col-1"></div>			
				<div class="col">
					<div class="row">
											
						<div class="col-1"><i class="bi bi-people text-primary fs-4"></i></div>
						<div class="col-6 fs-6">
							<select class="form-select form-select-md mb-2" aria-label=".form-select" name="friends_group_no">
								<c:forEach items="${FG}" var="data">
									<option class="fst-italic" value="${data.no}">${data.name}</option>
								</c:forEach>
							</select><hr/>
						</div>
						<div class="col-1"></div>
					</div>
				</div>
				<div class="col-4"></div>								
			</div>
			<div class="row mt-3">
				<div class="col-1"></div>
				<div class="col-1"><i class="bi bi-card-text text-secondary fs-4"></i></div>					
				<div class="col"><input class="btn btn-outline-secondary" type="text" name="content" placeholder="친구 설명 작성"></div>					
			</div>			
				<div class="row mt-5">
					<div class="col-1"></div>									
					<div class="col-2"><a class="fst-italic text-primary text-opacity-75 fs-6" href="./friends.do">Friends 페이지</a></div>
					<div class="col text-start"> <button type="submit" class="btn-sm btn-secondary fst-italic"><i class="bi bi-person-plus-fill text-primary fs-7"></i> 친구 추가 하기</button></div>				
				</div>
			</form>	
		</div>
		<div class="col-1">
			<aside>
				<jsp:include page="../common/aside.jsp"/>
			</aside>
		</div>
		<div class="col-2"></div>	
	</div>
	<footer>
			<jsp:include page="../common/footer.jsp"/>
	</footer>
</div>

		
	


		
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>