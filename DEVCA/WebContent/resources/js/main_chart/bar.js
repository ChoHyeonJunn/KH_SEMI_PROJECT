
function getBarChartData(param){
	$.ajax({				
		type: "POST",
		data : {
			param : param
		},
		url: "/DEVCA/main/getBarChartData.do",
		dataType: "JSON",
		
		success: function(data) {	
			drawBarChart(data);
		},
		
		error : function() {
			alert("통신 실패");
		}
	})
}

function drawBarChart(data){	
	
	am4core.ready(function() {
	
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	// Create chart instance
	var chart = am4core.create("chartdiv_job_rank", am4charts.XYChart);
	chart.scrollbarX = new am4core.Scrollbar();
	
	console.log("barchart data : " + JSON.stringify(data));
	
	// Add data
	chart.data = data;
	
	// Create axes
	var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
	categoryAxis.dataFields.category = "tech";
	categoryAxis.renderer.grid.template.location = 0;
	categoryAxis.renderer.minGridDistance = 30;
	categoryAxis.renderer.labels.template.horizontalCenter = "right";
	categoryAxis.renderer.labels.template.verticalCenter = "middle";
	categoryAxis.renderer.labels.template.rotation = 270;
	categoryAxis.tooltip.disabled = true;
	categoryAxis.renderer.minHeight = 10;
	
	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
	valueAxis.renderer.minWidth = 50;
	
	// Create series
	var series = chart.series.push(new am4charts.ColumnSeries());
	series.sequencedInterpolation = true;
	series.dataFields.valueY = "requireNum";
	series.dataFields.categoryX = "tech";
	series.tooltipText = "[{categoryX}: bold]{valueY}[/]";
	series.columns.template.strokeWidth = 0;
	
	series.tooltip.pointerOrientation = "vertical";
	
	series.columns.template.column.cornerRadiusTopLeft = 10;
	series.columns.template.column.cornerRadiusTopRight = 10;
	series.columns.template.column.fillOpacity = 0.8;
	
	// on hover, make corner radiuses bigger
	var hoverState = series.columns.template.column.states.create("hover");
	hoverState.properties.cornerRadiusTopLeft = 0;
	hoverState.properties.cornerRadiusTopRight = 0;
	hoverState.properties.fillOpacity = 1;
	
	// column 클릭 이벤트
	series.columns.template.events.on("hit", function(ev) {
		var onclickBarItem = ev.target.dataItem.categories.categoryX;
		console.log("clicked on ", onclickBarItem);
		barChartColumClick(onclickBarItem);
	}, this);

	
	
	series.columns.template.adapter.add("fill", function(fill, target) {
	  return chart.colors.getIndex(target.dataItem.index);
	});
	
	// Cursor
	chart.cursor = new am4charts.XYCursor();
	
	}); // end am4core.ready()
}