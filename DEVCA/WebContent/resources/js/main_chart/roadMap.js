function getRoadMapData(MEMBER_CODE){
	$.ajax({				
		type: "POST",
		data : {
			MEMBER_CODE : MEMBER_CODE
		},
		url: "/DEVCA/main/getRoadMapData.do",
		dataType: "JSON",
		
		success: function(data) {
			drawRoadMap(JSON.parse(data.roadMap), data.field);
		},
		
		error : function() {
			alert("통신 실패");
		}
	})
	//drawRoadMap(MEMBER_CODE);
}

function addRoadMapData(MEMBER_CODE, item){
	$.ajax({				
		type: "POST",
		data : {
			MEMBER_CODE : MEMBER_CODE,
			item : item
		},
		url: "/DEVCA/main/addRoadMapData.do",
		dataType: "JSON",
		
		success: function(data) {		
			drawRoadMap(JSON.parse(data.roadMap));
		},
		
		error : function() {
			alert("통신 실패");
		}
	})	
}

function removeRoadMapData(MEMBER_CODE, item){
	$.ajax({				
		type: "POST",
		data : {
			MEMBER_CODE : MEMBER_CODE,
			item : item
		},
		url: "/DEVCA/main/removeRoadMapData.do",
		dataType: "JSON",
		
		success: function(data) {	
			drawRoadMap(JSON.parse(data.roadMap));
		},
		
		error : function() {
			alert("통신 실패");
		}
	})	
}

function linkRoadMapData(MEMBER_CODE, selectedItem, Item){
	$.ajax({				
		type: "POST",
		data : {
			MEMBER_CODE : MEMBER_CODE,
			selectedItem : selectedItem,
			Item : Item
		},
		url: "/DEVCA/main/linkRoadMapData.do",
		dataType: "JSON",
		
		success: function(data) {	
			drawRoadMap(JSON.parse(data.roadMap));
		},
		
		error : function() {
			alert("통신 실패");
		}
	})	
}

function drawRoadMap(data, field){	
	console.log("roadMapData" + data)
	
	
	$("#roadMap_field").text(field)	
	am4core.ready(function() {
	
		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end
		
		var chart = am4core.create("chartdiv_roadmap", am4plugins_forceDirected.ForceDirectedTree);
		chart.legend = new am4charts.Legend();
		var networkSeries = chart.series.push(new am4plugins_forceDirected.ForceDirectedSeries())
		

		
		networkSeries.data = data; 
		
		networkSeries.dataFields.linkWith = "linkWith";
		networkSeries.dataFields.name = "name";
		networkSeries.dataFields.id = "name";
		networkSeries.dataFields.value = "value";
		networkSeries.dataFields.children = "children";
		
		networkSeries.nodes.template.tooltipText = "{name}";
		networkSeries.nodes.template.fillOpacity = 1;
		
		networkSeries.nodes.template.label.text = "{name}"
		networkSeries.fontSize = 20;
		networkSeries.maxLevels = 2;
		networkSeries.maxRadius = am4core.percent(10);
		networkSeries.manyBodyStrength = -16;
		networkSeries.nodes.template.label.hideOversized = false;
		networkSeries.nodes.template.label.truncate = false;
		
		// 노드 클릭 이벤트
		networkSeries.nodes.template.events.on("hit", function(event){
			var node = event.target;
			if(node.outerCircle.disabled == false){
				return;	// 클릭한 노드가 부모 노드라면 이벤트 발생 불가
			} else {
				roadMapNodeClick(node.dataItem.dataContext.name);
			}
		})	
		
		// 노드 연결 이벤트
		var selectedNode;
		var selectedItem;

		networkSeries.nodes.template.events.on("up", function (event) {
			var node = event.target;
			
			if (!selectedNode) {
				if(node.outerCircle.disabled == true){
					return;	// 최초 선택노드가 자식 노드라면 연결이벤트 불가!!
				} else {
					node.outerCircle.strokeDasharray = "3,3";
					selectedNode = node;
					selectedItem = node.dataItem.dataContext.name;
				}
			}
			else if (selectedNode == node) {
				node.outerCircle.strokeDasharray = "";
				selectedNode = undefined;
			}
			else {
			  var node = event.target;		
			  var link = node.linksWith.getKey(selectedNode.uid);
		
			  if (link) {// selected 노드와 연결 해제
				  console.log("연결 해제 : " + link)
				  node.unlinkWith(selectedNode);
			  }
			  else {// selected 노드와 연결
				  if(node.outerCircle.disabled == false){
					  return;	// 연결될 노드가 부모노드라면 이벤트 생성 해제
				  } else {
					  Item = node.dataItem.dataContext.name;
					  alert(selectedItem + " 와 연결될 노드 : " + Item)
					  node.linkWith(selectedNode, 0.2);
					  
					  linkBypass(selectedItem, Item);
				  }		
			  }
		  }
		})
	}); // end am4core.ready()
}