<%@page import="com.ja.shape.vo.QuestionReplyVo"%>
<%@page import="com.ja.shape.vo.QuestionVo"%>
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
			<div class="col">
			
				<div class="row">
					<div class="col-2">
						<jsp:include page="../common/aside2.jsp"/>
						<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
					</div>
					<div class="col-2"></div>
					<div class="col">
						<article>
							<div class="row mt-5">
								<div class="col mt-5">
									<h1 class="fw-bold text-center">질문 상세</h1>
								</div>
							</div>
							
							<div>
								<div class="row mt-5">
									<div class="col mt-5 container-fluid">
										<h4><i class="bi bi-person-circle"></i> ${data.memberVo.id }</h4>
										
										<fmt:formatDate value="${data.questionVo.write_date }" pattern="yyyy.MM.dd"/>

										<div class="row text-end"><!-- 글 삭제/수정 -->
											<div class="col container-fluid">
												<!-- 로그인 시에만 뜨게 -->
												<c:if test="${!empty user && user.no == data.questionVo.member_no}">	
													<a href="./deleteQuestionProcess.do?question_no=${data.questionVo.no }" class="btn" role="button"><h3><i class="bi bi-trash"></i></h3></a>
													<!-- 답변이 없을 시에만 질문 수정이 가능하게 -->
													<c:if test="${empty data2.questionReplyVo }">
														<a href="./updateQuestionPage.do?question_no=${data.questionVo.no }" class="btn" role="button"><i class="bi bi-pencil-square fs-4 text-dark"></i></a>
													</c:if>
												</c:if>
											</div>
										</div>
										<hr style="border-color: grey;">

										<!--본문-->
										<div class="mt-5 mb-5">
											<c:forEach items="${data.imageVoList }" var="imageVo">
												<img class="img-responsive" src="/uploadQuestion/${imageVo.file_link }">
											</c:forEach>
											
											<div class="mt-5 mb-5">
												${data.questionVo.content }<br>
											</div>
										</div>
									</div>
								</div>
								
								<!-- 답변 입력/삭제/수정 -->
								<div class="row">
									<div>
										<hr style="border-color: grey;">
									</div>
									<div class="p-3 mb-2 bg-secondary bg-opacity-10" style="height: auto; min-height: 200px;">
										<div class="col">
											<!-- admin 답변이 있는 경우/없는 경우 -->
											<c:choose>
												<c:when test="${!empty data2.questionReplyVo.content }"><!-- 있는 경우 -->
													<c:forEach items="${data2.imageVoList }" var="imageVo">
														<img class="img-responsive" src="/uploadReply/${imageVo.file_link }"><br>
													</c:forEach>
													<div class="mt-5">
														${data2.questionReplyVo.content }
													</div>
													<div class="mt-5 text-end">
														<c:if test="${!empty user && user.no == 0}"><a href="./deleteReplyProcess.do?reply_no=${data2.questionReplyVo.no }&question_no=${data.questionVo.no}" class="btn" role="button"><h4><i class="bi bi-trash"></i></h4></a></c:if><br>
													</div>
												</c:when>
												<c:otherwise><!-- 없는 경우 -->
													<!-- admin 계정만 답변을 달 수 있게 조건-->
													<c:if test="${!empty user && user.no == 0 && empty data2.questionReplyVo}">
														<div>
															
															<form action ="writeQuestionReplyProcess.do" method="post" enctype="multipart/form-data">
																<input type ="hidden" name="question_no"  value="${data.questionVo.no }">
																<textarea class="container-fluid" name="content" placeholder="답변을 입력하세요" required></textarea>
																
																
																<div class="input-group">
																	<input type="file" class="form-control" multiple accept="image/*" name="filesQuestion" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
																	<button class="btn btn-outline-secondary" type="button" id="inputGroupFileAddon04">이미지</button>
																</div>
																<div class="mt-3 text-end">
																	<input type="submit" value="등록" class="btn btn-secondary" role="button">
																</div>
															</form>
														</div>
													</c:if> 
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
								
								
								<div class="row mt-3">
									<div class="col">
									<a href="../board/question.do" class="btn btn-secondary" role="button">목록</a>
									</div>
								</div>
								
								

							</div>				
						</article>
						
					</div>
					

				</div>
			</div>
			<div class="col-1"></div>	
			<div class="col-1 pt-5">
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