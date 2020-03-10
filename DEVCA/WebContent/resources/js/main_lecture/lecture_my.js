function recommend_swiper(){
	new Swiper('.swiper-container', {
		slidesPerView : 7, // 동시에 보여줄 슬라이드 갯수
		spaceBetween : 10, // 슬라이드간 간격
		slidesPerGroup : 5, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
		speed : 1000,
		//loop : true, // 무한 반복
		mousewheelControl : true,
			
		navigation : { // 네비게이션
		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
		},
	});
}				
function selectMyList(MEMBER_CODE){
	$.getJSON("/DEVCA/main/mylistajax.do", {MEMBER_CODE : MEMBER_CODE}, function(data){
		fillMainLectureList(data, "#my-wrapper");
		recommend_swiper();
	});
}
