proc options option=rsasuser;
run;

libname sasuser "/folders/myfolders/Certprep";

/* Simple SAS program using DATA and PROC steps */

data sasuser.admit2;
		set sasuser.admit;
		where age>39;
run;

proc print data=sasuser.admit2;
run;

/* Other procedures */

proc freq data=sashelp.cars;
	table origin*drivetrain;
run;

/* Sorting and managing data - no output but message to log */

proc copy in=sasuser out=work;
		select admit;
run;

options validvarname=v7;