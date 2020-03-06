<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">

section{
	overflow:hidden;
	height:auto;
}
.lecture{
	float: left; 
	padding: 0px;
	margin: 30px; 
	overflow: hidden;
	width: 300px;
	height: 400px;
	border: 1px solid gray;
	overflow: hidden;
}
.lecture:hover .lecture_back{
	opacity: 0.8;
}
.lecture_back{
	position: absolute;
	width: 300px;
	height: 400px;

	padding: 0px;
	margin: 0px;
	background-color: black;
	color: white;
	opacity: 0;
}
.lecture_img_div{
	padding: 0px;
	margin: 0px;
	width: 100%; 
	height: 40%;
}	
.lecture_des_div{
	padding: 0px;
	margin: 0px;
	width: 100%; 
	height: 60%;
}
</style>

<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

let isEnd = false;
let startNo = 0;

$(function(){	
	
	$(window).scroll(function(){
		let $window = $(this);
		let scrollTop = $window.scrollTop();
		let windowHeight = $window.height();
		let documentHeight = $(document).height();
		
		console.log(
				"documentHeight : " + documentHeight
				+ " | scrollTop : " + scrollTop
				+ " | windowHeight : " + windowHeight
				);
		
		// scrollbar의 thumb가 바닥 전 30px 까지 도달하면 리스트를 가져온다~
		if(scrollTop + windowHeight + 1 > documentHeight){
			selectLectureList();	
		}
	})
	

	// 일단 리스트 한번 가져옴~
	selectMyLectureList();
})

let selectMyLectureList = function(){
	
	if(isEnd == true){
		return;
	}
	
	// 방명록 리스트를 가져올 때 시작 번호
    // renderList 함수에서 html 코드를 보면 <li> 태그에 data-no 속성이 있는 것을 알 수 있다.
    // ajax에서는 data- 속성의 값을 가져오기 위해 data() 함수를 제공.
    // let startNo = $("#lectureListContainer div").last().data("no") || 0;
	
	$.getJSON("/DEVCA/lecture/mylecturelistajax.do?no=" + startNo , function(data){
		
		// 가져온 데이터가 5개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		/* alert(data.length) */
		if(length < 20){
			isEnd = true;
		}
		
		$.each(data, function(index, item){
			
			if(item.LECTURE_TITLE == undefined){
				var lectureItem = $("<div>").attr({
					"class" : "lecture"
				})
				
				// 강의 링크버튼 opacity
				var lecture_back = $("<div>").attr({
					"class" : "lecture_back",
					"onclick" : "DeleteMyGarbageLecture(" + item.LECTURE_CODE + ");"
				}).append(
						$("<h4>").text("증발").attr("style","color: white;")
						);
				
				var lecture_msg = $("<div>").append("<h2>만료된 강의입니다.</h2>")
				
				lectureItem.append(lecture_back);
				lectureItem.append(lecture_msg);
				$("#lectureListContainer").append(lectureItem);
			} else {
				// 강의 div
				var lectureItem = $("<div>").attr({
					"class" : "lecture"
				})
				
				// 강의 링크버튼 opacity
				var lecture_back = $("<div>").attr({
					"class" : "lecture_back",
					"onclick" : "location.href='/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + item.LECTURE_CODE + "'"
				}).append(
						$("<h4>").text(item.LECTURE_TITLE).attr("style","color: white;")
						).append(
								$("<div>").text(item.LECTURE_DESCRIPTION).attr("style","color: white;")
								);
	
				// 이미지 관련 div
				var lecture_img_div = $("<div>").attr({
					"class" : "lecture_img_div"
				})
				var lecture_img = $("<img>").attr({
					"src" : item.LECTURE_IMG,
					"style" : "width: 100%; height: 100%; object-fit: cover;"
				})			
				lecture_img_div.append(lecture_img);
				
				// 강의 정보 div
				var lecture_des_div = $("<div>").attr({
					"class" : "lecture_des_div"
				});
				var lecture_title = $("<h4>").text(item.LECTURE_TITLE);
				var lecture_description = $("<div>").text(item.LECTURE_DESCRIPTION);
				var lecture_payflag = $("<div>").text(item.LECTURE_PAYFLAG);
				lecture_des_div.append(lecture_title).append(lecture_description).append(lecture_payflag);
				
				// 강의 div 에 append 하여 content 완성
				lectureItem.append(lecture_back);
				lectureItem.append(lecture_img_div);
				lectureItem.append(lecture_des_div);
				
				$("#lectureListContainer").append(lectureItem);
			}
		}) 
		
		if(length == 0){
			var noContentDiv = $("<div>").css("height","500px");
			var messege = $("<div>").text("찜 한 강의가 존재하지 않습니다.");	
			var button_div = $("<div>");
			var lecture_button = $("<button>").attr({
				"onclick" : "location.href='/DEVCA/lecture/lecturelistpage.do'"
			}).text("강의 보러가기")
			
			button_div.append(lecture_button);
			noContentDiv.append(messege);
			noContentDiv.append(button_div);
			$("#lectureListContainer").append(noContentDiv);
		}
	})
	
	startNo += 12;
}


function DeleteMyGarbageLecture(LECTURE_CODE){
    $.ajax({
        type: "POST",
        url: "/DEVCA/lecture/deleteMyGarbageLecture.do",
        data: {
        	LECTURE_CODE: LECTURE_CODE
        },
        datatType: "JSON",

        success: function (args) {
        	$("#lectureListContainer").empty();
        	selectMyLectureList();
        },

        error: function (request, status, error) {
           alert("통신 실패");
           alert("code : " + request.status + "\n" +
              "message : " + request.responseText + "\n" +
              "error : " + error);
        }
     });
}
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>
	<section id="lectureListContainer">

		
	</section>	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>