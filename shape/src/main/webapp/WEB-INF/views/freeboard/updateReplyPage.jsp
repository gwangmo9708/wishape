<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		  <div class="col-1 mt-2">
			
			    <aside>
			        <jsp:include page="../common/aside2.jsp"/>
			    </aside>
			    <img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>
			<div class="col-2"></div>
			  <div class="col-6">
			  <article>
					<div class="row mt-5">
						<div class="col mt-5">
                          <h3 class="fw-bold text-left">댓글 수정</h3>
                          </div>
                     </div> 
						 <div class="row mt-4">
							<div class="col">
				          	<form action="./updateReplyProcess.do" method="get">
						      <input type="hidden" name="no" value="${freeBoardReplyVo.no }"> 
						      <input type="hidden" name="free_board_no" value="${freeBoardReplyVo.free_board_no }"> 
						      <h5> <i class="bi bi-person-circle"></i>${user.id}</h5>      
						      <h5> <i class="bi bi-pencil"></i>내용</h5>
						      <textarea  rows="10" cols="60" name="content">${freeBoardReplyVo.content }</textarea><br>
						     <input type="submit" value="등록">
				  
				          	</form>				          	
				          	
							
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

			<div style="width:1200px" class="row">
			<div class="col mt-5"></div>
			</div>
			
		<footer>
		<jsp:include page="../common/footer.jsp"/>
		</footer>
		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>          
</body>
</html>