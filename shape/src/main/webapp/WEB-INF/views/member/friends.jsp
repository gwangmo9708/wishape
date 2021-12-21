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
			<div class="col-1"></div>
			<div class="col-2 px-5">
				
				<aside>
					<jsp:include page="../common/aside2.jsp"></jsp:include>
				</aside>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>	
			<div class="col card mx-5">
				<div class="row mt-5">
					<div class="col-4">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-6 text-secondary fs-5 fw-bold"><i class="bi bi-person-plus text-primary text-opacity-75"></i> 친구 추가<hr/></div>
							<div class="col-3"></div>							
						</div>
					</div>
					<div class="col-4"></div>
					<div class="col-4"></div>					
				</div>
				<div class="row mt-3">
					
					<div class="col-11">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-8">
							<form action="./friends.do">
								<div class="row mb-4">									
									<div class="col-6"><input class="btn btn-outline-secondary form-control fst-italic text-start" name="searchWord"  type="text" name="" placeholder="아이디 입력"></div>
									<div class="col-4"><button class="btn btn-light fs-6" type="submit"><i class="bi bi-search"></i></button></div>
									
								</div>
							</form>	
							</div>
																				
						</div>
						<c:forEach items="${member_list}" var="data">
							<form action="./addFriends.do">
								<input type="hidden" name="no" value="${data.memberVo.no}">
								<c:if test="${data.memberVo.no != user.no}">
									<div class="row">
										<div class="col-1"></div>
										<div class="col">									
											<div class="row mt-1">											
												<div class="col-3"><i class="bi bi-person-circle"></i> ${data.memberVo.id}</div>
												<div class="col-3 text-center text-primary"><i class="bi bi-filter-right"></i>${data.bigCategory.big_name}<hr/></div>
												<div class="col-3 text-center text-secondary"><i class="bi bi-filter-right"></i>${data.smallCategory.small_name}<hr/></div>
												<div class="col-3"><button class="btn btn-primary" type="submit"><i class="bi bi-person-plus-fill"></i></button></div>
											</div>
										</div>	
									</div> 
								</c:if>
							</form>
						</c:forEach>
						<div class="row">
							<div class="col-1"></div>
							<div class="col"><hr/></div>
							<div class="col-1"></div>
						</div>
						
									
						<div class="row mt-5">
							<div class="col-4">
								<div class="row">
									<div class="col-1"></div>
									<div class="col-6 text-secondary text-start fw-bold fs-5"><i class="bi bi-people text-primary"></i> 내 그룹<hr/></div>
																	
								</div>
							</div>							
						</div>							
						<div class="row mt-4">
							<div class="col-1"></div>
							<div class="col-8">
								<div class="row">
									<div class="col-3 fs-6 text-secondary fst-italic"><i class="bi bi-people-fill"></i> 기본 (설명)<hr/></div>																	
								</div>
							</div>							
						</div>	
						<c:forEach items="${friends_list}" var="data2">
							<form action="./updateFriendsToProcess.do">
								<c:if test="${data2.friendsGroupVo.name != '기본그룹'}">
									<input type="hidden" name="friends_group_no" value="${data2.friendsGroupVo.no}">
									<div class="row mt-2">
										<div class="col-1"></div>
										<div class="col-8">
											<div class="row mt-4">
												<div class="col-4 fst-italic text-primary target fs-6">
													<i class="bi bi-people-fill"></i> ${data2.friendsGroupVo.name} (${data2.friendsGroupVo.content})
													<hr/>
												</div>
												<div class="col-4">
													<button class="btn btn-light fst-italic" type="submit">
														<i class="bi bi-trash fs-4"></i>
													</button>
												</div>									
											</div>
										</div>
									</div>						
								</c:if>
							</form>									
							<c:forEach items="${data2.getFriendsAndMembers}" var="data3">													
								<div class="row mt-3">
									<div class="col-2"></div>																										
									<div class="col target">
										<i class="bi bi-person-lines-fill"></i> ${data3.memberVo.id} (${data3.friendsVo.content})										
									</div>
									<div class="col ">
									<form action="./sendMessage.do">										
											<input type="hidden" name="no" value="${data3.memberVo.no}">
											<input type="hidden" name="id" value="${data3.memberVo.id}">
											<button class="btn btn-primary" type="submit"><i class="bi-sm bi-cursor"></i></button>																				
										</form>
									</div>
									<div class="col-2 text-end">
										<form action="./updateFriendsMove.do">
											<input type="hidden" name="no" value="${data3.friendsVo.no}">
											<button class="btn btn-light fst-italic" type="submit"><i class="bi bi-pencil-square"></i></button>
										</form>
									</div>									
									<div class="col-2 text-start">							
										<form action="./deleteFriends.do">
										<input type="hidden" name="member_no" value="${data3.memberVo.no}">
										<button class="btn btn-light fst-italic" type="submit" value="친구 삭제"><i class="bi bi-x"></i></button>
										</form>
									</div>
																		
									
											
									
								</div>						
							</c:forEach>
						</c:forEach>
						
						<div class="row">
							<div class="col-1"></div>
							<div class="col"><hr/></div>
							<div class="col-1"></div>
						</div>
						
						<div class="row mt-2 mb-5">
							<div class="col-1"></div>
							<div class="col">
								<a class="fst-italic text-opacity-75 btn btn-secondary fs-6" href="../wish/index.do">메인 페이지 </a>
							</div>							
							<div class="col text-end"><form action="./addFriendsGroup.do">
									 <button class="btn-sm btn-secondary text-opacity-75 fst-italic fs-6" type="submit"><i class="bi bi-people-fill fs-5"></i> 새 그룹 추가</button>
								</form></div>
							
							<div class="col">
								<c:if test="${friends_list.size()>1 }">							
									<form action="./updateFriendsGroup.do">
										 <button class="btn-sm btn-secondary text-opacity-75 fst-italic fs-6" type="submit"><i class="bi bi-pencil-square fs-5"></i> 새 그룹 이름 변경</button>
									</form>
								</c:if>
							</div>							
						</div>		
					</div>					
				</div>
			</div>
			<div class="col-1">
					<div class="row sticky-top">
						<aside class="card shadow">
							<jsp:include page="../common/aside.jsp"/>
						</aside>
					</div>
			</div>
			<div class="col-1"></div>
		</div>
	</div>
		<footer>
			<jsp:include page="../common/footer.jsp"/>
		</footer>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>	
</body>
</html>