{crmTitle string="Events Overview"}

<div class="eventsoverview">
    <div id="participants" style="width:100%;">
        <strong>Participants</strong>
        <a class="reset" href="javascript:participantsLine.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <div class="clearfix"></div>
    </div>
</div>

<script>
    'use strict';

    var data = {crmSQL file="events"};

    console.log(URL);

    {literal}

        if(!data.is_error){

            var statusLabel = {};
            data.values.forEach (function(d) {
                statusLabel[d.id] = d.label;
                
            });
           

            var typeLabel = {};
            data.values.forEach (function(d) {
                typeLabel[d.value] = d.label;
                console.log(d.label);
            });
            

            var numberFormat = d3.format(".2f");
            var datetimeFormat = d3.time.format("%Y-%m-%d %H:%M:%S");
            var dateFormat = d3.time.format("%Y-%m-%d");
            var currentDate = new Date();

            var Events={};

            data.values.forEach(function(d){
                d.rd = dateFormat.parse(d.rd);
                d.ed = datetimeFormat.parse(d.ed);
                d.sd = datetimeFormat.parse(d.sd);
                if(d.im==1)
                    d.im='Monetory';
                else
                    d.im='Free';
                if(d.tid!="")
                    d.tid = typeLabel[d.tid];  
                else
                    d.tid = "Unspecified";
                Events[d.id]={'title':d.title,'sd':d.sd,'ed':d.ed};
            });

            console.log(data);
            var participantsLine;

            cj(function($) {

                function print_filter(filter){var f=eval(filter);if(typeof(f.length)!="undefined"){}else{}if(typeof(f.top)!="undefined"){f=f.top(Infinity);}else{}if(typeof(f.dimension)!="undefined"){f=f.dimension(function(d){return "";}).top(Infinity);}else{}console.log(filter+"("+f.length+")="+JSON.stringify(f).replace("[", "[\n\t").replace(/}\,/g, "},\n\t").replace("]", "\n]"));}

                function eventReduceAdd(a,d){
                    if(!a.events[d.id]){
                        a.events[d.id]=d.count;
                        a.eventcount++;
                    }
                    else{
                        a.events[d.id]+=d.count;
                    }
                    a.participantcount+=d.count;
                    return a;
                }

                function eventReduceRemove(a, d) {
                    a.events[d.id]-=d.count;
                    if(a.events[d.id]==0){
                        a.eventcount--;
                    }
                    a.participantcount-=d.count;
                    return a;
                }

                function eventReduceInitial() {
                    var eventlist = {}
                    Object.keys(Events).forEach(function(a){
                        eventlist[a]=0;
                    });
                    return {events:eventlist, eventcount:0, participantcount:0};
                }

                var min = d3.time.month.offset(d3.min(data.values, function(d) { return d.rd;} ),-1);
                var max = d3.time.month.offset(d3.max(data.values, function(d) { return d.ed;} ), 1);

                var firstEvent = d3.min(data.values, function(d) {return d.id});


                var ndx                 = crossfilter(data.values),
                all = ndx.groupAll();

                participantsLine = dc.lineChart("#participants");
              
                
                var registrationMonth = ndx.dimension(function(d) { return d3.time.month(d.rd);});
                var registrationMonthGroup = registrationMonth.group().reduce(eventReduceAdd,eventReduceRemove,eventReduceInitial);



                

              
          
                //Events


                participantsLine
                    .margins({top: 0, right: 50, bottom: 20, left:40})
                    .height(200)
                    .dimension(registrationMonth)
                    .valueAccessor(function (d) {
                        return d.value.events[firstEvent];
                    })
                    .brushOn(false)
                    .x(d3.time.scale().domain([min, max]))
                    .round(d3.time.month.round)
                    .elasticY(true)
                    .elasticX(true)
                    .xUnits(d3.time.months);

                var flag=1;

                Object.keys(Events).forEach(function(a){
                    if(flag==1){
                        participantsLine
                            .group(registrationMonthGroup);
                            flag=2;
                    }   
                    else{
                        if(a!=firstEvent){
                            participantsLine
                                .stack(registrationMonthGroup,Events[a],function(d){return d.value.events[a];})
                                .title(Events[a], function(d) { 
                                    return Events[a]+" "+d.value.events[a]; 
                                });
                        }
                    }
                });

                dc.renderAll();
            });
        }
        else{
            cj('.eventsoverview').html('<div style="color:red; font-size:18px;">Civisualize Error. Please contact Admin.'+data.error+'</div>')
        }
    {/literal}
</script>
<div class="clear"></div>
