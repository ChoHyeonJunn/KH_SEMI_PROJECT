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
</style>
<!-- END :: css -->

<!-- START :: set JSTL variable -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
$(function(){
	
	$("#check_module").click(function() {
		IMP.init('imp96246324');

		IMP.request_pay({
			//pay_method : 'card', // 'card'만 지원됩니다.
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : 'DEVCA 정기권 인증결제',
			amount : 0, // 빌링키 발급만 진행하며 결제승인을 하지 않습니다.
			customer_uid : '${sessionMember_profile.MEMBER_EMAIL}', //customer_uid 파라메터가 있어야 빌링키 발급을 시도합니다.
			buyer_email : '${sessionMember_profile.MEMBER_EMAIL}',
			buyer_name : '${sessionMember_profile.MEMBER_NAME}',
			buyer_tel : '${sessionMember_profile.MEMBER_PHONE}'
		}, function(rsp) {
			if ( rsp.success ) {
				console.log('빌링키 발급 성공');
 			 	$.ajax({
			    	type: "POST",
			    	url: "/DEVCA/member/privacypaymentpageRegular.do", // 서비스 웹서버
			        data: {
			        	customer_uid: '${sessionMember_profile.MEMBER_EMAIL}', // 카드(빌링키)와 1:1로 대응하는 값
			        	merchant_uid: rsp.merchant_uid,
			        	amount: '100',
			        	schedule_at: new Date().getTime()		        	
			    	},
			        dataType: "JSON",

					success: function(msg) {	
						console.log("결제 예약 성공");
						
						// ajax로 회원 등급 up
		 			 	$.ajax({
					    	type: "POST",
					    	url: "/DEVCA/member/privacypaymentpageUpdateMemberRole.do", // 서비스 웹서버
					        data: {
					        	MEMBER_CODE: '${sessionMember_profile.MEMBER_CODE}'        	
					    	},
					        dataType: "JSON",

							success: function(msg) {	
								alert("DEVCA 구독 성공");								
							},						
							error : function(msg) {
								alert("DEVCA 구독 실패");
							}
					 	}) 
					},						
					error : function(msg) {
						alert("결제 예약 실패");
					}
			 	}) 

			 	
			} else {
				console.log('빌링키 발급 실패');
			}
			console.log("최초인증결제 결과 : " + JSON.stringify(rsp))
		});
	});

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
					
					<c:if test="${sessionMember_profile.MEMBER_ROLE eq '1'}">
						<!-- 결제버튼 -->
						<div id="check_module" class="card p-4 my-3 bg-white text-center">
							<h1 class="card-title">
								<strong style="color: #862d86;">DEVCA</strong> PREMIUM
							</h1>
							<h4>
								6개월 구독하기
							</h4>
						</div>
						<!-- 결제버튼 -->
					</c:if>
					
					<c:if test="${sessionMember_profile.MEMBER_ROLE eq '2'}">
						
						<!-- 결제버튼 -->
						<div class="card p-4 my-3 bg-light text-center">
							<h1 class="card-title">
								<strong style="color: #862d86;">DEVCA</strong> PREMIUM
							</h1>
							<h4>
								구독중입니다
							</h4>
						</div>
						<!-- 결제버튼 -->
					</c:if>
					
				</div>
			</article>	
			<!-- END :: profile content -->	
			
		</div>
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>