* ods _all_ close;
ods html5 file="/tmp/test.html" gpath="/tmp/" style=journal1a;

ods graphics / reset width=6.4in height=4.8in imagemap;


ods layout gridded columns=2;

ods region;
proc sgplot data=SASHELP.HEART;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / datalabel;
	xaxis ;
run;

ods region;
proc odstext;
	p 'Pretty much a standard horizontal barchart from SAS';
run;



ods region;
ods graphics / noborder;

proc sgplot data=SASHELP.HEART ;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / datalabel;
	xaxis ;
run;

ods region;
proc odstext;
	p 'Remove unneccessary outer border';
run;





ods region;
ods graphics / noborder;

proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / datalabel;
	xaxis;
run;

ods region;
proc odstext;
	p 'Remove unneccessary inner border';
run;





ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline datalabel;
	xaxis ;
run;

ods region;
proc odstext;
	p 'Remove the outline around the bars, and change color to something that pops from the background';
run;






ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline;
	yaxistable Smoking_Status / position=left nostatlabel location=inside;
	xaxis ;
run;

ods region;
proc odstext;
	p 'Numbers "on top" of the bars make them appear taller than they actaully are. Put them on the other side of the bars.';
run;



ods layout end;
ods graphics / reset;
title;
footnote2;

ods _all_ close;