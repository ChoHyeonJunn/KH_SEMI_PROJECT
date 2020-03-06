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
let searchNo = 0;

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
	if('${search}' != ""){
		selectSearchList('${search}');
	}else{
		selectLectureList();		
	}	
})

let selectLectureList = function(){
	
	if(isEnd == true){
		return;
	}
	
	$.getJSON("/DEVCA/lecture/lecturelistajax.do?no=" + startNo , function(data){
		
		// 가져온 데이터가 5개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		/* alert(data.length) */
		if(length < 20){
			isEnd = true;
		}
		
		$.each(data, function(index, item){
			console.log(item.LECTURE_CODE)
			
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
		}) 
	})
	
	startNo += 20;
}

function selectSearchList(search){
	
	if(isEnd == true){
		return;
	}
	
	$.getJSON("/DEVCA/lecture/lecturesearchlistajax.do?no=" + searchNo +"&search=" + search , function(data){
		
		// 가져온 데이터가 5개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		/* alert(data.length) */
		if(length < 20){
			isEnd = true;
		}
		
		$.each(data, function(index, item){
			console.log(item.LECTURE_CODE)
			
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
		}) 
	})
	
	searchNo += 20;
}

</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>
	
	<a href="/DEVCA/lecture/CrawlingJobData.do">jobd 탐색 시작!</a>
	<a href="/DEVCA/lecture/CrawlingLectureList.do">크롤링 시작!</a>
	<section id="lectureListContainer">

		
	</section>
	
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>