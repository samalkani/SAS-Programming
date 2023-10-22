%let cert=/folders/myfolders/Certprep;
libname sasuser "&cert";

/* Instream data - dataset could not be found */

data sasuser.Carsurvey;
	input Age 1-3 Sex 5-6 Income 8-14 Color $ 16-17;
	datalines;
	19  1   14000  Y
	45  1   65000  G
	72  2   35000  B
	31  1   44000  Y
	58  2   83000  W
	;

proc print data=sasuser.Carsurvey;
title'Car Survey Data Set';
run;

/* Permanently storing formats */

libname library "&cert/Formats";

/* PROC FORMAT - VALUE statement */

proc format library=library;
			value gender
						1='Male'
						2='Female';
			value agegroup
						13 -< 20 = 'Teen'
						20 -< 65 = 'Adult'
						65 - HIGH = 'Senior';
			value $col
						'W' = 'Moon White'
						'B' = 'Sky Blue'
						'Y' = 'Sunburst Yellow'
						'G' = 'Rain Cloud Gray';
run;

/* Applying Temporary User Defined formats in a PROC PRINT step */

proc print data=sasuser.Carsurvey;
format Age agegroup. Sex gender. Income dollar8. Color $col.;
title'Car Survey Data Set with applied formats';
run;

/* Applying Permanent User Defined formats in a DATA step */

data sasuser.Carsurvey1;
			set sasuser.carsurvey;
			format Age agegroup. Sex gender. Income dollar8. Color $col.;
run;

proc contents data=sasuser.carsurvey1;
title 'Applying Permanent User Defined formats in a DATA step';
run;

proc print data=sasuser.Carsurvey1;
title'Car Survey Data Set with Permanent applied formats through a DATA step prior to PROC PRINT step';
run;

proc print data=sasuser.Carsurvey;
title1'Car Survey Data Set with Temporary user defined formats'; 
title2'that have not been applied in the PROC PRINT step';
run;

/* Displaying User-Defined Formats */

libname library "&cert/Formats";
proc format library=library fmtlib;
run;







