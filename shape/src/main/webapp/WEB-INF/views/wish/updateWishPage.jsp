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
			        <form action="./updateWishProcess.do" method="post">
			        
			            <div class="row">
			                <div class="col-2 mt-5"></div>
			                <div class="col-8 mt-5 mb-5">
			                    <h1 class="fw-bold text-center mt-5"><span style="">WISH PLAN 수정 <i class="bi bi-hammer"></i></span></h1>
			                </div>
			                <div class="col-2 mt-5"></div>
			            </div>                                                                                              
			            <div class="row mb-5">
			                <div class="col-4"></div>
			                <div class="col-4 mt-5">
			                    <div class="row mb-2">
			                        <h4 class="fw-bold text-center mb-3">카테고리 설정</h4>
			                    </div>
			                    <div class="row">
			                        <div class="col">
									 	<select class="form-select" name="small_category_no"> 
									 		<option selected>소분류</option>
											<c:forEach items="${smallList }" var="data">
												<option value="${data.no }">${data.small_name }</option>
											</c:forEach>
										</select>						
			                        </div>
			                    </div>
			                </div>
			                <div class="col-4"></div>   
			            </div>
			            		            
			            <div class="row mb-5">
				            <div class="col-4"></div>
				            <div class="col-4">
				            	<div class="row">
				            		<h4 class="fw-bold text-center mt-5">위시 주제 바꾸기</h4>
				            	</div>
				            	<div class="row mt-3">
				            		<input type="text"  class="form-control" name="title" placeholder="해외여행, 바디프로필,...">
				            	</div>
				            </div>
				            <div class="col-4"></div>
			            </div> 
			            
			            
			            
			            <div class="row mb-5">
				            <div class="col-4"></div>
				            <div class="col-4">
				            	<div class="row">
				            		<h4 class="fw-bold text-center mt-5">위시 내용 바꾸기</h4>
				            	</div>
				            	<div class="row mt-3">
				            		<input type="text" class="form-control" name="content" placeholder="어떤 위시인지 간단히 설명 해 주세요!">
				            	</div>
				            </div>
				            <div class="col-4"></div>
			            </div> 
			
		
			            <div class="row">
			                <div class="col-4"></div>
			                <div class="col-4">
			                    <div class="row">
			                    	<h4 class="fw-bold text-center mt-5">공개 여부 설정</h4>
			                    </div>
						
								<div class="row mt-3 mb-5">
									<div class="form-check">
									  <input class="form-check-input" type="radio" name="access_option" id="flexRadioDefault1" value="private">
									  <label class="form-check-label" for="flexRadioDefault1">
									    private
									  </label>
									</div>
									<div class="form-check">
									  <input class="form-check-input" type="radio" name="access_option" id="flexRadioDefault2" value="onlyfriends">
									  <label class="form-check-label" for="flexRadioDefault2">
									    only friends
									  </label>
									</div>            
									<div class="form-check">
									  <input class="form-check-input" type="radio" name="access_option" id="flexRadioDefault2" value="public">
									  <label class="form-check-label" for="flexRadioDefault2">
									    public
									  </label>
									</div>    
								</div>
								
			                </div>
			                <div class="col-4"></div>
			            </div> 
			            
			
			            
			            
			            <div class="row mt-5 mb-5">
			                <div class="col-4"></div>
			                <div class="col-4 d-grid">
			                    <input type="hidden" name="plan_check" value="N">
			                    <input type="hidden" name="no" value="${wishNo }">
			                    <button type="submit" class="btn btn-primary opacity-75 btn-lg">위시 수정</button>
			                </div>
			                <div class="col-4"></div>
			            </div>  
			
			        </form>
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
