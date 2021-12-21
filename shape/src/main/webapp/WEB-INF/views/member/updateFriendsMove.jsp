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
<script type="text/javascript">
var myModal = null;

window.addEventListener('DOMContentLoaded', function(){
    myModal = new bootstrap.Modal(document.getElementById('editFriends'));
});
	//id 들을 하나로 엮어줌
	function createQueryString(){
		var no = document.getElementById("no").value;
		var content = document.getElementById("content").value;
		var friends_group_no = document.getElementById("friends_group_no").value;
		
		var queryString = "no="+no+"&content="+content +"&friends_group_no="+friends_group_no;
			
		return queryString;
	}
	
	function showModal(){
		myModal.show();
	}
	
	function updateConfirm(){
		var queryString = createQueryString();
		window.location.href = './updateFriendsMoveProcess.do?'+queryString;
	}

</script>

</head>
<body class="bg-secondary bg-gradient bg-opacity-10">

	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<div class="continer-fluid">
		<div class="row">
			<div class="col-3">
				<jsp:include page="../common/aside2.jsp"/>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">				
			</div>
			<div class="col card mx-5">
				
					<input type="hidden" id="no" name="no" value="${map.friendsVo.no}">
				<div class="row mt-5">
					<div class="col-4">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-1"><i class="bi bi-pencil-square text-primary text-opacity-75 fs-5"></i></div>
							<div class="col text-start fw-bold text-secondary fs-5">친구 수정</div>
						</div>
					</div>
					<div class="col-4"></div>
					<div class="col-4"></div>
					
				</div>
				<div class="row mt-4">
					<div class="col-8">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-2 text-end"><i class="bi bi-person-lines-fill"></i></div>
							<div class="col-4 fst-italic">${map.memberVo.id}<hr/></div>
							
						</div>
					</div>
					<div class="col-2"></div>
					<div class="col-2"></div>
				</div>
				<div class="row mt-4">
					<div class="col-4">
						<div class="row">
							<div class="col-1"></div>
							<div class="col-1"><i class="bi bi-card-text text-secondary fs-5"></i></div>
							<div class="col fs-5 text-secondary">친구 설명 수정</div>							
						</div>
					</div>					
				</div>
				<div class="row mt-2">
					<div class="col-5">
						<div class="row">
							<div class="col-1"></div>							
							<div class="col-8"><input class="btn btn-outline-secondary fst-italic" id="content" type="text" name="content" placeholder="기존 설명 : ${map.friendsVo.content}"><hr/></div>														
						</div>
					</div>					
				</div>				
				<div class="row">
					<div class="col-5">
						<div class="row">
							<div class="col-1"></div>
							<div class="col"><i class="bi bi-people-fill text-primary fs-5"></i>
								<select class="form-select form-select-md mb-2" id="friends_group_no" aria-label=".form-select" name="friends_group_no">
							<c:forEach items="${FriendsGroupList}" var="data">
								<option class="fst-italic" value="${data.no}">${data.name}</option>
							</c:forEach>
						</select>
							</div>							
						</div>
					</div>					
				</div>
				<div class="row mt-5 mb-3">
					<div class="col-5">
						<div class="row">
							<div class="col-1"></div>							
							<div class="col fs-6"><a class="fst-italic text-primary" href="./friends.do">Friends 페이지</a></div>
							
							<div class="col text-end"><button class="btn-sm btn-secondary fst-italic" type="submit" onclick="showModal()"><i class="bi-lg bi-pencil-square fs-7"></i> 수정하기</button></div>							
						</div>
					</div>										
				</div>
				
			</div>
			<div class="col-1">
				<aside>
					<jsp:include page="../common/aside.jsp"/>
				</aside>
			</div>
			<div class="col-2"></div>
		</div>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	</div>
	
	<!-- Modal -->
<div class="modal fade" id="editFriends" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title primary" id="exampleModalLabel">완료</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
                수정이 완료 되었습니다 !
      </div>
      <div class="modal-footer">     
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="updateConfirm()">확인</button>
      </div>
    </div>
  </div>
</div>


	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>	
</body>
</html>