<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cb814c56464901f9531e39a895635e3&libraries=services"></script>
<script>

 	var replyBox = document.getElementById("replyBox");
 	var today = new Date();
 	var geocoder = new kakao.maps.services.Geocoder();
 	
	// header today 예외처리.
	function checkDate() {
		
		if(${empty user}){
			return;
		};

		console.log(today);
		if(today == null){
			return;
		};
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(mapList of data.wishRunTodoRunDateList) {
					for(todoRunDay of mapList.todoRunDateList) {
				
						console.log(todoRunDay);
						
						var formatDate = new Date(todoRunDay);
						var todoRunDate = getFormatDate(formatDate);
						
						var now = getFormatDate(today)
						
						console.log(todoRunDate);
						console.log(now);
						if(todoRunDate === now){
							return;
						};
					};
					
				};
				
				alert("오늘 일정이 없습니다.");
				window.location.href = "/shape/wish/index.do";
			}
		};
		
		xmlhttp.open("get" , "./getTodoRunDate.do");
		xmlhttp.send();
		
	}
	// header today 예외처리.
	function getFormatDate(date){
		
		// console.log(date);
		var year = date.getFullYear();
		var month = (date.getMonth()+1);
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		
		return year + "-" + month + "-" + day;
		
	}
 	
 	
 	
 	
 	
 	
	// 신뢰도.
	function clickReliabilty(check, wish_run_no){
		
		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				//alert("테스트");
				//alert(xmlhttp.responseText);
				
				var data = JSON.parse(xmlhttp.responseText);
				var goodButton = document.getElementById("goodButton");
				var badButton = document.getElementById("badButton");
				
				goodButton.setAttribute("class", "bi bi-hand-thumbs-up");
				badButton.setAttribute("class", "bi bi-hand-thumbs-down");
				
				if(data.myReliabilityVo != null){
					if(data.myReliabilityVo.good_bad == 'y'){
						goodButton.setAttribute("class", "bi bi-hand-thumbs-up-fill text-primary");
						badButton.setAttribute("class", "bi bi-hand-thumbs-down");
					} else if(data.myReliabilityVo.good_bad == 'n'){
						goodButton.setAttribute("class", "bi bi-hand-thumbs-up");
						badButton.setAttribute("class", "bi bi-hand-thumbs-down-fill text-primary");
					}
				}
				
				
				document.getElementById("reliability1").innerText = data.countReliability;
				document.getElementById("reliability2").innerText = data.countReliability;
				
			}
		};
		
		// get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./createReliability.do?wish_run_no="+wish_run_no+"&good_bad="+check); 
		xmlhttp.send();
		
	}
	
	// wish_run_reply 생성.
	function createReply() {
		
		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		var content = document.getElementById("content").value;
		console.log("실행1");
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				console.log("실행2");
				getReplyList();
				
			}
		};
		
		xmlhttp.open("get" , "./createWishRunReply.do?wish_run_no=${relatedWishMap.wishRunVo.no}&content="+content); 
		xmlhttp.send();
	}
	
	// wish_run_reply 리스트 가져오기.
	function getReplyList(){
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				var replyBox = document.getElementById("replyBox");
				var modalBox = document.getElementById("modalBox");
				replyBox.innerHTML = "";
				modalBox.innerHTML = "";
				
				for(i in data.wishRunReplyList){
					
					var no = data.wishRunReplyList[i].wishRunReplyVo.no;
					
					var divRow = document.createElement("div");
					divRow.setAttribute("class", "row");
					
					var colId = document.createElement("div");
					colId.setAttribute("class", "col-2 text-center mt-2");
					colId.innerText = data.wishRunReplyList[i].memberVo.id;
					divRow.appendChild(colId);
					
					var colContent = document.createElement("div");
					colContent.setAttribute("class", "col text-center mt-2");
					colContent.innerText = data.wishRunReplyList[i].wishRunReplyVo.content;
					divRow.appendChild(colContent);
					
					/* var write_date = new Date(data.wishRunReplyList[i].wishRunReplyVo.write_date);
					var format_date = getFormatDate(write_date);
					var colDate = document.createElement("div");
					colDate.setAttribute("class", "col-2 text-center mt-2");
					colDate.innerText = format_date;
					divRow.appendChild(colDate); */
					
					if(data.wishRunReplyList[i].wishRunReplyVo.member_no == ${user.no}){
						
						// 댓글 수정.
						var colUpdate = document.createElement("i");
						colUpdate.setAttribute("class", "col-1 bi bi-pencil-square btn");
						colUpdate.setAttribute("style", "color:#00008B;");
						colUpdate.setAttribute("data-bs-toggle", "modal");
						colUpdate.setAttribute("data-bs-target", "#updateModal"+i);
						// colUpdate.setAttribute("onclick", "getReplyList()");
						divRow.appendChild(colUpdate); // 조립
						
						var modalFade = document.createElement("div");
						modalFade.setAttribute("class", "modal fade");
						modalFade.setAttribute("id", "updateModal"+i);
						modalFade.setAttribute("tabindex", "-1");
						modalFade.setAttribute("aria-labelledby", "modalLabel"+i);
						modalFade.setAttribute("aria-hidden", "true");
						modalFade.setAttribute("data-bs-backdrop", "static");
						modalFade.setAttribute("data-bs-keyboard", "false");
						modalBox.appendChild(modalFade);
						
						var modalDialog = document.createElement("div");
						modalDialog.setAttribute("class","modal-dialog");
						modalFade.appendChild(modalDialog);
						
						var modalContent = document.createElement("div");
						modalContent.setAttribute("class", "modal-content");
						modalDialog.appendChild(modalContent);
						
						var modalHeader = document.createElement("div");
						modalHeader.setAttribute("class", "modal-header");
						modalContent.appendChild(modalHeader);
						var modalTitle = document.createElement("h4");
						modalTitle.setAttribute("class", "modal-title");
						modalTitle.setAttribute("id", "modalLabel"+i);
						modalTitle.innerText = "댓글 수정하기";
						modalHeader.appendChild(modalTitle);
						var modalButton = document.createElement("button");
						modalButton.setAttribute("type", "button");
						modalButton.setAttribute("class", "btn-close");
						modalButton.setAttribute("data-bs-dismiss", "modal");
						modalButton.setAttribute("aria-label", "Close");
						modalHeader.appendChild(modalButton);
						
						var modalBody = document.createElement("div");
						modalBody.setAttribute("class", "modal-body mb-4");
						modalContent.appendChild(modalBody);
						var textLabel = document.createElement("label");
						textLabel.setAttribute("for", "message-text");
						textLabel.setAttribute("class", "col-form-label");
						modalBody.appendChild(textLabel);
						var modalText = document.createElement("textarea");
						modalText.setAttribute("class", "form-control");
						modalText.setAttribute("id", no);
						modalText.setAttribute("rows", "3");
						modalText.setAttribute("cols", "60");
						modalText.value = data.wishRunReplyList[i].wishRunReplyVo.content;
						modalBody.appendChild(modalText);
						
						var modalFooter = document.createElement("div");
						modalFooter.setAttribute("class", "modal-footer");
						modalContent.appendChild(modalFooter);
						var modalCloseButton = document.createElement("button");
						modalCloseButton.setAttribute("type", "button");
						modalCloseButton.setAttribute("class", "btn btn-secondary");
						modalCloseButton.setAttribute("data-bs-dismiss", "modal");
						modalCloseButton.setAttribute("onclick", "getReplyList()");
						modalCloseButton.innerText = "닫기";
						modalFooter.appendChild(modalCloseButton);
						var modalChangeButton = document.createElement("button");
						modalChangeButton.setAttribute("type","button");
						modalChangeButton.setAttribute("class","btn btn-primary");
						modalChangeButton.setAttribute("onclick", "updateReply("+no+")");
						modalChangeButton.setAttribute("data-bs-dismiss", "modal");
						modalChangeButton.innerText = "수정하기";
						modalFooter.appendChild(modalChangeButton);
						
						// 댓글 삭제.
						var colDelete = document.createElement("i");
						colDelete.setAttribute("class", "col-1 bi bi-x-square btn");
						colDelete.setAttribute("onclick", "deleteReply("+no+")");
						colDelete.setAttribute("style", "color:#00008B;");
						colDelete.setAttribute("align", "left");
						divRow.appendChild(colDelete);
						
					}else{
						
						if(data.wishRunReplyList[i].wishRunReplyWarningVo == null){
							
							var colWarning = document.createElement("div");
							colWarning.setAttribute("class", "col-2 text-center btn");
							colWarning.setAttribute("style", "color:#8B0000;");
							colWarning.setAttribute("data-bs-toggle", "modal");
							colWarning.setAttribute("data-bs-target", "#updateModal"+i);
							colWarning.innerText = "신고하기";
							divRow.appendChild(colWarning);
							
							var modalFade = document.createElement("div");
							modalFade.setAttribute("class", "modal fade");
							modalFade.setAttribute("id", "updateModal"+i);
							modalFade.setAttribute("tabindex", "-1");
							modalFade.setAttribute("aria-labelledby", "modalLabel"+i);
							modalFade.setAttribute("aria-hidden", "true");
							modalFade.setAttribute("data-bs-backdrop", "static");
							modalFade.setAttribute("data-bs-keyboard", "false");
							modalBox.appendChild(modalFade);
							
							var modalDialog = document.createElement("div");
							modalDialog.setAttribute("class","modal-dialog");
							modalFade.appendChild(modalDialog);
							
							var modalContent = document.createElement("div");
							modalContent.setAttribute("class", "modal-content");
							modalDialog.appendChild(modalContent);
							
							var modalHeader = document.createElement("div");
							modalHeader.setAttribute("class", "modal-header");
							modalContent.appendChild(modalHeader);
							var modalTitle = document.createElement("h3");
							modalTitle.setAttribute("class", "modal-title");
							modalTitle.setAttribute("id", "modalLabel"+i);
							modalTitle.innerText = "댓글 신고";
							modalHeader.appendChild(modalTitle);
							var modalButton = document.createElement("button");
							modalButton.setAttribute("type", "button");
							modalButton.setAttribute("class", "btn-close");
							modalButton.setAttribute("data-bs-dismiss", "modal");
							modalButton.setAttribute("aria-label", "Close");
							modalHeader.appendChild(modalButton);
							
							var modalBody = document.createElement("div");
							modalBody.setAttribute("class", "modal-body mb-4");
							modalContent.appendChild(modalBody);
							var textLabel = document.createElement("label");
							textLabel.setAttribute("for", "message-text");
							textLabel.setAttribute("class", "col-form-label");
							modalBody.appendChild(textLabel);
							var modalWarning = document.createElement("h6");
							modalWarning.setAttribute("class", "text-center mb-3");
							modalWarning.innerText = "댓글 신고는 수정/삭제가 불가능합니다."
							modalBody.appendChild(modalWarning);
							var modalText = document.createElement("textarea");
							modalText.setAttribute("class", "form-control");
							modalText.setAttribute("id", no);
							modalText.setAttribute("rows", "3");
							modalText.setAttribute("cols", "60");
							modalBody.appendChild(modalText);
							
							var modalFooter = document.createElement("div");
							modalFooter.setAttribute("class", "modal-footer mt-2");
							modalContent.appendChild(modalFooter);
							var modalCloseButton = document.createElement("button");
							modalCloseButton.setAttribute("type", "button");
							modalCloseButton.setAttribute("class", "btn btn-secondary");
							modalCloseButton.setAttribute("data-bs-dismiss", "modal");
							modalCloseButton.innerText = "닫기";
							modalFooter.appendChild(modalCloseButton);
							var modalChangeButton = document.createElement("button");
							modalChangeButton.setAttribute("type","button");
							modalChangeButton.setAttribute("class","btn btn-primary text-center");
							modalChangeButton.setAttribute("onclick", "createReplyWarning("+no+")");
							modalChangeButton.setAttribute("data-bs-dismiss", "modal");
							modalChangeButton.innerText = "신고";
							modalFooter.appendChild(modalChangeButton);
							
						} else {
							
							var colWarning = document.createElement("div");
							colWarning.setAttribute("class", "col-2 text-center my-2");
							colWarning.innerText = "신고완료";
							divRow.appendChild(colWarning);
						}
					
					};
					
					replyBox.appendChild(divRow);
					
					console.log("실행완료");
				};
			};
		}
		
		xmlhttp.open("get" , "./getWishRunReply.do?wish_run_no=${relatedWishMap.wishRunVo.no}"); 
		xmlhttp.send();
	}
	
	// reply 삭제.
	function deleteReply(no) {
		
		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				getReplyList();
			}
		};
		
		xmlhttp.open("get" , "./deleteWishRunReply.do?wish_run_reply_no="+no); 
		xmlhttp.send();
	}
	
	
	
	// 댓글 수정.
	function updateReply(no){
			
		var content = document.getElementById(no);

		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				getReplyList();
			}
		};
		
		xmlhttp.open("get" , "./updateWishRunReply.do?content="+content.value+"&no="+no);
		xmlhttp.send();
	}
	
	// reply_waring 생성.
	function createReplyWarning(no){
		
		var content = document.getElementById(no);
	
		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				getReplyList();
			}
		};
		
		xmlhttp.open("get" , "./createWishRunReplyWarning.do?content="+content.value+"&wish_run_reply_no="+no);
		xmlhttp.send();
	}
	
	// 날짜 형식 format
	function getFormatDate(date){
		
		var year = date.getFullYear();
		var month = (date.getMonth()+1);
		month = month >= 10 ? month : '0' + month;
		var day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		return year + "-" + month + "-" + day;
		
	}
	
	
	
	// 에필로그 관련...
	// wish_run_epilogue 생성하기.
	function createEpilogue(wishRunNo){
		
		if(${empty user}){
			return;
		};
		
		
		var epilogueContent = document.getElementById("epilogueContent").value;
		var address = document.getElementById("address").value;
		
		if(epilogueContent == null || epilogueContent == ""){
			alert("위시 후기를 작성해주세요.");
			return;
		}
		
		if(address == null || address == "") {
			alert("인상깊었던 장소를 작성해주세요.")
			return;
		}

		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				alert("위시 후기가 작성되었습니다.");
				selectEpilogue();
				
			}
		};
		
		xmlhttp.open("get" , "./createEpilogue.do?content="+epilogueContent+"&wish_run_no="+wishRunNo+"&address="+address);
		xmlhttp.send();
		
	}
	// wish_run_epilogue 불러오기.
	function selectEpilogue() {
		
		if(${empty user}){
			return;
		};
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		var epilogueBox = document.getElementById("epilogueContent");
		var inputButtonBox = document.getElementById("inputButtonBox");
		var address = document.getElementById("address");
		var placeButton = document.getElementById("placeButton");
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				if(data.wishRunEpilogueVo != null) {
					
					inputButtonBox.innerHTML = "";
					epilogueBox.value = data.wishRunEpilogueVo.content;
					
					var inputButton = document.createElement("button");
					inputButton.setAttribute("class", "btn btn-secondary form-control");
					inputButton.setAttribute("onclick", "updateEpilogue(${relatedWishMap.wishRunVo.no}, "+data.wishRunEpilogueVo.no+")");
					inputButton.innerText = "후기 수정";
					inputButtonBox.appendChild(inputButton);
					
				}
				
				if(data.wishRunEpiloguePlaceVo != null){
					
					address.value = data.wishRunEpiloguePlaceVo.address;
					
					geocoder.addressSearch(data.wishRunEpiloguePlaceVo.address, function(result, status) {

					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {

							var y = result[0].y;
							var x = result[0].x;
					        
							drawMap(y, x);
							
					    } 
					}); 
					
				}
				
				
			}
		};
		
		xmlhttp.open("get" , "./getEpilogue.do?&wish_run_no=${relatedWishMap.wishRunVo.no}");
		xmlhttp.send();
		
	}
	// wish_run_epilogue 수정하기.
	function updateEpilogue(wishRunNo, epilogueNo) {
		
		
		console.log(epilogueNo);
		
		var epilogueContent = document.getElementById("epilogueContent").value;
		var address = document.getElementById("address").value;
		
		
		if(epilogueContent == null || epilogueContent == ""){
			alert("위시 후기를 작성해주세요.");
			selectEpilogue();
			return;
		}
		
		if(address == null || address == ""){
			alert("인상깊었던 장소를 작성해주세요.");
			selectEpilogue();
			return;
		}
		
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				alert("위시 후기가 수정되었습니다.");
				selectEpilogue();
				
			}
		};
		
		xmlhttp.open("get" , "./updateEpilogue.do?content="+epilogueContent+"&wish_run_no="+wishRunNo+"&address="+address+"&wish_run_epilogue_no="+epilogueNo);
		xmlhttp.send();

	}
	
	
	

	// MAP API...
	// 다음 api.
	function clickAddress(){
		
		var address = document.getElementById("address");
		
		new daum.Postcode({
			oncomplete: function(data) {
			    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			    // 예제를 참고하여 다양한 활용법을 확인해 보세요.
				console.log(data.address);
				address.value = data.address;
				
				
				geocoder.addressSearch(data.address, function(result, status) {

				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {

						var y = result[0].y;
						var x = result[0].x;
				        
						drawMap(y, x);
						
				    } 
				}); 
				
			}
		
		}).open();
		 
	}
	// 카카오 API.
	function drawMap(y, x){
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var markerPosition  = new kakao.maps.LatLng(y, x);
	    var options = { //지도를 생성할 때 필요한 기본 옵션
	    	center: new kakao.maps.LatLng(y, x), //지도의 중심좌표.
	    	level: 3 //지도의 레벨(확대, 축소 정도)
	    	 
	    };
		
	    container.setAttribute("style", "width:500px;height:400px;");
	    var map = new kakao.maps.Map(container, options);
	    
	    var marker = new kakao.maps.Marker({
	        position: markerPosition
	    });
	    marker.setMap(map)
		
	}
	
	
	
	// 초기화
	function init(){
		
		getReplyList();
		selectEpilogue()
		
	}
	
	// 문서 onload API.
	window.addEventListener('DOMContentLoaded', init);
	
</script>
<style>
	.target{ display: inline-block;
	    width: 200px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis; 
	}
</style>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<title>My WishList page</title>
</head>
<body class="bg-secondary bg-gradient bg-opacity-10">
	<header>
		<jsp:include page="../common/header.jsp"/>
	</header>
	<div class="container-fluid">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-2 px-5">
				
				<%-- <aside>
					<jsp:include page="../common/aside2.jsp"></jsp:include>
				</aside> --%>
				<img width="280px" src="/shape/resources/side1.jpg" class="shadow">
			</div>	
			<div class="col mx-5">
				<article>
					<div class="row">
						<div class="col"> 
							<div class="shadow card card-body py-4">
								<div class="row">
									<div class="col text-center fs-5 fw-bold">
										${relatedWishMap.wishVo.title } <i class="bi bi-stars" style="color: #FFA500"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow-sm p-1">
								<div class="row">
									<div class="col-4">
										<div class="row text-center">
											<div class="col-3"></div>
											<div class="col-5 my-2">
												포기여부
											</div>
											<div class="col-1 my-2">
												<c:choose>
													<c:when test="${relatedWishMap.wishRunVo.quit_date == null}">
														X
													</c:when>
													<c:otherwise>
														O
													</c:otherwise>
												</c:choose>
											</div>
											<div class="col-3"></div>
										</div>
									</div>
									<div class="col-4">
										<div class="row text-center">
											<c:choose>
												<c:when test="${relatedWishMap.wishRunVo.quit_date == null}">
													<c:choose>
														<c:when test="${relatedWishMap.Dday>0 }">
															<div class="col-1"></div>
															<div class="col my-2">
																종료일
															</div>
															<div class="col my-2">
																D-${relatedWishMap.Dday }
															</div>
															<div class="col-1"></div>
														</c:when>
														<c:otherwise>
															<div class="col-1"></div>
															<div class="col my-2">
																위시가 종료되었습니다.
															</div>
															<div class="col-1"></div>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<div class="col-1"></div>
													<div class="col my-2">
														위시를 포기했습니다.
													</div>
													<div class="col-1"></div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="col-4">
										<div class="row text-center">
											<div class="col-4 my-2 text-end">
												<c:if test="${!empty reliabilityMap.countReliability }">
													신뢰도
												</c:if>
											</div>
											<div id="reliability1" class="col-5 my-2">
												<c:if test="${!empty reliabilityMap.countReliability }">
													${reliabilityMap.countReliability }
												</c:if>
											</div>
											<div class="col-1"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="card shadow py-2">
								<div class="row my-4">
									<div class="col-2"></div>
									<div class="col">
										<div class="shadow-sm card card-body">
											<div class="row mt-3">
												<div class="col-1"></div>
												<div class="col-6">
													▣ 위시 내용
												</div>
												<div class="col target">
													${relatedWishMap.wishVo.content }
												</div>
												<div class="col-1"></div>
											</div>
											<div class="row mt-2">
												<div class="col-1"></div>
												<div class="col-6">
													▣ 위시 시작일
												</div>
												<div class="col">
													<fmt:formatDate value="${relatedWishMap.wishRunVo.start_date }" pattern="yyyy-MM-dd"/> 
												</div>
												<div class="col-1"></div>
											</div>
											<div class="row mt-2">
												<div class="col-1"></div>
												<div class="col-6">
													▣ 위시 종료일
												</div>
												<div class="col">
													<fmt:formatDate value="${relatedWishMap.wishRunVo.end_date }" pattern="yyyy-MM-dd"/>
												</div>
												<div class="col-1"></div>
											</div>
											<div class="row mt-2">
												<div class="col-1"></div>
												<div class="col-6">
													▣ 위시를 만든 유저
												</div>
												<div class="col">
													${relatedWishMap.wishMemberVo.id }
												</div>
												<div class="col-1"></div>
											</div>
											<div class="row mt-2 mb-3">
												<div class="col-1"></div>
												<div class="col-6">
													▣ 위시를 실행하는 유저
												</div>
												<div class="col">
													${relatedWishMap.wishRunMemberVo.id }
												</div>
												<div class="col-1"></div>
											</div>
										</div>
									</div>
									<div class="col-2"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col"> 
							<div class="shadow card card-body py-4">
								<div class="row">
									<div class="col text-center fs-5 fw-bold">
										위시 투두 <i class="bi bi-list-check"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="shadow card card-body px-5 py-4">
								<div class="row px-4">
									<div class="col-1"></div>
									<div class="col">
										<div class="shadow-sm card card-body py-4">
											<div class="row mt-2 mb-3">
												<div class="col-1"></div>
												<div class="col">
													<div class="row">
														<div class="col-9 text-center">
															투두 내용
														</div>
													</div>
												</div>
												<div class="col-1"></div>
												<div class="col text-center ms-2">
													투두 진행사항
												</div>
												<div class="col-1"></div>
											</div>
										
											<c:forEach items="${relatedWishMap.relatedTodoList }" var="data">
												<div class="row mt-2">
													<div class="col-1"></div>
													<div class="col fw-bold">
														${data.todoVo.title }
													</div>
													<div class="col"></div>
													<div class="col-1"></div>
												</div>
												<div class="row">
													<div class="col-1 mt-1"></div>
													<div class="col-6 mt-1">
														<i class="bi bi-check2-circle" style="color:#00008B"></i> ${data.todoVo.content }
													</div>
													<div class="col-4 text-end">
														<c:choose>
															<c:when test="${data.totalCount != '결과 없음'}">
																<div class="progress">
																	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${data.totalCount }%" aria-valuenow="${data.totalCount }" aria-valuemin="0" aria-valuemax="100">
																		${data.totalCount }%
																	</div>
																</div>
															</c:when>
															<c:otherwise>
																실행 하지 않음
															</c:otherwise>
														</c:choose>
													</div>
													<div class="col-1"></div>
												</div>
											</c:forEach>
											<div class="row mb-2"></div>
										</div>
									</div>
									<div class="col-1"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							<div class="shadow card card-body py-4">
								<div class="row">
									<div class="col text-center fs-5 fw-bold">
										위시 일정 보기 <i class="bi bi-calendar2-week-fill" style="color: #3232FF"></i> 
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="shadow card card-body py-4">
								<div class="row">
									<div class="col-1"></div>
									<div class="col text-end">	
										시작일 
										<fmt:formatDate value="${relatedWishMap.wishRunVo.start_date }" pattern="yyyy-MM-dd"/>
									</div>
									<div class="col-1 text-center">
										~
									</div>
									<div class="col">
										종료일 
										<fmt:formatDate value="${relatedWishMap.wishRunVo.end_date }" pattern="yyyy-MM-dd"/>
									</div>
									<div class="col-1"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="shadow card card-body py-4 px-1">
								<div class="row">
									<div class="col-1"></div>
									<div class="col">
										<div class="shadow-sm card card-body py-4 px-1">
											<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
												<div class="carousel-inner">
													<c:forEach items="${relatedWishMap.relatedTodoDayList }" var="data" varStatus="status">
														<c:if test="${status.index == 0}">
															<div class="carousel-item active" data-bs-interval="5000">
														</c:if>
														<c:if test="${status.index != 0}">
															<div class="carousel-item">
														</c:if>
														<div class="row mt-4">
															<div class="col text-center fs-5 fw-bold">
																<fmt:formatDate value="${data.todo_day }" pattern="yyyy년 MM월 dd일"/>
															</div>
														</div>
														<div class="row mt-5"></div>
														<div class="row mt-1"></div>
														<c:forEach items="${data.relatedWishTodoDayList }" var="data2">
															<div class="row mt-1">
																<div class="col-1"></div>
																<div class="col text-center fw-bold">
																	${data2.todo.title }
																</div>
																<div class="col">
																	<i class="bi bi-check2-circle" style="color:#00008B"></i> ${data2.todo.content }
																</div>
																<div class="col-1"></div>
															</div>
															<div class="row mt-1"></div>
														</c:forEach>
														<!-- <form action="readTodoRun.do" method="get"> -->
															<div class="row mt-5"></div>
															<c:if test="${relatedWishMap.wishRunVo.member_no == user.no }">
																<div class="row">
																	<div class="col-4"></div>
																	<div class="col">
																		<fmt:formatDate value="${data.todo_day }" pattern="yyyy년 MM월 dd일" var="todoDay"/>
																		<fmt:formatDate value="${data.todo_day }" pattern="yyyy-MM-dd" var="todo_day_"/>
																		<a class="btn btn-primary form-control" href="readTodoRun.do?todo_day=${todo_day_ }">
																			투두 상세보기
																		</a>
																	</div>
																	<div class="col-4"></div>
																</div>
																<div class="row mb-4"></div>
															</c:if>
														</div>
											    	</c:forEach>
											    	<div class="row">
											    		<div class="col">
															<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
																<span class="carousel-control-prev-icon" aria-hidden="true"></span>
																<span class="visually text-secondary mx-5">Prev</span>
															</button>
														</div>
														<div class="col">
															<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
																<span class="carousel-control-next-icon" aria-hidden="true"></span>
																<span class="visually text-secondary mx-5">Next</span>
														  	</button>
													  	</div>
												  	</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-1"></div>
								</div>
							</div>
						</div>
					</div>
					
					<c:if test="${relatedWishMap.wishRunVo.end_date < nowDate}">
						<div class="row mt-4">
							<div class="col">
								<div class="shadow card card-body py-4">
									<div class="row text-center fs-5 fw-bold">
										<div class="col">
											위시 후기 <i class="bi bi-vector-pen"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="card shadow py-3 px-2">
									<div class="row my-3">
										<div class="col-2"></div>
										<div class="col fw-bold">
											위시를 실행하면서 느꼈던 후기 작성
										</div>
										<div class="col-2"></div>
									</div>
									<div class="row">
										<div class="col-2"></div>
										<div class="col">
											<textarea id="epilogueContent" rows="10" class="form-control"></textarea>
										</div>
										<div class="col-2"></div>
									</div>
									<div class="row mt-4 mb-3">
										<div class="col-2"></div>
										<div class="col fw-bold">
											인상깊었던 장소 남기기
										</div>
										<div class="col-2"></div>
									</div>
									<div class="row">
										<div class="col-2"></div>
										<div class="col-6">
											<input class="form-control" id="address" type="text">
										</div>
										<div class="col">
											<button class="btn btn-secondary form-control" id="placeButton" onclick="clickAddress()">장소찾기</button>
										</div>
										<div class="col-2"></div>
									</div>
									<div class="row mt-2">
										<div class="col-2"></div>
										<div class="col" id="map"></div>
										<div class="col-2"></div>
									</div>
									<div class="row mt-2">
										<div class="col-7"></div>
										<div class="col" id="inputButtonBox">
											<button class="btn btn-primary form-control" onclick="createEpilogue(${relatedWishMap.wishRunVo.no})">후기 작성</button>
										</div>
										<div class="col-2"></div>
									</div>
									<div class="row mb-3"></div>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row mt-4">
						<div class="col">
							<div class="shadow card card-body">
								<div class="row mt-5"></div>
								<div class="row">
									<div class="col-8"></div>
									<div class="col text-center">
										위시 실행 신뢰도 평가하기.
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-3">
										<div class="row text-center">
											<div class="col">
												댓글 작성 <i class="bi bi-chat-dots"></i>
											</div>
											<div class="col-2"></div>
										</div>
									</div>
									<div class="col"></div>
									<div class="col-1 text-end">
										<a onclick="clickReliabilty('y',${relatedWishMap.wishRunVo.no})">
											<c:choose>	
												<c:when test="${reliabilityMap.myReliabilityVo.good_bad == 'y' }">
													<i id="goodButton" class="bi bi-hand-thumbs-up-fill text-primary"></i>
												</c:when>
												<c:otherwise>
													<i id="goodButton" class="bi bi-hand-thumbs-up"></i>
												</c:otherwise>
											</c:choose>
											
										</a>
									</div>
									<div class="col-1 text-end">
										<a onclick="clickReliabilty('n',${relatedWishMap.wishRunVo.no})">
											<c:choose>
												<c:when test="${reliabilityMap.myReliabilityVo.good_bad == 'n' }">
													<i id="badButton" class="bi bi-hand-thumbs-down-fill text-primary"></i>
												</c:when>
												<c:otherwise>
													<i id="badButton" class="bi bi-hand-thumbs-down"></i>
												</c:otherwise>
											</c:choose>
										</a>
									</div>
									<div class="col-2 text-center" id="reliability2">
										<c:if test="${!empty reliabilityMap.countReliability }">
											${reliabilityMap.countReliability }
										</c:if>
									</div>
								</div>
								<div class="row mt-3"></div>
								<div class="row">
									<hr>
								</div>
								<div class="row mt-3"></div>
								<div class="row mb-4 px-3">
									<div class="col-2 text-center fw-bold">
										아이디
									</div>
									<div class="col text-center fw-bold">
										댓글 내용
									</div>
									<div class="col-2 text-center fw-bold">
										댓글관련
									</div>
								</div>
								<div class="row"></div>
									<div id="replyBox" class="px-3"></div>
									<div id="modalBox"></div>
								<div class="row mt-2"></div>
								<div class="row mt-4"></div>
								<div class="row">
									<hr>
								</div>
								<div class="row mt-2">
									<form action="./createWishRunReplyProcess.do">
										<div class="row px-4">
											<div class="col text-center">
												<textarea id="content" class="shadow-sm form-control" rows="5" cols="50"></textarea>
											</div>
										</div>
										<div class="row my-3 px-4">
											<div class="col-10"></div>
											<div class="col">
												<input class="shadow-sm btn btn-primary form-control" type="button" value="댓글작성" onclick="createReply()">
											</div>
										</div>
									</form>
								</div>								
								</div>
							</div>
						</div>
						<div class="row mb-5"></div>
						<div class="row mb-5"></div>
					</article>
				</div>

			<div class="col-1">
<!-- 				<div class="row mt-5"></div>
				<div class="row mt-5"></div>
				<div class="row mt-3"></div>
				<div class="row mt-3"></div>
				<div class="row mt-1"></div>
				<div class="row mt-1"></div> -->
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
	
	<!-- 줄맞추기 -->
	<div style="width:1200px;" class="row">
		<div class="col mt-5"></div>
	</div>
	
	<footer class="bg-white card shadow">
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>