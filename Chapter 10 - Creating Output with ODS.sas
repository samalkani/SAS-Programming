%let cert=/folders/myfolders/Certprep;
libname sasuser "&cert";

/* Closing down multiple ODS destinations at once */

ods html close;

/* Clsong the HTML Destination - to save system resources */

ods html path="%qsysfunc(pathname(work))";

/* Creating output with PROC PRINT */


ods html body="&cert/admit.html";

proc print data=sasuser.admit label;
		var sex age height weight actlevel;
		label actlevel='Activity Level';
run;
ods html close;
ods html path="%qsysfunc(pathname(work))";

/* Creating HTML Output with a Table of Contents */

ods html body="&cert/html_data.html"
		 contents="&cert/html_toc.html"
		 frame="&cert/html_frame.html";
		 

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* Relative URL's - useful for building HTML files that might be moved from one location to the other */
/* The page and body files must be in the same location */

ods html body="&cert/html_data.html" (url='data.html')
		 contents="&cert/html_toc.html" (url='toc.html')
		 frame="&cert/html_frame.html";
		 

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* Absolute URL's - You can specify complete URL's using HTTP. These files can be stored in the 
same or different locations */

ods html body="&cert/html_data.html" 
		(url='http://folders/myfolders/Certprep/HTMLfiles/html_data.html')
		 contents="&cert/html_toc.html" 
		(url='http://folders/myfolders/Certprep/HTMLfiles/html_toc.html')
		 frame="&cert/html_frame.html"
		(url='http://folders/myfolders/Certprep/HTMLfiles/html_frame.html');

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* PATH= option with URL=NONE option */


ods html path="&cert/" (url=none)
		 body="html_data.html"
		 contents="html_toc.html"
		 frame="html_frame.html";
		 

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* PATH= option with no URL option */


ods html path="&cert/" 
		 body="html_data.html"
		 contents="html_toc.html"
		 frame="html_frame.html";
		 

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* PATH= option with specified URL option */


ods html path="&cert/" (url="http://folders/myfolders/Certprep/HTMLfiles")
		 body="html_data.html"
		 contents="html_toc.html"
		 frame="html_frame.html";
		 

proc print data=sasuser.admit (obs=10) label;
		 var id sex age height weight actlevel;
		 label actlevel='Activity Level';
		 title1 'Admit data set';
run;


proc print data=sasuser.stress2 (obs=10);
		var id resthr maxhr rechr;
		title1 'Stress2 data set';
run;

ods html close;
ods html path="%qsysfunc(pathname(work))";

/* Changing the Appearance of HTML output */


proc template;
	list styles/store=sashelp.tmplmst;
run;

/* STYLE= option (Banker Style) */

ods html body="&cert/admit.html"
			style=banker;

proc print data=sasuser.admit label;
		var sex age height weight actlevel;
		label actlevel='Activity Level';
run;
ods html close;
ods html path="%qsysfunc(pathname(work))";


/* Creating PDF Output Using the FILE= Option */

%let cert1=/opt/sasinside/SASHome/SASFoundation/9.4/sashelp;

libname sasuser1 "&cert1";

ods html close;
ods pdf file="&cert/Samplepdf";
		proc freq data=sasuser1.cars;
				tables origin*type;
		run;
ods pdf close;

/* creating a printable table of contents */

ods html close;
title "Create table of contents";
options nodate orientation=landscape;
ods pdf file="&cert/Sample.pdf" contents=yes bookmarklist=hide;

		proc freq data=sasuser1.cars;
				tables origin*type;
		run;
		
		proc print data=sasuser1.cars (obs=15);
		run;
		
ods pdf close;
ods html path="%qsysfunc(pathname(work))";

/* Changing the Appearance of PDF Output */

ods html close;
ods pdf file="&cert/Samplepdf" style=FestivalPrinter;
		proc freq data=sasuser1.cars;
				tables origin*type;
		run;
ods pdf close;

/* Creating RTF Output with ODS */

ods html close;
ods rtf file="&cert/Samplertf" style=FestivalPrinter;
		proc freq data=sasuser1.cars;
				tables origin*type;
		run;
ods rtf close;

/* Customizing Your Excel Output */

%let cert1=/opt/sasinside/SASHome/SASFoundation/9.4/sashelp;

libname sasuser1 "&cert1";

ods excel file="&cert/multitablefinal.xlsx" 
		options(sheet_interval="bygroup"
				suppress_bylines="yes"
				sheet_label="country"
				embedded_titles="yes"
				embed_titles_once="yes");
				
	title "Historical Sales Data";
	proc tabulate data=sasuser1.prdsale;
				by country;
				var predict actual;
				class region division prodtype year;
				table year=[label=' '], 
				region*(division*prodtype all=[label='division total'])
				all=[label='grand total'],
				predict=[label='total predicted sales']*f=dollar10.*sum=[label=' ']
				actual=[label='total actual sales']*f=dollar10.*sum=[label=' '] /
				box=_page_;
	run;
				
		
ods excel close;

/* Customizing ODS Excel Output Using TAGATTR Style Attribute */

ods html close;

data prdsale;
		set sasuser1.prdsale;
		Difference = actual - predict;
run;

proc sort data=prdsale;
		by country region division year;
run;

ods excel file="&cert/tagattr.xlsx";
proc print data=prdsale (obs=15) noobs label split='*';
		id country region division;
var prodtype product quarter month year;
var predict actual /
        style={tagattr='(format:$#,##0_);[Red]/($#,##0/)'};
var difference /
		style={tagattr='(format:$#,##0_); [Red]/($#,##0/) formula: RC[-1]-RC[-2]'};
sum predict actual difference / 
		style={tagattr='(format:$#,##0_); [Red]/($#,##0/)'};
label prodtype='Product*Type'
	  predict='Predicted*Sales*For Area'
	  actual='Áctual*Sales*Amount';
run;
ods excel close;
ods html path="%qsysfunc(pathname(work))";

/* Applying a Style Sheet to Excel Output */

%let cert=/folders/myfolders/Certprep;
libname sasuser "&cert";

%let cert1=/opt/sasinside/SASHome/SASFoundation/9.4/sashelp;
libname sasuser1 "&cert1";

ods html close;
ods excel file="&cert/ExcelAnchorCss.xlsx";
				cssstyle="&cert/Stylesheet.css"
				options(sheet_interval="none");
ods excel anchor="expense";
proc print data=sasuser1.class;
run;

ods excel anchor="reports" cssstyle="&cert/Stylesheet.css";
proc print data=sasuser1.class;
run;

ods excel close;
ods html path="%qsysfunc(pathname(work))";







