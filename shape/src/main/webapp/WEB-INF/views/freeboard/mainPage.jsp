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
						<h1 class="fw-bold text-center">자유게시판</h1>
						</div>
			            </div>
			            <form action="./mainPage.do" method="get">
					<div class="row mt-5"><!-- 검색... -->
						<div class="col-2">
							<select name="searchOptionFreeBoard" class="form-control">
								<option value="freeboard_title">제목</option>
								<option value="freeboard_content">내용</option>
								<option value="freeboard_id">작성자</option>
							</select>
						</div>
						<div class="col">
							<input name="searchWordFreeBoard" class="form-control" type="text" placeholder="검색어를 입력하세요">
						</div>
						<div class="col-2 d-grid">
							<input class="btn btn-primary btn-sm" type="submit" value="검색">
						</div>
					</div>
					</form>
				          <div class="row mt-5"> <!-- 글목록테이블 내용.. -->
						<div class="col-2"></div>
						<div class="col">
					</div>	
				 </div>	
                <table class="table table-hover">
                <tr>
                 <td>글 번호</td>
	             <td>제목</td>
	             <td>작성자</td>
			     <td><i class="bi bi-eye"></i>조회수</td>
			     <td>작성일</td>
                </tr>
  	      <c:forEach items="${list }" var="data">
		  <tr>
			<td>${data.freeBoardVo.no }</td>
			
            <td><a href="./readContentPage.do?no=${data.freeBoardVo.no }">${data.freeBoardVo.title }
                  <c:if test="${data.totalReplyCount>0 }">
						[<c:out value="${data.totalReplyCount }"/>]
				   </c:if>
                   <c:if test="${data.imageExist >0 }">
						<i class="bi bi-images"></i>
				   </c:if>

            </a></td>
	    	<td>${data.memberVo.id }</td>
			<td><c:choose>
			<c:when test="${data.freeBoardVo.read_count >20 }">
			     <p style="color:green;">${data.freeBoardVo.read_count}</p>
			</c:when>
			<c:otherwise>
			    <p style="color:black;">  ${data.freeBoardVo.read_count }</p>
			</c:otherwise>
			</c:choose>
			</td>
			<td><fmt:formatDate value="${data.freeBoardVo.write_date }" pattern="yy.MM.dd hh:mm"/></td>		
		 </tr>
	     </c:forEach>		
	     </table>
				
			<div class="row"> <!-- 페이징관련버튼,글쓰기버튼1-->
				<div class="col-1"></div>
				<div class="col">
				<nav>
				  <ul class="pagination justify-content-center">
				  	<c:choose>
				  		<c:when test="${beginFbPageNum <=1 }">
				  			<li class="page-item disabled">
				      			<span class="page-link">Previous</span>
				    		</li>
				  		</c:when>
				  		<c:otherwise>
				  			<li class="page-item">
				      			<a class="page-link" href="./mainPage.do?fbPageNum=${beginFbPageNum-1 }${addFbParams}">Previous</a>
				    		</li>
				  		</c:otherwise>
				  	</c:choose>				  
				    
				    <c:forEach begin="${beginFbPageNum }" end="${endFbPageNum}" var="i">
					    <c:choose>
					    	<c:when test="${currentFbPageNum == i }">
					    		<li class="page-item active"><a class="page-link" href="./mainPage.do?fbPageNum=${i}${addFbParams}">${i}</a></li>
					    	</c:when>
					    	<c:otherwise>
					    		<li class="page-item"><a class="page-link" href="./mainPage.do?fbPageNum=${i}${addFbParams}">${i}</a></li>
					    	</c:otherwise>
				    	</c:choose>				    
				    </c:forEach>
				    <c:choose>
				    	<c:when test="${endFbPageNum >= totalFbPageCount }">
				    		<li class="page-item disabled">
				      			<a class="page-link">Next</a>
				    		</li>
				    	</c:when>
				    	<c:otherwise>
				    		<li class="page-item">
				      			<a class="page-link" href="./mainPage.do?fbPageNum=${endFbPageNum+1}${addFbParams}">Next</a>
			    			</li>
				    	</c:otherwise>
				    </c:choose>					
				  </ul>
				</nav>
				</div>
				<div class="col-2" align="right">
				<c:if test="${!empty user }">
					<a class="btn btn-primary" href="./writeContentPage.do"><i class="bi bi-pencil"></i>글쓰기</a>
				</c:if>
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
		

			
			<div style="width:1200px" class="row">
			<div class="col mt-5"></div>
			</div>
			</div>
		<footer>
		<jsp:include page="../common/footer.jsp"/>
		</footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>  
</body>
</html>