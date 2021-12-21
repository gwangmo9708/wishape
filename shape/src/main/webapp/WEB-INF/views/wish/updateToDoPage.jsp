<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
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
	        <div class="col">
	        	<div class="card mx-5">
		            <div class="row">
		                <div class="col-3"></div>
		                <div class="col">
		                    <div class="row">
		                        <h1 class="fw-bold text-center mt-5 mb-5">투두 수정하기 <i class="bi bi-hammer"></i></h1>
		                    </div>
		                    <form action="./updateToDoProccess.do" method="post">
		                        <div class="row">
		                            <div class="col">
		                                <div class="row mt-5">
		                                    <h2 class="text-center text">Wish</h2>
		                                </div>
		                                <div class="row mt-2">
		                                    <div class="fs-2 text-center">${title }</div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="row mt-5">
		                            <div class="col">
		                                <div class="row mt-5">
		                                	<div class="col"></div>
		                                    <h3 class="text-center">투두 주제 정하기</h3>
		                                </div>
		                                <div class="row">
		                                	<div class="col"></div>
		                                    <input class="text-center rounded border" type="text" name="title" placeholder="예) 유산소 운동 하기">
		                                </div>
		                            </div>
		                        </div>
		                        <div class="row mt-5">
		                            <div class="col">
		                                <div class="row mt-5">
		                               		<div class="col"></div>
		                                    <h3 class="text-center">투두 상세 내용</h3> 
		                                </div>
		                                <div class="row">
		                                	<div class="col"></div>
		                                    <input class="text-center rounded border" type="text" name="content" placeholder="예) 하루 30분 한강변 달리기 ">
		                                </div>
		                            </div>
		                        </div>
		                        <div class="row mt-5">
		                            <div class="col">
		                                <div class="row mt-5">
		                                	<div class="col-2"></div>
		                                	<div class="col">
		                                    	<input type="hidden" name="no" value="${toDoNo }">
		                                    	<button type="submit" class="btn btn-primary opacity-75 text-center form-control" >투두 수정하기</button>                              	
		                                	</div>
		                                	<div class="col-2"></div>
		                             
		                                </div>
		                                <div class="row mt-2">
		                                	<div class="col-2"></div>
		                                	<div class="col">
		                                		<button class="text-center form-control btn btn-secondary text-white"type="reset">다시 작성하기</button>
		                                	</div>
		                                	<div class="col-2 "></div>
		                                </div>
		                            </div>
		
		                        </div>
		                    </form>
		                </div>
		                <div class="col-3"></div>
		            </div>
		            <div class="row mb-5"></div>
	            </div>
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
	
    <footer class="bg-white card shadow">
        <jsp:include page="../common/footer.jsp"/>
    </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		        
</body>
</html>