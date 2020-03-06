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

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
	
		<form action="/DEVCA/study/studyupdatepage.do" method="POST">
			<input type="hidden" value="${study.STUDY_CODE }" name='STUDY_CODE'>
			
			<div>
				<div>
					<h1>제목 : ${study.STUDY_TITLE }</h1>
				</div>
				<div>
					<span>
						<img id="profile_image" src="
										<c:choose>
											<c:when test="${not empty study.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${study.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
											<c:otherwise>../resources/images/add.png</c:otherwise>
										</c:choose>	
										">
					</span>
					<span>
						${study.MEMBER_NAME }
					</span>
					<span>
						${study.MEMBER_EMAIL }
					</span>
				</div>
			


				<div>
					<span>
						내용
					</span>
					<span>
						${study.STUDY_CONTENT }
					</span>
				</div>
				
				<!-- 지도 표시 -->
		  		<div id="map" style="width:100%;height:400px;"></div>
	
				<c:if test="${sessionLoginMember.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq study.MEMBER_CODE}">
					<input type="submit" value="수정"> 
					<input type="button" value="삭제" onclick="location.href='/DEVCA/study/studydelete.do?STUDY_CODE=${study.STUDY_CODE}'">
				</c:if>
				<input type="button" value="목록" onclick="location.href='/DEVCA/study/studylistpage.do'">
					
			</div>			
		</form>
		
		<!-- 스터디 신청하기 폼 , 로그인된 회원만 볼 수 있음 ajax 통신 -->
		<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
		<c:if test="${sessionLoginMember.MEMBER_CODE ne study.MEMBER_CODE && sessionLoginKakao.MEMBER_CODE ne study.MEMBER_CODE && sessionLoginNaver.MEMBER_CODE ne study.MEMBER_CODE}">
			<div id="applyStudyContainer">

			</div>
		</c:if>
		
		</c:if>
		
		<!-- 회원 가입 여부 상관없이 모두 볼 수 있음 -->
		<div>
			<h2>참여중인 스티디원</h2>
			<div>
				${study.STUDY_PARTICIPANTS}명 참여중
			</div>
			<div id="participateStudyList">
					
			</div>
		</div>	
		
		<!-- 방장만 볼 수 있는 신청인원, 초대인원 -->
		<c:if test="${sessionLoginMember.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq study.MEMBER_CODE}">
		
		
			<div>
				<h2>초대하기</h2>
				<input type="text" name="search_MEMEBER_EMAIL_NAME">
				<button id="searchMember_email">초대</button>
			</div>
			<div>
				<h2>초대한 사람들</h2>
				<div id="inviteStudyList">
						
				</div>
			</div>
			
			<div>
				<h2>신청한 사람들</h2>
				<div id="applyStudyList">
						
				</div>
			</div>
			
		</c:if>
			
<script type="text/javascript">
	
function selectApplyStudyList(){
	
	var participateStudyList = $("#participateStudyList");	// 참여중인 인원 리스트
	var inviteStudyList = $("#inviteStudyList");			// 초대한 인원 리스트
	var applyStudyList = $("#applyStudyList");				// 신청한 인원 리스트
	
	participateStudyList.empty();
	inviteStudyList.empty();
	applyStudyList.empty();
	
	$.getJSON("/DEVCA/study/selectApplyStudy.do?", {STUDY_CODE:'${study.STUDY_CODE}'}, function(data){
		
		var am_i_apply = 0;
		
		// 방장이 보게될 참여자 리스트 채우기
		$.each(data, function(index, apply){
			if(apply.MEMBER_CODE == '${sessionLoginMember.MEMBER_CODE}' || apply.MEMBER_CODE == '${sessionLoginKakao.MEMBER_CODE}' || apply.MEMBER_CODE == '${sessionLoginNaver.MEMBER_CODE}')
				am_i_apply++;
			
			var applyItem = $("<div>").attr({
				"class" : "apply_item"
			})
			
			var image = $("<img>").attr({
				"id" : "apply_profile_image",
				"src" : <c:choose>
							<c:when test="${not empty study.MEMBER_PROFILE_IMAGE_S_NAME}">'../resources/images/profileupload/${study.MEMBER_PROFILE_IMAGE_S_NAME}'</c:when>
							<c:otherwise>'../resources/images/add.png'</c:otherwise>
						</c:choose>
			})
			
			var member = $("<span>").text(apply.MEMBER_NAME);
			
			var email = $("<span>").text(apply.MEMBER_EMAIL);

			var date = $("<span>").text(apply.APPLY_STUDY_DATE);
			
			// 참여중인 인원 리스트
			if(apply.APPLY_STUDY_VERIFY == 'Y'){
				var verify = $("<span>").text("스터디원");
				
				var exclude = $("<button>").attr({
						"class" : "excludeApply",
						"value" : apply.MEMBER_CODE
					}).text("강퇴")

				applyItem.append(image).append(member).append(email).append(verify).append(date).append(exclude);
				participateStudyList.append(applyItem);
			}
			
			// 초대한 인원 리스트
			if(apply.APPLY_STUDY_VERIFY == 'I'){
				var verify = $("<span>").text("초대 승인 대기중...");		
				
				applyItem.append(image).append(member).append(email).append(verify).append(date);
				inviteStudyList.append(applyItem);
			}
			
			// 신청한 인원 리스트
			if(apply.APPLY_STUDY_VERIFY == 'N'){
				var verify = $("<span>").text("참여 대기중...");	
				
				var approve = $("<button>").attr({
						"class" : "approveApply",
						"value" : apply.MEMBER_CODE
					}).text("승인")
					
				applyItem.append(image).append(member).append(email).append(verify).append(date).append(approve);
				applyStudyList.append(applyItem);
			}
		})
		
		if(am_i_apply > 0){
			$("#applyStudyContainer").empty();
			$("#applyStudyContainer").append("<h2>신청 대기중...</h2>");
			$("#applyStudyContainer").append($("<button>").attr({
				"class" : "cancelApply",
				"value" : '${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}'
			}).text("취소"));
			
		}else{
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
				"value" : "신청하기"
			}))
			
			$("#applyStudyContainer").append(form);
		}
		
	})
}
</script>
		
	</section>
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
	
	<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
	<input type="hidden" name="STUDY_LATITUDE" value="<c:if test="${empty study.STUDY_LATITUDE}">33.450701</c:if>${study.STUDY_LATITUDE}">
	<input type="hidden" name="STUDY_LOGITUDE" value="<c:if test="${empty study.STUDY_LOGITUDE}">126.570667</c:if>${study.STUDY_LOGITUDE}">
	
</body>

<script type="text/javascript">

// 회원 검색 자동 완성
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
		var li_item = $("<div>");
		li_item.append($("<img>").attr({
							"style" : "width: 50px; height: 50px;",
							"src" : <c:choose>
										<c:when test="${not empty item.image}">'../resources/images/profileupload/${item.image}'</c:when>
										<c:otherwise>'../resources/images/add.png'</c:otherwise>
									</c:choose>
						}))
						.append($("<span>").text(item.name))
						.append($("<span>").text(item.label))
						
		return $("<li>").append(li_item).appendTo(ul);
	}

})


var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng($("input[name='STUDY_LATITUDE']").val(), $("input[name='STUDY_LOGITUDE']").val()), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//스터디 위치 마커로 표시하기
var jsonArray = new Array();

	var json = new Object();
	
	json.title = '${study.STUDY_TITLE}'
	json.latlng = new kakao.maps.LatLng('${study.STUDY_LATITUDE}', '${study.STUDY_LOGITUDE}')
	json.study_code = '${study.STUDY_CODE}'
	
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
    
    // 인포윈도우에 제목 표시
    var iwContent = '<div><a href="/DEVCA/study/studydetailpage.do?STUDY_CODE=' + positions[i].study_code + '">'
    					+ positions[i].title +
    				'</a></div>',
    iwPosition = new kakao.maps.LatLng(positions[i].latlng, positions[i].title); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	marker.setMap(map);
	infowindow.open(map, marker); 
}

</script>
</html>