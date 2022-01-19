*Question 1(a & b);
data customer;
	infile '/home/n170599810/my_shared_file_links/yehchingl0/IST3144_Aug2020/PracticalMidTerm_Datasets/Customer.txt';
	input ID LastVisit mmddyy10. Cat $ Pur1 Pur2 Pur3;
	if propcase(Cat) = 'Basic';
	Total = sum(of Pur1-Pur3);
	run;

title 'Total of customer in Basic';
Proc print data=customer;
var ID Total;
format Total dollar8.2;
run;
title;

*Question 1(c);
data customer2018 customer2019;
	infile '/home/n170599810/my_shared_file_links/yehchingl0/IST3144_Aug2020/PracticalMidTerm_Datasets/Customer.txt';
	input ID LastVisit mmddyy10. Cat $ Pur1 Pur2 Pur3;
	if '01jan2018'd <= LastVisit <= '31dec2018'd then output customer2018;
	else if '01jan2019'd <= LastVisit <= '31dec2019'd then output customer2019;
run;

title 'Customer data in 2018';
proc print data=customer2018;
format LastVisit ddmmyy10.;
run;
title;

title 'Customer data in 2019';
proc print data=customer2019;
format LastVisit ddmmyy10.;
run;
title;

*Question 2;
libname test '/home/n170599810/Magdalene/PSAT';
Data test.seminar;
	infile "/home/n170599810/my_shared_file_links/yehchingl0/IST3144_Aug2020/PracticalMidTerm_Datasets/Seminar.dat";
	input @1 FirstName $20.
		  @21 LastName $20.
		  @42 AttendID 4.
		  @47 Phone $13.
		  @61 MPhone $13.
		  @75 CMobile $3.
		  @79 TypeReg $12.
		  @91 Rate 3.
		  @95 Student $3.
		  @99 Workshop $3.; 
	if TypeReg = 'Presenter' AND rate = 450 then Attendees = 'Regular';
	if TypeReg = 'Participant' AND rate = 300 then Attendees = 'Regular';
	if Student = 'Yes' AND rate = 200 then Attendees = 'Regular';
	if TypeReg = 'Presenter' AND rate = 395 then Attendees = 'Early';
	if TypeReg = 'Participant' AND rate = 250 then Attendees = 'Early';
	if Student = 'Yes' AND rate = 150 then Attendees = 'Early';
	Areacode = scan(Mphone, 1, '()');
	if length(Areacode) > 4 then areacode=.;
	if areacode = . then do;
	areacode = scan(Phone, 1, '()');
	end;
	if Student = 'Yes' then flag = 1;
	else flag = 0;
	FirstName = propcase(FirstName);
	LastName = propcase(LastName);
run;

title 'Student attendees';
Proc print data=test.seminar;
var FirstName LastName AttendID;
where flag = 1;
run;
title;

*Question 3;
libname test1 '/home/n170599810/my_shared_file_links/yehchingl0/IST3144_Aug2020/PracticalMidTerm_Datasets';
proc sort data=test1.sales out=pursort;
by gender purchase;
run;

data work.sales1;
  set pursort;
  by gender purchase; 
  if first.gender then PurCount = 0;
  PurCount+Purchase;
  if last.gender;
run;

title 'Purchase Count for each Gender';
proc print data=work.sales1;
  var Gender PurCount;
run;
title;




	