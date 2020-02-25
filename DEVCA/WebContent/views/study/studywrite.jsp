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
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde3d6a6f398e8afdf7600f84f211532&libraries=services"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$('#summernote').summernote({
		 height: 300,                 // set editor height
         minHeight: null,             // set minimum height of editor
         maxHeight: null,             // set maximum height of editor
         focus: true                  // set focus to editable area after initializing summernote
	});

});
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
		<h1>스터디 팀 만들기</h1>
		<form id="studyWriteForm" action="/DEVCA/study/studywrite.do" action="POST">
			<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}">
			<input type="hidden" name="STUDY_LATITUDE">
			<input type="hidden" name="STUDY_LOGITUDE">
					
			<input type="text" name="STUDY_TITLE" required="required" placeholder="스터디이름">
			<textarea id="summernote" name="STUDY_CONTENT" rows="10" cols="60" required="required"></textarea>
				

		
			<!-- 멤버 프로필 위치 정보 -->
			<div>
				<p><em>검색 후 지도를 클릭해 스터디 위치를 저장하세요</em></p> 
				<input type="text" id="searchLoc"><button type="button" onclick="searchLocation();" >검색</button>
				<!-- <div id="clickLatlng"></div> -->
				<div id="map" style="width:100%;height:400px;"></div>
			</div>
			
			
			<input type="submit" value="등록"> 
			<input type="button" value="취소" onclick="location.href='/DEVCA/study/studylistpage.do'">
		</form>

						

	</section>
	
	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
	
	
	<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
	<input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LATITUDE}">33.450701</c:if>${member.MEMBER_PROFILE_LATITUDE}">
	<input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LOGITUDE}">126.570667</c:if>${member.MEMBER_PROFILE_LOGITUDE}">
	
</body>


<!-- START :: KAKAO MAP -->
<script type="text/javascript">

var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션		
		center: new kakao.maps.LatLng($("input[name='MEMBER_PROFILE_LATITUDE']").val(), $("input[name='MEMBER_PROFILE_LOGITUDE']").val()), //지도의 중심좌표.
	level: 5 //지도의 레벨(확대, 축소 정도)
};


var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var ps = new kakao.maps.services.Places();

function searchLocation(){
	var loc = $("#searchLoc").val();
	ps.keywordSearch(loc, placesSearchCB);
}


function placesSearchCB(data, status, pagination){
	if(status === daum.maps.services.Status.OK){
		var bounds = new kakao.maps.LatLngBounds();
		
		for(var i=0;i<data.length; i++){
			bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		}
		
		map.setBounds(bounds);
		
	}
}

// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter()
});

// 지도에 마커 표시
marker.setMap(map);
marker.setDraggable(true);

var infowindow = new kakao.maps.InfoWindow();

// 지도 클릭이벤트
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    //인포윈도우 생성
  	var iwContent = "<div onclick='saveLoc("+latlng.getLat()+","+latlng.getLng()+");'>위치 저장하기</div>";
   	var iwPosition = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
   
	infowindow.setContent(iwContent);
	infowindow.setPosition(iwPosition);
	infowindow.open(map, marker);   

   	kakao.maps.event.addListener(marker, 'dragend', function(){
		infowindow.close();
		infowindow.open(map, marker);
   	})    
});

function saveLoc(lat, lng){
	$("input[name='STUDY_LATITUDE']").val(lat);
	$("input[name='STUDY_LOGITUDE']").val(lng);
	
	alert($("input[name='STUDY_LOGITUDE']").val()
			+"\n" + $("input[name='STUDY_LATITUDE']").val())
}

</script>
<!-- END :: KAKAO MAP -->

</html>