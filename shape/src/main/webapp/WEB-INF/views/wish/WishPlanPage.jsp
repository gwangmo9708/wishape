<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
</head>
<!-- 나의 시작하지 않은 위시만 보이는 페이지. -->
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
				<div class="row mt-5">
					<div class="col">
				  		<div class="card shadow-sm py-2">
				  			<div class="card-body fs-3 text-center fw-bold">
					    		시작 하지 않은 위시 플랜 <i class="bi bi-calendar-x"></i>
							</div>
				  		</div>
					</div>
				</div>
	            <div class="card shadow bg-white p-4 mt-3">
	            <div class="row">
	                <c:forEach items="${wishAndToDoPlanList }" var="data">           
	                    <div class="col-6">
							<div class="card shadow-sm my-2">
		                    	<div class="row">
		                    		<div class="col-1"></div>                   		
		                    		<div class="col">	
				                        <div class="row">
				                            <div class="col text-center fw-bold fs-3 mt-5 mb-5">
				                            	${data.wishVo.title }
				                            </div>
				                        </div>
				                        <c:forEach  items="${data.todoList }" var="data2">
				                        <div class="row mt-2">
				                            <div class="col-1">
				                            	<div class="row"></div>
				                            	<div class="row">
				                            		<div class="col"></div>
				                            		<div class="col text-end">
				                            		</div>
				                            		<div class="col"></div>
				                            	</div>
				                            	<div class="row"></div>    
				                            </div>
				                            <div class="col mt-1">
				                                <div class="row">
				                                	<div class="col-2"></div>
				                                	<div class="col fw-bold">
				                                		${data2.title}
				                                	</div>                              
				                                </div>
				                                <div class="row">
				                                	<div class="col-2">
				                                		<i class="bi bi-check2-circle" style="color:#00008B"></i>
				                                	</div>                                  
				                                	<div class="col">
				                                		${data2.content}
				                                	</div>                                  
				                                </div>
				                            </div>
				                            <div class="col-3 mt-3">
				                                <c:choose>
				                                    <c:when test="${data.wishVo.plan_check  eq 'N'}">
														<form action="./updateToDoPage.do">
															<input type="hidden" name="toDoNo" value="${data2.no }">
															<input type="hidden" name="wishTitle" value="${data.wishVo.title }">
															<button class="btn btn-secondary btn-sm ">
																<i class="bi bi-pencil-square"></i>
															</button>
														</form>
				                                    </c:when>
				                                    <c:otherwise>
				                                    	<!-- 그냥 빈칸 -->                             	
				                                    </c:otherwise>
				                                </c:choose>
				                            </div>
				                            <div class="col-1"></div>
				                        </div>
				                        </c:forEach>
				                        <div class="row">
				                            <div class="col-3"></div>
				                            <div class="col">
			                                <c:choose>
				                                    <c:when test="${data.wishVo.plan_check  eq 'N'}">
				                                        <form action="./makeToDoPage.do" method="post"> 
				                                            <button class="form-control btn btn-primary mt-5">투두 추가 <i class="bi bi-plus"></i></button>
				                                            <input type="hidden" name="wish_no" value="${data.wishVo.no }">                                        
				                                        </form> 		                                          
				                                    </c:when>
				                                    <c:otherwise>
				                                    	<!-- (그냥 공백) -->
				                                    </c:otherwise>
				                                </c:choose>             
				                            </div>
				                            <div class="col-3"></div>
				                        </div>			      
				                        <div class="row mt-3">
				                            <div class="col mt-2">
				                            	<hr>
				                            </div>
				                        </div>
				                        <c:choose>
				                        <c:when test="${data.wishVo.plan_check  eq 'N'}">
				                        <div class="row">
				                        	<div class="col-1"></div>	                        
				                            <div class="col mt-2 d-grid">
				                                <form action="./updatePlanCheck.do">
				                                	<input type="hidden" name="wishNo" value="${data.wishVo.no }">
				                                    <button class="form-control btn btn-primary">이대로 확정! <i class="bi bi-check2"></i></button>
				                                </form>                                            
				                            </div>
				                            <div class="col-1"></div>	                            
				                        </div>
				                        <div class="row mt-1 mb-5">
				                            <div class="col-6">
				                            	<div class="row">
				                            		<div class="col-2"></div>
				                            		<div class="col">
														<form action="./updateWishPage.do">
															<input type="hidden" name="wishNo" value="${data.wishVo.no }">
															<button class="form-control btn btn-secondary">수정</button>
														</form>		                            		
				                            		</div>
				                            		
				                            	</div>	
				                            </div>
				                            <div class="col-6">
				                            	<div class="row">
				                            		<div class="col">
						                                <form action="./deleteWishProcess.do">
						                                    <button class="form-control btn btn-secondary">삭제</button>
						                                    <input type="hidden" name="no" value="${data.wishVo.no }">
						                                </form>		                            		
				                            		</div>
				                            		<div class="col-2"></div>
				                            	</div>    
				                            </div>
				                        </div>
				                        </c:when>
				                        <c:otherwise>
				                        <div class="row">
				                            <div class="col">
				                            	<div class="row">
				                            		<div class="col-1"></div>
				                            		<div class="col mt-2">
						                                <form action="./wishTodoRun.do">
						                                	<input type="hidden" name="wish_no" value="${data.wishVo.no }">
						                                    <button class="form-control btn btn-primary">위시 시작하기</button>
						                                </form>		                            		
				                            		</div>
				                            		<div class="col-1"></div>
				                            	</div>      
				                            </div>
				                        </div>
				                        <div class="row mt-1 mb-5">
				                            <div class="col">
				                            	<div class="row">
				                            		<div class="col-1"></div>
				                            		<div class="col">
						                                <form action="./deleteWishProcess.do">
						                                    <button class="form-control btn btn-secondary">삭제</button>
						                                    <input type="hidden" name="no" value="${data.wishVo.no }"> 
						                                </form>		                            		
				                            		</div>
				                            		<div class="col-1"></div>
				                            	</div>
				                            </div>
				                        </div>
				                        </c:otherwise>
				                        </c:choose>                  			
		                    		</div>
		                    		<div class="col-1"></div>
		                    	</div>
	                    	</div>
	                    </div>
	                </c:forEach>
	            </div>
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
			<div class="col-2">
			</div>
	    </div>
    </div>
    
    <div class="row mt-5"></div>
    <div class="row mt-5"></div>
    
 
    <footer class="bg-white card shadow">
        <jsp:include page="../common/footer.jsp"/>
    </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		
</body>
</html>