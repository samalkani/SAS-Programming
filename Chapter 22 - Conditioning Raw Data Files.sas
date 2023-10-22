%let cert=/folders/myfolders/Certprep;
libname sasuser "&cert";

%let path=/folders/myfolders/ecprg293; 
libname orion "&path";

/* Reading a Detailed Record */

filename census "/folders/myfolders/Certprep/Census.prn";

data sasuser.people;
		infile census;
		retain Address;
		input type $1. @;
		if type='H' then input @3 address $16.;
		if type='P';
		input @3 Name $10. @14 Age 3. @18 Gender $1.;
run;

proc print data=sasuser.people;
title'People Data Set';
run;

/* Dropping variables */

filename census "/folders/myfolders/Certprep/Census.prn";

data sasuser.people (drop=type);
		infile census;
		retain Address;
		input type $1. @;
		if type='H' then input @3 address $16.;
		if type='P';
		input @3 Name $10. @14 Age 3. @18 Gender $1.;
run;

proc print data=sasuser.people;
title'People Data Set - dropping variables';
run;

/* Creating One Observation per Header Record */

data sasuser.residents (drop=type);
		infile census end=last;
		retain Address;
		input type $1. @;
		if type='H' then do;
				if _N_ > 1 then output;
				    Total=0;
				input address $ 3-18;
		end;
		else if type='P' then total+1;
		if last then output;
run;

proc print data=sasuser.residents;
title'Residents Data Set - Creating one observation per record';
run;











