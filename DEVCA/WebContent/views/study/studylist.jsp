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
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
  		<h1>STUDY :: LIST</h1>
  		
  		<div id="map" style="width:90%;height:400px;"></div>
  		<c:if test="${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}">
			<input type="button" value="글쓰기" onclick="location.href='/DEVCA/study/studywritepage.do'">
		</c:if>
  		<div>
  			<c:choose>
				
				<c:when test="${empty studyList }">
					<div>
						----스터디가 존재하지 않습니다.----		
					</div>				
				</c:when>
				
				<c:otherwise>
				
					<c:forEach var="study" items="${studyList}">
						<div>
							<span>
								${study.MEMBER_CODE}
							</span>
							<span>
								<a href="/DEVCA/study/studydetailpage.do?STUDY_CODE=${study.STUDY_CODE}">${study.STUDY_TITLE}</a>
							</span>
							<span>
								${study.STUDY_DATE}
							</span>
						</div>
					</c:forEach>	
										
				</c:otherwise>
				
			</c:choose>	
  		</div>	
		
	</section>
	
	<!-- FOOTER FORM -->	
	<%@ include file="/views/form/footer.jsp"%>
	
	
	<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
	<input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LATITUDE}">33.450701</c:if>${member.MEMBER_PROFILE_LATITUDE}">
	<input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LOGITUDE}">126.570667</c:if>${member.MEMBER_PROFILE_LOGITUDE}">

	
	
	
</body>


<script type="text/javascript">

var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng($("input[name='MEMBER_PROFILE_LATITUDE']").val(), $("input[name='MEMBER_PROFILE_LOGITUDE']").val()), //지도의 중심좌표.
	level: 4 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴



// 스터디 위치 list 마커로 표시하기
var jsonArray = new Array();
<c:forEach items="${studyList}" var="study">
	console.log('${study.STUDY_TITLE}' + '${study.STUDY_LATITUDE}' + '${study.STUDY_LOGITUDE}')

	var json = new Object();
	
	json.title = '${study.STUDY_TITLE}'
	json.latlng = new kakao.maps.LatLng('${study.STUDY_LATITUDE}', '${study.STUDY_LOGITUDE}')
	json.study_code = '${study.STUDY_CODE}'
	
	jsonArray.push(json);
</c:forEach>
var positions = jsonArray;

/* 
	position dataType example
[
    {
        title: '카카오', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        title: '생태연못', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '근린공원',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
];
 */
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