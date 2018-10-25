BU Visualizations!
====================================

Taken from https://github.com/TechToThePeople/civisualize

Create your own visualizations
------------------------------
If you are a developer you can customize or create your extensions with a little knowledge of mysql/crmAPI, d3.js/dc.js and crossfilter. Civisualize basically has two parts

- Extract data from civiCRM
- Display data using dc.js/d3

###For the first part, we are using the following methods

- ####{crmAPI}
  ``{crmAPI entity="OptionValue" option_group_id="14"}``
  
  You can add getstat as a new action on some entities in the api.

- ####{crmSQL}
  We have added a new crmSQL to run a mySQL query. For obvious reasons crmSQL only let you run SELECT queries. You can get your data using any of the following three methods.
  - #####SQL String
    ``{crmSQL sql="SELECT count(*) ... group by ...."}``
   
  - #####SQL File
    ``{crmSQL query="somethingcool"}``
 
    This will fetch the sql query from `/queries/somethingcool.sql`

  - #####JSON Object
    ``{crmSQL json="somethingcooler" cid=4 bla="hello"}``

    This will fetch a json object from `/queries/somethingcooler.json`
    The format of the json is 

    ```javascript
    {  "query":"SELECT * from ABC where id=%1 and bla=%2",
       "params":{  "1":{ "name":"cid",
                         "type":"Integer"},
                   "2":{ "name":"bla",
                         "type":"String"}
                }
    }
    ```
    You can further use {crmRetrieve var="a" name="b" type="Integer"}
    This will assign the POST or GET variable named b into a, which can then be given to {crmSQL}

  #####Optional Arguments
  {crmSQL set="varname"} will assign the result of the sql query to a smarty variable named varname

  #####Return Value
  {crmSQL} returns a json of the following format
  ```javascript
     {"is_error":0,"error":"error_str","values":"Array of objects"}
  ```
  so we primarily use {crmSQL}.values for our visualizations.

- ####{crmReport}
  A 3rd option is to be able to fetch data from a report instance using a {crmReport...}. Eileen has done (most of?) the work already. I think it's on 4.5 

###Display data

The principle is to get the data in a template as a json, and apply dc on it until it looks awesome. You simply have to create a template into `templates/dataviz/Something.tpl`. Once you have the data from the above methods you can apply dc on it, and you can access it from `http://yoursite.org/civicrm/dataviz/something`

To get you started, you can visit http://yoursite.org/civicrm/dataviz/contribute or any of the above mentioned visualizations

This is using the wondefully magic dc, that is a layer of love on the top of d3 and crossfilter. Click on the graphs to filter down. magic, I told you. No matter if you use {crmAPI} or {crmSQL}, you end up with a json and a d3 and dc loaded and ready to rock


In the template, put

```javascript
   <div id="theplacetograph"></div>
   <script>
     var mydata={crmAPI or crmSQL};
    {literal}
    d3("#theplacetograph").selectAll(...).data(mydata.values).domagic(...);
```    

We have also used {crmTitle} function which let you set the title of the page, and a print_filter function that will help you in playing around with crossfilter.

