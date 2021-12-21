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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
<style>
	
	#storyCard{
		padding:17px;
	}
	
	#storyTextbox{
		border-radius: 10px;
	}

</style>

<script type="text/javascript">
	var storyModal = null;
	
	window.addEventListener('DOMContentLoaded',function(){
		storyModal = new bootstrap.Modal(document.getElementById('updateStoryForm'));
	});             
	

	

	 // 수정버튼 누르면 모달 뜨게
	function showStoryModal(storyNo){
	
		document.getElementById("updateTextForm").value = ""; 
		 
		document.getElementById("hidden_story_no").value = storyNo;
		 
		storyModal.show();
	 }
	
	
	 // 스토리 닫기 버튼 활성화
	function hideStoryModal(){
		storyModal.hide();
	 }
		
	function updateStoryProcess(){
		
		// 수정 스토리 textarea 
		var updateText = document.getElementById("updateTextForm").value;
		// 히든 storyNo 
		var hidden_story_no = document.getElementById("hidden_story_no").value;
		
		
		
		var xmlhttp = new XMLHttpRequest();
		
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				//렌더링
				var storyContent =  document.getElementById("storyContent");
				storyContent.value = updateText;
				
			}
		};
		
		
		xmlhttp.open("post" , "./updateStoryProcess.do"); //입력은 post가 유리
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("no=" + hidden_story_no + "&content=" + updateText);	
		
		
		storyModal.hide();
		
		location.href = "./storyUserProfile.do?friend_member_no="+userNo;
	}
	
	
	//좋아요
	function doStoryLike(target , storyNo){
		//alert(storyNo);
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				getMyLikeCount(target , storyNo);
			}
		};
		
		//get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./doStoryLike.do?story_no=" + storyNo); 
		xmlhttp.send();
	}
	
	function getMyLikeCount(target , storyNo){
		
		var xmlhttp = new XMLHttpRequest();
		var likeBox = target.getElementsByTagName("i");
		
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				//....렌더링...
				if(data.myLikeCount > 0){
					likeBox[0].setAttribute("class" , "bi bi-hand-thumbs-up-fill fs-4 text-primary");				
				}else{
					likeBox[0].setAttribute("class" , "bi bi-hand-thumbs-up fs-4 text-primary");
				}
				
				target.parentElement.getElementsByClassName("totalLikeBox")[0].innerText = data.totalLikeCount;
			}
		};
		
		//get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./getMyLikeCount.do?story_no=" + storyNo); 
		xmlhttp.send();
	}

	//프로필 마우스오버 - 색 변화
	function highlightUser(e){
		
		e.style.color = "#0080FF";
		
	}
	
	function unhighlightUser(e){
		e.style.color = "black";
	}

	
	
	
	// 친구 추가하기.
	function createMyFriend(){
		
		if(${empty user}){
			window.location.href="../member/login.do";
			return;
		};
			
		var friendsIcon = document.getElementById("friendsIcon");
		
		
		if(userNo == ${user.no}) {
			
			friendsIcon.setAttribute("class", "bi bi-person-circle");
			alert("자기 자신과 친구추가를 할 수 없습니다.");
			return;
			
		}
		
		
		if(friendsIcon.getAttribute("class") == "bi bi-person-check-fill") {
			
			alert(userId+" 님과 친구입니다.");
			return;
			
		}
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		// document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				alert(userId+" 님이 친구추가 되었습니다.")
				getMyFriendsList();
			}
		};
		
		xmlhttp.open("get" , "../member/createFriend.do?member_no="+userNo);
		xmlhttp.send();
		
	}
	// 친구 리스트 확인하기.
	function getMyFriendsList(){
		
		if(${empty user}){
			window.location.href="../member/login.do";
			return;
		};
		
		var friendsIcon = document.getElementById("friendsIcon");
		
		
		if(userNo == ${user.no}) {
			
			friendsIcon.setAttribute("class", "bi bi-person-circle");
			return;
			
		}
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		// document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(memberNo of data.myFriendsList) {
					
					
					if(userNo == ${user.no}) {
						
						friendsIcon.setAttribute("class", "bi bi-person-circle");
						friendsIcon.setAttribute("style", "font-size: 18px;")
						return;
						
					}
					
					if(memberNo == userNo) {
						
						friendsIcon.setAttribute("class", "bi bi-person-check-fill");
						friendsIcon.setAttribute("style", "font-size: 18px; color:blue;")
						return;
					}
					
					
					friendsIcon.setAttribute("class", "bi bi-person-plus-fill");
					friendsIcon.setAttribute("style", "font-size: 18px; color:black;")
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "../member/getMyFriendsList.do");
		xmlhttp.send();
		
	}
	
	// 초기화
	function init(){
		
		getMyFriendsList();
		
	}
	
	// 문서 onload API.
	window.addEventListener('DOMContentLoaded', init);
	
	
	
</script>
</head>
<body>
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>





	
	<!-- 스토리 수정 Modal -->
		<div class="modal fade" id="updateStoryForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">스토리 수정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<textarea class="form-control" name="content" id = "updateTextForm"></textarea><!--스토리 내용-->
					</div>
					
					<div class="modal-footer">
						<button type="submit" onclick="updateStoryProcess()" class="btn btn-primary">스토리 수정</button>
						<button type="button" onclick="hideModal()" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
					<input type="hidden" name="no" id="hidden_story_no">
				</div>
			</div>
		</div>
	
	<div class="container-fluid bg-secondary text-black bg-opacity-10">
		

		<div class="row">
			<div class="col">
				<jsp:include page="../common/aside2.jsp"/>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>
	
			
			<!--본문 스토리-->
			<div class="col-5">

			<!--상단프로필바 -->
				<div class="row">
					<div class="col">
						<div class="row bg-primary text-black bg-opacity-10" style="height:200px"><!-- 이미지 넣는 범위 -->
					    <img width="830px" height="200px" src="/shape/resources/story.jpg">
						</div>
				
						<div class="row bg-white">
						<div class="col-7 mt-2">
							<h2><i class="bi bi-person-circle"></i>
								<c:forEach items="${relatedProfileStoryList }" var="data" varStatus="status">
									<c:if test="${status.index == 0}">
										${data.memberVo.id }
										<script>
											var userNo = "${data.memberVo.no}";
											var userId = "${data.memberVo.id}";
										</script>
									</c:if>
								</c:forEach>
							</h2> 
						</div>
						<div class="col-5"></div>
						<div  class="col mt-1 mb-2" align="right">
							<div class="col-1 text-center btn" onclick="createMyFriend()">
								<a id="friendsIcon" class="bi bi-person-plus-fill"  style="font-size: 18px; color:black;"></a>
							</div>
						</div> 
						</div>
					</div>
				</div>
	

				<!--프로필 바 하단-->
				<div class="row">
					<!--위시 리스트-->
					<div class="col-3 mt-3 ">
						<div class="sticky-top">
							<div class="card mt-3 shadow">
								<div class="card-body" align="center">
									Wish
								</div>
							</div>
							<div class="mt-3 ">
								<c:if test="${empty list2}">
									<div class="card mt-3">
										<div class="card-body">
											<div class="row">
												<div class="col" align ="center">
													<span>위시가</span><br>
													<span>없습니다.</span>
												</div>
												<div class="col-4 mt-2 " align ="center"> 
													<i class="bi bi-clipboard-x align-middle"></i>
												</div>
											</div>
										</div>
									</div>	
								</c:if>
								<c:forEach items="${list2 }" var="data3">
									<div class="card mt-3">
										<div class="card-body">
											<div class="row">
													<div class="col">
														<div class="row-1">
															<div class="col" align="center">
																<div class="card-title">${data3.wishVo.title }</div>
															</div>
														</div>
														<div class="row-4">
															<div class="col mt-3" align="center">
																<div  class="card-text">${data3.wishVo.content }</div>
															</div>
														</div>
														<div class="row-1">
															<div class="col d-grid mt-3" align="center">
																<a href="/shape/wish/getWishDataByWishNo.do?wish_no=${data3.wishVo.no}" class="btn btn-primary">위시 보기</a><!--!!!!!!!!!!!!위시 페이지랑 링크 연결!!!!!!!!!!!!!!!!-->
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
								</c:forEach>
							</div>
						</div>
					</div>



					<!--스토리 카드 리스트 -->
					<div class="col-9 mt-3">
						<article>
							<div class="card mt-3 shadow">
								<div class="card-body" align="center">
									Story
								</div>
							</div>
							<div>
								<c:forEach items="${relatedProfileStoryList }" var="data">
									<div class="card rounded container-fluid mt-3" id="storyCard">
										<!--상단 바?-->
										<div class="row">
											<div class="col">
												<div class="row">
													<div class="col-1 mt-1">
														<h4><i class="bi bi-person-circle"></i></h4>
													</div>
													
													<!-- 아이디 누르면 해당 아이디 프로필로 이동! -->
													<div class="col-5 userId btn" style="text-align:left; padding-left:6px" onclick="location.href='./storyUserProfile.do?friend_member_no=${data.memberVo.no}'" onmouseover="highlightUser(this)" onmouseout="unhighlightUser(this)">
														${data.memberVo.id }
													</div>
													<div class="col" ></div><!-- 가로 공백-->
													<!--스토리 삭제 버튼/ 로그인시, admin일 경우 뜨게-->
													<c:if test="${!empty user && data.storyVo.member_no == user.no || user.no == 0}">
														<div class="col-2 d-grid">
															<a href="./deleteStoryProcess.do?no=${data.storyVo.no }" class="btn" role="button"><h4><i class="bi bi-trash"></i></h4></a>
														</div>
														<div class="col-2 d-grid" onclick="showStoryModal(${data.storyVo.no })">
															<a class="btn" role="button"><i class="bi bi-pencil-square fs-4 text-dark"></i></a>
														</div>
													</c:if> 
												</div>
												<div class="row">
													<div class="col">
														<fmt:formatDate value="${data.storyVo.write_date }" pattern="yy.MM.dd hh:mm"/>
													</div>
												</div>
											</div>
											
										</div>
							
										<!--본문-->
										<div class="row-1"></div>
										<div class="row mt-3">
											<!--스토리 이미지/ 첨부 안하면  글만-->
											<c:choose>
												<c:when test="${data.countStoryImage > 0 }">
													<img src="/uploadStory/${data.storyVo.image_file_link }" class="card-img-top" alt="...">
												</c:when>
												<c:otherwise>
													<div></div>
												</c:otherwise>
											</c:choose>
											
											
											<div class="card-body">
												<p class="card-text text-break" id = "storyContent">${data.storyVo.content}</p><!--스토리 내용-->
											</div>
											<!--좋아요-->
											<div>
												<c:if test="${!empty user }">
													<c:choose>
														<c:when test="${data.myStoryLikeCount>0 }">
															<span onclick="doStoryLike(this,${data.storyVo.no })" >
																<i id="likeBox" class="bi bi-hand-thumbs-up-fill fs-4 text-primary"></i>
															</span>
														</c:when>
														<c:otherwise>
															<span onclick="doStoryLike(this,${data.storyVo.no })" id="likeBox">
																<i id="likeBox" class="bi bi-hand-thumbs-up  fs-4 text-primary"></i>
															</span>
														</c:otherwise>
													</c:choose>
												</c:if>
												<span class="totalLikeBox">${data.totalStoryLikeCount }</span>
											</div>
										</div>
							
										<hr style="border-color: grey;">
							
										<!--댓글 리스트-->
										<div class="row">
											<c:forEach items="${data.storyReplyMemberList}" var="data2">													
												<div class="col-10 mt-2">
														<div class="row">
															<div class="col">
																<div class="row">
																	<div class="col-2">
																		<i class="bi bi-person-circle"></i>  <span onclick="location.href='./storyUserProfile.do?friend_member_no=${data2.replyMemberVo.no}'">${data2.replyMemberVo.id}</span>
																	</div>
																	<div class="col-10 bg-opacity-10" style="color:black; background-color:#E6E6E6; padding:20px; border-radius: 0px 10px 20px 30px;">
																		${data2.storyReplyVo.content }
																	</div>
																</div>
																<div class="row">
																	<div class="col-2"></div><!--좌측 공백-->
																	<div class="col-10" style="color:#848484">
																		<fmt:formatDate value= "${data2.storyReplyVo.write_date }" pattern="yy.MM.dd hh:mm"/>
																	</div>
																</div>
															</div>
														</div>
												</div>
												<div class="col-2 mt-2">
													<!-- 댓글 삭제 /로그인시, admin일 경우 뜨게 -->
													<c:if test="${!empty user && data2.storyReplyVo.member_no == user.no || user.no == 0}">
														<div class="row">
															<div class="col">
																<a style = "bg-dark" href="./deleteStoryReplyProcess.do?reply_no=${data2.storyReplyVo.no }&story_no=${data.storyVo.no}"><i class="bi bi-trash fs-5 text-dark"></i></a>
															</div>
														</div>
													</c:if> 
												</div>
											</c:forEach>	
										</div>
	
	
										
										<!--댓글 입력 창-->
										<div class="row mt-5">
											<div class="col">
												<form action="./writeProfileStoryReplyProcess.do" method="get">
													<input type="hidden" name="story_no" value="${data.storyVo.no}"><!--히든 타입/ 스토리 no 보내기용-->
													<input type="hidden" name="friend_member_no" value="${data.storyVo.member_no}">
													<div class="row">
														<div class="col-1">
															<h4><i class="bi bi-person-circle"></i></h4>
														</div>											
														<div class="col-10 bg-opacity-10" style="color:black; background-color:#E6E6E6; padding:20px; border-radius: 0px 10px 20px 30px;">
															<div class="row">
																<div class="col-10">
																	<textarea class="form-control" name="content" style="background-color: transparent; border: none" required="required" placeholder="댓글을 달아주세요." rows="1"></textarea>
																</div>
																<div class="col-2 d-grid">
																	<input type="submit" class="btn btn-sm btn-outline-secondary"  value="등록">
																</div>
															</div>
														</div>
														<div class="col-1"></div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</article>
					</div>
				</div>
				<div class="row mb-5"></div><!-- 하단 공백 -->
			</div>


			<div class="col"></div>
			
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