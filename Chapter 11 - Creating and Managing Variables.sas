%let cert=/folders/myfolders/Certprep;
libname sasuser "&cert";

/* Sum Statement - Creating an Accumulating variable */

data sasuser.stress1 ;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		SumSec+TotalTime;
run;

proc print data=sasuser.stress1;
title'Stress 1 data set';
run;

/* Using The RETAIN statement to initialize the accumulating variable to something other than zero */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - with SumSec accumulating variable set to an initial value of 5400 seconds';
run;

/* Assigning values Conditionally */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		if totaltime>800 then TestLength='Long';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Assigning the value of Testlength conditionally';
run;

/* Providing an Alternative Action */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;		
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Providing an Alternative Action';
run;

/* Specifying Lengths of Variables */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Specifying Lengths of Variables';
run;

/* Subsetting Data - Deleting observations */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		if resthr<70 then delete;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Deleting observations';
run;

/* Subsetting Data - Selecting Variables - Dropping variables */

data sasuser.stress1R (drop=timemin timesec);
		infile "&cert/tests.dat" obs=8;
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Selecting Variables - Dropping variables ';
run;

data sasuser.stress1R ;
		infile "&cert/tests.dat" obs=8;
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		drop timemin timesec;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Selecting Variables - Dropping variables - DROP STATEMENT - yields same result';
run;

/* Assigning Permanent Labels and Formats */

data sasuser.stress1R ;
		infile "&cert/tests.dat" obs=8;
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		drop timemin timesec;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
		label sumsec='Cumulative Total Seconds (+5,400)';
		format sumsec comma6.;
run;

proc print data=sasuser.stress1R label;
title'Stress 1 data set - Selecting Variables - Permanently assigning formats and labels in a DATA step';
run;

/* Assigning Values Conditionally Using SELECT Groups */

data emps (keep=salary group);
		set sasuser.payrollmaster;
		length group $20;
		select(jobcode);
				when ("FA1") group="Flight Attendant I";
				when ("FA2") group="Flight Attendant II";
				when ("FA3") group="Flight Attendant III";
				when ("ME1") group="Mechanic I";
				when ("ME2") group="Mechanic II";
				when ("ME3") group="Mechanic III";
				when ("NA1") group="Navigator I";
				when ("NA2") group="Navigator II";
				when ("NA3") group="Navigator III";
				when ("PT1") group="Pilot I";
				when ("PT2") group="Pilot II";
				when ("PT3") group="Pilot III";
				when ("TA1","TA2","TA3") group="Ticket Agents";
				otherwise group="Other";
		end;
run;

proc sort data=emps out=emps1;
by group descending salary ;
run;

proc print data=emps1 n='Number of employees N= ' 
grandtotal_label='Total Salary of all Employees = '
sumlabel='Total #byval1 salary = ';
title'Emps Data set - Using Conditional Select Groups';
by group;
id group;
sumby group;
pageby group;
run;

/* Grouping Statements Using DO Groups */

data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8 Message $20;
		if totaltime>800 then 
			do;
				TestLength='Long';
				Message='Run blood Panel';
			end;
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Grouping statements using DO groups';
run;

/* Grouping statements with SELECT groups */


data sasuser.stress1R;
		infile "&cert/tests.dat";
		input ID $ 1-4 Name $ 6-25 RestHR 27-29 MaxHR 31-33 
			  RecHR 35-37 TimeMin 39-40 TimeSec 42-43
			  Tolerance $ 45;
		TotalTime=(timemin*60)+timesec;
		retain SumSec 5400;
		SumSec+TotalTime;
		length TestLength $8 Condition $20 Action $20 Trainer $20;
		if totaltime>800 then TestLength='Long';
		else if 750<=TotalTime<=800 then TestLength='Normal';
		else if TotalTime<750 then TestLength='Short';
		select(Tolerance);
			when ("I") 
					do;
						Condition='Improved';
						Action='None Required';
						Trainer='Not Informed';
					end;			
			when ("D") 
					do;
						Condition='Worsened'; 
						Action='More Exercise Needed';
						Trainer='Informed';
					end;
			otherwise do;
						Condition='Same';
						Action='None Required';
						Trainer='Not Informed';
			end;
		end;		
run;

proc print data=sasuser.stress1R;
title'Stress 1 data set - Grouping statements using DO groups';
run;







				








