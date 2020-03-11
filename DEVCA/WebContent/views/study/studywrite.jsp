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
<link href="/DEVCA/resources/css/kakaomap.css" rel="stylesheet" type="text/css">

<style type="text/css">

#profile_image{
	widht: 50px;
	height: 50px;
	border: 1px solid gray;
	border-radius: 30%;	
}

.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10378302e2e084e60bce37163dc9cca1&libraries=services"></script>

<!-- summernote including -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>
    
<script type="text/javascript">
$(document).ready(function() {
	$('#summernote').summernote({
		 height: 400,                 // set editor height
         minHeight: null,             // set minimum height of editor
         maxHeight: null,             // set maximum height of editor
         focus: false,                  // set focus to editable area after initializing summernote
         
         toolbar: [
           ['style', ['style']],
           ['font', ['bold', 'underline', 'clear']],
           ['color', ['color']],
           ['para', ['ul', 'ol', 'paragraph']],
           ['table', ['table']],
           ['insert', ['link', 'picture', 'video']],
           ['view', ['fullscreen', 'codeview', 'help']]
         ]
	});

	
	// 카카오맵 인포윈도우 온클릭 이벤트
	$(document).on("click", ".infoWindow", function(){
		var place_name = $(this).find("input[name='place_name']").val();
		var address_name = $(this).find("input[name='address_name']").val();
		var road_address_name = $(this).find("input[name='road_address_name']").val();
		var x = $(this).find("input[name='x']").val();
		var y = $(this).find("input[name='y']").val();
		
		$("#studyWriteForm input[name='STUDY_PLACE_NAME']").val(place_name);
		$("#studyWriteForm input[name='STUDY_ADDRESS']").val((road_address_name != "") ? road_address_name : address_name);
		$("#studyWriteForm input[name='STUDY_LATITUDE']").val(y);
		$("#studyWriteForm input[name='STUDY_LOGITUDE']").val(x);
		
		$("#showPlace").empty();
		$("#showPlace").append($("<div>").text("스터디 위치 : " + place_name + "(" + address_name + ")"));
	})
	
});
</script>

<!-- END :: JAVASCRIPT -->
</head>
<body>

	<section>
	
		<div class="card p-4 my-3 bg-white">
		
			<h1 class="card-title">스터디 팀 만들기</h1>
			
			<div class="row">
			
				<div class="col-md-8">
					<form id="studyWriteForm" action="/DEVCA/study/studywrite.do" action="POST">
						<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}">
						
						<input type="hidden" name="STUDY_PLACE_NAME">
						<input type="hidden" name="STUDY_ADDRESS">
						
						<input type="hidden" name="STUDY_LATITUDE">
						<input type="hidden" name="STUDY_LOGITUDE">
						
						<div class="row">
							<div class="col-md-9">
								<input class="form-control form-control-lg" type="text" name="STUDY_TITLE" required="required" placeholder="스터디이름">
							</div>
							<div class="col-md-3">
								<input class="form-control form-control-lg" type="date" name="STUDY_DATE" required="required"> 
							</div>
						</div>		
						
						<textarea id="summernote" name="STUDY_CONTENT" required="required"></textarea>				
						
						<input class="btn" type="submit" value="등록"> 
						<input class="btn" type="button" value="취소" onclick="location.href='/DEVCA/study/studylistpage.do'">
					</form>
				</div>
				
				<div class="col-md-4">
					<div class="map_wrap">
					    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
					
					    <div id="menu_wrap" class="bg_white">
					        <div class="option">
					            <div>
					                    키워드 : <input type="text" id="keyword" size="15"> 
					          		<button type="button" onclick="searchPlaces(); return false;">검색하기</button> 
					            </div>
					        </div>
					        <hr>
					        <ul id="placesList"></ul>
					        <div id="pagination"></div>
					    </div>
					    
					</div>
					
			  		<div id="showPlace" class="card-link"></div>
				</div>
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


///////////////////지도 클릭 이벤트로 위치 설정////////////////////////

// 지도를 클릭한 위치에 표출할 마커입니다
var clickMarker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter()
});

// 지도 클릭이벤트
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;  
    
    // 클릭한 위치의 address 얻어오기
    searchDetailAddrFromCoords(latlng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        	var detailAddr = !!result[0].road_address ? result[0].road_address.address_name : '';
            detailAddr += result[0].address.address_name;
            
            
            // 마커 위치를 클릭한 위치로 옮깁니다
            clickMarker.setPosition(latlng);
            clickMarker.setMap(map);
            
            
            //인포윈도우 생성
          	var iwContent = "<div onclick='saveLoc("+latlng.getLat()+","+latlng.getLng()+",\""+detailAddr+"\");'>"+detailAddr+" : 위치 저장하기</div>";
           	var iwPosition = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
           
        	infowindow.setContent(iwContent);
        	infowindow.setPosition(iwPosition);
        	infowindow.open(map, clickMarker);   

           	kakao.maps.event.addListener(clickMarker, 'dragend', function(){
        		infowindow.close();
        		infowindow.open(map, clickMarker);
           	}) 
        }   
    });
    
   
});

function saveLoc(lat, lng, detailAddr){
	$("#studyWriteForm input[name='STUDY_LATITUDE']").val(lat);
	$("#studyWriteForm input[name='STUDY_LOGITUDE']").val(lng);
	$("#studyWriteForm input[name='STUDY_ADDRESS']").val(detailAddr);
	
	$("#showPlace").empty();
	$("#showPlace").append($("<div>").text("스터디 위치 : " + detailAddr));
}
//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}
function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}





///////////////////장소 검색으로 위치 설정////////////////////////

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

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
    	
    	
    	

		console.log(places[i])
		
		
		
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
            
        })(marker, places[i]);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
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
    var content = '<div class="infoWindow" style="padding:5px;z-index:1;">' 
    			+ title.place_name 
    			+ '<input type="hidden" name="place_name" value="' + title.place_name + '"/>'
    			+ '<input type="hidden" name="address_name" value="' + title.address_name + '"/>'
    			+ '<input type="hidden" name="road_address_name" value="' + title.road_address_name + '"/>'
    			+ '<input type="hidden" name="x" value="' + title.x + '"/>'
    			+ '<input type="hidden" name="y" value="' + title.y + '"/>'
    			+ '</div>';

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