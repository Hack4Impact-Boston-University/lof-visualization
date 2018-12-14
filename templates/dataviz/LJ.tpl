{crmTitle string="LJ Figured Out State Location Graph"}

<div class="dc_contacts" id="dataviz-contacts">
	<div id="datacountstate" style="margin-bottom:20px;">
	    <h2><strong><span class="filter-count"></span></strong> contacts selected from a total of <strong><span id="total-count"></span></strong> records</h2>
	</div>
	<div style="clear:both"></div>
	<div class="clear"></div>
	<div id="state">
	    <strong>Location by State</strong>
	    <a class="reset" href="javascript:stateRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
	    <div class="clearfix"></div>
	</div>
	<div class="clear"></div>
</div>

<script>

(function(guid){ldelim}
	'use strict';

	var stateInfo = {crmSQL file="LJ"};
	{literal}

		if(!stateInfo.is_error){	//Check for database error
			var stateRow = null;

			cj(function($) {
				var totalContacts = 0;

				stateInfo.values.forEach(function(d){
					totalContacts++;
				});

				stateRow 	= dc.rowChart('#state');

				var ndxState  = crossfilter(stateInfo.values), allState = ndxState.groupAll();

				var totalCountState = dc.dataCount("#datacountstate")
			        .dimension(ndxState)
			        .group(allState);

			    document.getElementById("total-count").innerHTML=totalContacts;

				var stateLocation = ndxState.dimension(function (d) {
					return d.abbreviation;
				});
				var stateLocationGroup = stateLocation.group().reduceSum(function(d){return 1;});

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
			cj('.dc_contacts').html('<div style="color:red; font-size:18px;">There is a database error. Please Contact the administrator as soon as possible.</div>');
		}
	{/literal}
{rdelim})("#dataviz-contacts ");
</script>
<div class="clear"></div>
