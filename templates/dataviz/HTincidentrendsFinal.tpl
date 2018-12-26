{crmTitle string="Human Trafficking Incident Trends"}
 
  <div class="VictimcasesFinal">
        <div style="font-size:20px; float:left; width:100%; height:40px;">
        based on Human Trafficking Incident Activity and Client Demographic Fields and Case Client Subtype
        </div>

		<div id="cases" style="width:100%;">
			<strong>Cases</strong>
			<a class="reset" href="javascript:casesBar.filterAll();dc.redrawAll();" style="display: none;">reset</a>
			<div class="clearfix"></div>
    	</div>

		<div id="trafficking">
          <strong>Type of Human Trafficking</strong>
          <a class="reset" href="javascript:trafficPie.filterAll();dc.redrawAll();" style="display: none">reset</a>
          <div class="clearfix"></div>
    	</div>

     	<div id="age-of-client-chart" class="col-md-4">
          <strong>Age of Client</strong>
          <a class="reset" href="javascript:clientAgeChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
          <div class="clearfix"></div>
        </div>

	  	<div id="state">
			<strong>Location by State</strong>
			<a class="reset" href="javascript:stateRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
		<div class="clearfix"></div>
	</div>

      <div id="gender" class="col-md-4">
         <strong>Gender</strong>
         <a class="reset" href="javascript:pieGender.filterAll();dc.redrawAll();" style="display: none;">reset</a>
         <div class="clearfix"></div>
     </div>

      <div class="clear"></div>
 </div>
 
  <script>
 'use strict';
 
 var data = {crmSQL file="incidentTrends"};
 console.log(data)
 {literal}
 
      if(!data.is_error){
 
          var datetimeFormat = d3.time.format("%Y-%m-%d %H:%M:%S");
          var dateFormat = d3.time.format("%Y-%m-%d");
          var currentDate = new Date();
 
 
         var pieGender, clientAgeChart, stateRow, trafficPie, casesBar;
 
         cj(function($) {
             var ndx = crossfilter(data.values), all = ndx.groupAll();
             data.values.forEach(function(d){
                  d.bd = dateFormat.parse(d.bd);
                  d.sd = datetimeFormat.parse(d.sd);
                  if (d.gender == 1){
                    d.gender = "Female";
                  }
                  else if (d.gender == 2){
                    d.gender = "Male";
                  }
                  else if (d.gender == 3){
                    d.gender = "Non-Binary";
                  }
                  else{
                    d.gender = "Other";
                  }
                  if (d.exploitation == ""){
                    d.exploitation='None';
                  }
             });

             pieGender = dc.pieChart("#gender").innerRadius(50).radius(90);
             clientAgeChart = dc.rowChart("#age-of-client-chart");
			 stateRow 	= dc.rowChart('#state');
			 trafficPie = dc.pieChart("#trafficking");
			 casesBar = dc.barChart("#cases");

			 var min = d3.time.month.offset(d3.min(data.values, function(d) { return d.sd;} ),-1);
             var max = d3.time.month.offset(d3.max(data.values, function(d) { return d.sd;} ), 1);

             var cases = ndx.dimension(function(d) {
                  if (d.sd != null)
                  {
                    return (d3.time.month(d.sd));
                  }
                  else {
                    return 0;
                  }
              });
            var casesGroup = cases.group().reduceSum(function(d){return 1;});

             var gender = ndx.dimension(function(d){return d.gender;});
             var genderGroup = gender.group().reduceSum(function(d) {return 1;});
 
             var ageofClient = ndx.dimension(function (d) {
               if (d.bd!=null){
 
                 var age = currentDate.getFullYear() - d.bd.getFullYear();
                 
                 if (currentDate.getMonth() > d.bd.getMonth()){
                   age--;
                 }
                 else if(currentDate.getMonth() == d.bd.getMonth()){
                   if(currentDate.getDate()> d.bd.getDate()){
                     age--;
                   }
                 }
          
                 if (age>=46){
                   return "46+";
                 }
                 else if (age >= 40 && age <= 45){
                   return "40 - 45";
                 }
                 else if (age >= 33 && age <= 39){
                   return "33 - 39";
                 }
                 else if (age >= 29 && age <= 32){
                   return "29 - 32"
                 }
                 else if (age >= 25 && age <= 28){
                   return "25 - 28";
                 }
                 else if (age >= 21 && age <= 24){
                   return "21 - 24";
                 }
                 else if (age >= 18 && age <= 20){
                   return "18 - 20";
                 }
                 else {
                   return "Less than 18";
                 }
               }
             });
				var ageofClientGroup = ageofClient.group().reduceSum(function(d){return 1;});
	
				var trafficking = ndx.dimension(function(d) {return d.exploitation;});
             	var traffickingGroup = trafficking.group().reduceSum(function(d){return 1;});

				var minYear     = d3.min(data.values, function(d){return d.sd.getFullYear();});
                var maxYear     = d3.max(data.values, function(d){return d.sd.getFullYear();});
				

				
				var stateLocation = ndx.dimension(function (d) {
						return d.state;
					});
				var stateLocationGroup = stateLocation.group().reduceSum(function(d){return 1;});



             // VISUALS
			casesBar
                .height(200)
                .margins({top: 20, right: 0, bottom: 40, left:20})
                .dimension(cases)
                .group(casesGroup)
                .centerBar(true)
                .gap(1)
                .x(d3.time.scale().domain([min, max]))
                .xUnits(d3.time.months);

			trafficPie
                  .innerRadius(10)
                  .radius(80)
                  .width(550)
                  .height(210)
                  .dimension(trafficking)
                  .group(traffickingGroup)
                  .minAngleForLabel(30)
                  .legend(dc.legend().x(15).y(10).itemHeight(13).gap(10));
 
            
			pieGender
                 .width(250)
                 .height(200)
                 .dimension(gender)
                 .group(genderGroup)
                 .renderlet(function (chart) {
                 });
 
            clientAgeChart
                 .width(430)
                 .height(220)
                 .margins({top: 20, left: 10, right: 10, bottom: 40})
                 .group(ageofClientGroup)
                 .dimension(ageofClient)
                 .ordinalColors(["#d95f02","#1b9e77","#7570b3","#e7298a","#66a61e","#e6ab02","#a6761d"])
                 .elasticX(true)
                 .xAxis().ticks(4);

			stateRow
					.width(300)
					.height(200)
					.margins({top: 0, left: 10, right: 10, bottom: 20})
					.group(stateLocationGroup)
					.dimension(stateLocation)
					.ordinalColors(["#d95f02","#1b9e77","#7570b3","#e7298a","#66a61e","#e6ab02","#a6761d"])
					.label(function (d) {
						return d.key;
					})
					.title(function (d) {
 						return d.value;
					})
					.elasticX(true)
					.xAxis().ticks(4);
              
           dc.renderAll();
          });
     }
     else{
         cj('.HTincidentrendsFinal').html('<div style="color:red; font-size:18px;">Civisualize Error. Please contact Admin.'+data.error+'</div>')
     }
 
 {/literal}
 </script>
 