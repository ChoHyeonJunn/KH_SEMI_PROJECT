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
article{
	position: relative;
	margin-left: 250px;
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

	$("#check_module").click(function() {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp96246324');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
				pg : 'nictest04m', // version 1.1.0부터 지원.
				/*
				'kakao':카카오페이,
				html5_inicis':이니시스(웹표준결제)
				'nice':나이스페이
				'jtnet':제이티넷
				'uplus':LG유플러스
				'danal':다날
				'payco':페이코
				'syrup':시럽페이
				'paypal':페이팔
				 */
				pay_method : 'card',
				/*
				'samsung':삼성페이,
				'card':신용카드,
				'trans':실시간계좌이체,
				'vbank':가상계좌,
				'phone':휴대폰소액결제
				 */
				merchant_uid : 'merchant_' + new Date().getTime(),
				/*
				merchant_uid에 경우
				https://docs.iamport.kr/implementation/payment
				위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				참고하세요.
				나중에 포스팅 해볼게요.
				 */
				name : '주문명:DEVCA 구독', // 
				//결제창에서 보여질 이름
				amount : 100,				
				//가격
				
				buyer_email : 'ancsbbc@naver.com',	// session값 으로 입력
				buyer_name : '조현준',	// session값 으로 입력
				buyer_tel : '010-3919-9307', // session값 으로 입력
				buyer_addr : '서울특별시 송파구 마천동',	// api 사용 입력
				buyer_postcode : '123-456',	// api 사용 입력
				
				
				m_redirect_url : 'https://localhost:8090/member/privacypayment.jsp'
			/*
			모바일 결제시,
			결제가 끝나고 랜딩되는 URL을 지정
			(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			 */
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
				console.log(msg);
			});
		});

</script>
<!-- END :: JAVASCRIPT -->

<!-- START :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver}">
	<jsp:forward page="/DEVCA/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 비회원이 잘못된 경로를 통해 접근했을 때 block -->
</head>
<body>
	
	
	<section>
		<%@ include file="/views/form/privacysidebar.jsp"%>	
		
		<!-- START :: profile content -->
		<article>
			
			
			<!-- 결제버튼 -->
			<button id="check_module" type="button">아임 서포트 결제 모듈 테스트 해보기</button>
			<!-- 결제버튼 -->
			
			
			<form action="https://www.myservice.com/subscription/issue-billing"	method="post">
				<div>
					<label for="card_number">카드 번호 XXXX-XXXX-XXXX-XXXX</label> 
					<input id="card_number" type="text" name="card_number">
				</div>
				<div>
					<label for="expiry">카드 유효기간 YYYY-MM</label> 
					<input id="expiry" type="text" name="expiry">
				</div>
				<div>
					<label for="birth">생년월일 YYMMDD</label> 
					<input id="birth" type="text" name="birth">
				</div>
				<div>
					<label for="pwd_2digit">카드 비밀번호 앞 두자리 XX</label> 
					<input id="pwd_2digit" type="text" name="pwd_2digit">
				</div>
				<input hidden type="text" value="gildong_0001_1234" name="customer_uid"> 
				<input type="submit" value="결제하기">
			</form>




		</article>	
		<!-- END :: profile content -->	
		
	</section>	
	
	<!-- FOOTER FORM -->		
	<%@ include file="/views/form/footer.jsp"%>
</body>
</html>