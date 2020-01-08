/*****************************************************************************************************************

SAS file name: Bar_Chart.sas
File location: 
_________________________________________________________________________________________________________________

Purpose: To demonstrate how to create a simple bar chart in SAS with PROC SGPLOT
Author: Peter Clemmensen
Creation Date: 04/11/2016

This program supports the example page "Bar Chart with PROC SGPLOT" on SASnrd.com

*****************************************************************************************************************/

/* Make sure that ods graphics is on and that the HTML output desitnation is on */
ods graphics on / reset;
ods html style=htmlblue;

/* The simplst vertical bar chart */
proc sgplot data=sashelp.cars;
   vbar type;
run;

/* Horisontal bar chart */
proc sgplot data=sashelp.cars;
   hbar type / colormodel=twocolorramp;
run;

/* Removing chart junk and enhanching the graph */
title "Vertical Bar Chart";
title2 "Mileage By Type";
proc sgplot data=sashelp.cars noborder;
  vbar type / response=mpg_city stat=freq barwidth=0.8 datalabel group=type colorresponse=mpg_city;
  xaxis display=(nolabel noline noticks);
  yaxis display=(noline) grid;
  keylegend / noborder;
  format mpg_city 8.0;
run;
title;