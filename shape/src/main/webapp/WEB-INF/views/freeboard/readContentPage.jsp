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

<script type="text/javascript">

var replyWarningModal = null;
var replyUpdateModal = null;

window.addEventListener('DOMContentLoaded',function(){
	 replyWarningModal =
         new bootstrap.Modal(document.getElementById('replyWarningForm'));
	 
	 replyUpdateModal =
         new bootstrap.Modal(document.getElementById('replyUpdateForm'));
   });   
   

	function showReplyWarningModal(freeBoardReplyNo){
		
		console.log(freeBoardReplyNo);
		
		document.getElementById("hidden_reply_no").value = freeBoardReplyNo;
		replyWarningModal.show();
   }

   function hideReplyWarningModal(){
	   replyWarningModal.hide();
   }

   function replyWarningProcess(){
	   
	 var replyWarningText =document.getElementById("replyContent").value;
	 var hidden_reply_no = document.getElementById("hidden_reply_no").value;
	   
	 
	 console.log(hidden_reply_no);
	//ajax api
	var xmlhttp = new XMLHttpRequest();
	
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			replyWarningModal.hide();
		     alert("신고가 접수되었습니다.");
		}
	};
	
	 xmlhttp.open("post","./doReplyWarning.do"); 
     xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
     xmlhttp.send("free_board_reply_no="+ hidden_reply_no + "&content=" + replyWarningText );   
     
     
     }
   
//    //댓글수정..미완
//    function showReplyUpdateModal(freeBoardReplyNo){
// 	   document.getElementById("hidden_reply_no").value = freeBoardReplyNo;
// 		replyUpdateModal.show();
//    }
   
//    function hideReplyUpdateModal(){
// 	   replyUpdateModal.hide();
//    }
   
//    function replyUpdateProcess(){
	   
// 		 var replyUpdateText =document.getElementById("replyUpdateContent").value;
// 		 var hidden_reply_no = document.getElementById("hidden_reply_no").value;
// 		 var hidden_free_board_no = document.getElementById("hidden_free_board_no").value;
		   
		 
// 		 console.log(hidden_reply_no);
// 		//ajax api
// 		var xmlhttp = new XMLHttpRequest();
		
// 		xmlhttp.onreadystatechange = function(){
// 			if(xmlhttp.readyState==4 && xmlhttp.status==200){
// 				replyUpdateModal.hide();
			     
// 			}
// 		};
		
// 		 xmlhttp.open("post","./doReplyUpdate.do"); 
// 	     xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
// 	     xmlhttp.send("no="+ hidden_reply_no + "&content=" + replyUpdateText );   
	     
	     
// 	     }
   

</script>

</head>
<body>

 <!-- 댓글신고 Modal -->
      <div class="modal fade" id="replyWarningForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">

               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel"><i class="bi bi-exclamation-triangle-fill"></i>댓글 신고하기</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>

               <div class="modal-body">
                  <textarea class="form-control" name="content" id = "replyContent" placeholder="신고사유를 작성해주세요"></textarea><!--신고사유-->
               </div>
               
               <div class="modal-footer">
                  <button type="submit" onclick="replyWarningProcess()" class="btn btn-primary">신고하기</button>
                  <button type="button" onclick="hideReplyWarningModal()" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
               </div>
               <input type="hidden" name="reply_no" id="hidden_reply_no">
            </div>
         </div>
      </div>
      
      <!-- 댓글수정 Modal -->
      <div class="modal fade" id="replyUpdateForm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">

               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">댓글 수정하기</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>

               <div class="modal-body">
                  <textarea class="form-control" name="content" id = "replyUpdateContent"></textarea>
               </div>
               
               <div class="modal-footer">
                  <button type="submit" onclick="replyUpdateProcess()" class="btn btn-primary">수정하기</button>
                  <button type="button" onclick="hideReplyUpdateModal()" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
               </div>
               <input type="hidden" name="fb_reply_no" id="hidden_reply_no">
                <input type="hidden" name="free_board_no" id="hidden_free_board_no"> 
            
            </div>
         </div>
      </div>
      
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
                                <div class="col mt-5 fs-3 text-start">
                                    ${data.freeBoardVo.title }
                                    <hr style="border-color: grey;">
                                </div>
                            </div>   
                            <div class="row">  <!--본문 -->
                                <div class="col-sm-3"><i class="bi bi-person-circle">${data.memberVo.id}</i></div>
                                <div class="col-sm-2"></div>
                                <div class="col-sm-5 text-muted">작성일 :<fmt:formatDate value="${data.freeBoardVo.write_date }" pattern="yy.MM.dd hh:mm"/></div>
                                <div class="col-sm-2 text-muted"><i class="bi bi-eye"></i>${data.freeBoardVo.read_count }</div>
                            </div> 
                            <hr style="border-color: grey;"> 
                            <div class="row">
                                <c:forEach items="${data.imageVoList }" var="imageVo">
                                <div class="col"><img class= "img-fluid mx-auto d-block" src="/uploadFreeBoard/${imageVo.file_link }"><br></div>
                                </c:forEach>
                                <br>
                                <div>
                               	${data.freeBoardVo.content }
                               	</div>
                               	<br>
                             </div>
                             <hr style="border-color: grey;">
                            
                            <div class="row"><!-- 좋아요관련 -->
                                <div class="col">
                                    <div class="col mt-1"> 
                                        <c:if test="${!empty user }">
                                            <c:choose>
                                                <c:when test="${myLikeCount > 0 }">
                                                    <a href="./doLike.do?free_board_no=${data.freeBoardVo.no }"><i class="bi bi-heart-fill fs-6 text-danger"></i></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="./doLike.do?free_board_no=${data.freeBoardVo.no }"><i class="bi bi-heart fs-6 text-danger"></i></a>
                                                </c:otherwise>
                                            </c:choose>
										     <span class="fs-6">${totalLikeCount}</span>
                                        </c:if>                                        
                                    </div>                                   
                                </div>
                                <div class="col-5"></div>
                                    <div class="col" align="right">
										<c:if test="${!empty user && user.no == data.freeBoardVo.member_no}">
                                            	<a class="btn btn-primary btn-sm" href="./updateContentPage.do?no=${data.freeBoardVo.no }">수정</a>	
                                                <a class="btn btn-primary btn-sm" href="./deleteContentProcess.do?no=${data.freeBoardVo.no }">삭제</a>
										</c:if>
                                            	<a class="btn btn-primary btn-sm" href="./mainPage.do">목록</a>
                                    </div>
                            </div>
                            <hr style="border-color: grey;">
							
   
                            <div class="row">
                                <div class="col">전체댓글:${data.totalReplyCount}</div>
                            </div>
                            <div class="row mt-1"><!-- 댓글목록 -->
                                <div class="col">
                                    <div class="row">
                                        <c:forEach items="${data2 }" var="data3">
                                            <div class="col-3 mt-1">
                                                <i class="bi bi-person-circle">${data3.memberVo.id}</i>
                                            </div>
                                            <div class="col-5 mt-1" id="replycontent">${data3.freeBoardReplyVo.content }</div>	
                                            <div class="col-2 mt-1" ><fmt:formatDate value= "${data3.freeBoardReplyVo.write_date }" pattern="yy.MM.dd hh:mm"/></div>
                                            <div class="col" align="right">
                                                <c:if test="${!empty user}">
                                                    <c:choose>
                                                        <c:when test="${user.no == data3.freeBoardReplyVo.member_no }">
                                                        <div ><%--onclick="showReplyUpdateModal(${data3.freeBoardReplyVo.no })" --%>
                                                           <a href="./updateReplyPage.do?free_board_reply_no=${data3.freeBoardReplyVo.no }"><i class="bi bi-pencil-square fs-4 text-dark"></i></a>
                                                            <a href="./deleteReplyProcess.do?free_board_reply_no=${data3.freeBoardReplyVo.no }&free_board_no=${data.freeBoardVo.no}"><i class="bi bi-x-square fs-4 text-dark"></i></a>
                                                            </div>
                                                        </c:when> 
                                                        <c:otherwise>
                                                            <div onclick="showReplyWarningModal(${data3.freeBoardReplyVo.no })"><i class="bi bi-exclamation-square fs-4"></i></div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>	
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3 bg-secondary bg-opacity-10"><!-- 댓글입력창 -->
                                <div class="col">
                                    <form action="./writeReplyProcess.do?free_board_no=${data.freeBoardVo.no }" method="post">
                                    <input type="hidden" name="free_board_no" value="${data.freeBoardVo.no }"> 
                                    <i class="bi bi-person-circle">${user.id}</i><br>	         
                                    <textarea  name="content" class="form-control"  placeholder="댓글입력"></textarea>
                                    <div align="right">
									<input type="submit" class="btn btn-dark btn-sm" value="등록">
									</div>
                                    </form>
                                </div>
                            </div>
						</article>
                     </div>
                     <div class="col-1"></div> 
                     <div class="col-1 mt-3 ">
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