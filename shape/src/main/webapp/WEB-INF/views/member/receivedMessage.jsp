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
		<div class="col-3"></div>
		<div class="col card mx-5">
			<div class="row mt-5">
				<div class="col-4"></div>
				<div class="col-3 text-center text-secondary fw-bold fs-5"><i class="bi bi-mailbox2 text-primary"></i> 쪽지함<hr/></div>
				<div class="col-5"></div>
			</div>
				<c:forEach var="data" items="${toList}">
					<form action="./deleteReceivedMessage.do">
						<c:if test="${data.messageVo.delete_check == 'n'}">
							<input type="hidden" id="no" name="no" value="${data.messageVo.no}">
								<div class="row mt-3">
							    	<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-person-circle text-primary"></i> 보낸이</div>
							    	<div class="col-3 fst-italic text-begin fs-6">${data.memberVo.id}</div>
							    	<div class="col-3"></div>
							    	<div class="col-3"></div>
							    </div>
							    <div class="row mt-2">
							    	<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-list text-primary"></i> 내용</div>
							    	<div class="col-3 text-begin fs-6">${data.messageVo.content}</div>
							    	<div class="col-3"></div>
							    	<div class="col-3"></div>
							    </div>
							    <div class="row mt-2">
							    	<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-bell text-primary"></i>읽기 여부</div>
							    	<div class="col-3 fst-italic text-begin fs-6">
							    	<c:choose>
							    		<c:when test="${data.messageVo.read_check == 'y'}">
							    		<i class="bi bi-bell text-secondary"></i>
							    		</c:when>
							    		<c:otherwise>
							    		<i class="bi bi-bell-fill text-warning"></i>
							    		</c:otherwise>
							    	</c:choose>
							    	</div>
							    	<div class="col-3"></div>
							    	<div class="col-3"></div>
							    </div>
							    <div class="row">
							    	<div class="col-3 text-secondary text-end text-opacity-75 fs-6 mt-2"><i class="bi bi-calendar-event text-primary"></i> 보낸 날짜</div>
							    	<div class="col-3 fst-italic text-secondary fs-6 mt-2"><fmt:formatDate value="${data.messageVo.write_date}" pattern="yyyy-MM-dd"/></div>
							    	<div class="col-4 "><button class="btn btn-light fst-italic fs-4" type="submit"><i class="bi bi-trash"></i></button></div>
							    	<div class="col-2"></div>
							    </div>
							    <div class="row mt-2"></div>
							    <div class="row">
							    	<div class="col">
							    		 <hr>
							    	</div>
							    </div>
						</c:if>
					</form>
				</c:forEach>
					<div class="row mt-3 mb-5">
						<div class="col-2"></div>
						<div class="col text-center"><a class="fst-italic text-primary text-opacity-75 fs-7" href="./message.do">Message 페이지</a></div>
						<div class="col-2"></div>
					</div>	
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