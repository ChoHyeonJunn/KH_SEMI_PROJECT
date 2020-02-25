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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde3d6a6f398e8afdf7600f84f211532"></script>

<script type="text/javascript">

</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
	
		<form action="/DEVCA/study/studyupdatepage.do" method="POST">
			<input type="hidden" value="${study.STUDY_CODE }" name='STUDY_CODE'">
			
			<div>
				<div>
					<span>
						이름
					</span>
					<span>
						${study.MEMBER_CODE }
					</span>
				</div>
			
				<div>
					<span>
						제목
					</span>
					<span>
						${study.STUDY_TITLE }
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
		<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">
			<div>
				<h2>스터디 신청하기</h2>
				<form action="/DEVCA/study/applyStudy.do" method="POST">
					<input type="hidden" name="STUDY_CODE" value="${study.STUDY_CODE}">
					<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}">
					<input type="submit" value="신청하기">
				</form>
			</div>
		</c:if>
		<c:choose>
			<c:when test="${sessionLoginMember.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq study.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq study.MEMBER_CODE}">
				<div>
					<h2>신청한 사람들</h2>
					<div id="applyForMaster">
						
					</div>
				</div>
			</c:when>
			
			<c:otherwise>
				<div>
					<h2>참여중인 스티디원</h2>
					<div id="applyForOthers">
					
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

<script type="text/javascript">

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