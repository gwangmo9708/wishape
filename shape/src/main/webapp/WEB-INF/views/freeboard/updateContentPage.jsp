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
                          <h1 class="fw-bold text-center">글 수정</h1>
                          </div>
                         </div> 
                         
						<div class="row mt-4">
							<div class="col">
								<form action="./updateContentProcess.do" method="post" enctype="multipart/form-data">
									<h5> <i class="bi bi-pencil"></i>제목</h5>
									<input type="text" class="form-control" name="title" value="${data.freeBoardVo.title }"><br>
									<c:forEach items="${data.imageVoList }" var="imageVo">
									<img src="/upload/${imageVo.file_link }"><br>
									</c:forEach>
									<h5> <i class="bi bi-pencil"></i>내용</h5>
									<textarea class="form-control" rows="20" cols="70" name="content">${data.freeBoardVo.content }</textarea>
									<br>
									<div class="row">
									 	<div class="col form-row float-right"><input type="file" multiple accept="image/*" name="files"></div>
									 		<div class="col"><input type="hidden" name="no" value="${data.freeBoardVo.no }"></div>
									 		<div class="col form-row" align="right"><input type="submit" value="작성 완료"></div>
							     	</div>
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
			    <div class="col-1"></div>
			</div>
			
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