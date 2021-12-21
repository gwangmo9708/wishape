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
							<h1 class="fw-bold text-center">질문 작성</h1>
						</div>
					</div>
					
					<div>
                        <div class="row mt-5">
                            <div class="col mt-5">
                                <h3 class="fw-bold text-center">질문 쓰기</h3>
                            </div>
                        </div>
                        
                        <div class="row mt-3">
                            <div class="col">
                            
                                <form action="./writeQuestionProcess.do" method="post" enctype="multipart/form-data">
                                	<div class="mb-3 container-fluid">
                                		<h4><i class="bi bi-person-circle"></i> ${user.id }</h4>
                                	</div>
									<hr style="border-color: grey;">
									<div class="mb-3 container-fluid">
										
										<textarea class="form-control" name="content" id="exampleFormControlTextarea1" rows="3" required="required"></textarea>
										<div class="input-group mt-5">
											<input type="file" class="form-control" multiple accept="image/*" name="filesQuestion" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
											<button class="btn btn-outline-secondary" type="button" id="inputGroupFileAddon04">이미지</button>
										</div>
									</div>
									<div class="mb-3 form-check">
										<input class="form-check-input" type="checkbox" name="private_check" value="y" id="flexCheckDefault">
										<label class="form-check-label" for="flexCheckDefault">
											비밀글
										</label>
									</div>
									<div class="container-fluid">
										<div class="row">
											<div class="col"></div>
											<div class="col-2 d-grid">
												<button type="submit"  class="btn btn-secondary">작성 완료</button>
											</div>
										</div>
									</div>
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