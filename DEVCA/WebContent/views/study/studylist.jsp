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
<link href="/DEVCA/resources/css/kakaomap.css" rel="stylesheet" type="text/css">

<style type="text/css">
section{
	width: 100%;
	height: auto;
}
#profile_image{
	widht: 50px;
	height: 50px;
	border: 1px solid gray;
	border-radius: 30%;	
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10378302e2e084e60bce37163dc9cca1&libraries=services"></script>

<script type="text/javascript">
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<section>
		<div class="card p-4 my-3 bg-white">		
	  		
	  		<div class="map_wrap">
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
	  			
	  		<h1 class="card-title">STUDY :: LIST</h1>
	  		
	  		<c:if test="${not empty sessionLoginMember.MEMBER_CODE || not empty sessionLoginKakao.MEMBER_CODE || not empty sessionLoginNaver.MEMBER_CODE}">
				<input class="btn btn-lg" type="button" value="글쓰기" onclick="location.href='/DEVCA/study/studywritepage.do'" style="width: 100px;">
			</c:if>
	  		<div>
	  			<c:choose>
					
					<c:when test="${empty studyList }">
						<div class="card p-4 my-3 bg-white">			
							----스터디가 존재하지 않습니다.----		
						</div>				
					</c:when>
					
					<c:otherwise>
					
						<c:forEach var="study" items="${studyList}">
							<div class="card p-4 my-3 bg-white" onclick="location.href='/DEVCA/study/studydetailpage.do?STUDY_CODE=${study.STUDY_CODE}'" style="cursor: pointer;">
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
												<strong>${study.MEMBER_NAME}</strong>
												<br>
												<strong>${study.MEMBER_EMAIL}</strong>
											</div>
										</div>
									</div>
									<div class="col-md-5">
										<h5><a class="card-link" href="/DEVCA/study/studydetailpage.do?STUDY_CODE=${study.STUDY_CODE}">${study.STUDY_TITLE}</a></h5>
									</div>
									<div class="col-md-1">
										${study.STUDY_PARTICIPANTS}명 참여중
									</div>
									<div class="col-md-1">
										${study.STUDY_DATE}
									</div>
									<div class="col-md-3">
										${study.STUDY_PLACE_NAME}
										(${study.STUDY_ADDRESS})
									</div>
								</div>	
							</div>
						</c:forEach>	
											
					</c:otherwise>
					
				</c:choose>	
	  		</div>	
		</div>
	</section>
	
	<!-- FOOTER FORM -->	
	<%@ include file="/views/form/footer.jsp"%>
	
	
	<!-- 내 위치정보를 정리해 놓을 HIDDEN INPUT -->
	<input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test="${empty sessionMember_profile.MEMBER_PROFILE_LATITUDE}">33.450701</c:if>${sessionMember_profile.MEMBER_PROFILE_LATITUDE}">
	<input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test="${empty sessionMember_profile.MEMBER_PROFILE_LOGITUDE}">126.570667</c:if>${sessionMember_profile.MEMBER_PROFILE_LOGITUDE}">

	
	
	
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
var MyimageSrc =  <c:choose>
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


///////////////////장소 검색으로 위치 설정////////////////////////

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
</html>