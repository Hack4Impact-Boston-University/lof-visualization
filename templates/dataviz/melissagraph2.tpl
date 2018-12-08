{crmTitle title="Melissa Graphs: Type of Human Trafficking Pie and Nationality of Client"}
  <div class="type" id="clear">
    <div id="trafficking" style="width:600px;">
          <strong>Type of Human Trafficking</strong>
          <a class="reset" href="javascript:trafficPie.filterAll();dc.redrawAll();" style="display: none;">reset</a>
          <div class="clearfix"></div>
    </div>
    <div id="nationality" class="clear">
      <strong>Nationality of Client</strong>
      <a class="reset" href="javascript:sourceRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
    </div>

   <div class="clear"></div>

  
<script>


(function(guid){ldelim}
'use strict';

var data = {crmSQL file="melissaqueries"};

{literal}
if(!data.is_error){//Check for database error
			var numberFormat = d3.format(".2f");

      var traffickingArray = {};
      var nationalityArray = {};
//console.log(data.values.what_type_of_exploitation_311)
//console.log(data.values[3].client_nationality_272)

cj(function($) {
				data.values.forEach(function(d){

          //traffickingArray[d]
          console.log(d.client_nationality_272)
          //console.log(d.what_type_of_exploitation_311)
         // d.trafficking = d.values[i].what_type_of_exploitation_311;
         // i = i + 1;
      });
var ndx  = crossfilter(data.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);


var trafficking = ndx.dimension(function(d) {
  return d.what_type_of_exploitation_311;});
var traffickingGroup = trafficking.group().reduceSum(function(d){return 1;});

var nationality = ndx.dimension(function(d) {return d.client_nationality_272;});
var nationalityGroup= nationality.group().reduceSum(function(d){return d.qty;});



var trafficPie = dc.pieChart("#trafficking")
                    .innerRadius(10)
                    .radius(100)
                    .width(650)
                    .height(400)
                    .dimension(trafficking)
                    .group(traffickingGroup)
                    .minAngleForLabel(30)
                    //.valueAccessor(function (d) {return d.trafficking;})
                    .legend(dc.legend().x(15).y(10).itemHeight(13).gap(10));

var nationalityRow = dc.rowChart('#nationality')
          .height(200)
          .margins({top: 20, left: 10, right: 10, bottom: 20})
          .dimension(nationality)
          .cap(5)
          .ordering (function(d) {return d.qty;})
          .colors(d3.scale.category10())
          .group(nationalityGroup)
          .elasticX(true);

 
dc.renderAll(); });
}
{/literal}
{rdelim})("#dataviz-melissagraph")

</script>

<style>
{* .clear {clear:both;} *}
</style>

