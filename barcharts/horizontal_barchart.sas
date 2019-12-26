* ods _all_ close;
ods html5 file="/tmp/test.html" gpath="/tmp/" style=daisy; * style=journal1a;

ods graphics / reset width=6.4in height=3in imagemap;


ods layout gridded columns=2;


/*************/
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



/*******/

ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline;
	yaxistable Smoking_Status / position=left nostatlabel nolabel location=inside;
	xaxis ;
run;

ods region;
proc odstext;
	p 'Numbers "on top" of the bars make them appear taller than they actaully are. Put them on the other side of the bars.';
run;







ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline;
	yaxistable Smoking_Status / position=left nostatlabel location=inside nolabel label="Procedurtid antal minuter (median)";
	xaxis display=(noline) ;
	Yaxis display=(noline noticks);
run;

ods region;
proc odstext;
	p "We don't really need the axes, do we? Remove them!";
run;





ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title height=14pt justify=left "Procedurtid";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline;
	yaxistable Smoking_Status / position=left nostatlabel location=inside nolabel label="Procedurtid antal minuter (median)";
	xaxis display=(noline) label="min" labelpos=right;
	Yaxis display=(noline noticks) labelpos=top;
run;

ods region;
proc odstext;
	p "Move y-axis label to top of y-axis. If x-axis label is a measure, put it in the end of the x-axis.";
	p "Left align main title (optional).";
	p "Now we're done! The rest is optional, and will make the code less genereic.";
run;








ods region;
proc sgplot data=SASHELP.HEART noborder nowall;
	title1 height=14pt justify=left bold "Procedurtid";
	title2 " ";
	title3 " ";
	title4 height=9pt  justify=left "Ablation av" justify=center "Procedurtid antal minuter (median)";
	footnote2 justify=left height=8pt "Diagrambeskrivning: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non iaculis dui, eget molestie ante. Proin suscipit mauris arcu. Etiam placerat in lacus quis molestie. Integer faucibus tincidunt quam, vel aliquet enim pellentesque sit amet.";
	hbar Smoking_Status / fillattrs=(color=CX999999) nooutline;
	yaxistable Smoking_Status / position=left nostatlabel location=inside nolabel label=" ";
	xaxis display=(noline) label="min" labelpos=right label="min";
	Yaxis display=(noline noticks nolabel) labelpos=top;
run;

ods region;
proc odstext;
	p "Use title statements to describe the category variable and the X-axis.";
run;




ods layout end;
ods graphics / reset;
title;
footnote2;

ods _all_ close;