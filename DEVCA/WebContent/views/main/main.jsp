<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<style type="text/css">
section{
	width: 100%;
	height: auto;
}

/* CHART STYLE */
#bar_chart_container, #roadMap_container{
	position: relative;
}
#chartdiv_roadmap{
	max-width: 80%;
	height: 500px;
}
#chartdiv_job_rank {
  max-width: 100%;
  height: 500px;
}
#bar_chart_description, #roadMap_description{
	padding: 0px;
	margin: 0px;
	
	background-color: black;
	color: white;
	opacity: 0.7;
	width: 20%;
	height: 100%;
	
	position: absolute;
	z-index: 100;
	right: 0px;
	top: 0px;
}

/* LECTURE STYLE */
.swiper-container {
	padding: 0px;
	margin: 0px;
	width:100%;
	height: auto;
}
.swiper-slide {
	padding: 0px;
	margin: 0px;
	text-align:center;
	display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */
	align-items:center; /* 위아래 기준 중앙정렬 */
	justify-content:center; /* 좌우 기준 중앙정렬 */
}
.swiper-slide img {
	padding: 0px;
	margin: 0px;
	max-width:100%;
}

.lecture{
	float: left; 
	padding: 0px;
	margin: 0px; 
	overflow: hidden;
	width: 100%;
	height: 400px;
	border: 1px solid gray;
	overflow: hidden;
}
.lecture:hover .lecture_back{
	opacity: 0.8;
}
.lecture_back{
	position: absolute;
	width: 100%;
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
	overflow: hidden;
}

</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/timeline.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/bullets.js"></script>
<script src="https://www.amcharts.com/lib/4/plugins/forceDirected.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/dark.js"></script>

<!-- Chart code -->
<script type="text/javascript" src="../resources/js/main_chart/bar.js"></script>
<script type="text/javascript" src="../resources/js/main_chart/roadMap.js"></script>

<!-- SWIPER PAGING -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<script type="text/javascript" src="../resources/js/main_lecture/lecture_recommend.js"></script>
<script type="text/javascript" src="../resources/js/main_lecture/lecture_my.js"></script>
<script type="text/javascript" src="../resources/js/main_lecture/lecture_frontend.js"></script>
<script type="text/javascript" src="../resources/js/main_lecture/lecture_backend.js"></script>
<script type="text/javascript" src="../resources/js/main_lecture/lecture_fullstack.js"></script>


<!-- START :: JAVASCRIPT -->
<script type="text/javascript">
$(function(){
	/* 
	////// roadMap 관련 //////
	*/
	getRoadMapData('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}');
	
	$("#roadMap_item_name").css("display","none")
	$("#roadMap_item_remove_button").css("display","none")
	// 로드맵에 추가하기 버튼 클릭시
	$("#roadMap_item_add_button").click(function(){
		var item = $("input[name='roadMap_new_item']").val();
		if(item != ""){
			addRoadMapData('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}', item);
		}
	})
	
	// 지우기 버튼 클릭 시
	$("#roadMap_item_remove_button").click(function(){
		var item = $("#roadMap_item_name").text();
		if(confirm("정말 지우시겠습니까?")){
			removeRoadMapData('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}', item);
		}
		
	})
	
	/*
	////// barChart 관련 //////
	*/
	getBarChartData('Developer');
	$("#Developer").click(function(){
		getBarChartData('Developer');
		$("#bar_chart_description").toggle(300);
	})
	$("#Web").click(function(){
		getBarChartData('Web');
		$("#bar_chart_description").toggle(300);
	})
	$("#Server").click(function(){
		getBarChartData('Server');
		$("#bar_chart_description").toggle(300);
	})
	$("#Language").click(function(){
		getBarChartData('Language');
		$("#bar_chart_description").toggle(300);
	})
	$("#DataBase").click(function(){
		getBarChartData('DataBase');
		$("#bar_chart_description").toggle(300);
	})
	$("#frameWork").click(function(){
		getBarChartData('frameWork');
		$("#bar_chart_description").toggle(300);
	})
	
	// barChart 라벨 클릭 이벤트
	$("#bar_chart_description").css("display", "none");
	$(document).on("click", "tspan", function(e){
		var item_name = $(this).text();
		//alert($(this).text());
		
		$("#bar_chart_description").toggle(function(){
			$(this).find("#bar_chart_item_name").text(item_name);
		});
	});
	// 닫기 클릭시
	$("#bar_chart_item_close").click(function(){
		$("#bar_chart_description").toggle(300);
	})
	
	// 로드맵에 추가하기 버튼 클릭시
	$("#bar_chart_item_add_button").click(function(){
		var item = $("#bar_chart_item_name").text();
		
		addRoadMapData('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}', item);
	})
	
	/*
	////// 강의 관련 //////
	*/
	selectRecommandList('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}');
	selectMyList('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}');
	selectFrontEndList();
	selectBackEndList();
	selectFullStackList();
})
// roadMap 노드 클릭 시
function roadMapNodeClick(item){
	$("#roadMap_item_name").text(item)
	if($("#roadMap_item_name").css("display") == "none"){
		$("#roadMap_item_name").toggle()
		$("#roadMap_item_remove_button").toggle()
	}
}
// roadMap 링크 연결
function linkBypass(selectedItem, Item){
	linkRoadMapData('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}', selectedItem, Item);
}


// barChart컬럼 클릭시 
function barChartColumClick(onclickBarItem){
	$("#bar_chart_description").toggle(function(){
		$(this).find("#bar_chart_item_name").text(onclickBarItem);
	});
}

</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->

</head>
<body>	
	<section>		
		<article id="roadmap">
			<p>
				<c:out value="${sessionLoginMember.MEMBER_NAME}"></c:out>
				<c:out value="${sessionLoginKakao.KAKAO_NICKNAME}"></c:out>
				<c:out value="${sessionLoginNaver.NAVER_NICKNAME}"></c:out>
				
				님의 <strong id="roadMap_field"></strong> 로드맵
			</p>
			<div id="roadMap_container">
				<div id="chartdiv_roadmap"></div>
				
				<span id="roadMap_description">
					<div id="roadMap_item_name"></div>
					<button id="roadMap_item_remove_button">지우기</button>
					
					<input type="text" name="roadMap_new_item">
					<button id="roadMap_item_add_button">로드맵에 추가하기</button>
				</span>			
			</div>	
			
			<p>기업의 기술 요구사항</p>
			<button id="Developer">개발자라면</button>
			<button id="Web">웹 지식</button>
			<button id="Server">서버</button>
			<button id="Language">언어</button>
			<button id="DataBase">데이터베이스</button>
			<button id="frameWork">프레임워크 & 라이브러리</button>
			
			<div id="bar_chart_container">
				<div id="chartdiv_job_rank">
				</div>
				
				<span id="bar_chart_description">
					<div id="bar_chart_item_name">					
					</div>
					
					<button id="bar_chart_item_add_button">로드맵에 추가하기</button>
					<button id="bar_chart_item_close">닫기</button>
				</span>
			</div>
			<p>위 차트는 programmers 와 saramIn 데이터를 참조합니다. </p>
			
		</article>
		
		<article id="persnoal">
			<div>
				프로필 정보
			</div>
			<div>
				학습 플래너
			</div>		
		</article>
		
		<article id="lecture-board">
			<div>
				추천강의
				<!-- 클래스명은 변경하면 안 됨 -->
				<div class="swiper-container">
					<div class="swiper-wrapper" id="recommand-wrapper">
					</div>				
					<!-- 네비게이션 버튼 -->
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
			</div>
			
			<div>
				보관 강의
				<!-- 클래스명은 변경하면 안 됨 -->
				<div class="swiper-container">
					<div class="swiper-wrapper" id="my-wrapper">
					</div>				
					<!-- 네비게이션 버튼 -->
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
			</div>
			
			<div>
				프론트앤드 인기강의
				<!-- 클래스명은 변경하면 안 됨 -->
				<div class="swiper-container">
					<div class="swiper-wrapper" id="frontend-wrapper">
					</div>				
					<!-- 네비게이션 버튼 -->
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
			</div>
			
			<div>
				백엔드 인기강의
				<!-- 클래스명은 변경하면 안 됨 -->
				<div class="swiper-container">
					<div class="swiper-wrapper" id="backend-wrapper">
					</div>				
					<!-- 네비게이션 버튼 -->
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
			</div>
			
			<div>
				풀스택 인기강의
				<!-- 클래스명은 변경하면 안 됨 -->
				<div class="swiper-container">
					<div class="swiper-wrapper" id="fullstack-wrapper">
					</div>				
					<!-- 네비게이션 버튼 -->
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
			</div>
		</article>
		
	</section>
	
	<!-- FOOTER FORM -->	
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>