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
#lecture_img{
	width: 100%;
	height: 100%;	
	cursor: pointer;
}

/* crawling lecture detail :: css */
.course_detail div{
	margin-top: 20px;
	margin-bottom: 20px;
}
.course_detail li{
	list-style: none;
	padding-left: 10px;
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
/* 리뷰 별점 */
.star-rating-review { 
	width:100px; 
}
.star-rating-review , .star-rating-review span { 
	display:inline-block; 
	height:20px; 
	overflow:hidden;
	background:url(../resources/images/star.png)no-repeat; 
	background-size: 100px 40px;
}
.star-rating-review span{ 
	background-position:left bottom; 
	line-height:0; 
	vertical-align:top; 
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


/* review :: 프로필 이미지 */
#profile_image_review{
	widht: 40px;
	height: 40px;
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
	
	$(".review_title"+REVIEW_CODE).empty();
	$(".review_content"+REVIEW_CODE).empty();
	$(".review_controll"+REVIEW_CODE).css("display","none");
	
	$(".review_title"+REVIEW_CODE).append($("<input>").attr({
		"class" : "form-control",
		"type" : "text",
		"name" : "new_review_title"+REVIEW_CODE,
		"value" : review_title
	}))
	$(".review_content"+REVIEW_CODE).append($("<textarea>").attr({
		"class" : "form-control",
		"cols" : "40",
		"rows" : "10",
		"name" : "new_review_content"+REVIEW_CODE
	}).text(review_content))
	.append($("<div>").attr({"class":"text-right"})
			.append($("<button>")
						.attr({"class" : "btn text-right new_review_submit"+REVIEW_CODE,"onclick" : "submitNewReview(" + REVIEW_CODE + ")"})
						.text("완료")
			)
	)
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
		<!-- START :: lectureDescription -->
			<div class="bg-dark my-3">
				<div class="row">
				
					<div class="col-xl-4 p-5 text-center">
						<img id="lecture_img" alt="크롤링한 이미지" src="${lecture_detail.LECTURE_IMG }" onclick="location.href='${lecture_detail.LECTURE_LINK }'" style="background-size: contain;">
					</div>
					
					<div class="col-xl-8 p-5 text-light my-auto">
						<h1 class="my-3">${lecture_detail.LECTURE_TITLE }</h1>
						
						<div class="course_meta">${lecture_detail.LECTURE_DESCRIPTION }</div>
						
						<div class="mt-2">${lecture_detail.LECTURE_PAYFLAG }</div>
						
						<!-- 별점이 나올 부분 -->
						<div class="rating_star my-2">
							<span class="star-rating">
								<span class="rear-star" style="width:${lecture_detail.LECTURE_RATE*20 }%;">
																
								</span>
							</span>	
							${fn:length(reviewList)}개의 수강평
						</div>
						
						<button class="course_cnt btn" onclick="location.href='${lecture_detail.LECTURE_LINK }'">강의보러가기</button>
											
						<button class="course_wish_btn btn" id="addMyLecture">
							<div class="wish">
								<i class="far fa-heart"> MY LECTURE 담기</i>
							</div>
						</button>
					</div>
					
				</div>
			</div>
		
		<!-- START :: lectureContent -->
		<section class="card p-5 my-3 bg-white">
			<h4>강의소개</h4>
			<div class="course_detail p-5">
				${lecture_detail.LECTURE_CONTENT }
			</div>
		</section>

		<!-- START : review -->
		<article class="reviews card p-4 my-3 bg-white" id="reviews">
			
			<div class="review_summary">
			
				<!-- 별점이 나올 부분 -->
				<div class="rating_star my-2">
					<span class="star-rating">
						<span class="rear-star" style="width:${lecture_detail.LECTURE_RATE*20 }%;">
														
						</span>
					</span>	
					${fn:length(reviewList)}개의 수강평
				</div>
			</div>
			
			<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver}">

				<div class="card p-4 my-3 bg-white">
					<form id="writeReviewForm" action="/DEVCA/lecture/insertReview.do" method="post">
						<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE}${sessionLoginKakao.MEMBER_CODE}${sessionLoginNaver.MEMBER_CODE}">
						<input type="hidden" name="LECTURE_CODE" value="${lecture_detail.LECTURE_CODE}">
						<input type="hidden" name="REVIEW_WRITER" value="${sessionLoginMember.MEMBER_NAME}${sessionLoginKakao.KAKAO_NICKNAME}${sessionLoginNaver.NAVER_NICKNAME}">
						<input type="hidden" name="REVIEW_RATE" value="0.5">
						<input type="hidden" name="REVIEW_COUNT" value="${fn:length(reviewList)}">
						
						<h3>후기 작성하기</h3>
						
						<div class="row">							
							<div class="input-group mb-3 col-md-10">
								<input type="text" class="form-control" name="REVIEW_TITLE" required="required" placeholder="제목">
							</div>
							<div class="starRev col-md-2">
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
						</div>
						<div class="input-group mb-3">
							<textarea rows="10" class="form-control" name="REVIEW_CONTENT" required="required" placeholder="여러분의 소중한 후기를 남겨주세요."></textarea>
						</div>	
						<div class="text-right">
							<input type="submit" class="btn" value="후기작성">						
						</div>
					</form>
				</div>			
			</c:if>
			
			<div id="review_list_container">				
				<c:forEach var="review" items="${reviewList}">
					<div class="card p-4 my-3 bg-white">
						
						<div class="writer_info my-auto">
							<img id="profile_image_review" src="
												<c:choose>
													<c:when test="${not empty review.MEMBER_PROFILE_IMAGE_S_NAME}">../resources/images/profileupload/${sessionMember_profile.MEMBER_PROFILE_IMAGE_S_NAME }</c:when>
													<c:otherwise>../resources/images/add.png</c:otherwise>
												</c:choose>	
												">
							<!-- 별점이 나올 부분 -->
							<span class="star-rating-review">
								<span class="rear-star-review" style="width:${review.REVIEW_RATE*20 }%;">		
								</span>
							</span>
							<span class="review_writer font-weight-bold mx-1">${review.REVIEW_WRITER }</span>		
							<span class="review_regdate mx-1">${review.REVIEW_REGDATE }</span>													
								
						</div>
						
						<hr>
						<div>
							<h4 class="font-weight-bold review_title${review.REVIEW_CODE}">${review.REVIEW_TITLE }</h4>
							<div class="review_content${review.REVIEW_CODE}"><div class="pl-5">${review.REVIEW_CONTENT }</div></div>
						</div>
						<div class="review_controll${review.REVIEW_CODE} text-right">
							<c:if test="${sessionLoginMember.MEMBER_CODE eq review.MEMBER_CODE || sessionLoginKakao.MEMBER_CODE eq review.MEMBER_CODE || sessionLoginNaver.MEMBER_CODE eq review.MEMBER_CODE}">
								<button class="btn" onclick="udpateReview('${review.REVIEW_CODE}')">수정</button>
								<button class="btn" onclick="deleteReview('${review.REVIEW_CODE}','${review.REVIEW_RATE}')">삭제</button>
							</c:if>
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