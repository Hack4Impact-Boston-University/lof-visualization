{crmTitle string="Human Trafficking Victim Cases"}
 
  <div class="VictimcasesFinal">
        <div style="font-size:20px; float:left; width:100%; height:40px;">
        from Intake forms
        </div>
      <div id="cases" style="width:100%;">
        <strong>Cases</strong>
        <a class="reset" href="javascript:casesBar.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <div class="clearfix"></div>
    </div>

    <div id="participants" style="width:100%;">
        <strong>Participants</strong>
        <a class="reset" href="javascript:participantsLine.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <div class="clearfix"></div>
    </div>
      <div id="trafficking">
          <strong>Type of Human Trafficking</strong>
          <a class="reset" href="javascript:trafficPie.filterAll();dc.redrawAll();" style="display: none">reset</a>
          <div class="clearfix"></div>
    </div>
  
      <div id="duration-chart">
         <strong>Length of Case</strong>
         <a class="reset" href="javascript:durationRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
         <div class="clearfix"></div>
     </div>

     <div id="age-of-client-chart" class="col-md-4">
          <strong>Age of Client</strong>
          <a class="reset" href="javascript:clientAgeChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
          <div class="clearfix"></div>
         </div>

     <div id="nationality" class="clear">
          <strong>Nationality of Client</strong>
          <a class="reset" href="javascript:nationalityRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
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
 
 var data = {crmSQL file="victimCases"};
 {literal}
 
      if(!data.is_error){
 
          var datetimeFormat = d3.time.format("%Y-%m-%d %H:%M:%S");
          var dateFormat = d3.time.format("%Y-%m-%d");
          var currentDate = new Date();
 
 
         var casesBar, participantsLine, durationRow, pieGender, clientAgeChart, trafficPie, nationalityRow;
 
         cj(function($) {
             var ndx = crossfilter(data.values), all = ndx.groupAll();
             data.values.forEach(function(d){
                  d.bd = dateFormat.parse(d.bd);
                  d.sd = datetimeFormat.parse(d.sd);
                  d.ed = datetimeFormat.parse(d.ed);
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

             var min = d3.time.month.offset(d3.min(data.values, function(d) { return d.sd;} ),-1);
             var max = d3.time.month.offset(d3.max(data.values, function(d) { return d.sd;} ), 1);

             casesBar = dc.barChart("#cases");
             participantsLine = dc.lineChart("#participants");
             pieGender = dc.pieChart("#gender").innerRadius(50).radius(90);
             clientAgeChart = dc.rowChart("#age-of-client-chart");
             durationRow = dc.rowChart("#duration-chart");
             nationalityRow = dc.rowChart('#nationality');
             trafficPie = dc.pieChart("#trafficking");

             
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
 
             var duration = ndx.dimension(function (d) {
               var timeDiff = Math.abs(d.ed.getTime() - d.sd.getTime());
               var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
               if (diffDays < 7){
                 return "less than one week";
               }
               else if (diffDays >= 7 && diffDays<= 31){
                 return "7-31 days";
               }
               else if (diffDays > 31 && diffDays <= 90){
                 return "2-3 months";
               }
               else if (diffDays > 90 && diffDays <=240){
                 return "4-8 months";
               }
               else if (diffDays > 240 && diffDays <= 365){
                 return "8-12 months";
               }
               else if (diffDays > 365 && diffDays <= 600){
                 return "13-20 months";
               }
               else if (diffDays > 600){
                 return "21+ months";
               }
             });
             var durationGroup = duration.group().reduceSum(function(d) {return 1;});

             var trafficking = ndx.dimension(function(d) {return d.exploitation;});
             var traffickingGroup = trafficking.group().reduceSum(function(d){return 1;});

              var nationality = ndx.dimension(function(d) {
                if (d.client_nationality == null)
                  {
                    return "None";
                  }
                else
                  {
                    return d.country_name;
                  }
              });
              var nationalityGroup = nationality.group().reduceSum(function(d){return 1;});
              
             // VISUALS
            casesBar
                .height(200)
                .margins({top: 10, right: 40, bottom: 40, left:40})
                .dimension(cases)
                .group(casesGroup)
                .centerBar(true)
                .gap(1)
                .x(d3.time.scale().domain([min, max]))
                .xUnits(d3.time.months);

            participantsLine
                .margins({top: 10, right: 50, bottom: 30, left:40})
                .height(200)
                .dimension(cases)
                .group(casesGroup)
                .brushOn(false)
                .x(d3.time.scale().domain([min, max]))
                .elasticY(true)
                .elasticX(true)
                .xUnits(d3.time.months);
            
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
                 .xAxis().ticks(4)

            durationRow
                 .width(200)
                 .height(200)
                 .dimension(duration)
                 .group(durationGroup)
                 .xAxis().ticks(1);

            nationalityRow
                  .height(200)
                  .margins({top: 20, left: 0, right: 10, bottom: 20})
                  .dimension(nationality)
                  .cap(5)
                  .ordering (function(d) {return d.qty;})
                  .colors(d3.scale.category10())
                  .group(nationalityGroup)
                  .elasticX(true);
              
            trafficPie
                  .innerRadius(10)
                  .radius(80)
                  .width(550)
                  .height(210)
                  .dimension(trafficking)
                  .group(traffickingGroup)
                  .minAngleForLabel(30)
                  .legend(dc.legend().x(15).y(10).itemHeight(13).gap(10));
 
           dc.renderAll();
          });
     }
     else{
         cj('.VictimcasesFinal').html('<div style="color:red; font-size:18px;">Civisualize Error. Please contact Admin.'+data.error+'</div>')
     }
 
 {/literal}
 </script>
 