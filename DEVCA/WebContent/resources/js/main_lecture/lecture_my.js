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
		$.each(data, function(index, item){					
			//swipe div
			var swiper_slide = $("<div>").attr({
				"class" : "swiper-slide"
			})
							
			// 강의 div
			var lectureItem = $("<div>").attr({
				"class" : "lecture"
			})
							
			// 강의 링크버튼 opacity
			var lecture_back = $("<div>").attr({
				"class" : "lecture_back",
				"onclick" : "location.href='/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + item.LECTURE_CODE + "'"
			}).append(
					$("<h4>").text(item.LECTURE_TITLE).attr("style","color: white;")
				).append(
							$("<div>").text(item.LECTURE_DESCRIPTION).attr("style","color: white;")
							);

			// 이미지 관련 div
			var lecture_img_div = $("<div>").attr({
				"class" : "lecture_img_div"
			})
			var lecture_img = $("<img>").attr({
				"src" : item.LECTURE_IMG,
				"style" : "width: 100%; height: 100%; object-fit: cover;"
			})			
			lecture_img_div.append(lecture_img);
							
			// 강의 정보 div
			var lecture_des_div = $("<div>").attr({
				"class" : "lecture_des_div"
			});
			var lecture_title = $("<h4>").text(item.LECTURE_TITLE);
			var lecture_description = $("<div>").text(item.LECTURE_DESCRIPTION);
			var lecture_payflag = $("<div>").text(item.LECTURE_PAYFLAG);
			lecture_des_div.append(lecture_title).append(lecture_description).append(lecture_payflag);
							
			// 강의 div 에 append 하여 content 완성
			lectureItem.append(lecture_back);
			lectureItem.append(lecture_img_div);
			lectureItem.append(lecture_des_div);
							
			swiper_slide.append(lectureItem);
							
			$("#my-wrapper").append(swiper_slide);
		})

		recommend_swiper();
	});
}
