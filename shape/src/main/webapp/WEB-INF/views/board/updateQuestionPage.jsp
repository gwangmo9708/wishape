<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<jsp:include page="../common/aside2.jsp"/>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>
			<div class="col-1"></div>
			<div class="col">
			
				<article>
					<div class="row mt-5">
						<div class="col mt-5">
							<h1 class="fw-bold text-center">수정 페이지</h1>
						</div>
					</div>
					
					<div class="container-fluid">
                        <div class="row mt-3">
                            <div class="col">
                            
                                <form action="./updateQuestionProcess.do" method="post">
                                	<div class="mb-3 container-fluid">
                                		<h4><i class="bi bi-person-circle"></i> ${user.id }</h4>
                                	</div>
									<hr style="border-color: grey;">
									<div class="mb-3 container-fluid">
										
										<textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="3">${data.questionVo.content }</textarea>
										<!-- 이미지 수정 불가?-->
									</div>
									<div class="mb-3 form-check">
										<input class="form-check-input" type="checkbox" name="private_check" value="y" id="flexCheckDefault"><!-- y는 공개 -->
										<label class="form-check-label" for="flexCheckDefault">
											비밀글
										</label>
									</div>
									<div class="container-fluid">
										<div class="row">
											<div class="col"></div>
											<div class="col-2 d-grid">
												<button type="submit"  class="btn btn-secondary">수정 완료</button>
											</div>
										</div>
									</div>
									<input type ="hidden" name="no" value="${data.questionVo.no }">
								</form>
                                
                                
                            </div>
                        </div>
                        
                    
                    
                    </div>				
				</article>
			</div>
			<div class="col-1"></div>
			<div class="col-1 mt-5">
			
				<aside>
					<jsp:include page="../common/aside.jsp"/>
				</aside>
				
			</div>
			<div class="col-1"></div>
		</div>
	</div>
	
	<!-- 줄맞추기 -->
	<div style="width:1200px" class="row">
		<div class="col mt-5"></div>
	</div>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>