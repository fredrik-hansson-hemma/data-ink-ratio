
* ods _all_ close;
ods html5 file="/tmp/can_not_sort.html" gpath="/tmp/" style=daisy; * style=journal1a;
ods graphics / reset width=6.4in height=3in imagemap noborder;
ods layout gridded columns=2;




data work.heart;
	merge	work.summary(where=(_type_=3))
			work.summary(where=(_type_=2));
run;

title1 "Sorting by bar-size works fine...";
title2 "categoryorder=respdesc";

proc sgplot data=sashelp.heart;
	hbar Smoking_Status / categoryorder=respdesc;
	yaxistable Smoking_Status / position=left  location=inside ;
run;


title1 "Sorting groups alphabetically also works fine...";
title2 "grouporder=ascending";
	
proc sgplot data=sashelp.heart;
	hbar Smoking_Status / group=sex grouporder=ascending ;
	yaxistable Smoking_Status / position=left  location=inside ;
run;


title1 "But if we combine the two, groups get ordered by size, not alphabetically";
title2 "categoryorder=respdesc + grouporder=ascending";
proc sgplot data=sashelp.heart;	
	hbar Smoking_Status / group=sex grouporder=ascending categoryorder=respdesc;
	yaxistable Smoking_Status / position=left  location=inside ;
run;










* Solution	;

title1 "The solution is to order data in desired order";
title2 "and then let sgplot use data-order";

proc summary data=sashelp.heart missing completetypes;
   class smoking_status sex;
   types smoking_status smoking_status*sex;
   output out=work.summary ;
run;

	
proc sql;
   create table work.plot as
   select order_data.category_total_freq, plot_data.*
   from work.summary(where=(_type_=3)) as plot_data
      left join
		work.summary(where=(_type_=2) rename=(_FREQ_=category_total_freq)) as order_data
      on plot_data.smoking_status=order_data.smoking_status
   order by order_data.category_total_freq desc, plot_data.sex
   ;
quit;


proc sgplot data=work.plot;
	hbarparm category=Smoking_Status response=_FREQ_ / group=sex;
	yaxistable _FREQ_ / class=sex position=left  location=inside ;
run;



ods layout end;

title;
footnote2;

ods _all_ close;