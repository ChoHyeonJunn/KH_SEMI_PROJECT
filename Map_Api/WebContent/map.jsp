<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 생성하기</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<div>
	<div style="width: 100%">
		<input class="form-control" type="text" id="searchLoc" placeholder="위치를 검색해 자신의 위치를 저장하세요!">
		<div>						
			<button type="button" onclick="searchLocation();" >위치 검색</button>
		</div>
	</div>
	<!-- <div id="clickLatlng"></div> -->
	
	<div id="map" style="width:100%;height:400px;"></div>
	
</div>
<form id="locationHiddenForm" action="/Map_Api/member/privacyprofilegpsupdate.do" method="POST">
	
	<input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test='${empty member.MEMBER_PROFILE_LATITUDE}'>33.450701</c:if>${member.MEMBER_PROFILE_LATITUDE}"/>
	<input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test='${empty member.MEMBER_PROFILE_LOGITUDE}'>126.570667</c:if>${member.MEMBER_PROFILE_LOGITUDE}"/>
</form>
<div>
	<input type="button" value="마커확인" onclick = "displayStudyList();"/>
</div>				
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10378302e2e084e60bce37163dc9cca1&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 



var ps = new kakao.maps.services.Places();

function searchLocation(){
	var loc = $("#searchLoc").val();
	ps.keywordSearch(loc, placesSearchCB);
}


function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
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
	$("#locationHiddenForm input[name='MEMBER_PROFILE_LATITUDE']").val(lat);
	$("#locationHiddenForm input[name='MEMBER_PROFILE_LOGITUDE']").val(lng);
	
	$.ajax({				
		type: "POST",
		url: "/Map_Api/member/privacyprofilegpsupdate.do",
		data: { 
			MEMBER_PROFILE_LATITUDE : $("#locationHiddenForm input[name='MEMBER_PROFILE_LATITUDE']").val(),
			MEMBER_PROFILE_LOGITUDE : $("#locationHiddenForm input[name='MEMBER_PROFILE_LOGITUDE']").val()
			},
		dataType: "JSON",
		
		success: function(msg) {	
			
			if(msg.res > 0){
				$("#locationHiddenForm input[name='MEMBER_PROFILE_LATITUDE']").val(lat);
				$("#locationHiddenForm input[name='MEMBER_PROFILE_LOGITUDE']").val(lng);
				
				alert("위치 저장 완료!");
			}else{
				alert("위치 저장 실패!");
			}				
			
		},
		
		error : function() {
			alert("통신 실패");
		}
	})
}

///////////////////스터디 위치 list 마커////////////////////////
function displayStudyList(){
	var jsonArray = new Array();
	<c:forEach items="${studyList}" var="study">
		console.log('${study.MEMBER_PROFILE_LATITUDE}', '${study.MEMBER_PROFILE_LOGITUDE}')

		var json = new Object();
		
		json.latlng = new kakao.maps.LatLng('${study.MEMBER_PROFILE_LATITUDE}', '${study.MEMBER_PROFILE_LOGITUDE}')
		
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
	        image : markerImage // 마커 이미지 
	    });
		// 마커가 지도 위에 표시되도록 설정합니다
	    marker.setMap(map);
	}
}
</script>
</body>
</html>