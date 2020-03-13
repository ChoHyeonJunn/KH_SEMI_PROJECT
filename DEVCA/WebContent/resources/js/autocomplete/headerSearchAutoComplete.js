function headerSearchAutoComplete(){
	
	// 검색어 자동완성
	$("#headerSearch input[name='search']").autocomplete({
		
		source: function(request, response){
		    $.ajax({
		        type: "POST",
		        url: "/DEVCA/lecture/lectureSearchAutoComplete.do",
		        data: {
		        	search : request.term
		        },
		        datatType: "JSON",

		        success: function (data) {
		        		console.log(data)
			        	response(
		        		$.map(JSON.parse(data), function(item){
		        			return{
		        				label: item.LECTURE_TITLE,
		        				value: item.LECTURE_TITLE,
		        				link: item.LECTURE_CODE,
		        				image: item.LECTURE_IMG	        				
		        			}
		        		})	
		        	)
		        },
		        error: function () {
		           alert("통신 실패");
		        }
		     })
		},
		minLength : 1,
		focus : function(event, ui){
			console.log(ui)
			$("#headerSearch input[name='search']").val(ui.item.value)
			return false;
		}
	}).autocomplete("instance")._renderItem = function(ul, item){
		var li_item = $("<div>").attr({"class":"my-auto"});
		var img = $("<img>").attr({
						"class" : "m-1",
						"style" : "width: 50px; height: 30px; border-radius: 5%;",
						"src" :  item.image
					})
		var link = $("<a>").attr({
						"href" : "/DEVCA/lecture/lecturedetailpage.do?lecture_code=" + item.link
					})
		var title = $("<span>").attr({"class":"mx-2"}).text(item.label);
		li_item.append(link.append(img)).append(title)
						
		return $("<li>").append(li_item).appendTo(ul);
	}
	
}

