<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
	
	//function
	
	function getSmallCategoryByBigcategory() {//소분류 옵션
		
		var bigCategory = document.getElementById("bigCategoryBox");
		var smallcategory = document.getElementById("smallCategoryBox");
		
		var xmlhttp = new XMLHttpRequest();
		
		if(bigCategory.value != "대분류"){
			//<option value="${data.no }">${data.small_name }</option>

			//서버에서 응답 후 처리 로직.
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					
					smallcategory.innerHTML = "";
					
					var data = JSON.parse(xmlhttp.responseText);
					
	/* 				<c:forEach items="${data.smallCategoryList}" var ="smallCategory">
						<option value="${smallCategory.no }">${smallCategory.small_name }</option>
					</c:forEach>	 */
					
					for(smallCategory of data.smallCategoryList){
						console.log(smallCategory.no)
						
						var smallOption = document.createElement("option"); //<option>  </option>
						
						smallOption.setAttribute("value", smallCategory.no);
						
						smallOption.innerText=smallCategory.small_name;
						
						smallcategory.appendChild(smallOption);
					}
				}
			};
			
			//get 방식으로 파라미터 보내는법...
			xmlhttp.open("get" , "./getSmallCategoryList.do?big_category_no=" + bigCategory.value); 
			xmlhttp.send();
			
			//post 방식으로 파라미터 보내는법...
			//xmlhttp.open("post" , "./testRest.do");
			//xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			//xmlhttp.send("id=" + id);
			

			
			return;		
			
		}else{
			
			smallcategory.innerHTML = "";
			
			var smallOption = document.createElement("option"); //<option> 소분류 </option>
			
			smallOption.innerText="소분류";
			
			smallcategory.appendChild(smallOption);
		}
	}
	
	
	function sortOtherWish(){
		
		
		var xmlhttp = new XMLHttpRequest();
		
		var wishBox = document.getElementById("wishBox"); 
		var smallcategory = document.getElementById("smallCategoryBox");
		var searchString = document.getElementById("searchString");
		var selectOption = document.getElementById("selectOption");
		
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				wishBox.innerHTML = "";
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(otherWish of data.otherWishList) {
					
					var tableTr = document.createElement("tr");
					wishBox.appendChild(tableTr);
					
					
					// no
					var noTd = document.createElement("td");
					tableTr.appendChild(noTd);
					
					var noA = document.createElement("a");
					noA.setAttribute("class", "text-decoration-none text-body fw-bold");
					noA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					noA.innerText = otherWish.wishVo.no;
					noTd.appendChild(noA);
					
					
					// small_name
					var nameTd = document.createElement("td");
					tableTr.appendChild(nameTd);
					
					var nameA = document.createElement("a");
					nameA.setAttribute("class", "text-decoration-none text-body");
					nameA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					nameA.innerText = otherWish.small_name;
					nameTd.appendChild(nameA);
					
					
					// title
					var titleTd = document.createElement("td");
					tableTr.appendChild(titleTd);
					
					var titleA = document.createElement("a");
					titleA.setAttribute("class", "text-decoration-none text-body");
					titleA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					titleA.innerText = otherWish.wishVo.title;
					titleTd.appendChild(titleA);
					
					
					// id
					var idTd = document.createElement("td");
					tableTr.appendChild(idTd);
					
					var idA = document.createElement("a");
					idA.setAttribute("class", "text-decoration-none text-body");
					idA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					idA.innerText = otherWish.writer_ID;
					idTd.appendChild(idA);
					
					
					// readCount
					var readCountTd = document.createElement("td");
					tableTr.appendChild(readCountTd);
					
					var readCountA = document.createElement("a");
					readCountA.setAttribute("class", "text-decoration-none text-body");
					readCountA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					readCountA.innerText = otherWish.wishVo.read_count
					readCountTd.appendChild(readCountA);
					
					
					// likeCount
					var likeCountTd = document.createElement("td");
					tableTr.appendChild(likeCountTd);
					
					var likeCountA = document.createElement("a");
					likeCountA.setAttribute("class", "text-decoration-none text-body");
					likeCountA.setAttribute("href", "./getWishDataByWishNo.do?wish_no="+otherWish.wishVo.no);
					likeCountA.innerText = otherWish.wish_like_count;
					likeCountTd.appendChild(likeCountA);
					
				}
				
			}
		}
			
		
		//get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./sortWishByOption.do?small_category_no="+smallcategory.value+"&selectOption="+selectOption.value+"&searchString="+searchString.value); 
		xmlhttp.send();
		
	}
	
	
	
 	window.addEventListener('DOMContentLoaded', function(){ 
 		//실행될 코드
 		getSmallCategoryByBigcategory()
 		
 		
 		})

	
	//Ajax	


	
	
	
</script>

</head>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
<header>
    <jsp:include page="../common/header.jsp"/>
</header>
	<!-- 다른 사람들의 위시를 보여주는 페이지... 내 위시는 보이면 안된다.(내 위위시는 내 위시만 보이는 페이지가 있게끔)-->
	<!-- 검색해서 고른 위시의 no를 다음 페이지를 위해 보내줘야 한다. -->
	<!-- 아래 폼의 변수는 임의로 가정하고 만들었으므로 설정 꼭 해야 한다! -->
   <div class="container-fluid">
   <div class="row">
        <div class="col-1"></div>
		<div class="col-2 px-5">
			
			<aside>
				<jsp:include page="../common/aside2.jsp"></jsp:include>
			</aside>
			<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
		</div>	
        <div class="col">
			<div class="row mx-5">
				<!-- <div class="col-2"></div> -->
				<div class="col">
					<div class="card bg-white p-5">
						<div class="row mt-5 mb-5">
							<div class="col-4"></div>
							<div class="col-4 text-center fs-1 fw-bold">
								위시 검색
							</div>
							<div class="col-4"></div>				
						</div>					
						<form action="./searchWishByOption.do">
							<div class="row mt-5 mb-3">
								<div class="col-3">					
									<select class="form-select shadow-sm fw-bold" name="selectOption" id="selectOption">
									<option value="writer">작성자</option>
									<!-- <option value="read_count">조회수</option> -->
									<option value="title">Wish 주제</option>
									</select>
								</div>
								<div class="col-6">
									<input type="text" class="form-control shadow-sm" placeholder="검색  keyword" name="searchString" id="searchString">
								</div>
								<div class="col-3 d-grid">
									<button type="submit" class="btn btn-primary fw-bold">검색</button>
								</div>
							</div>
						</form>

						<div class="row mt-1 mb-1">
							<!-- 비어있는 로우 -->
							
						</div>
						<div class="row mt-3">
							<div class="col-9">
								<div class="row">								
									<div class="col-6">
										<!-- 대분류 드롭다운 -->
										<select id="bigCategoryBox" class="form-select shadow-sm fw-bold" aria-label="Default select example" onchange="getSmallCategoryByBigcategory()">
											<option selected value="대분류">대분류</option>
											<c:forEach items="${bigList }" var="data">
												<option value="${data.no }">${data.big_name }</option>
											</c:forEach>
										</select>									
									</div>
									<div class="col-6">
										<!-- '소분류' 드롭다운 -->
										<select id="smallCategoryBox" name="small_category_no" class="form-select shadow-sm fw-bold"  aria-label="Default select example">
												<option selected value="소분류">소분류</option>
										</select>									
									</div>																	
								</div>
							</div>
							<div class="col-3 d-grid">
								<!-- '정렬' 버튼 -->
								<button type="submit" class="btn btn-primary fw-bold" onclick="sortOtherWish()">정렬</button>
							</div>							
						</div>
						<div class="row mt-5 mb-5">
							<!-- 비어있는 로우 -->
							<hr></hr>
						</div>
						<div class="row mt-5 mb-5">																	
						<form action="./getWishDataByWishNo.do">	
							<table class="table table-hover border rounded border-2 shadow-sm text-center caption-top" >
							<caption>다른 사람들의 위시</caption>
							<thead class="bg-dark bg-opacity-10">
								<tr>
									<th scope="col">No.</th>
									<th scope="col">소분류</th>
									<th scope="col">위시 주제</th>
									<th scope="col">작성자</th>
									<th scope="col">조회수</th>
									<th scope="col">좋아요 수</th>
								</tr>
							</thead>
								
							<tbody id="wishBox">				  							  
								<c:forEach items="${OtherWishList }" var="data">						
									<tr>					    	
										<td><a class="text-decoration-none text-body fw-bold" href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.wishVo.no }</a></td>
										<td><a class="text-decoration-none text-body " href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.small_name }</a></td>
										<td><a class="text-decoration-none text-body " href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.wishVo.title }</a></td>
										<td><a class="text-decoration-none text-body " href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.writer_ID }</a></td>
										<td><a class="text-decoration-none text-body " href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.wishVo.read_count }</a></td>		
										<td><a class="text-decoration-none text-body " href="./getWishDataByWishNo.do?wish_no=${data.wishVo.no }">${data.wish_like_count }</a></td>						
									</tr>					    
								</c:forEach>														     
							</tbody>
													
							</table>						
							<input type="hidden" name="wish_no" value="${data.wishVo.no }">
						</form>																									
						</div>
						<div class="row mt-5 mb-5">
							<!-- 비어있는 로우 -->
						</div>						
					</div>
				</div>
				</div>
				<!-- <div class="col-2"></div> -->
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
		<div class="col-2"></div>
       
        
   </div>
   </div>	
<footer class="bg-white card shadow">
    <jsp:include page="../common/footer.jsp"/>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>	
</body>
</html>


<!-- 									<div class="col-6"> -->
<!-- 										<select id="bigCategoryBox" class="form-select shadow-sm fw-bold" aria-label="Default select example" onchange="sortSmallCategory()"> -->
<!-- 											<option selected value="대분류">대분류</option> -->
<%-- 											<c:forEach items="${bigList }" var="data"> --%>
<%-- 												<option value="${data.no }">${data.big_name }</option> --%>
<%-- 											</c:forEach> --%>
<!-- 										</select>									 -->
<!-- 									</div> -->
<!-- 									<div class="col-6"> -->
<!-- 										'소분류' 드롭다운 -->
<!-- 										<select id="smallCategoryBox" name="small_category_no" class="form-select shadow-sm fw-bold"  aria-label="Default select example"> -->
<!-- 												<option selected value="소분류">소분류</option> -->
<%-- 												<c:forEach items="${smallList }" var="data"> --%>
<%-- 													<option value="${data.no }">${data.small_name }</option> --%>
<%-- 												</c:forEach> --%>
<!-- 										</select>									 -->
<!-- 									</div> -->