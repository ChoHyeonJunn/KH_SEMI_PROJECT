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
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">

<style type="text/css">
/* CHART STYLE */
#bar_chart_container, #roadMap_container{
	position: relative;
}
#bar_chart_item_description{
	height: 300px;
	overflow: scroll;
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
	opacity: 0.9;
	width: 25%;
	height: 100%;
	
	position: absolute;
	z-index: 100;
	right: 0px;
	top: 0px;
}
#myChart{
   width: 100%;
   height: 100%;
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

/* lecture container */
.lecture, .lecture_back{
	float: left;
	width: 100%;
	height: 350px;
}
.lecture_back{
	position: absolute;
	color: white;
	background-color: black;
	opacity: 0;
	z-index: 1;
}
.lecture:hover .lecture_back{
	opacity: 0.9;
}

/* lecture contant */
.lecture_img_div{
	width: 100%; 
	height: 40%;
}	
.lecture_des_div{
	width: 100%; 
	height: 60%;
	position: relative;
}
.lecture_additional_des{
	position: absolute;
	bottom: 0px;
	width: 100%;
}

/* 내 강의에 추가하기 이미지 */
.add_my_lecture_img_container{
	position: absolute;
	bottom: 20px;
	right: 20px;
	width: 100%;
}
.add_my_lecture_img{
	width: 30px;
	height: 30px;
	-webkit-filter: opacity(.9) drop-shadow(0 0 0 white);
	filter: opacity(50%) drop-shadow(0px 0px 0px white) contrast(0%);
	cursor: pointer;
}
.add_my_lecture_img:hover{
	width: 32px;
	height: 32px;
	-webkit-filter: opacity(.9) drop-shadow(0 0 0 white);
	filter: opacity(50%) drop-shadow(0px 0px 0px yellow) contrast(0%);
	cursor: pointer;
}

/* 별점 */
.star-rating { 
	width:80px; 
}
.star-rating , .star-rating span { 
	display:inline-flex; 
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
.hr{
	background-color: white;
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- kakaoMap -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde3d6a6f398e8afdf7600f84f211532&libraries=services"></script>

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
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<!-- SWIPER PAGING -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<script type="text/javascript" src="../resources/js/main_lecture/fillMainLectureList.js"></script>
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
	// 카테고리 추가하기 버튼 클릭시
	$("#roadMap_category_add_button").click(function(){
		var item = $("input[name='roadMap_new_item']").val();
		if(item != ""){
			addRoadMapCategory('${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}', item);
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
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('Developer');
	})
	$("#Web").click(function(){
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('Web');
	})
	$("#Server").click(function(){
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('Server');
	})
	$("#Language").click(function(){
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('Language');
	})
	$("#DataBase").click(function(){
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('DataBase');
	})
	$("#frameWork").click(function(){
		$(".nav-justified").find(".active").removeClass("active");
		$(this).addClass("active")
		
		getBarChartData('frameWork');
	})
	
	// barChart 라벨 클릭 이벤트
	$("#bar_chart_description").css("display", "none");
	$(document).on("click", "tspan", function(e){
		var item_name = $(this).text();
		
		$("#bar_chart_description").toggle(function(){
			$(this).find("#bar_chart_item_name").text(item_name);
			wikiSearching(item_name);				
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
		wikiSearching(onclickBarItem);		
	});
}
function wikiSearching(word){
	var des = $("#bar_chart_item_description");
	des.empty();
	des.append($("<div>").attr({"id":"loading","class":"text-center","style":"width:100%;"})
				.append($("<img>").attr({"src":"../resources/images/Spinner-1s-200px-bg-black.gif","style":"display:block; margin: 0px auto; z-index:9000;"}))						
		)
	$.ajax({				
		type: "POST",
		data : {word : word},
		url: "/DEVCA/main/getDescriptionWikiSearchingAjax.do",
		dataType: "JSON",
		
		success: function(data) {	
			console.log(data)
			des.empty();
			des.append(JSON.stringify(data.description))
		},
		
		error : function() {
			alert("통신 실패");
		}
	})	
}

/* 내 강의에 추가하기  */
function addMyLecture(LECTURE_CODE){
	//상위로 이벤트가 전파되지 않도록 중단한다.
    event.stopPropagation();
	
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
        	selectMyList('${sessionMember_profile.MEMBER_CODE}');
        },

        error: function (request, status, error) {
           alert("통신 실패");
           alert("code : " + request.status + "\n" +
              "message : " + request.responseText + "\n" +
              "error : " + error);
        }
     });
}
/* myLecture 지우기 */
function DeleteMyGarbageLecture(LECTURE_CODE){
	//상위로 이벤트가 전파되지 않도록 중단한다.
    event.stopPropagation();

    $.ajax({
        type: "POST",
        url: "/DEVCA/lecture/deleteMyGarbageLecture.do",
        data: {
        	MEMBER_CODE: '${sessionMember_profile.MEMBER_CODE}',
        	LECTURE_CODE: LECTURE_CODE
        },
        datatType: "JSON",

        success: function (args) {
        	$("#lectureListContainer").empty();
        	alert("강의 지우기")
        	
        	isEnd = false;
        	startNo = 0;
        	selectMyList('${sessionMember_profile.MEMBER_CODE}');
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

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->

</head>
<body>	
	<section>		
		<article id="roadmap">
			
			<div class="card p-4 my-3 mx-1 bg-dark">
				
				<!-- 비 구독자 결제 페이지 이동 버튼 -->
				<c:if test="${sessionMember_profile.MEMBER_ROLE eq '1'}">
					<button type="button" onclick="location.href='/DEVCA/member/privacypaymentpage.do'">DEVCA 6개월 구독하러가기</button>
				</c:if>
				
				
				<!-- 구독자의 경우 로드맵 서비스 제공 -->
				<c:if test="${sessionMember_profile.MEMBER_ROLE eq '2'}">
					<h5 class="card-title text-light p-3" data-toggle="collapse" data-target="#roadMap_container">
						<c:out value="${sessionLoginMember.MEMBER_NAME}"></c:out>
						<c:out value="${sessionLoginKakao.KAKAO_NICKNAME}"></c:out>
						<c:out value="${sessionLoginNaver.NAVER_NICKNAME}"></c:out>
						
						님의 <strong id="roadMap_field"></strong> 로드맵
					</h5>
					
					<div id="roadMap_container" class="collapse show flex">
						<div id="chartdiv_roadmap">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>
						
						<div id="roadMap_description" class="card p-4">
							<h3 id="roadMap_item_name" class="mx-auto font-weight-bold my-3">
							</h3>
							<button id="roadMap_item_remove_button" class="btn mb-5">지우기</button>
							
							<input type="text" name="roadMap_new_item" class="form-control">
							<div class="flex">
								<button id="roadMap_item_add_button" class="btn">로드맵에 추가하기</button>
								<button id="roadMap_category_add_button" class="btn">카테고리 추가하기</button>
							</div>
							
						</div>			
					</div>	
				</c:if>
				
			</div>
			
			
			<div class="card p-4 my-3 mx-1 bg-dark">
			
				<h5 class="card-title text-light p-3" data-toggle="collapse" data-target="#bar_chart_all_container">기업의 기술 요구사항</h5>
				<div id="bar_chart_all_container" class="collapse show">
					<ul class="nav nav-tabs nav-justified text-light">
	  					<li class="nav-item">
	    					<a class="nav-link active" id="Developer">개발자라면</a>
	  					</li>
	  					<li class="nav-item">
	    					<a class="nav-link" id="Web">웹 지식</a>
	  					</li>
	  					<li class="nav-item">
	    					<a class="nav-link" id="Server">서버</a>
	  					</li>
	  					<li class="nav-item">
	    					<a class="nav-link" id="Language">언어</a>
	  					</li>
	  					<li class="nav-item">
	    					<a class="nav-link" id="DataBase">데이터베이스</a>
	  					</li>
	  					<li class="nav-item">
	    					<a class="nav-link" id="frameWork">프레임워크 & 라이브러리</a>
	  					</li>
					</ul>
					
					<div id="bar_chart_container" class="bg-light flex">
						<div id="chartdiv_job_rank">
						</div>
						
						<div id="bar_chart_description" class="card p-4">
							<h3 id="bar_chart_item_name" class="mx-auto font-weight-bold my-3">					
							</h3>
							<div id="bar_chart_item_description" class="font-weight-bold p-1">
								
							</div>
							<div class="flex my-auto">
								<c:if test="${sessionMember_profile.MEMBER_ROLE eq '2'}">
									<button id="bar_chart_item_add_button" class="btn btn-lg">로드맵에 추가하기</button>
								</c:if>
								<button id="bar_chart_item_close" class="btn btn-lg">닫기</button>
							</div>
							
						</div>
					</div>
					<p class="text-light">위 차트는 programmers 와 saramIn 데이터를 참조합니다. </p>
				</div>
			</div>
		</article>
		
		<article id="persnoal" class="container-fluid">
			<div class="row">
				<div class="col-sm-6 p-0">
					
					<div id="profile" class="card p-4 mx-1 bg-dark">
		                <h5 class="card-title text-light p-3">프로필 정보</h5>
		                  
		                <div id="MyChart">
		                   <%
		                      int[] data = (int[])request.getAttribute("data");
		                   %>
		               
		                      <canvas id="myChart" width="330" height="330"></canvas>
		               
		                      <div>
		                         <table>
		                            <tbody>
		                               <tr>
		                                  <td style="color: white;">희망 직무  : 
		                                  <c:forEach items="${work }" var="work">
		                                        ${work } 
		                                  </c:forEach>
		                                  <hr class="hr"></td>
		                               </tr>
		                               <tr>
		                                  <td style="color: white;">주요 기술  : 
		                                  <c:forEach items="${skill }" var="skill">
		                                        ${skill } 
		                                  </c:forEach>
		                                  <hr class="hr"></td>
		                               </tr>
		                               <tr>
		                                  <td style="color: white;">등록 항목  : 
		                                  	경력 : <c:out value="${career_count }"></c:out>, 
		                                  	프로젝트 : <c:out value="${project_count }"></c:out>, 
		                                  	학력 : <c:out value="${school_credit }"></c:out>, 
		                                  	외국어 : <c:out value="${language_count }"></c:out>, 
		                                  	활동 : <c:out value="${action_count }"></c:out>, 
		                                  	수상/자격증 : <c:out value="${certificate_count }"></c:out>
		                                  </td>
		                               </tr>
		                            </tbody>
		                         </table>
		                      </div>
		                   </div>
	               </div>
					
					
				</div>
				
				<div class="col-sm-6 p-0">
					<div id="study" class="card p-4 mx-1 bg-dark">
						<h5 class="card-title text-light p-3" data-toggle="collapse" data-target="#map_wrap">스터디</h5>
						
						<div id="map_wrap" class="map_wrap" class="collapse show">
						    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
						
						    <div id="menu_wrap" class="bg_white">
						        <div class="option">
						            <div>
						                <form onsubmit="searchPlaces(); return false;">
						                    키워드 : <input type="text" id="keyword" size="15"> 
						                    <button type="submit">검색하기</button> 
						                </form>
						            </div>
						        </div>
						        <hr>
						        <ul id="placesList"></ul>
						        <div id="pagination"></div>
						    </div>
						</div>
						
						<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
						<input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test="${empty sessionMember_profile.MEMBER_PROFILE_LATITUDE}">33.450701</c:if>${sessionMember_profile.MEMBER_PROFILE_LATITUDE}">
						<input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test="${empty sessionMember_profile.MEMBER_PROFILE_LOGITUDE}">126.570667</c:if>${sessionMember_profile.MEMBER_PROFILE_LOGITUDE}">
						
					</div>	
				</div>
			</div>
		</article>
		
		<article id="lecture-board">
		
			<div class="card p-4 my-3 mx-1 bg-dark">
				<div>
					<h6 class="card-title text-light p-3" data-toggle="collapse" data-target="#recommand-container">추천</h6>
					
					<!-- 클래스명은 변경하면 안 됨 -->
					<div id="recommand-container" class="swiper-container collapse show">
						<div class="swiper-wrapper" id="recommand-wrapper">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>				
						<!-- 네비게이션 버튼 -->
						<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
						<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
					</div>
				</div>
				
				<div>
					<h6 class="card-title text-light p-3" data-toggle="collapse" data-target="#my-lecture-container">MY</h6>
					<!-- 클래스명은 변경하면 안 됨 -->
					<div id="my-lecture-container" class="swiper-container collapse show">
						<div class="swiper-wrapper" id="my-wrapper">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>				
						<!-- 네비게이션 버튼 -->
						<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
						<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
					</div>
				</div>
				
				<div>
					<h6 class="card-title text-light p-3" data-toggle="collapse" data-target="#front-end-container">Front-End</h6>
					<!-- 클래스명은 변경하면 안 됨 -->
					<div id="front-end-container" class="swiper-container collapse show">
						<div class="swiper-wrapper" id="frontend-wrapper">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>				
						<!-- 네비게이션 버튼 -->
						<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
						<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
					</div>
				</div>
				
				<div>
					<h6 class="card-title text-light p-3" data-toggle="collapse" data-target="#back-end-container">Back-End</h6>
					<!-- 클래스명은 변경하면 안 됨 -->
					<div id="back-end-container" class="swiper-container collapse show">
						<div class="swiper-wrapper" id="backend-wrapper">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>				
						<!-- 네비게이션 버튼 -->
						<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
						<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
					</div>
				</div>
				
				<div>
					<h6 class="card-title text-light p-3" data-toggle="collapse" data-target="#full-stack-container">Full-Stack</h6>
					<!-- 클래스명은 변경하면 안 됨 -->
					<div id="full-stack-container" class="swiper-container collapse show">
						<div class="swiper-wrapper" id="fullstack-wrapper">
							<div id="loading" class="text-center" style="width:100%">
								<img src='../resources/images/Spinner-1s-200px-main.gif' class="bg-dark" style="display:block; margin: 0px auto; z-index:9000;"/>
							</div>
						</div>				
						<!-- 네비게이션 버튼 -->
						<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
						<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
					</div>
				</div>
			</div>
		</article>
		
	</section>
	
	<!-- FOOTER FORM -->	
	<%@ include file="/views/form/footer.jsp"%>
</body>

<!-- START :: KAKAO MAP -->
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
	center: new kakao.maps.LatLng($("input[name='MEMBER_PROFILE_LATITUDE']").val(), $("input[name='MEMBER_PROFILE_LOGITUDE']").val()), //지도의 중심좌표.
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

///////////////////내 위치 마커////////////////////////
var MyimageSrc = <c:choose>
					<c:when test="${not empty sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME}">'../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }'</c:when>
			   		<c:otherwise>'../resources/images/add.png'</c:otherwise>
				</c:choose>	, // 마커이미지의 주소입니다    
				MyimageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
				MyimageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var MymarkerImage = new kakao.maps.MarkerImage(MyimageSrc, MyimageSize, MyimageOption),
MymarkerPosition = new kakao.maps.LatLng($("input[name='MEMBER_PROFILE_LATITUDE']").val(), $("input[name='MEMBER_PROFILE_LOGITUDE']").val()); // 마커가 표시될 위치입니다

//마커를 생성합니다
var Mymarker = new kakao.maps.Marker({
position: MymarkerPosition,
image: MymarkerImage // 마커이미지 설정 
});

//마커가 지도 위에 표시되도록 설정합니다
Mymarker.setMap(map);  


///////////////////스터디 위치 list 마커////////////////////////
function displayStudyList(){
	var jsonArray = new Array();
	<c:forEach items="${studyList}" var="study">
		console.log('${study.STUDY_TITLE}' + '${study.STUDY_LATITUDE}' + '${study.STUDY_LOGITUDE}')

		var json = new Object();
		
		json.title = '${study.STUDY_TITLE}'
		json.latlng = new kakao.maps.LatLng('${study.STUDY_LATITUDE}', '${study.STUDY_LOGITUDE}')
		json.study_code = '${study.STUDY_CODE}'
		json.STUDY_PARTICIPANTS = '${study.STUDY_PARTICIPANTS}'
		
		jsonArray.push(json);
	</c:forEach>
	var positions = jsonArray;

	//마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    // 이미지 마커 표시
		var imageSize = new kakao.maps.Size(24, 35);  // 마커 이미지의 이미지 크기 입니다  
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  // 마커 이미지를 생성합니다  
	    var marker = new kakao.maps.Marker({  // 마커를 생성합니다
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	    
	 	// 마커가 지도 위에 표시되도록 설정합니다
	    marker.setMap(map);
		
	    // 인포윈도우에 제목 표시
	    var content = '<div class="customoverlay">'
	    					+ '<a href="/DEVCA/study/studydetailpage.do?STUDY_CODE=' + positions[i].study_code + '">'
	    					+ positions[i].title + ':' + positions[i].STUDY_PARTICIPANTS + '명 참여중'
	    					+ '</a>' +
	    			  '</div>';

		// 인포윈도우를 생성합니다
		var customOverlay = new kakao.maps.CustomOverlay({
			map: map,
		    position : positions[i].latlng, 
		    content : content,
		    yAnchor: -1
		});
		customOverlay.setMap(map);
	}

}

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
//searchPlaces();
displayStudyList();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();    
    
	///////////////////검색결과 마커 표시////////////////////////
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
            	infowindow.close();
                displayInfowindow(marker, title);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function() {                
            });

            itemEl.onmouseover =  function () {
                infowindow.close();
                displayInfowindow(marker, title);
            };
            itemEl.onmouseout =  function () {
            };
            
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
    
    // 스터디리스트를 표시합니다.
    displayStudyList();
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>
<!-- END :: KAKAO MAP -->

<!-- START :: MYCHART.JS -->
<script type="text/javascript">
      var ctx = document.getElementById("myChart");
      var myRadarChart = new Chart(ctx, {
       type: 'radar',
       data: {
          labels: ['경력', '프로젝트', '학력', '외국어', '활동', '수상/자격증'],
               datasets: [{
                   label: '내프로필',
                   backgroundColor: "rgba(194,223,255,0.8)",
                   borderColor: "rgba(0,191,255,1)",
                   fill: true,
                   radius: 5,
                   pointRadius: 3,
                   pointBorderWidth: 3,
                   pointBackgroundColor: "#0078ff",
                   pointBorderColor: "rgba(204,205,207,1)",
                   pointHoverRadius: 6,
                   pointHitDetectionRadius : 20,
                   data: [<%=data[0]%>, <%=data[1]%>, <%=data[2]%>, <%=data[3]%>, <%=data[4]%>, <%=data[5]%>,]
               }]
       },
       options: options ={
             legend: {
                   labels: {
                       fontColor: "white",
                       fontSize: 15
                   }
               },
         responsive: false,
         tooltips: {
            enabled: false
         },
         hover: {
            animationDuration: 0
         },
         animation: {
            duration: 3,
            onComplete: function () {
               var chartInstance = this.chart,
                  ctx = chartInstance.ctx;
               ctx.fillStyle = 'white';
               ctx.font = "20px Verdana";
               this.data.datasets.forEach(function (dataset, i) {
                  var meta = chartInstance.controller.getDatasetMeta(i);
                  meta.data.forEach(function (bar, index) {
                     var data = dataset.data[index];                     
                     ctx.fillText(data, bar._model.x, bar._model.y - 5);
                  });
               });
            }
         },
         scale: {
            gridLines: {
               color:"#dddddd",
               lineWidth: 3
            },
            angleLines: {
               display: true,
               color : "rgba(221,221,221,1)",
               lineWidth: 3
            },
            ticks: {
               beginAtZero: true,
               display: false,
               backdropColor: "rgba(52,58,64,1)",
               suggestedMin: 0,
               suggestedMax: 3,
               stepSize: 1
            },
            pointLabels:{
               fontSize: 10,
               fontColor: "white"
            },
         }
      }
      });
</script>
<!-- END :: MYCHART.JS -->
</html>