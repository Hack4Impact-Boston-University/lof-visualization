{crmTitle title="Melissa Graphs: Type of Human Trafficking Pie and Nationality of Client"}
  <div class="type" id="clear">
    <div id="nationality" class="clear">
      <strong>Nationality of Client</strong>
      <a class="reset" href="javascript:sourceRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
    </div>

   <div class="clear"></div>

  
<script>


(function(guid){ldelim}
'use strict';

var data = {crmSQL file="melissaquery"};

{literal}
  if(!data.is_error){//Check for database error
			var numberFormat = d3.format(".2f");
     
			cj(function($) {

		
var ndx  = crossfilter(data.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);



var nationality = ndx.dimension(function(d) {return d.client_nationality_272;});
var nationalityGroup= nationality.group().reduceSum(function(d){return 1;});





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
else{
			cj('.dc_contacts').html('<div style="color:red; font-size:18px;">There is a database error. Please Contact the administrator as soon as possible.</div>');
		}
{/literal}
{rdelim})("#dataviz-melissagraph")

</script>

<style>
{* .clear {clear:both;} *}
</style>

