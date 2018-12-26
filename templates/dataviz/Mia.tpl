{crmTitle title="Here be dragons"}
This is a demo

    <div id="dob" class="clear">
      <strong>Date of Birth</strong>
      <a class="reset" href="javascript:dobBar.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
  </div>
  <div class="clear"></div>
  <div id="gender" style="width:350px;">
      <strong>Gender</strong>
      <a class="reset" href="javascript:genderPie.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
  </div>
  <div class="clear"></div>


<script>

{literal}
var data = {
is_error:0,
values:[
  {type:"Guitarist",gender:"M",qty:58, dob: "2018-05-05"},
  {type:"Guitarist",gender:"F",qty:19, dob: "2017-04-04"},
  {type:"Violonist",gender:"M",qty:10, dob: "2017-04-04"},
  {type:"Violonist",gender:"F",qty:23, dob: "2017-04-04"},
  {type:"Pianist",gender:"M",qty:30, dob: "2017-04-04"},
  {type:"Pianist",gender:"F",qty:33, dob:"2017-04-04"},
  {type:"Drummer",gender:"M",qty:18, dob:"2017-04-04"},
  {type:"Bassist",gender:"M",qty:17, dob:"2017-04-04"},
  {type:"Bassist",gender:"F",qty:9, dob:"2017-04-04"}
]};

var ndx  = crossfilter(data.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);

var dateFormat = d3.time.format("%Y-%m-%d");
 data.values.forEach(function(d){
                d.dataparsed = dateFormat.parse(d.dob);
                //console.log(d.dataparsed)
            });


var min = d3.time.year.offset(d3.min(data.values, function(d) { return d.dataparsed;} ),-1);
var max = d3.time.year.offset(d3.max(data.values, function(d) { return d.dataparsed;} ), 1);


var gender = ndx.dimension(function(d){if(d.gender!="") return d.gender; else return 3;});
var genderGroup = gender.group().reduceSum(function(d){return d.qty;});
var genderPie   = dc.pieChart('#gender')
  .innerRadius(10).radius(90)
  .width(250)
  .height(200)
  .dimension(gender)
  .colors(d3.scale.category10())
  .group(genderGroup);


var dob = ndx.dimension(function(d) 
{ 
  console.log(d.dob)
  
  return d.dob});
var dobGroup = dob.group().reduceSum(function(d){return d.qty;});
var dobBar = dc.barChart("#dob")
    .height(200)
    .margins({top: 0, right: 50, bottom: 20, left:40})
    .dimension(dob)
    .group(dobGroup)
    .centerBar(true)
    .gap(1)
    .x(d3.time.scale().domain([min, max]))
    .round(d3.time.year.round)
    .xUnits(d3.time.years);
 
//var typePie   = dc.pieChart("#type").innerRadius(10).radius(90);
dc.renderAll();


</script>

<style>
.clear {clear:both;}

</style>
{/literal}
