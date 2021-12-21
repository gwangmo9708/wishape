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
			<form action="./sendMessageProcess.do">
				<input type="hidden" name="from_member_no" value="${user.no}">
				<input type="hidden" name="to_member_no" value=" ${map.memberVo.no}">
			<div class="row mt-5">
				<div class="col-3"></div>
				<div class="col text-secondary text-center fw-bold fs-5"><i class="bi bi-chat-right  text-primary text-opacity-75 fs-5"></i> 메시지 보내기<hr/></div>
				<div class="col-4"></div>
			</div>
			<div class="row mt-3">
				<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-person-circle text-primary"></i> From</div>
				<div class="col-3 fst-italic text-begin text-secondary fs-6"> ${user.id}<hr/></div>
				<div class="col-3"></div>
				<div class="col-3"></div>
			</div>
			<div class="row mt-2">
				<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-person-square text-primary"></i> To</div>
				<div class="col-3 fst-italic text-begin text-secondary fs-6">${map.memberVo.id}<hr/></div>
				<div class="col-3"></div>
				<div class="col-3"></div>
			</div>
			<div class="row mt-2">
				<div class="col-3 text-secondary text-end text-opacity-75 fs-6"><i class="bi bi-pencil text-primary"></i> 내용</div>
				<div class="col-5 fst-italic">
				<div class="form-floating">
					<textarea class="form-control" placeholder="Leave a comment here"name="content" cols="30" rows="8" id="floatingTextArea"></textarea>
						<label for="floatingTextarea">내용을 작성 해주세요</label>					
				</div>
				</div>
				<div class="col-2"></div>
				<div class="col-2"></div>
			</div>
			<div class="row mt-5 mb-3">
				<div class="col-2"></div>
				<div class="col"><a class="fst-italic text-primary text-opacity-75 fs-7" href="./message.do">Message 페이지</a></div>
				<div class="col"> <button class="btn-sm btn-secondary text-opacity-75 fs-7" type="submit"><i class="bi-sm bi-cursor"></i> 보내기</button></div>
				<div class="col-2"></div>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>s
</body>
</html>