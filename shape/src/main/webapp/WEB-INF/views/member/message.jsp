<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
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
				<form action ="./receivedMessage.do">
				<div class="row mt-5">
					<div class="col-5"></div>
					<div class="col-2 text-secondary fw-bold fs-4 mt-2">
						<i class="bi bi-messenger text-primary"></i> 
						메시지
					</div>
					<div class="col text-center text-secondary fst-italic">
						쪽지함
						<button class="btn btn-light fst-italic fs-2" type="submit">
							<i class="bi bi-mailbox2"></i>
						</button>
					</div>
				</div>
				<div class="row">
					<div class="col-3"></div>
					<div class="col">
						<hr/>
					</div>
					<div class="col-3"></div>
				</div>
				</form>
				<form action="./message.do">				
				<div class="row mt-2 mb-3">
					<div class="col-4"></div>
					<div class="col"><input class="btn btn-outline-secondary form-control fst-italic text-start"  type="text" name="searchWord" placeholder="아이디 입력"></div>
					<div class="col-4"><button class="btn btn-light fst-italic" type="submit"><i class="bi bi-search"></i></button></div>
					
				</div>
				
				</form>	
				<c:forEach items="${members}" var="data">
					<form action="./sendMessage.do">
					<input type="hidden" name="no" value="${data.no}">
				<div class="row mt-2">
					<div class="col-4 text-end fs-5 "><i class="bi bi-person-circle "></i></div>
					
					<div class="col-4 fst-italic text-begin text-secondary fs-5"> ${data.id}</div>
					
					<div class="col-4 text-start"><button class="btn btn-primary" type="submit"><i class="bi bi-messenger"></i></button></div>
				</div>
					</form>
				</c:forEach>
				<div class="row mt-5">
					<div class="col-4"></div>
					<div class="col">
						<nav>
							<ul class="pagination mb-0 justify-content-center">
								<c:choose>
									<c:when test="${beginPageNumber <= 1}">
										<li class="page-item disabled">
											<a class="page-link">Prev</a>
										</li>										
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a class="page-link" href="./message.do?pageNum=${beginPageNumber-1}${addParams}">Prev</a>
										</li>
									</c:otherwise>
								</c:choose>
								
								<c:forEach begin="${beginPageNumber}" end="${endPageNumber}" var="i">
									<c:choose>
										<c:when test="${pageNum == i}">
											<li class="page-item active"><a class="page-link" href="./message.do?pageNum=${i}${addParams}">${i}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link" href="./message.do?pageNum=${i}${addParams}">${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								
								<c:choose>
									<c:when test="${endPageNumber >= totalPageCount}">
										<li class="page-item disabled">
										<a class="page-link">Next</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
										<a class="page-link" href="./message.do?pageNum=${endPageNumber+1}${addParams}">Next</a>
										</li>
									</c:otherwise>
								</c:choose>
							</ul>
						</nav>
					</div>
					<div class="col-4"></div>
				</div>
					
				<div class="row mb-5"></div>
				
										
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