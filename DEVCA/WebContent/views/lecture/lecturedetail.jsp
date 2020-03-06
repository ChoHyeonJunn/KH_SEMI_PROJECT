<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- HEADER FORM -->
<%@ include file="/views/form/header.jsp"%>

<!-- START :: css -->
<style type="text/css">
section {
	width: 100%;
	height:auto;
}
#lecture_img{
	widht: 600px;
	height: 300px;	
}

/* 별점 */
.star-rating { 
	width:205px; 
}
.star-rating , .star-rating span { 
	display:inline-block; 
	height:39px; 
	overflow:hidden; 
	background:url(../resources/images/star.png)no-repeat; 
}
.star-rating span{ 
	background-position:left bottom; 
	line-height:0; 
	vertical-align:top; 
}
.rear-star{
	padding: 0px;
	margin: 0px;
}

/* 별점 입력 */
.starR1{
	padding: 0px;
	margin: 0px;
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
	padding: 0px;
	margin: 0px;
	background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

/* 프로필 이미지 */
#profile_image{
	widht: 70px;
	height: 70px;
	border: 1px solid gray;
	border-radius: 30%;	
}
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

$(function(){
	//별점 입력 코드
	$('.starRev span').click(function(){
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
		$("#writeReviewForm input[name='REVIEW_RATE']").val($(".on").length / 2);
		return false;
	});
	
	//selectReviewList()
	
	$("#addMyLecture").click(function(){
		var MEMBER_CODE = ${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE};
		var LECTURE_CODE = ${lecture_detail.LECTURE_CODE};
		
	    $.ajax({
	        type: "POST",
	        url: "/DEVCA/lecture/addmylectureajax.do",
	        data: {
	        	MEMBER_CODE : MEMBER_CODE,
	        	LECTURE_CODE: LECTURE_CODE
	        },
	        datatType: "JSON",

	        success: function (args) {
	        	alert("내 강의에 추가되었습니다");
	        },

	        error: function (request, status, error) {
	           alert("통신 실패");
	           alert("code : " + request.status + "\n" +
	              "message : " + request.responseText + "\n" +
	              "error : " + error);
	        }
	     });
	})
})

function selectReviewList(){
	var LECTURE_CODE = ${lecture_detail.LECTURE_CODE};
    $.ajax({
        type: "POST",
        url: "/DEVCA/lecture/selectReviewList.do",
        data: {
        	LECTURE_CODE: LECTURE_CODE
        },
        datatType: "JSON",

        success: function (args) {
        	fillReviewList(args);
        },

        error: function (request, status, error) {
           alert("통신 실패");
           alert("code : " + request.status + "\n" +
              "message : " + request.responseText + "\n" +
              "error : " + error);
        }
     });
}
	
function fillReviewList(reviewList){
	var container = $("#review_list_container")
	container.empty();
	
	$.each(reviewList, function(index, review){
		
		container.append($("<div>").attr({
			"class":"123"
		}))
		
		
	})
}

function udpateReview(REVIEW_CODE){
	var review_title = $(".review_title"+REVIEW_CODE).text();
	var review_content = $(".review_content"+REVIEW_CODE).text();
	alert(review_title + review_content)
	$(".review_title"+REVIEW_CODE).empty();
	$(".review_content"+REVIEW_CODE).empty();
	$(".review_controll"+REVIEW_CODE).css("display","none");
	
	$(".review_title"+REVIEW_CODE).append($("<input>").attr({
		"type" : "text",
		"name" : "new_review_title"+REVIEW_CODE,
		"value" : review_title
	}))
	$(".review_content"+REVIEW_CODE).append($("<textarea>").attr({
		"cols" : "40",
		"rows" : "10",
		"name" : "new_review_content"+REVIEW_CODE
	}).text(review_content)).append($("<button>").attr({
		"class" : "new_review_submit"+REVIEW_CODE,
		"onclick" : "submitNewReview(" + REVIEW_CODE + ")"
	}).text("완료"))
}

function submitNewReview(REVIEW_CODE){
	$("#updateReviewForm input[name='REVIEW_CODE']").val(REVIEW_CODE);
	$("#updateReviewForm input[name='LECTURE_CODE']").val(${lecture_detail.LECTURE_CODE});
	$("#updateReviewForm input[name='REVIEW_TITLE']").val($("input[name='new_review_title"+REVIEW_CODE+"']").val());
	$("#updateReviewForm input[name='REVIEW_CONTENT']").val($("textarea[name='new_review_content"+REVIEW_CODE+"']").val());
	
	$("#updateReviewForm").submit();	
}
function deleteReview(REVIEW_CODE, REVIEW_RATE){
	$("#deleteReviewForm input[name='REVIEW_CODE']").val(REVIEW_CODE);
	$("#deleteReviewForm input[name='LECTURE_CODE']").val(${lecture_detail.LECTURE_CODE});
	$("#deleteReviewForm input[name='REVIEW_RATE']").val(REVIEW_RATE);
	$("#deleteReviewForm").submit();
}
</script>
<!-- END :: JAVASCRIPT -->



</head>
<body>

	<main id="main">
		<section class="course_header_container">
			<div class="container">
				<div class="columns">
					<div class="columns course_img">
						<div class="image">
							<img id="lecture_img" alt="크롤링한 이미지" src="${lecture_detail.LECTURE_IMG }">
						</div>
						<div class="column course_title">
							<div>
								<h1>
									${lecture_detail.LECTURE_TITLE }
								</h1>
								
								<div class="course_meta">
									${lecture_detail.LECTURE_DESCRIPTION }
								</div>
								
								<div class="course_reviews">
									<div class="rating_star">
									
										<!-- 별점이 나올 부분 -->${lecture_detail.LECTURE_RATE*20 }
										<span class="star-rating">
											<span class="rear-star" style="width:${lecture_detail.LECTURE_RATE*20 }%;">
												
											</span>
										</span>	
										
										<small> (${fn:length(reviewList)}개의 수강평) </small>
									</div>
								</div>
								
								<button class="course_cnt" onclick="location.href='${lecture_detail.LECTURE_LINK }'">강의보러가기</button>
								
								<button class="course_wish_btn" id="addMyLecture">
									<div class="wish">
										<i class="far fa-heart"> ::before </i> 
										<span class="wish_cnt">1555</span>
										<span class="text" > 담기 </span>
									</div>
								</button>
								
								<button class="price"></button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="next">
			
			</div>
			
			<div class="description_sub">
				<div class="tabs">
					<ul class="container">
						<li class="course_description"><a href="/lecture/">강의소개</a></li>
						<li class="course_review"><a href=""> 강의리뷰 </a></li>
					</ul>
				</div>
			</div>
		</section>
		
		
		<article class="course_content">
			<h4>강의소개</h4>
			<div class="course_detail">
				${lecture_detail.LECTURE_CONTENT }
			</div>
		</article>

		<article>
			<h4>강의장 위치</h4>
			
			<div class="course_map">
			
			</div>
		</article>

		<!-- START : review -->
		<article class="reviews" id="reviews">
			<h4 class="sub_heading">수강후기</h4>
			
			<div class="review_summary">
				<div class="average">
					<span class="average_num"> 4.9</span> 
						<div class="rating_star"> 별점 </div>

					<h5 class="review_total">${fn:length(reviewList)} 개의 수강평</h5>
				</div>
			</div>
			
			<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">

				<div class="write">
					<form id="writeReviewForm" action="/DEVCA/lecture/insertReview.do" method="post">
						<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}">
						<input type="hidden" name="LECTURE_CODE" value="${lecture_detail.LECTURE_CODE}">
						<input type="hidden" name="REVIEW_WRITER" value="${sessionLoginMember.MEMBER_NAME}${sessionLoginKakao.KAKAO_NICKNAME}${sessionLoginNaver.NAVER_NICKNAME}">
						<div>
							<h3>후기 작성하기</h3>
						</div>
						<div>
							<div>
								<input type="text" name="REVIEW_TITLE" required="required" placeholder="제목">
							</div>
							<div>
								<textarea rows="10" cols="60" name="REVIEW_CONTENT" required="required" placeholder="여러분의 소중한 후기를 남겨주세요."></textarea>
							</div>
						</div>
						<div class="starRev">
						  <span class="starR1 on">별1_왼쪽</span>
						  <span class="starR2">별1_오른쪽</span>
						  <span class="starR1">별2_왼쪽</span>
						  <span class="starR2">별2_오른쪽</span>
						  <span class="starR1">별3_왼쪽</span>
						  <span class="starR2">별3_오른쪽</span>
						  <span class="starR1">별4_왼쪽</span>
						  <span class="starR2">별4_오른쪽</span>
						  <span class="starR1">별5_왼쪽</span>
						  <span class="starR2">별5_오른쪽</span>
						</div>
						<input type="hidden" name="REVIEW_RATE" value="0.5">
						<input type="hidden" name="REVIEW_COUNT" value="${fn:length(reviewList)}">
						<input type="submit" value="완료">
					</form>
				</div>			
			</c:if>
			
			<div id="review_list_container">				
				<c:forEach var="review" items="${reviewList}">
					<div class="review_list_content">
						
						<div class="writer_info">
							<img id="profile_image" src="
												<c:choose>
													<c:when test="${not empty review.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
													<c:otherwise>../resources/images/add.png</c:otherwise>
												</c:choose>	
												">
							<span class="review_writer">${review.REVIEW_WRITER }</span>		
							<span class="review_regdate">${review.REVIEW_REGDATE }</span>													
							<!-- 별점이 나올 부분 -->
							<span class="star-rating">
								<span class="rear-star" style="width:${review.REVIEW_RATE*20 }%;">		
								</span>
							</span>		
						</div>
						
						<div class="review_title${review.REVIEW_CODE}">${review.REVIEW_TITLE }</div>
						<div class="review_content${review.REVIEW_CODE}">${review.REVIEW_CONTENT }</div>
						
						<div class="review_controll${review.REVIEW_CODE}">
							<c:if test="${sessionLoginMember.MEMBER_CODE eq review.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq review.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq review.MEMBER_CODE}">
								<button class="" onclick="udpateReview('${review.REVIEW_CODE}')">수정</button>
								<button class="" onclick="deleteReview('${review.REVIEW_CODE}','${review.REVIEW_RATE}')">삭제</button>
							</c:if>
						</div>
						<div class="review_comments">
							<div class="content">
								<small><span class="author"> 관리자 </span></small> 
								<span class="comment_body"> 리뷰의 댓글 부분입니다. </span>
							</div>
						</div>
						
					</div>
				</c:forEach>
			</div>
			
		</article>
		<!-- END : review -->
		
		<form id="deleteReviewForm" action="/DEVCA/lecture/deleteReview.do" method="post">
			<input type="hidden" name="REVIEW_CODE">
			<input type="hidden" name="LECTURE_CODE">
			<input type="hidden" name="REVIEW_RATE">
			<input type="hidden" name="REVIEW_COUNT" value="${fn:length(reviewList)}">
		</form>
		
		<form id="updateReviewForm" action="/DEVCA/lecture/updateReview.do" method="post">
			<input type="hidden" name="REVIEW_CODE">
			<input type="hidden" name="LECTURE_CODE">			
			<input type="hidden" name="REVIEW_TITLE">
			<input type="hidden" name="REVIEW_CONTENT">
		</form>

	</main>

	<!-- FOOTER FORM -->
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>