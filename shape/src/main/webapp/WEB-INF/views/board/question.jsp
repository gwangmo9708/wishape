<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
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
							<h1 class="fw-bold text-center">질문 게시판</h1>
						</div>
					</div>
					<!-- 예상 질문 -->
					<jsp:include page="./expectedQuestion.jsp" flush="false"/>
					
					<div class="row mt-5 ">
						<div class="col">
							<h3 class="fw-bold text-center">질문 목록</h3>
							<table class="table table-hover container-fluid" >
								<thead>
								  <tr>
									<th scope="col">글 번호</th>
									<th scope="col">작성자</th>
									<th scope="col">문의 질문</th>
									<th scope="col">작성일</th>
									<th scope="col">답변 수</th>
								  </tr>
								</thead>
								<tbody>
									<c:forEach items="${list }" var = "data">
										<tr>
											<th scope="row">${data.questionVo.no }</th>
											<td>${data.memberVo.id }</td>
											<c:choose>
												<c:when test="${data.questionVo.private_check == 'y' }">
													<!-- 유저 & 관리자만 볼 수 있게 -->
													<c:choose>
														<c:when test="${data.questionVo.member_no != user.no && user.no != 0}">
															<td><i class="bi bi-lock"></i>비밀글입니다.</td>
														</c:when>
														<c:otherwise>
															<td><a href="./readQuestionPage.do?question_no=${data.questionVo.no }">${data.questionVo.content }
																<c:if test="${data.countImage > 0}">
																	<i class="bi bi-images"></i>
																</c:if>
															</a></td>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<td><a href="./readQuestionPage.do?question_no=${data.questionVo.no }">${data.questionVo.content }
														<c:if test="${data.countImage > 0}">
															<i class="bi bi-images"></i>
														</c:if>
													</a></td>
												</c:otherwise>
											</c:choose>
											<td><fmt:formatDate value="${data.questionVo.write_date }" pattern="yyyy.MM.dd"/></td>
											<td>(${data.replyCount })</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="row mt-3">
								<div class="col-10"></div>
								<div class="col-2 d-grid">
									<c:if test="${!empty user }">
									<a class="btn btn-sm btn-secondary" href="./writeQuestionPage.do">글쓰기</a>
									</c:if>
								</div>
							</div>
							
						</div>
					</div>
					
					
					<!-- 검색 바 -->
					<form action="./question.do" method="get">
						<div class="row mt-5">
							   <div class="col-2">
								   <select name="searchQuestionOption" class="form-control">
									   <option value="content">질문 내용</option>
								   </select>
							   </div>
							   <div class="col">
								   <input name="searchQuestionWord" class="form-control" type="text" placeholder="검색어를 입력하세요">
							   </div>
							   <div class="col-2 d-grid">
								   <input class="btn btn-primary" type="submit" value="검색">
							   </div>
					   </div>
				   </form>
					   
					   
					<!-- 페이징 -->
					<div class="row mt-5">
						<div class="col-2"></div>
						<div class="col"  align="center">
							<nav aria-label="...">
								  <ul class="pagination justify-content-center">
								  	
								  	<c:choose>
								  		<c:when test="${beginQuestionPageNum <=1 }">
									  		<li class="page-item disabled">
									      		<a class="page-link">Previous</a>
									    	</li>
								  		</c:when>
								  		<c:otherwise>
								  			<li class="page-item">
									      		<a class="page-link" href="./question.do?pageNum=${beginQuestionPageNum-1 }${addParams}">Previous</a>
									    	</li>
								  		</c:otherwise>
								  	</c:choose>
								    
								    <c:forEach begin="${beginQuestionPageNum }" end="${endQuestionPageNum }" var="i">
								    	<c:choose>
								    		<c:when test="${currentQuestionPageNum == i }">
								    			<li class="page-item active"><a class="page-link" href="./question.do?pageNum=${i }${addParams}">${i }</a></li>
								    		</c:when>
								    		<c:otherwise>
								    			<li class="page-item"><a class="page-link" href="./question.do?pageNum=${i }${addParams}">${i }</a></li>
								    		</c:otherwise>
								    	</c:choose>
								    </c:forEach>
								    
								    <c:choose>
								    	<c:when test="${endQuestionPageNum >= totalQuestionBoardCount }">
									    	<li class="page-item disabled">
									      		<a class="page-link">Next</a>
									    	</li>
								    	</c:when>
								    	<c:otherwise>
								    		<li class="page-item">
									      		<a class="page-link" href="./question.do?pageNum=${endQuestionPageNum+1 }${addParams}">Next</a>
									    	</li>
								    	</c:otherwise>
								    </c:choose>
								    
								  </ul>
							</nav>
						</div>
						<div class="col-2"></div>
						
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