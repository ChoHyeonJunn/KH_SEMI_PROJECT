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
   height: 100%;
}

#profile_image{
   widht: 200px;
   height: 200px;
   border: 1px solid gray;
   border-radius: 30%;   
}

</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dde3d6a6f398e8afdf7600f84f211532&libraries=services"></script>

<script type="text/javascript">
$(function(){
   
   $("#profile_image").click(function(){
      $("#MEMBER_PROFILE_IMAGE_NAME").click();
   })
   
   $("#MEMBER_PROFILE_IMAGE_NAME").change(function(e){
      var form = $("#imageForm")[0];
      var formData = new FormData(form);
      //formData.append("MEMBER_PROFILE_IMAGE_NAME", $("#MEMBER_PROFILE_IMAGE_NAME")[0].files[0]);
      
      $.ajax({
         type: "POST",
         enctype: "multipart/form-data",
         url: "/DEVCA/member/privacyprofileimageupdate.do",
         processData: false,
         contentType: false,
         data: formData,
         dataType: "JSON",
         success: function(msg){
            alert("사진 변경 완료");
            $("#profile_image").attr("src","../resources/images/profileupload/" + msg.img);
         },
         error : function() {
            alert("통신 실패");
         }
      })
      
   })
   
   $("#name").keyup(function() {
      
      if($("#name").val() == null || $("#name").val() == "") {
         $("#name_confirm").text("필수 정보입니다.");
         $("#name_confirm").attr("style", "color:red");
      } else {         
         $.ajax({
            
            type: "POST",
            url: "/DEVCA/member/nameconfirm.do",
            data: { MEMBER_NAME : $("#name").val() },
            dataType: "JSON",
            
            success: function(msg) {   
               if(msg.result > 0) {                  
                  $("#name_confirm").text("이미 사용중인 별명입니다.");
                  $("#name_confirm").attr("style", "color:red");
                  
                  $("#SUBMIT").attr("disabled", "disabled");
               } else {
                  $("#name_confirm").text("사용 가능한 별명입니다.");
                  $("#name_confirm").attr("style", "color:blue");
                  
                  $("#SUBMIT").removeAttr("disabled");
               }
            },
            
            error : function() {
               alert("통신 실패");
            }
         })
      }
   })
   
})
</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
   <jsp:forward page="/DEVCA/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
</head>
<body>
   
   
   <section class="container-fluid">
      <div class="row">
         
         <%@ include file="/views/form/privacysidebar.jsp"%>   
      
         <!-- START :: profile content -->
         <article class="col-md-10">
            
            <div class="card p-4 my-3 bg-white">
         
               <!-- 멤버 프로필 이미지 -->
               <form id="imageForm" action="/DEVCA/member/privacyprofileimageupdate.do" method="POST" enctype="multipart/form-data">
                  <input type="hidden" name="MEMBER_CODE" value="${member.MEMBER_CODE }">
                  
                  <div style="text-align: center;">                  
                     <img id="profile_image" src="
                                       <c:choose>
                                          <c:when test="${not empty sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
                                          <c:otherwise>../resources/images/add.png</c:otherwise>
                                       </c:choose>   
                                       ">
                     <input id="MEMBER_PROFILE_IMAGE_NAME" type="file" name="MEMBER_PROFILE_IMAGE_NAME" value="${member.MEMBER_PROFILE_IMAGE_NAME }" style="display: none;">               
                     
                  </div>
                  
               </form>
            
               <!-- 멤버 프로필 정보 -->
               <form action="/DEVCA/member/privacyprofileupdate.do" method="POST">
                  <input type="hidden" name="MEMBER_CODE" value="${member.MEMBER_CODE }">
      
                  <div style="text-align: center;">                  
                     <input type="radio" name="MEMBER_ROLE" value="1" disabled="disabled" <c:if test="${member.MEMBER_ROLE == 1}">checked="checked"</c:if>>BASIC
                     <input type="radio" name="MEMBER_ROLE" value="2" disabled="disabled" <c:if test="${member.MEMBER_ROLE == 2}">checked="checked"</c:if>>PREMIUM
                  
                     <div>
                        <a href="/DEVCA/member/privacypaymentpage.do" class="btn btn-lg">premium 구독하러가기</a>
                     </div>               
                  </div>
                  <!--    <div class="input-group mb-3">
                     <input class="btn btn-block btn-lg" type="submit" value="변경사항 저장">
                  </div>    -->
                     
                  <label for="name">*별명</label>
                  <div class="input-group mb-3">
                     <input id="name" type="text" class="form-control" name="MEMBER_NAME" value="${member.MEMBER_NAME }" required="required" placeholder="nickname" autocomplete="name">
                     <div class="input-group-append">            
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                     </div>
                  </div>                  
                  <div id="name_confirm"></div>   <!-- 경고문이 들어갈 공간 -->
                  
                  
                  <label for="email">*이메일 (이메일은 수정할 수 없습니다.)</label>
                  <div class="input-group mb-3">
                     <input id="email" class="form-control" type="email" name="MEMBER_EMAIL" value="${member.MEMBER_EMAIL}" required="required" readonly="readonly" disabled="disabled">
                     <div class="input-group-append">            
                            <span id="email_check_remove" class="input-group-text"><i class="fas fa-envelope"></i></span>
                     </div>
                  </div>         
               
               
                  <label for="phone">*전화번호</label>
                  <div class="input-group mb-3">   
                     <input id="phone" class="form-control" type="tel" name="MEMBER_PHONE" value="${member.MEMBER_PHONE}" required="required" placeholder="010-1234-1234" autocomplete="tel">
                     <div class="input-group-append">            
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                     </div>               
                  </div>
                  
                  <hr>
                  
                  
                  <label for="introduce">한줄 소개(optional)</label>
                  <div class="input-group mb-3">   
                     <textarea id="introduce" class="form-control" rows="5" name="MEMBER_PROFILE_INTRODUCE">${member.MEMBER_PROFILE_INTRODUCE}</textarea>
                  </div>
                  
                  
                  <label for="homepage">홈페이지(optional)</label>
                  <div class="input-group mb-3">   
                     <input id="homepage" class="form-control" type="url" name="MEMBER_PROFILE_HOMEPAGE" value="${member.MEMBER_PROFILE_HOMEPAGE}" placeholder="example@example.com">
                     <div class="input-group-append">            
                            <span class="input-group-text"><i class="fas fa-home"></i></span>
                     </div>               
                  </div>
                  
                  
                  <label for="area">활동지역(optional)</label>
                  <div class="input-group mb-3">   
                     <input id="area" class="form-control" type="text" name="MEMBER_PROFILE_AREA" value="${member.MEMBER_PROFILE_AREA}" placeholder="서울시 강남구 역삼동...">
                     <div class="input-group-append">            
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                     </div>               
                  </div>
                  
                  
                  <div class="input-group mb-3">
                     <input class="btn btn-block btn-lg" type="submit" value="변경사항 저장">
                  </div>         
               </form>         
               
               <!-- 멤버 프로필 위치 정보 -->
               <div>
                  <div class="input-group" style="width: 100%">
                     <input class="form-control" type="text" id="searchLoc" placeholder="위치를 검색해 자신의 위치를 저장하세요!">
                     <div class="input-group-append">                  
                        <button type="button" class="btn btn-success btn-light" onclick="searchLocation();" >위치 검색</button>
                     </div>
                  </div>
                  <!-- <div id="clickLatlng"></div> -->
                  
                  <div id="map" style="width:100%;height:400px;"></div>
                  
               </div>
               
               <form id="locationHiddenForm" action="/DEVCA/member/privacyprofilegpsupdate.do" method="POST">
                  <input type="hidden" name="MEMBER_CODE" value="${member.MEMBER_CODE }">
                  
                  <input type="hidden" name="MEMBER_PROFILE_LATITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LATITUDE}">33.450701</c:if>${member.MEMBER_PROFILE_LATITUDE}">
                  <input type="hidden" name="MEMBER_PROFILE_LOGITUDE" value="<c:if test="${empty member.MEMBER_PROFILE_LOGITUDE}">126.570667</c:if>${member.MEMBER_PROFILE_LOGITUDE}">
               </form>
            
            
            
            </div>
            
            
         </article>   
         <!-- END :: profile content -->
            
      </div>
   </section>   
   
   
   <!-- FOOTER FORM -->      
   <%@ include file="/views/form/footer.jsp"%>
   
</body>


<!-- START :: KAKAO MAP -->
<script type="text/javascript">

var container = document.getElementById('map');
var options = { //지도를 생성할 때 필요한 기본 옵션      
   center: new kakao.maps.LatLng($("#locationHiddenForm input[name='MEMBER_PROFILE_LATITUDE']").val(), $("#locationHiddenForm input[name='MEMBER_PROFILE_LOGITUDE']").val()), //지도의 중심좌표.
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
   $("#locationHiddenForm input[name='MEMBER_PROFILE_LATITUDE']").val(lat);
   $("#locationHiddenForm input[name='MEMBER_PROFILE_LOGITUDE']").val(lng);
   
   $.ajax({            
      type: "POST",
      url: "/DEVCA/member/privacyprofilegpsupdate.do",
      data: { 
         MEMBER_CODE : $("#locationHiddenForm input[name='MEMBER_CODE']").val(),
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

</script>
<!-- END :: KAKAO MAP -->
</html>