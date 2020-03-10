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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="/DEVCA/resources/css/master.css" rel="stylesheet" type="text/css">
<link href="/DEVCA/resources/css/kakaomap.css" rel="stylesheet" type="text/css">

<style type="text/css">
section{
	width: 100%;
	height: auto;
}
#profile_image{
	widht: 70px;
	height: 70px;
	border: 1px solid gray;
	border-radius: 30%;	
}
#apply_profile_image{
	widht: 50px;
	height: 50px;
	border: 1px solid gray;
	border-radius: 30%;	
}
.ui-menu-item .ui-menu-item-wrapper.ui-state-active {
    background: #862d86 !important;
    font-weight: bold !important;
    color: #ffffff !important;
    border: none;
} 
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde3d6a6f398e8afdf7600f84f211532"></script>

<script type="text/javascript">

$(function(){
	
	selectApplyStudyList();
	
	// 스터디 참여 신청하기
	$(document).on("submit", "#applyStudy", function(e){	
		e.preventDefault();
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/study/applyStudy.do",
	        data: {
	        	STUDY_CODE : $("#applyStudy input[name='STUDY_CODE']").val(),
	        	MEMBER_CODE	: $("#applyStudy input[name='MEMBER_CODE']").val()
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	alert("스터디원 신청 완료");
	        	selectApplyStudyList()
	        },

	        error: function (request, status, error) {
	           alert("통신 실패");
	        }
	     });
	})
	
	// 스터디 참여 허가
	$(document).on("click", ".approveApply", function(){
		
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/study/approveApplyStudy.do",
	        data: {
	        	STUDY_CODE : '${study.STUDY_CODE}',
	        	MEMBER_CODE	: $(this).val()
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	alert("스터디원 승인 완료");
	        	selectApplyStudyList()
	        },

	        error: function (request, status, error) {
	           alert("통신 실패");
	        }
	     });
	})
	
	// 스터디 강퇴
	$(document).on("click", ".excludeApply", function(){
		
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/study/excludeApplyStudy.do",
	        data: {
	        	STUDY_CODE : '${study.STUDY_CODE}',
	        	MEMBER_CODE	: $(this).val()
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	alert("스터디원 강퇴");
	        	selectApplyStudyList()
	        },

	        error: function (request, status, error) {
	           alert("통신 실패");
	        }
	     });
	})
	
	// 스터디 신청 취소 
	$(document).on("click", ".cancelApply", function(){
		
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/study/cancelApplyStudy.do",
	        data: {
	        	STUDY_CODE : '${study.STUDY_CODE}',
	        	MEMBER_CODE	: $(this).val()
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	alert("스터디 신청 취소");
	        	selectApplyStudyList()
	        },

	        error: function (request, status, error) {
	           alert("통신 실패");
	        }
	     });
	})
	
	// 다른 사람 초대시
	$("#searchMember_email").click(function(){
		var search_MEMEBER_EMAIL_NAME = $("input[name='search_MEMEBER_EMAIL_NAME']").val();
		
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/study/inviteStudy.do",
	        data: {
	        	STUDY_CODE : '${study.STUDY_CODE}',
	        	MEMBER_EMAIL : search_MEMEBER_EMAIL_NAME
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	var result = JSON.parse(args);
	        	if(result.res == 1){
	        		alert("스터디 초대");
	        	}else{
	        		alert("DEVCA의 회원이 아닙니다.")
	        	}
	        	selectApplyStudyList()
	        },

	        error: function () {
	           alert("통신 실패");
	        }
	     });		
	})
	
})
</script>

<!-- START :: 참여, 신청, 초대 인원 select -->
<script type="text/javascript">
function selectApplyStudyList(){
	
	var participateStudyList = $("#participateStudyList");	// 참여중인 인원 리스트
	var inviteStudyList = $("#inviteStudyList");			// 초대한 인원 리스트
	var applyStudyList = $("#applyStudyList");				// 신청한 인원 리스트
	
	participateStudyList.empty();
	inviteStudyList.empty();
	applyStudyList.empty();
	
	$.getJSON("/DEVCA/study/selectApplyStudy.do?", {STUDY_CODE:'${study.STUDY_CODE}'}, function(data){
		
		var am_i_apply = 0; // 자신이 참여한 사람인지 구분하기 위한 flag
		
		// 방장이 보게될 참여자 리스트 채우기
		$.each(data, function(index, apply){
			if(apply.MEMBER_CODE == '${sessionLoginMember.MEMBER_CODE}' || apply.MEMBER_CODE == '${sessionLoginKakao.MEMBER_CODE}' || apply.MEMBER_CODE == '${sessionLoginNaver.MEMBER_CODE}'){
				if(apply.APPLY_STUDY_VERIFY == 'Y'){
					am_i_apply = 3;	// 참여중인 사람이라면
				}
				if(apply.APPLY_STUDY_VERIFY == 'I'){
					am_i_apply = 2;	// 초대받은 사람이라면
				}
				if(apply.APPLY_STUDY_VERIFY == 'N'){
					am_i_apply = 1;	// 이 스터디에 신청한 사람이라면
				}
			}
			
			var applyItem = $("<div>").attr({
				"class" : "apply_item"
			})
			
			var image = $("<img>").attr({
				"id" : "apply_profile_image",
				"src" : <c:choose>
							<c:when test="${not empty apply.MEMBER_PROFILE_IMAGE_S_NAME}">'../resources/images/profileupload/${apply.MEMBER_PROFILE_IMAGE_S_NAME}'</c:when>
							<c:otherwise>'../resources/images/add.png'</c:otherwise>
						</c:choose>
			})
			
			var member = $("<span>").text(apply.MEMBER_NAME).attr({"class":"px-3"});
			
			var email = $("<span>").text(apply.MEMBER_EMAIL).attr({"class":"px-3"});

			var date = $("<span>").text(apply.APPLY_STUDY_DATE).attr({"class":"px-3"});
			
			// 참여중인 인원 리스트 (방장 말고 회원/비회원 모두 볼 수 있음)
			if(apply.APPLY_STUDY_VERIFY == 'Y'){
				var verify = $("<span>").text("스터디원").attr({"class":"px-3"});
				
				if('${study.MEMBER_CODE}' == '${sessionMember_profile.MEMBER_CODE}'){ // 방장만 강퇴 버튼을 사용 가능!
					var exclude = $("<button>").attr({
						"class" : "excludeApply btn",
						"value" : apply.MEMBER_CODE
					}).text("강퇴")
				}				

				applyItem.append(image).append(member).append(email).append(verify).append(date).append(exclude);
				participateStudyList.append(applyItem);
			}
			
			// 초대한 인원 리스트
			if(apply.APPLY_STUDY_VERIFY == 'I'){
				var verify = $("<span>").text("초대 승인 대기중...").attr({"class":"px-3"});		
				
				applyItem.append(image).append(member).append(email).append(verify).append(date);
				inviteStudyList.append(applyItem);
			}
			
			// 신청한 인원 리스트
			if(apply.APPLY_STUDY_VERIFY == 'N'){
				var verify = $("<span>").text("참여 대기중...").attr({"class":"px-3"});	
				
				var approve = $("<button>").attr({
						"class" : "approveApply btn",
						"value" : apply.MEMBER_CODE
					}).text("승인")
					
				applyItem.append(image).append(member).append(email).append(verify).append(date).append(approve);
				applyStudyList.append(applyItem);
			}
		})
		
		// 참여 여부에 따라 방장이 아닌 회원이 보게 될 내용
		if(am_i_apply == 0){ // 신청, 초대, 참여 아무것도 해당되지 않는 사람
			$("#applyStudyContainer").empty();
			$("#applyStudyContainer").append("<h2>스터디 신청하기</h2>");
			
			var form = $("<form>").attr({
				"id" : "applyStudy",
				"method" : "POST"
			})
			.append($("<input>").attr({
				"type" : "hidden",
				"name" : "STUDY_CODE",
				"value" : "${study.STUDY_CODE}"
			}))
			.append($("<input>").attr({
				"type" : "hidden",
				"name" : "MEMBER_CODE",
				"value" : "${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}"
			}))
			.append($("<input>").attr({
				"type" : "submit",
				"value" : "신청하기",
				"class" :  "btn"
			}))
			
			$("#applyStudyContainer").append(form);
		} 
		else if(am_i_apply == 1){ // 이 스터디에 신청한 사람이라면
			$("#applyStudyContainer").empty();
		
			$("#applyStudyContainer").append("<h2>신청 대기중...</h2>");			
			$("#applyStudyContainer").append($("<button>").attr({
				"class" : "cancelApply btn",
				"value" : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}'
			}).text("신청 취소"));			
		} 
		else if(am_i_apply == 2){ // 초대받은 사람이라면
			$("#applyStudyContainer").empty();
			
			$("#applyStudyContainer").append("<h2>이 스터디에 초대받으셧습니다.</h2>");	
			$("#applyStudyContainer").append($("<button>").attr({
				"class" : "approveApply btn",
				"value" : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}'
			}).text("참여하기"));
			$("#applyStudyContainer").append($("<button>").attr({
				"class" : "cancelApply btn",
				"value" : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}'
			}).text("초대 거부"));
		}
		else if(am_i_apply == 3){ // 참여중인 사람이라면
			$("#applyStudyContainer").empty();
			
			$("#applyStudyContainer").append("<h2>이 스터디에 참여중입니다.</h2>");
			$("#applyStudyContainer").append($("<button>").attr({
				"class" : "excludeApply btn",
				"value" : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}'
			}).text("탈퇴하기"));
		}
		
	})
}
</script>
<!-- END :: 참여, 신청, 초대 인원 select -->

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
	
		<div class="card p-4 my-3 bg-white">		
		
			<!-- 지도 표시 -->
		  	<div id="map" style="width:100%;height:250px;"></div>
			
			<form action="/DEVCA/study/studyupdatepage.do" method="POST">
				<input type="hidden" value="${study.STUDY_CODE }" name='STUDY_CODE'>
				
				<div class="card p-4 my-3 bg-white">
					<div class="row">	
							
						<div class="col-md-2">
							<div class="row">
								<div class="col-md-3">
									<img id="profile_image" src="
													<c:choose>
														<c:when test="${not empty study.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${study.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
														<c:otherwise>../resources/images/add.png</c:otherwise>
													</c:choose>	
													">
								</div>
								<div class="col-md-9">
									<h5><strong>${study.MEMBER_NAME}</strong></h5>
									<h5><strong>${study.MEMBER_EMAIL}</strong></h5>
								</div>
							</div>
						</div>
						
						<div class="col-md-10">					
							<h1>제목 : ${study.STUDY_TITLE }</h1>
						</div>
					</div>
					
					<div class="card p-4 my-3 bg-white">
						<span>
							내용
						</span>
						<span>
							${study.STUDY_CONTENT }
						</span>
					</div>
				</div>
					
				<input class="btn" type="button" value="목록" onclick="location.href='/DEVCA/study/studylistpage.do'">
		
				<c:if test="${sessionLoginMember.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq study.MEMBER_CODE}">
					<input class="btn" type="submit" value="수정"> 
					<input class="btn" type="button" value="삭제" onclick="location.href='/DEVCA/study/studydelete.do?STUDY_CODE=${study.STUDY_CODE}'">
					
					
					<div class="input-group mb-3 my-4">
						<button type="button" id="searchMember_email" class="btn">초대하기</button>
						<input type="text" name="search_MEMEBER_EMAIL_NAME" class="form-control" placeholder="example@example.com">
						<div class="input-group-append">				
		       				<span id="email_check_remove" class="input-group-text"><i class="fas fa-envelope"></i>&nbsp;<i class="fas fa-user"></i></span>
						</div>
					</div>
				</c:if>
								
			</form>
		</div>
		
		<!-- 방장이보게될 / 회원이 보게될 / 회원비회원모두보게될 -->
		<c:choose>
			<c:when test="${sessionMember_profile.MEMBER_CODE eq study.MEMBER_CODE}">
				<div class="card p-4 my-3 bg-white">
					<h4>스터디원 관리</h4>
					
					<hr>
					
					<h5>참여중인 스티디원 (${study.STUDY_PARTICIPANTS}명 참여중)</h5>
					<div id="participateStudyList"></div>
					
					<hr>			
					
					<h5>초대한 사람들</h5>
					<div id="inviteStudyList"></div>
					
					<hr>			
	
					<h5>신청한 사람들</h5>
					<div id="applyStudyList"></div>
				</div>
			</c:when>
			
			<c:when test="${not empty sessionMember_profile && sessionMember_profile.MEMBER_CODE ne study.MEMBER_CODE}">
				<div id="applyStudyContainer" class="card p-4 my-3 bg-white"></div>
					
				<div class="card p-4 my-3 bg-white">
					<h4>참여중인 스티디원 (${study.STUDY_PARTICIPANTS}명 참여중)</h4>
					<div id="participateStudyList">
							
					</div>
				</div>	
			</c:when>
			
			<c:otherwise>
				<div class="card p-4 my-3 bg-white">
					<h4>참여중인 스티디원 (${study.STUDY_PARTICIPANTS}명 참여중)</h4>
					<div id="participateStudyList">
							
					</div>
				</div>
			</c:otherwise>
		</c:choose>	
		
	</section>
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
	
	<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
	<input type="hidden" name="STUDY_LATITUDE" value="<c:if test="${empty study.STUDY_LATITUDE}">33.450701</c:if>${study.STUDY_LATITUDE}">
	<input type="hidden" name="STUDY_LOGITUDE" value="<c:if test="${empty study.STUDY_LOGITUDE}">126.570667</c:if>${study.STUDY_LOGITUDE}">
	
</body>


<!-- START :: 회원 검색 자동 완성 -->
<script type="text/javascript">
$(function(){
	$("input[name='search_MEMEBER_EMAIL_NAME']").autocomplete({
		source: function(request, response){
		    $.ajax({
		        type: "POST",
		        url: "/DEVCA/member/searchMemberEmailName.do",
		        data: {
		        	MY_MEMBER_CODE : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}',
		        	EMAIL_NAME : request.term
		        },
		        datatType: "JSON",

		        success: function (data) {
			        	response(
		        		$.map(JSON.parse(data), function(item){
		        			return{
		        				label: item.MEMBER_EMAIL,
		        				value: item.MEMBER_EMAIL,
		        				name: item.MEMBER_NAME,
		        				image: item.MEMBER_PROFILE_IMAGE_S_NAME
		        				
		        			}
		        		})	
		        	)
		        },
		        error: function () {
		           alert("통신 실패");
		        }
		     })
		},
		minLength : 1,
		focus : function(event, ui){
			$("input[name='search_MEMEBER_EMAIL_NAME']").val(ui.item.value)
			return false;
		}
	}).autocomplete("instance")._renderItem = function(ul, item){
		var li_item = $("<div>").attr({"class":"my-auto"});
		li_item.append($("<img>").attr({
							"class" : "m-1",
							"style" : "width: 30px; height: 30px;",
							"src" : <c:choose>
										<c:when test="${not empty item.image}">'../resources/images/profileupload/${item.image}'</c:when>
										<c:otherwise>'../resources/images/add.png'</c:otherwise>
									</c:choose>
						}))
						.append($("<span>").attr({"class":"mx-1"}).text(item.name))
						.append($("<span>").attr({"class":"mx-1"}).text(item.label))
						
		return $("<li>").append(li_item).appendTo(ul);
	}

})
</script>
<!-- END :: 회원 검색 자동 완성 -->

<!-- START :: KAKAO MAP -->
<script type="text/javascript">

var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng($("input[name='STUDY_LATITUDE']").val(), $("input[name='STUDY_LOGITUDE']").val()), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴



///////////////////스터디 위치 마커로 표시하기////////////////////////

var jsonArray = new Array();

	var json = new Object();
	
	json.title = '${study.STUDY_TITLE}'
	json.latlng = new kakao.maps.LatLng('${study.STUDY_LATITUDE}', '${study.STUDY_LOGITUDE}')
	json.study_code = '${study.STUDY_CODE}'
	json.STUDY_PARTICIPANTS = '${study.STUDY_PARTICIPANTS}'

	jsonArray.push(json);
	
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
</script>
<!-- END :: KAKAO MAP -->
</html>