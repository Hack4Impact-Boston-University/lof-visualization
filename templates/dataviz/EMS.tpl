{crmTitle title="Here be dragons"}
This is a demo

  <div id="type" class="clear">
      <strong>Musician</strong>
      <a class="reset" href="javascript:sourceRow.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
  </div>
  <div class="clear"></div>
  <div id="gender" style="width:350px;">
      <strong>Gender</strong>
      <a class="reset" href="javascript:genderPie.filterAll();dc.redrawAll();" style="display: none;">reset</a>
      <div class="clearfix"></div>
  </div>

  <div id="trafficking" style="width:600px;">
        <strong>Type of Human Trafficking</strong>
        <a class="reset" href="javascript:trafficPie.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <div class="clearfix"></div>
  </div>
  <div class="clear"></div>


<script>
//var data = {crmSQL sql="SELECT something, somethingelse, count(*) as total from civicrm_table where whatever group by something, somethingelse"};

{literal}
var data = {
is_error:0,
values:[
  {type:"Guitarist",gender:"M",qty:58, trafficking: "Escort SVCs"},
  {type:"Guitarist",gender:"F",qty:19, trafficking: "Escort SVCs"},
  {type:"Violonist",gender:"M",qty:10, trafficking: "Pornography"},
  {type:"Violonist",gender:"F",qty:23, trafficking: "Bars, Strip Clubs and Cantinas"},
  {type:"Pianist",gender:"F",qty:30, trafficking: "Escort SVCs"},
  {type:"Pianist",gender:"F",qty:33, trafficking: "Construction"},
  {type:"Drummer",gender:"M",qty:18, trafficking: "Illicit Massage"},
  {type:"Bassist",gender:"M",qty:17, trafficking: "Residential"},
  {type:"Bassist",gender:"F",qty:9,  trafficking: "Residential"},
  {type:"Trumpeteer",gender:"F",qty:9,  trafficking: "Remote Interactive Sexual Activities"},
  {type:"Trumpeteer",gender:"F",qty:9,  trafficking: "Agricultural and Animal Husbandry"}

]};

var ndx  = crossfilter(data.values)
  , all = ndx.groupAll();

var totalCount = dc.dataCount("#datacount")
      .dimension(ndx)
      .group(all);


var gender = ndx.dimension(function(d){if(d.gender!="") return d.gender; else return 3;});
var genderGroup = gender.group().reduceSum(function(d){return d.qty;});
var genderPie   = dc.pieChart('#gender')
 .innerRadius(10).radius(90)
 .width(250)
  .height(200)
  .dimension(gender)
  .colors(d3.scale.category10())
  .group(genderGroup);
/*
  .label(function(d) {
    if (genderPie.hasFilter() && !genderPie.hasFilter(d.key))
              return d.key + "(0%)";
    return d.key+"(" + Math.floor(d.value / all.reduceSum(function(d) {return d.qty;}).value() * 100) + "%)";;
  });
*/
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


var type = ndx.dimension(function(d) {return d.type;});
var typeGroup= type.group().reduceSum(function(d){return d.qty;});
var typeRow = dc.rowChart('#type')
         .height(200)
          .margins({top: 20, left: 10, right: 10, bottom: 20})
          .dimension(type)
          .cap(5)
          .ordering (function(d) {return d.qty;})
          .colors(d3.scale.category10())
          .group(typeGroup)
          .elasticX(true);

 
//var typePie   = dc.pieChart("#type").innerRadius(10).radius(90);
dc.renderAll();


</script>

<style>
.clear {clear:both;}

</style>
{/literal}
