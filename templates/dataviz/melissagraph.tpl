{crmTitle title="Melissa Graphs: Type of Human Trafficking Pie and Nationality of Client"}
  <div class="type" id="clear">
    <div id="trafficking" style="width:600px;">
          <strong>Type of Human Trafficking</strong>
          <a class="reset" href="javascript:trafficPie.filterAll();dc.redrawAll();" style="display: none;">reset</a>
          <div class="clearfix"></div>
    </div>
    <div class="clear"></div>

  
<script>


(function(guid){ldelim}
'use strict';

var data = {crmSQL file="melissaqueries"};
//var trafficking = {crmAPI entity="melissaqueries" action="getoptions" field="what_type_of_exploitation_311"};

{literal}
if(!data.is_error){//Check for database error
			var numberFormat = d3.format(".2f");
			var traffickingLabel = {};

			/*trafficking.values.forEach(function(d){
				traffickingLabel[d.key]=d.value;
			});*/
     

			//var dateFormat = d3.time.format("%Y-%m-%d");

		//	var trafficPie=null

			cj(function($) {
				var totalContacts = 0;

				data.values.forEach(function(d){ 
					totalContacts+=d.count;
					d.trafficking=traffickingLabel[d.gender_id];
					if(d.source=="")
						d.source='None';
					if(d.trafficking_id=="")
						d.trafficking='None';
				});
console.log(data)
var ndx  = crossfilter(data.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);


var trafficking = ndx.dimension(function(d) {return d.trafficking;});
var traffickingGroup = trafficking.group().reduceSum(function(d){return d.qty;});

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

 
dc.renderAll(); });
}
{/literal}
{rdelim})("#dataviz-melissagraph")

</script>

<style>
{* .clear {clear:both;} *}
</style>

