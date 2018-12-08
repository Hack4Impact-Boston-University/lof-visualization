{crmTitle title="Here be dragons"}
This is a demo


   <div id="cases" style="width:100%;">
        <strong>Cases</strong>
        <a class="reset" href="javascript:casesBar.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <div class="clearfix"></div>
    </div>
  <div class="clear"></div>


<script>
//var data = {crmSQL sql="SELECT something, somethingelse, count(*) as total from civicrm_table where whatever group by something, somethingelse"};

(function(guid){ldelim}
	'use strict';
var data2 = {crmSQL file= "jasonqueries"};

//console.log(data2)

{literal}
var data = {
is_error:0,
values:[
  {type:"Guitarist",gender:"M",qty:58, date_exploitation_started_306: "2018-10-08 00:00:00"},
  {type:"Guitarist",gender:"F",qty:19, date_exploitation_started_306: "2018-09-08 00:00:00"},
  {type:"Violonist",gender:"M",qty:10, date_exploitation_started_306: "2018-02-08 00:00:00"},
  {type:"Violonist",gender:"F",qty:23, date_exploitation_started_306: "2018-01-08 00:00:00"},
  {type:"Pianist",gender:"M",qty:30, date_exploitation_started_306: "2018-07-08 00:00:00"},
  {type:"Pianist",gender:"F",qty:33, date_exploitation_started_306: "2018-07-08 00:00:00"},
  {type:"Drummer",gender:"M",qty:18, date_exploitation_started_306: "2018-05-08 00:00:00"},
  {type:"Bassist",gender:"M",qty:17, date_exploitation_started_306: "2018-03-08 00:00:00"},
  {type:"Bassist",gender:"F",qty:9, date_exploitation_started_306: "2018-03-08 00:00:00"}
]};

var ndx  = crossfilter(data2.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);

var datetimeFormat = d3.time.format("%Y-%m-%d %H:%M:%S");
 data2.values.forEach(function(d){
                d.dataparsed = datetimeFormat.parse(d.date_exploitation_started_306);
                //console.log(d.dataparsed)
            });



var min = d3.time.month.offset(d3.min(data2.values, function(d) { return d.dataparsed;} ),-1);
var max = d3.time.month.offset(d3.max(data2.values, function(d) { return d.dataparsed;} ), 1);
//console.log("MIN" + min)
//console.log("MAX" + max)


var cases = ndx.dimension(function(d) {console.log(d3.time.month(d.dataparsed));
return d3.time.month(d.dataparsed);});
var casesGroup = cases.group().reduceSum(function(d){return 1;});
var casesPie = dc.barChart("#cases")
                    .height(200)
                    .margins({top: 0, right: 50, bottom: 20, left:40})
                    .dimension(cases)
                    .group(casesGroup)
                    .centerBar(true)
                    .gap(1)
                    .x(d3.time.scale().domain([min, max]))
                    .xUnits(d3.time.months);



dc.renderAll();

	{/literal}
{rdelim})("#dataviz-EMS2 ")
</script>
