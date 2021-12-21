<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(chartCallBack);

	
	function chartCallBack(){
		
		getCountGender();
		getTodoRunGraph();
		getWishLikeGraph();
		getQuitWishGraph();
	}
	
	// 성별 데이터 읽어오기.
	function getCountGender(){
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				console.log(data.getCountGender.GENDER);
				
				drawGenderChart(data);
				
				
				for(countGender of data.getCountGender){
					
					if(countGender.GENDER == 'm') {
						
						document.getElementById("countMan").innerText = countGender.CNT;
						
						
					} else if(countGender.GENDER == 'w') {
						
						document.getElementById("countWoman").innerText = countGender.CNT;
						
					}
					
				}
				
				if(document.getElementById("countMan").innerText == null || document.getElementById("countMan").innerText == ""){
					
					
					document.getElementById("countMan").innerText = 0;
					
				}
				
				if(document.getElementById("countWoman").innerText == null || document.getElementById("countWoman").innerText == ""){
					
					
					document.getElementById("countWoman").innerText = 0;
					
				}
				
			}
		};
		
		xmlhttp.open("get" , "./getCountWishGender.do?wish_no=${wishAndToDoByWishNo.wishData.no}");
		xmlhttp.send();
		
	}
	// 성별 도넛 그래프 그리기.
  	function drawGenderChart(data) {

		/*
		var tempData = [];
		tempData.push(['gender', 'aefefwef']);
		
		for(x of data.getCountGender){
			tempData.push([x.GENDER , x.CNT ]);
		}
		
    	var chartData = google.visualization.arrayToDataTable(tempData);
		*/
		
		var chartData = new google.visualization.DataTable();
		
		chartData.addColumn('string' , 'gender');
		chartData.addColumn('number' , 'cnt');
		
		for(x of data.getCountGender){
			chartData.addRow([x.GENDER , x.CNT ]);
		}
		
    	
        var options = {
        	title: '성별 그래프',
        	is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('genderGraph'));
        chart.draw(chartData, options);
        
 	}
	
	
	
	// todo_run 불러오기.
	function getTodoRunGraph(){
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				drawTodoRunChart(data);
				
				
				
				for(countTodoRun of data.todoRunGraph){
					
					if(countTodoRun.check == 'y') {
						
						document.getElementById("countY").innerText = countTodoRun.CNT;
						
						
					} else if(countTodoRun.check == 'n') {
						
						document.getElementById("countN").innerText = countTodoRun.CNT;
						
					}
					
				}
				
				if(document.getElementById("countN").innerText == null || document.getElementById("countN").innerText == ""){
					
					document.getElementById("countN").innerText = 0;
					
				}
				
				if(document.getElementById("countY").innerText == null || document.getElementById("countY").innerText == ""){
					
					document.getElementById("countY").innerText = 0;
					
				}
				
				
			}
		};
		
		xmlhttp.open("get" , "./getTodoRunGraph.do?wish_no=${wishAndToDoByWishNo.wishData.no}");
		xmlhttp.send();
		
	}
	// todo_run 그래프.
	function drawTodoRunChart(data) {
		
		
		var chartData = new google.visualization.DataTable();
		
		chartData.addColumn('string' , 'gender');
		chartData.addColumn('number' , 'cnt');
		
		for(x of data.todoRunGraph){
			chartData.addRow([x.check , x.CNT ]);
		}
		
		// 그래프 그리기 관련.
        var options = {
            	title: '투두 실행 성공 여부',
            	is3D: true,
            };

        var chart = new google.visualization.PieChart(document.getElementById('todoRunGraph'));
        chart.draw(chartData, options);

	}
	
	
	
	// wishLike graph 불러오기.
	function getWishLikeGraph(){
			
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				drawWishLikeChart(data);
				
			}
		};
		
		xmlhttp.open("get" , "./getWishLikeGraph.do?wish_no=${wishAndToDoByWishNo.wishData.no}");
		xmlhttp.send();
		
	}
	// wishLike graph 그래프.
	function drawWishLikeChart(data) {
		
		
		var wishLikeBox = document.getElementById("wishLikeBox");
		
		wishLikeBox.innerHTML = "";

		var chartData = new google.visualization.DataTable();
		
		chartData.addColumn('string' , 'date');
		chartData.addColumn('number' , 'Like');
		
		for(x of data.wishLikeGraph){
			chartData.addRow([x.LIKE_DATE , x.CNT ]);
		}
		
		// 그래프 그리기 관련.
		var options = {
	    	hAxis: {
	    		title: '좋아요를 누른 날짜'
	    	},
	    	vAxis: {
	    		title: '좋아요 수'
	    	},
	    	colors: ['darkblue']
		};
	
	
		var wishLikeGraph = document.createElement("div");
		wishLikeGraph.setAttribute("id", "wishLikeGraph");
		wishLikeGraph.setAttribute("style", "width:622px;");
		wishLikeBox.appendChild(wishLikeGraph);
		
		
        var chart = new google.visualization.LineChart(document.getElementById('wishLikeGraph'));
        chart.draw(chartData, options);
		
	}
	
	
	
	// quitWish graph 불러오기.
	function getQuitWishGraph(){
		
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				drawQuitWishChart(data);
				
			}
		};
		
		xmlhttp.open("get" , "./getQuitWishGraph.do?wish_no=${wishAndToDoByWishNo.wishData.no}");
		xmlhttp.send();
		
	}
	// quitWish graph 그래프.
	function drawQuitWishChart(data) {
		
		
		var chartData = new google.visualization.DataTable();
		
		chartData.addColumn('string' , 'date');
		chartData.addColumn('number' , 'Quit');
		
		for(x of data.quitWishGraph){
			chartData.addRow([x.QUIT_DAY , x.CNT ]);
		}
		
		// 그래프 그리기 관련.
		var options = {
	    	hAxis: {
	    		title: '위시를 포기한 날짜'
	    	},
	    	vAxis: {
	    		title: '그 날에 포기한 수'
	    	},
	    	colors: ['darkred']
		};

        var chart = new google.visualization.LineChart(document.getElementById('quitWishGraph'));
        chart.draw(chartData, options);
		
	}
	
	
	
	
	// 좋아요 관련 기능..
	// 클릭할 때 좋아요 인서트, 딜리트하기.
	function clickWishLike(){
		
		if(${empty user}){
			alert("로그인 후 이용가능합니다.")
			return;
		};
		
		var likeIcon = document.getElementById("likeIcon");
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){

				getMyWishLikeCount();
				getWishLikeCount();
				getWishLikeGraph();
			}
		};
		
		// get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./wishLikeProcess.do?wish_no=${wishAndToDoByWishNo.wishData.no}"); 
		xmlhttp.send();
		
	}
	// 내 좋아요 수 확인하기.
	function getMyWishLikeCount() {
		
		var likeIcon = document.getElementById("likeIcon");
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){

				var data = JSON.parse(xmlhttp.responseText);
				
				if(data.myWishLikeCount < 1){
					
					likeIcon.setAttribute("class", "bi bi-heart");
					likeIcon.setAttribute("style", "");
					
					
				} else {
					
					likeIcon.setAttribute("class", "bi bi-heart-fill");
					likeIcon.setAttribute("style", "color:#CD5C5C");
					
				}
				
			}
		};
		
		// get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./getMyWishLikeCount.do?wish_no=${wishAndToDoByWishNo.wishData.no}"); 
		xmlhttp.send();
		
		
	}
	// 좋아요 수 불러오기.
	function getWishLikeCount() {
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){

				var data = JSON.parse(xmlhttp.responseText);
				
				var likeBox1 = document.getElementById("likeBox1");
				likeBox1.innerText = data.wishLikeCount;
				var likeBox2 = document.getElementById("likeBox2");
				likeBox2.innerText = data.wishLikeCount;
				
			}
		};
		
		// get 방식으로 파라미터 보내는법...
		xmlhttp.open("get" , "./getWishLikeCount.do?wish_no=${wishAndToDoByWishNo.wishData.no}"); 
		xmlhttp.send();
		
	}
	
	
	
	
	
	// 댓글 관련 기능..
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
		
		xmlhttp.open("get" , "./createWishReply.do?wish_no=${wishAndToDoByWishNo.wishData.no}&content="+content); 
		xmlhttp.send();
	}
	
	
	
	
	
	// wish_run_reply 리스트 가져오기.
	function getReplyList(){
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		if(${empty user}) {
			window.location.href="./index.do"
			return;
		}
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				var replyBox = document.getElementById("replyBox");
				var modalBox = document.getElementById("modalBox");
				replyBox.innerHTML = "";
				modalBox.innerHTML = "";
				
				for(i in data.wishReplyList){
					
					var no = data.wishReplyList[i].wishReplyVo.no;
					
					var divRow = document.createElement("div");
					divRow.setAttribute("class", "row");
					
					var colId = document.createElement("div");
					colId.setAttribute("class", "col-2 text-center mt-2");
					colId.innerText = data.wishReplyList[i].memberVo.id;
					divRow.appendChild(colId);
					
					var colContent = document.createElement("div");
					colContent.setAttribute("class", "col text-center mt-2");
					colContent.innerText = data.wishReplyList[i].wishReplyVo.content;
					divRow.appendChild(colContent);
					
					/* var write_date = new Date(data.wishRunReplyList[i].wishRunReplyVo.write_date);
					var format_date = getFormatDate(write_date);
					var colDate = document.createElement("div");
					colDate.setAttribute("class", "col-2 text-center mt-2");
					colDate.innerText = format_date;
					divRow.appendChild(colDate); */
					
					if(data.wishReplyList[i].wishReplyVo.member_no == ${user.no}){
						
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
						modalText.value = data.wishReplyList[i].wishReplyVo.content;
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
						
						if(data.wishReplyList[i].wishReplyWarningVo == null){
							
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
		
		xmlhttp.open("get" , "./getWishReply.do?wish_no=${wishAndToDoByWishNo.wishData.no}"); 
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
		
		xmlhttp.open("get" , "./deleteWishReply.do?wish_reply_no="+no); 
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
		
		xmlhttp.open("get" , "./updateWishReply.do?content="+content.value+"&no="+no);
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
		
		xmlhttp.open("get" , "./createWishReplyWarning.do?content="+content.value+"&wish_reply_no="+no);
		xmlhttp.send();
	}
	
	
	
	// 친구 추가하기.
	function createMyFriend(){
		
		if(${empty user}){
			window.location.href="../member/login.do";
			return;
		};
			
		var friendsIcon = document.getElementById("friendsIcon");
		
		
		if(${wishAndToDoByWishNo.memberVo.no} == ${user.no}) {
			
			friendsIcon.setAttribute("class", "bi bi-person-circle");
			alert("자기 자신과 친구추가를 할 수 없습니다.");
			return;
			
		}
		
		
		if(friendsIcon.getAttribute("class") == "bi bi-person-check-fill") {
			
			alert("${wishAndToDoByWishNo.memberVo.id}님과 친구입니다.");
			return;
			
		}
		
		
		
		
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				alert("${wishAndToDoByWishNo.memberVo.id}님이 친구추가 되었습니다.")
				getMyFriendsList();
			}
		};
		
		xmlhttp.open("get" , "../member/createFriend.do?member_no=${wishAndToDoByWishNo.memberVo.no}");
		xmlhttp.send();
		
	}
	// 친구 리스트 확인하기.
	function getMyFriendsList(){
		
		if(${empty user}){
			window.location.href="../member/login.do";
			return;
		};
		
		var friendsIcon = document.getElementById("friendsIcon");
		
		
		if(${wishAndToDoByWishNo.memberVo.no} == ${user.no}) {
			
			friendsIcon.setAttribute("class", "bi bi-person-circle");
			return;
			
		}
		
		//AJAX API 사용....
		var xmlhttp = new XMLHttpRequest();
		document.getElementById("content").value = "";
		
		//서버에서 응답 후 처리 로직.
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status==200){
				
				var data = JSON.parse(xmlhttp.responseText);
				
				for(memberNo of data.myFriendsList) {
					
					
					if(${wishAndToDoByWishNo.memberVo.no} == ${user.no}) {
						
						friendsIcon.setAttribute("class", "bi bi-person-circle");
						friendsIcon.setAttribute("style", "font-size: 18px;")
						return;
						
					}
					
					if(memberNo == "${wishAndToDoByWishNo.memberVo.no}") {
						
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
		
		getMyWishLikeCount();
		getWishLikeCount();
		getReplyList();
		getMyFriendsList();
	}
	
	// 문서 onload API.
	window.addEventListener('DOMContentLoaded', init);
	
	

</script>


<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
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
							<div class="shadow card card-body pt-4 pb-1">
								<div class="row text-center">
									<div class="col fs-4 fw-bold">
										${wishAndToDoByWishNo.wishData.title}
									</div>
								</div>
								<div class="row mt-2">
									<div class="col text-center">
										${wishAndToDoByWishNo.wishData.content}
									</div>
								</div>
								<div class="row">
									<div class="col-5"></div>
									<div class="col-4 text-end mt-2">
										${wishAndToDoByWishNo.memberVo.id}
									</div>
									<div class="col-1 text-center btn" onclick="createMyFriend()">
										<a id="friendsIcon" class="bi bi-person-plus-fill"  style="font-size: 18px; color:black;"></a>
									</div>
									<div class="col-2"></div>
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
											<div class="row mb-3">
												<div class="col text-center fw-bold">
													투두 내용
												</div>
											</div>
											
											<c:forEach items="${wishAndToDoByWishNo.toDoData }" var="data">
												<div class="row mt-2">
													<div class="col-2"></div>
													<div class="col-4 fw-bold">
														${data.title }
													</div>
													<div class="col">
														${data.content}
													</div>
													<div class="col-1"></div>
												</div>
											</c:forEach>
											<div class="row mt-5">
												<div class="col-2"></div>
												<div class="col">
													<a class="btn btn-primary form-control" href="./wishTodoRun.do?wish_no=${wishAndToDoByWishNo.wishData.no}">위시 실행하기</a>
												</div>
												<div class="col-2"></div>
											</div>
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
					  		<div class="card shadow-sm py-3">
					  			<div class="card-body fs-5 text-center fw-bold">
						    		위시 관련 데이터
								</div>
					  		</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col">
							<div class="card shadow-sm p-1">
								<div class="row my-2">
									<div class="col-1"></div>
									<div class="col">
										<div class="row text-center">
											<div class="col-1"></div>
											<div class="col">
												<i class="bi bi-suit-heart-fill" style="color:#CD5C5C"></i>
											</div>
											<div class="col" id="likeBox2">
												
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col">
										<div class="row text-center">
											<div class="col-1"></div>
											<div class="col">
												<i class="bi bi-trophy-fill" style="color:#DAA520;"></i>
											</div>
											<div class="col">
												${wishRankData.runWishCount}
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col">
										<div class="row text-center">
											<div class="col-1"></div>
											<div class="col">
												<i class="bi bi-eye-fill" style="color:#008000;"></i>
											</div>
											<div class="col">
												${wishAndToDoByWishNo.wishData.read_count}
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col">
										<div class="row text-center">
											<div class="col-1"></div>
											<div class="col">
												<i class="bi bi-hand-thumbs-down-fill" style="color:#4B0082;"></i>
											</div>
											<div class="col">
												${wishRankData.quitWishCount}
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col-1"></div>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="row">
						<div class="col">
							<div class="card shadow-sm py-4">
								<div class="row mx-5 py-5">
								  	<div class="col">
							  			<div id="genderGraph" style="width:330px;"></div>
									</div>
									<div class="col mt-3">
										<div class="fw-bold">
											실행하는 사람의 성별
										</div>
										<table class="table table-striped table-hover mt-3">
											<thead>
												<tr class="text-center">
													<th scope="row">No.</th>
										      		<td colspan="2">성별</td>
										      		<td>인원수</td>
												</tr>
											</thead>
											<tbody>
											    <tr class="text-center">
										      		<th scope="row" >1</th>
										      		<td colspan="2">남성</td>
										      		<td id="countMan"></td>
										 		</tr>
										    	<tr class="text-center">
										      		<th scope="row">2</th>
										      		<td colspan="2">여성</td>
										      		<td id="countWoman"></td>
										    	</tr>
										  	</tbody>
										</table>
									</div>
									<div class="col-1"></div>
								</div>
								<div class="row mx-5 pb-3">
								  	<div class="col">
							  			<div id="todoRunGraph" style="width:330px;"></div>
									</div>
									<div class="col mt-1">
										<div class="fw-bold">
											투두 실행률
										</div>
										<table class="table table-striped table-hover mt-3">
											<thead>
												<tr class="text-center">
													<th scope="row">No.</th>
										      		<td colspan="2">성공여부</td>
										      		<td>개수</td>
												</tr>
											</thead>
											<tbody>
											    <tr class="text-center">
										      		<th scope="row" >1</th>
										      		<td colspan="2">성공</td>
										      		<td id="countY"></td>
										    	</tr>
										    	<tr class="text-center">
										      		<th scope="row">2</th>
										      		<td colspan="2">실패</td>
										      		<td id="countN"></td>
										    	</tr>
										  	</tbody>
										</table>
									</div>
									<div class="col-1"></div>
								</div>

								<div class="row mx-5 py-5">
									<div class="fw-bold">
										<div class="row">
											<div class="col-1"></div>
											<div class="col">
												날짜별 좋아요 수
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col" align="center" id="wishLikeBox">
							  			<div id="wishLikeGraph" style="width:622px;"></div>
									</div>
								</div>
								<div class="row mx-5 py-5">
									<div class="fw-bold">
										<div class="row">
											<div class="col-1"></div>
											<div class="col">
												날짜별 위시 포기 수
											</div>
											<div class="col-1"></div>
										</div>
									</div>
									<div class="col" align="center">
							  			<div id="quitWishGraph" style="width:622px;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							<div class="shadow card card-body">
								<div class="row mt-3"></div>
								<div class="row">
									<div class="col-3">
										<div class="row text-center">
											<div class="col">
												댓글 작성 <i class="bi bi-chat-dots"></i>
											</div>
											<div class="col-2"></div>
										</div>
									</div>
									<div class="col"></div>
									<div class="col-2" align="right">
										<a onclick="clickWishLike()">
											<i class="bi bi-heart-fill" id="likeIcon"></i>
										</a>
									</div>
									<div class="col-1" id="likeBox1">
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
					<div class="row mb-2"></div>
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
	        <div class="col-2"></div>
	    </div>
    </div>

	
	<div class="row my-5"></div>
    <footer class="bg-white card shadow">
        <jsp:include page="../common/footer.jsp"/>
    </footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		
</body>
</html>