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
<link href="/DEVCA/resources/css/lectureList.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* 별점 */
.star-rating { 
	width:80px; 
}
.star-rating , .star-rating span { 
	display:inline-block; 
	height:15px; 
	overflow:hidden;
	background:url(../resources/images/star.png)no-repeat; 
	background-size: 80px 30px;
}
.star-rating span{ 
	background-position:left bottom; 
	line-height:0; 
	vertical-align:top; 
}
</style>

<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

/* initialize tooltip */
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();   
});

/* 내 강의에 추가하기  */
function addMyLecture(LECTURE_CODE){
    $.ajax({
        type: "POST",
        url: "/DEVCA/lecture/addmylectureajax.do",
        data: {
        	MEMBER_CODE : '${sessionMember_profile.MEMBER_CODE}',
        	LECTURE_CODE: LECTURE_CODE
        },
        datatType: "JSON",

        success: function (args) {
        	alert("내 강의에 추가되었습니다");
        },

        error: function (request, status, error) {
           alert("통신 실패");
           alert("code : " + request.status + "\n" +
              "message : " + request.responseText + "\n" +
              "error : " + error);
        }
     });
	//상위로 이벤트가 전파되지 않도록 중단한다.
    event.stopPropagation();
}

/* lecture list 뿌리기 */
function fillLectureList(data){
	
	
	$.each(data, function(index, item){
		console.log(item.LECTURE_CODE)
		
		// 강의 div
		var lectureItem = $("<div>").attr({
			"class" : "lecture card m-4"
		})
		
		// 강의 링크버튼 opacity
		var add_my_lecture;
		if('${sessionMember_profile}' != ''){
			add_my_lecture = 
				$("<div>").attr({"class":"add_my_lecture_img_container","style":"text-align:right;"})
				.append($("<img src='../resources/images/heart.png'>").attr({
					"class":"add_my_lecture_img",
					"onclick":"addMyLecture("+item.LECTURE_CODE+")",
					"data-toggle":"tooltip",
					"title":"MY LECTURE 에 추가하기"
					})) 
		}else{
			add_my_lecture = 
				$("<div>").attr({"class":"add_my_lecture_img_container","style":"text-align:right;"})
				.append($("<img src='../resources/images/heart.png'>").attr({
					"class":"add_my_lecture_img",
					"data-toggle":"tooltip",
					"title":"DEVCA 로그인 하세요"
					})) 
		}
		var lecture_back = $("<div>").attr({
			"class" : "lecture_back card p-3",
			"onclick" : "location.href='/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + item.LECTURE_CODE + "'"
		})
		.append($("<h4>").text(item.LECTURE_TITLE).attr("style","color: white;"))
		.append($("<div>").text(item.LECTURE_DESCRIPTION).attr({"class":"pt-3","style":"color: white;"}))
		.append(add_my_lecture)
		
		// 이미지 관련 div
		var lecture_img_div = $("<div>").attr({"class" : "lecture_img_div"})
		var lecture_img = $("<img>").attr({"src" : item.LECTURE_IMG,"style" : "width: 100%; height: 100%; object-fit: cover;"})			
		lecture_img_div.append(lecture_img);
		
		// 강의 정보 div
		var lecture_des_div = $("<div>").attr({
			"class" : "lecture_des_div p-3"
		});
		var lecture_title = $("<h4>").text(item.LECTURE_TITLE);		// 제목		
		var lecture_additional_des = $("<div>").attr({"class":"lecture_additional_des row py-4 px-1"}) // 부가정보		
		var lecture_rate = $("<div>").attr({"class":"col-sm-6"})
							.append($("<div>").append(   $("<div>").attr({"class":"star-rating"}).append($("<span>").attr({"class":"rear-start","style":"width:"+item.LECTURE_RATE*20+"%;"}))  )  )
							.append($("<div>").text(item.LECTURE_READCOUNT+"개의 후기"));// 별점, 후기갯수

		var lecture_payflag = $("<div>").attr({"class":"col-sm-6", "style":"text-align: right;"}).text(item.LECTURE_PAYFLAG);// 가격		
		lecture_additional_des.append(lecture_rate).append(lecture_payflag);		
		lecture_des_div.append(lecture_title).append(lecture_additional_des);
		
		// 강의 div 에 append 하여 content 완성
		lectureItem.append(lecture_back);
		lectureItem.append(lecture_img_div);
		lectureItem.append(lecture_des_div);
		
		$("#lectureListContainer").append(lectureItem);
	})

	$("#loading").hide();
}

/* 무한 스크롤 eventListner */
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
			$("#loading").show();
			if('${search}' != ""){
				selectSearchList('${search}');
			}else{
				selectLectureList();		
			}		
		}
	})
	

	// 일단 리스트 한번 가져옴~
	if('${search}' != ""){
		selectSearchList('${search}');
	}else{
		selectLectureList();		
	}	
})

function selectLectureList(){	
	if(isEnd == true)
		return;
	
	$.getJSON("/DEVCA/lecture/lecturelistajax.do?no=" + startNo , function(data){
		// 가져온 데이터가 20개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		if(length < 20){
			isEnd = true;
		}
		fillLectureList(data)		 
	})	
	startNo += 20;
}

function selectSearchList(search){	
	if(isEnd == true)
		return;	
	
	$.getJSON("/DEVCA/lecture/lecturesearchlistajax.do?no=" + searchNo +"&search=" + search , function(data){
		// 가져온 데이터가 20개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		if(length < 20){
			isEnd = true;
		}
		fillLectureList(data)		 		 
	})	
	searchNo += 20;
}
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>
	<a href="/DEVCA/lecture/CrawlingJobData.do">jobd 탐색 시작!</a>
	<a href="/DEVCA/lecture/CrawlingLectureList.do">크롤링 시작!</a>
	<section class="card p-4 my-3 bg-white">
		<h1 class="card-title">LECTURE</h1>
	
		<div id="lectureListContainer" class="d-flex flex-wrap">	
			
		</div>
		<div id="loading">
			<img src='../resources/images/Spinner-1s-600px.gif' style="display:block; margin: 0px auto; z-index:9000;"/>
		</div>
		
	</section>
	
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>