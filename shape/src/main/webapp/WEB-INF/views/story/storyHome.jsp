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
		
		location.href = "./storyHome.do";
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

	

</script>
</head>
<body>
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


    <header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	
	
	<div class="container-fluid p-3 mb-2 bg-secondary text-black bg-opacity-10">
		<div class="row">
			<div class="col-3">
				<jsp:include page="../common/aside2.jsp"/>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>
			<div class="col-1"></div>
			
			<!--본문 스토리-->
			<div class="col">
			
				<article>
					<!--스토리 입력 창-->
					
					<div class="card">
						<div class="card-body">
							<!-- 로그인 시에만 뜨게 -->
							<c:if test="${!empty user}">	
												
								<div class="row bg-white">
									<div class="col">
										<form action="./writeStoryProcess.do" method="post" enctype="multipart/form-data" id = "storyTextbox">
											<div class="row">
												<div class="col-1">
													<h3><i class="bi bi-person-circle"></i></h3>
												</div>											
												<div class="col-11">
													<textarea class="form-control" name="content" required="required" placeholder=" '${user.id }' 님 스토리를 공유해주세요." id="exampleFormControlTextarea1" rows="3"></textarea>
												</div>
											</div>
											
											<!--파일 첨부-->
											<div class="input-group mt-5">
												<input type="file" class="form-control" multiple accept="image/*" name="file" id="inputGroupFile04" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
											</div>
											<div class="row">
												<div class="col-10"></div>
												<div class="col d-grid">
													<input type="submit" class="btn btn-secondary mt-3" value="스토리 등록">
												</div>
											</div>
											
												
										</form>
									</div>	
								</div>
							
							</c:if>
						</div>
					</div>
					
					
					
					
		
					<!--스토리 카드 -->
					<div class="mt-5" style="margin:0 auto">
						<c:forEach items="${relatedStoryList }" var="data">
							<div class="card rounded container-fluid mt-5" id="storyCard">
								<!--상단 바?-->
								<div class="row">
									<div class="col">
										<div class="row">
											<div class="col-1 mt-1">
												<h3><i class="bi bi-person-circle"></i></h3>
											</div>
											
											<!-- 아이디 누르면 해당 아이디 프로필로 이동! -->
											<div class="col-5 userId btn" style="text-align:left; padding-left:6px" onclick="location.href='./storyUserProfile.do?friend_member_no=${data.memberVo.no}'" onmouseover="highlightUser(this)" onmouseout="unhighlightUser(this)">
												${data.memberVo.id }
											</div>
											<div class="col"></div><!-- 가로 공백-->
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
										<form action="./writeStoryReplyProcess.do?story_no=${data.storyVo.no}" method="post">
											<input type="hidden" name="story_no" value="${data.storyVo.no}"><!--히든 타입/ 스토리 no 보내기용-->
								
											<div class="row">
												<div class="col-1">
													<h3><i class="bi bi-person-circle"></i></h3>
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
			<div class="col-1"></div>
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