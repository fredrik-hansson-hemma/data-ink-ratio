


* Smoking status som numerisk variabel	;
proc SQL;
	create table smoking_status_distinct as
	select distinct smoking_status
	from sashelp.heart;
quit;


/* example of using the SELECT statement */
data work.smoking_status_translate;
	length smoking_text $30;
	set work.smoking_status_distinct;
	select (Smoking_Status);
	   when ('') do;
			Smoking_Cat=0;
			smoking_text="[missing]";
		end;
	   when ('Non-smoker') do;
	   Smoking_Cat=1;
		smoking_text=Smoking_Status;
		end;
	   when ('Light (1-5)') do;
	   Smoking_Cat=2;
		smoking_text=Smoking_Status;
		end;
	   when ('Moderate (6-15)') do;
	   Smoking_Cat=3;
		smoking_text=Smoking_Status;
		end;
	   when ('Heavy (16-25)') do;
		Smoking_Cat=4;
		smoking_text=Smoking_Status;
	   end;
	   when ('Very Heavy (> 25)') do;
		   Smoking_Cat=5;
			smoking_text=Smoking_Status;
		end;
	   otherwise do;
	   	put "ERROR: Something went wrong";
		end;
	end;
	fmtname="smoking_category";
	infmtname="smoking_to_numeric";
	type="I";
run;

proc format cntlin=work.smoking_status_translate(rename=(Smoking_Cat=start smoking_text=label) drop=type) library=work;
quit;

proc format cntlin=work.smoking_status_translate(rename=(Smoking_Status=start Smoking_Cat=label infmtname=fmtname) drop=fmtname) library=work;
quit;



* Summering per månad och redovisning per en tidsperiod		;
libname produkti "%sysfunc(pathname(WORK))";

* Genererar upp testdata	;
data work.heart;
	length year_month 4;
	set sashelp.heart;
	* Slumpar fram månad och år	;
	year_month  = input(put(rand("Integer", '01NOV2018'd, '28FEB2020'd), yymmn6.),best6.);
	
	attrib smoking_category
		length=3
		format=smoking_category.;
	smoking_category=input(Smoking_Status, smoking_to_numeric.);
run;


* Summerar de intressanta klassvariablerna per år och månad	;
proc summary data=work.heart missing;
	class year_month smoking_category sex;
	var diastolic;
	types	year_month
			year_month*smoking_category
			year_month*sex
			year_month*smoking_category*sex;
	output out=produkti.summerat mean(diastolic)=mean_diastolic; * N=Antal;
run;


proc sort data=produkti.summerat;
	by sex;
run;

data produkti.attrmap;
	length value $100;
	id="attribute_sex";
	
	
	value="Female";
	linecolor="CXdf408f"; fillcolor="CXdf408f";
	textcolor="CXdf408f"; textstyle="italic";
	textweight="normal";
	Show="Attrmap";
	output;
	
	value="Male";
	linecolor="cx7190c9"; fillcolor="cx7190c9";
	textcolor="cx7190c9"; textstyle="normal";
	textweight="normal";
	Show="Attrmap";
	output;
	
run;



********** Slut martprogram	********** ;




********** Start rapport ********** ;
title;
footnote;

%let from=201812;
%let to=202001;


Data work.urval_tid / view=work.urval_tid;
	set work.summerat;
	where year_month between &from and &to;
run;

* ods _all_ close;
ods html5 file="/tmp/test2.html" gpath="/tmp/" style=daisy; * style=journal1a;

ods graphics / reset width=6.4in height=3in imagemap noborder;


ods layout gridded columns=2;


/*************/
ods region;
proc odstext;
	p "Vanligt stapeldiagram.";
run;

ods region;
proc sgplot data=work.urval_tid noborder nowall;
	where _TYPE_=6;
	title1 height=14pt justify=left bold "Rökning";
	title2 " ";
	title3 " ";
	title4 height=9pt  justify=left "Smoking status" justify=center "Antal basregistreringar";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar smoking_category / response=_FREQ_ fillattrs=(color=CX999999) categoryorder=respdesc nooutline;
	yaxistable _FREQ_ / position=left nostatlabel location=inside nolabel label=" ";
	xaxis display=(noline) labelpos=right label="st";
	Yaxis display=(noline noticks nolabel) labelpos=top;
run;





ods region;
proc odstext;
	p "Grupperat efter kön. Tyvärr inte längre sorterad efter längd på stapeln.";
run;

ods region;
proc sgplot data=work.urval_tid noborder nowall  dattrmap=produkti.attrmap;
	where _TYPE_=7;
	title1 height=14pt justify=left bold "Rökning";
	title2 " ";
	title3 " ";
	title4 height=9pt  justify=left "Smoking status" justify=center "Antal basregistreringar";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar smoking_category / group=sex response=_FREQ_ nooutline  attrid=attribute_sex grouporder=ascending;
	yaxistable _FREQ_ / position=left nostatlabel location=inside ; * nolabel label=" ";
	xaxis display=(noline) labelpos=right label="st";
	Yaxis display=(noline noticks nolabel) labelpos=top;
run;
footnote;






ods region;
proc odstext;
	p "Om vi sorterar efter stapelns längd, byter vi även plats på grupperna...";
run;

ods region;
proc sgplot data=work.urval_tid noborder nowall  dattrmap=produkti.attrmap;
	where _TYPE_=7;
	title1 height=14pt justify=left bold "Rökning";
	title2 " ";
	title3 " ";
	title4 height=9pt  justify=left "Smoking status" justify=center "Antal basregistreringar";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar smoking_category / group=sex response=_FREQ_ grouporder=ascending categoryorder=respdesc nooutline  attrid=attribute_sex nozerobars;
	yaxistable _FREQ_ / position=left nostatlabel location=inside ; * nolabel label=" ";
	xaxis display=(noline) labelpos=right label="st";
	Yaxis display=(noline noticks nolabel) labelpos=top;
run;
footnote;





ods layout end;

title;
footnote2;

ods _all_ close;


