<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
   
   <!--Fontawesome CDN-->
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
   
<!-- end bootstrap --!>

<!-- START :: css -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/DEVCA_Module_ScrollPagination/resources/css/master.css" rel="stylesheet" type="text/css">
<link href="/DEVCA_Module_ScrollPagination/resources/css/lectureList.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* 별점 */
.star-rating { 
	width:80px; 
}
.star-rating , .star-rating span { 
	display:inline-block; 
	height:15px; 
	overflow:hidden;
	background:url(${pageContext.request.contextPath}/resources/images/star.png)no-repeat; 
	background-size: 80px 30px;
}
.star-rating span{ 
	background-position:left bottom; 
	line-height:0; 
	vertical-align:top; 
}
</style>

<!-- END :: css -->


<!-- START :: JAVASCRIPT -->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

/* lecture list 뿌리기 */
function fillLectureList(data){	
	
	$.each(data, function(index, item){
		console.log(item.LECTURE_CODE)
		
		// 강의 div
		var lectureItem = $("<div>").attr({
			"class" : "lecture card m-4"
		})
		
		// 강의 링크버튼 opacity
		var add_my_lecture = 
				$("<div>").attr({"class":"add_my_lecture_img_container","style":"text-align:right;"})
				.append($("<img src='${pageContext.request.contextPath}/resources/images/heart.png'>").attr({
					"class":"add_my_lecture_img",
					"data-toggle":"tooltip",
					"title":"MY LECTURE 에 추가하기"
					})) 
		
		var lecture_back = $("<div>").attr({
			"class" : "lecture_back card p-3"
		})
		.append($("<div>").attr({"style":"height:90%; overflow: hidden;"})
				.append($("<h4>").text(item.LECTURE_TITLE).attr("style","color: white;"))
				.append($("<div>").text(item.LECTURE_DESCRIPTION).attr({"class":"pt-3","style":"color: white;"}))
				)
		.append(add_my_lecture)
		
		// 이미지 관련 div
		var lecture_img_div = $("<div>").attr({"class" : "lecture_img_div"})
		var lecture_img = $("<img>").attr({"src" : item.LECTURE_IMG,"style" : "width: 100%; height: 100%; object-fit: cover;"})			
		lecture_img_div.append(lecture_img);
		
		// 강의 정보 div
		var lecture_des_div = $("<div>").attr({
			"class" : "lecture_des_div p-3"
		});
		var lecture_title = $("<h5>").attr({"class":"font-weight-bold"}).text(item.LECTURE_TITLE);		// 제목		
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

}

/* 무한 스크롤 eventListner */
let isEnd = false;
let startNo = 0;
let searchNo = 0;

$(function(){	
	
	$(window).scroll(function(){
		var scrollTop = $(window).scrollTop();	// 현재 브라우저 스크롤이 있는 위치
		var documentHeight = $(document).height();	// 문서의 총 높이
		var windowHeight = $(window).height();	// 브라우저에 보여지는 높이
		
		console.log(
				"documentHeight : " + $(document).height()
				+ " | scrollTop : " + $(window).scrollTop() 
				+ " | windowHeight : " + $(window).height()
				+ " | scrollTop + windowHeight = " + ($(window).scrollTop() + $(window).height())
				);
		
		if(documentHeight < scrollTop + windowHeight + 1){
			selectLectureList();	
		}
	})
	
	selectLectureList();	
})

function selectLectureList(){	
	if(isEnd == true)
		return;
	
	$.getJSON("/DEVCA_Module_ScrollPagination/lecture/lecturelistajax.do?no=" + startNo , function(data){
		// 가져온 데이터가 20개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
		let length = data.length;
		if(length < 20){
			isEnd = true;
			console.log("******마지막 컨텐츠까지 다 가져옴******")
		}
		fillLectureList(data)		 
	})	
	startNo += 20;
}
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section class="card p-4 my-3 bg-white">
		<h1 class="card-title">LECTURE</h1>
	
		<div id="lectureListContainer" class="d-flex flex-wrap">	
			
		</div>		
	</section>
</body>
</html>