libname sasuser "/folders/myfolders/Certprep";

/*unbalanced quotation marks*/

proc print data=sasuser.acities double noobs;
where country='USA';
title'acities dataset';
run;

proc print data=sasuser.acities double noobs;
where country='USA';
title'acities dataset';
run;


/* no RUN statement */

proc print data=sasuser.acities double noobs;
where country='USA';
title'acities dataset';

proc print data=sasuser.acities double noobs;
where country='USA';
title'acities dataset';
run;

/* PUTLOG statement */

data USA UK other;
		set sasuser.acities end=last;
		putlog _n_= country=;
		select(Country);
			when ('USA')  output USA;
			when ('United Kingdom') output UK;
			otherwise output other;			
		end;
		putlog city=$quote75.;
		if last=1 then do;
				putlog 'Last observation';
				putlog _all_;
		end;
run;

%macro print(country=);
proc print data=&country;
title"&country dataset";
run;
%mend print;

%print (Country=USA)
%print (Country=UK)
%print (Country=other)		

		






