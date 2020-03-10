/* lecture list 뿌리기 */
function fillMainLectureList(data, container){	
	$(container).empty();
	$.each(data, function(index, item){
		console.log(item.LECTURE_CODE)
		//swipe div
		var swiper_slide = $("<div>").attr({
			"class" : "swiper-slide"
		})
		
		// 강의 div
		var lectureItem = $("<div>").attr({
			"class" : "lecture card bg-light"
		})
		
		// 강의 링크버튼 opacity
		var add_my_lecture;
		if(container == '#my-wrapper'){
			add_my_lecture = 
				$("<div>").attr({"class":"add_my_lecture_img_container","style":"text-align:right;"})
				.append($("<img src='../resources/images/trash.png'>").attr({
					"class":"add_my_lecture_img",
					"onclick":"DeleteMyGarbageLecture("+item.LECTURE_CODE+");",
					"data-toggle":"tooltip",
					"title":"MY LECTURE 에서 지우기"
					}))                               
				
		}else{
			add_my_lecture = 
				$("<div>").attr({"class":"add_my_lecture_img_container","style":"text-align:right;"})
				.append($("<img src='../resources/images/heart.png'>").attr({
					"class":"add_my_lecture_img",
					"onclick":"addMyLecture("+item.LECTURE_CODE+");",
					"data-toggle":"tooltip",
					"title":"MY LECTURE 에 추가하기"
					})) 
		}
		var lecture_back = $("<div>").attr({
			"class" : "lecture_back card p-2",
			"onclick" : "location.href='/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + item.LECTURE_CODE + "'"
		})
		.append($("<h6>").text(item.LECTURE_TITLE).attr("style","color: white;"))
		.append($("<div>").text(item.LECTURE_DESCRIPTION).attr({"class":"pt-3","style":"color: white;"}))
		.append(add_my_lecture)
		
		// 이미지 관련 div
		var lecture_img_div = $("<div>").attr({"class" : "lecture_img_div"})
		var lecture_img = $("<img>").attr({"src" : item.LECTURE_IMG,"style" : "width: 100%; height: 100%; object-fit: cover;"})			
		lecture_img_div.append(lecture_img);
		
		// 강의 정보 div
		var lecture_des_div = $("<div>").attr({
			"class" : "lecture_des_div p-2"
		});
		var lecture_title = $("<h6>").text(item.LECTURE_TITLE);		// 제목		
		var lecture_additional_des = $("<div>").attr({"class":"lecture_additional_des row py-4"}) // 부가정보		
		var lecture_rate = $("<div>").attr({"class":"col-sm-6"})
							.append($("<div>")
									.append($("<div>").attr({"class":"star-rating"})
											.append($("<span>").attr({"class":"rear-start","style":"width:"+item.LECTURE_RATE*20+"%;"}))  
											)  
									)
							.append($("<small>").text(item.LECTURE_READCOUNT+"개의 후기"));// 별점, 후기갯수

		var lecture_payflag = $("<small>").attr({"class":"col-sm-6", "style":"text-align: right;"}).text(item.LECTURE_PAYFLAG.replace(/(<([^>]+)>)/ig,""));// 가격		
		lecture_additional_des.append(lecture_rate).append(lecture_payflag);
		lecture_des_div.append(lecture_title).append(lecture_additional_des);
		
		// 강의 div 에 append 하여 content 완성
		lectureItem.append(lecture_back);
		lectureItem.append(lecture_img_div);
		lectureItem.append(lecture_des_div);

		swiper_slide.append(lectureItem);
						
		$(container).append(swiper_slide);
	})

}


