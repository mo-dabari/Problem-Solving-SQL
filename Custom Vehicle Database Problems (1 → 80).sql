USE VehicleMakesDB;

alter table VehicleDetails 
add constraint FK_VehicleDetail_Make 
foreign key (MakeID)
references Makes (MakeID)

alter table VehicleDetails 
add constraint FK_VehicleDetail_MakeModel 
foreign key (ModelID)
references MakeModels (ModelID)

/*
==============
Problem - 01
==============
- Create Master View
*/

create view VehicleMasterDetails  as 
select 
	VD.ID , VD.MakeID		,	Makes.Make  ,
	VD.ModelID				,	MakeModels.ModelName ,
	VD.SubModelID			,	SubModels.SubModelName ,
	VD.BodyID				,	Bodies.BodyName , 
	VD.Vehicle_Display_Name ,	VD.[Year] ,
	VD.DriveTypeID			,	DriveTypes.DriveTypeName , 
	VD.Engine, VD.Engine_CC	,	VD.Engine_Cylinders , VD.Engine_Liter_Display,
	VD.FuelTypeID			,	FuelTypes.FuelTypeName , VD.NumDoors
from VehicleDetails as VD 
inner join Makes		on VD.MakeID	   = Makes.MakeID
inner join MakeModels	on VD.ModelID	   = MakeModels.ModelID 
inner join SubModels	on VD.SubModelID   = SubModels.SubModelID
inner join Bodies		on VD.BodyID	   = Bodies.BodyID
inner join DriveTypes	on VD.DriveTypeID  = DriveTypes.DriveTypeID
inner join FuelTypes	on VD.FuelTypeID   = FuelTypes.FuelTypeID ;
go
select * from VehicleMasterDetails;
	
/*
==============
Problem - 02
==============
- Get all vehicles made between 1950 and 2000
*/

select * 
from VehicleDetails 
where [year] between 1950 and 2000;

/*
==============
Problem - 03
==============
- Get number vehicles made between 1950 and 2000
*/

select count (*) numberOfVehicles 
from  VehicleDetails 
where [year] between 1950 and 2000;

/*
==============
Problem - 04
==============
-  Get number vehicles made between 1950 and 2000 per make and 
	order them by Number Of Vehicles Descending
*/

select Makes.Make , count(*) as NumberOfVehicles  
from VehicleDetails as VD 
inner join Makes on  VD.MakeID = Makes.MakeID 
where [year] between 1950 and 2000
group by Makes.Make 
order by NumberOfVehicles DESC;

/*
==============
Problem - 05
==============
-  Get All Makes that have manufactured more than 12000 Vehicles 
	in years 1950 to 2000
*/

select Makes.make , count (*) as NumberOfVehicles
from VehicleDetails 
inner join Makes 
on VehicleDetails.MakeID = Makes.MakeID 
and VehicleDetails.[year] between 1950 and 2000
group by makes.Make
having count (*) > 12000
order by NumberOfVehicles DESC;

-- other solution by (Sub Quarry)
select * from 
(
	select Makes.make , count (*) as NumberOfVehicles
	from VehicleDetails 
	inner join Makes 
	on VehicleDetails.MakeID = Makes.MakeID 
	and VehicleDetails.[year] between 1950 and 2000
	group by makes.Make
) as Result
where Result.NumberOfVehicles > 12000
order by Result.NumberOfVehicles DESC

/*
==============
Problem - 06
==============
- Get number of vehicles made between 1950 and 2000 
	per make and add total vehicles column beside
*/

select  Makes.Make , count(*) as NumberOfVehicles , 
(select count(*) from VehicleDetails )  as TotalVehicles
from  VehicleDetails
inner join Makes 
on VehicleDetails.MakeID = Makes.MakeID
and VehicleDetails.Year between 1950 and 2000
group by Makes.Make
order by NumberOfVehicles DESC;

/*
==============
Problem - 07
==============
- Get number of vehicles made between 1950 and 2000 per make and 
	add total vehicles column beside it, then calculate it's percentage.
*/

select * , (cast(NumberOfVehicles as float) / cast(TotalVehicles as float) * 100) as Prec from 
(
	select Makes.Make , count (*) as NumberOfVehicles ,
	(select count (*) from VehicleDetails) as TotalVehicles 
	from VehicleDetails
	inner join Makes
	on VehicleDetails.MakeID = Makes.MakeID
	and VehicleDetails.Year between 1950 and 2000
	group by Makes.Make
) as Result
order by NumberOfVehicles DESC;

/*
==============
Problem - 08
==============
- Get Make, FuelTypeName and Number of Vehicles per FuelType per Make and
	made between 1950 and 2000 per make
*/

select Makes.make , FuelTypes.FuelTypeName , count(*) as NumberOfVehicles
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join FuelTypes  on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
and VehicleDetails.Year between 1950 and 2000
group by Makes.make , FuelTypes.FuelTypeName
order by Makes.make;

/*
==============
Problem - 09
==============
- Get all vehicles that runs with GAS
*/

select VehicleDetails.* , FuelTypes.FuelTypeName 
from VehicleDetails
inner join FuelTypes on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
where FuelTypes.FuelTypeName = 'GAS';

/*
==============
Problem - 10
==============
- Get all Makes that runs with GAS
*/

select distinct Makes.Make , FuelTypes.FuelTypeName
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join FuelTypes on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
where FuelTypes.FuelTypeName = N'GAS'
order by Makes.Make;

/*
==============
Problem - 11
==============
- Get Total Makes that runs with GAS
*/

select count(*) as TotalMakesRunsOnGas  

from 
(
	select distinct Makes.make  
	from  VehicleDetails
	inner join Makes on VehicleDetails.MakeID = Makes.MakeID
	inner join FuelTypes on VehicleDetails.FuelTypeID = FuelTypes.FuelTypeID
	where FuelTypes.FuelTypeName = N'GAS'
) as Result;


/*
==============
Problem - 12
==============
-  Count Vehicles by make and order them by NumberOfVehicles from high to low.
*/

select Makes.Make , COUNT(*) as NumberOfVehicles 
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
group by Makes.Make
order by NumberOfVehicles DESC;


/*
==============
Problem - 13
==============
- Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
*/

select Makes.Make , count(*) as NumberOfVehicles
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
group by Makes.Make
having count(*) > 20000
order by NumberOfVehicles DESC

/*
==============
Problem - 14
==============
- Get all Makes with make starts with 'B'
*/

select Make from Makes 
where make like 'B%'

/*
==============
Problem - 15
==============
- Get all Makes with make ends with 'W'
*/

select Make from Makes 
where Make Like '%W'

/*
==============
Problem - 16
==============
- Get all Makes that manufactures DriveTypeName = FWD
*/

select distinct Makes.make , DriveTypes.DriveTypeName
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join DriveTypes on VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
where DriveTypes.DriveTypeName = N'FWD';

/*
==============
Problem - 17
==============
- Get total Makes that Mantufactures DriveTypeName=FWD
*/

select count(*) MakeWithFWD
	from
	(
		SELECT  distinct Makes.Make, DriveTypes.DriveTypeName
		FROM	DriveTypes 
		INNER JOIN VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID 
		INNER JOIN Makes ON VehicleDetails.MakeID = Makes.MakeID
		Where DriveTypes.DriveTypeName =N'FWD'
	) R1 ;

/*
==============
Problem - 18
==============
- Get total vehicles per DriveTypeName Per Make and 
	order them per make asc then per total Desc
*/

select Makes.Make , DriveTypes.DriveTypeName , count(*) TotalVehicles
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join DriveTypes on VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
group by Makes.Make , DriveTypes.DriveTypeName
order by  Makes.Make asc , TotalVehicles DESC ;

/*
==============
Problem - 19
==============
- Get total vehicles per DriveTypeName Per Make then 
	filter only results with total > 10,000
*/

select Makes.Make , DriveTypes.DriveTypeName , count(*) TotalVehicles
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join DriveTypes on VehicleDetails.DriveTypeID = DriveTypes.DriveTypeID
group by Makes.Make , DriveTypes.DriveTypeName
having count(*) > 10000
order by  Makes.Make asc , TotalVehicles DESC ;

/*
==============
Problem - 20
==============
- Get all Vehicles that number of doors is not specified
*/

select * from VehicleDetails
where NumDoors is null;

/*
==============
Problem - 21
==============
- Get Total Vehicles that number of doors is not specified
*/

select count(*) as TotalWithNoSpecifiedDoors 
from VehicleDetails
where NumDoors is null
/*
==============
Problem - 22
==============
- Get percentage of vehicles that has no doors specified
*/
select 
(
	cast
	(
		(select count (*) as TotalWithNoSpecifiedDoors from VehicleDetails where NumDoors is null) as float
	) 

	/ 
	cast
	(
		(select count (*) as allVe from VehicleDetails) as float
	)  

) * 100 as PercOfNoSpecifiedDoors ;

/*
==============
Problem - 23
==============
- Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'
*/

select distinct Makes.MakeID , Makes.Make , SubModels.SubModelName 
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
inner join SubModels on VehicleDetails.SubModelID = SubModels.SubModelID
and SubModels.SubModelName = N'Elite'

/*
==============
Problem - 24
==============
- Get all vehicles that have Engines > 3 Liters and have only 2 doors
*/

select * 
from VehicleDetails 
where Engine_Liter_Display > 3 and NumDoors = 2 ;

/*
==============
Problem - 25
==============
- Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
*/

select Makes.Make , VehicleDetails.Engine , VehicleDetails.Engine_Cylinders
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
where VehicleDetails.Engine like '%OHV%' and Engine_Cylinders = 4
/*
==============
Problem - 26
==============
- Get all vehicles that their body is 'Sport Utility' and Year > 2020
*/

select VehicleDetails.* ,  Bodies.BodyName 
from VehicleDetails 
inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID
and Bodies.BodyName = N'Sport Utility' 
and VehicleDetails.Year > 2020 ;

/*
==============
Problem - 27
==============
- Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
*/

select VehicleDetails.* ,  Bodies.BodyName 
from VehicleDetails 
inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID
and Bodies.BodyName in ( N'Coupe' , N'Hatchback' , N'Sedan') ;


/*
==============
Problem - 28
==============
- Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and 
	manufactured in year 2008 or 2020 or 2021
*/

select VehicleDetails.* ,  Bodies.BodyName 
from VehicleDetails 
inner join Bodies on VehicleDetails.BodyID = Bodies.BodyID
and Bodies.BodyName in ( N'Coupe' , N'Hatchback' , N'Sedan') 
and VehicleDetails.Year in (2008 , 2020 ,2021);

/*
==============
Problem - 29
==============
- Return found=1 if there is any vehicle made in year 1950
*/
-- Using EXISTS 
select Found = 1 
where  exists
(
	select top(1) * from VehicleDetails where Year = 5
);

-- Other Solution Using TOP(1)
select top(1)  Found = 1  from VehicleDetails
where Year = 5;


/*
==============
Problem - 30
==============
- Get all Vehicle_Display_Name, NumDoors and 
	add extra column to describe number of doors by words, 
	and if door is null display 'Not Set'
*/

select distinct NumDoors from VehicleDetails;

select [Vehicle_Display_Name] , NumDoors ,  DoorDescription = 
case 
	when NumDoors = 0 then 'Zero Doors'
	when NumDoors = 1 then 'One Doors'
	when NumDoors = 2 then 'Two Doors'
	when NumDoors = 3 then 'Three Doors'
	when NumDoors = 4 then 'Four Doors'
	when NumDoors = 5 then 'Five Doors'
	when NumDoors = 6 then 'Six Doors'
	when NumDoors = 8 then 'Eight Doors'
	when NumDoors is Null then 'Not Set'
	else 'Unknown'
end
from VehicleDetails ;

/*
==============
Problem - 31
==============
- Get all Vehicle_Display_Name, year and add extra column to calcuate 
	the age of the car then sort the results by age desc.
*/

select Vehicle_Display_Name ,  year , AgeOFCar = (YEAR(GETDATE()) - YEAR ) 
from VehicleDetails
order by AgeOFCar desc ;


/*
==============
Problem - 32
==============
- Get all Vehicle_Display_Name, year, Age for vehicles that their age 
	between 15 and 25 years old 
*/

select * 
from
(
	select Vehicle_Display_Name ,  year , AgeOFCar = (YEAR(GETDATE()) - YEAR ) 
	from VehicleDetails
) as Result
where Result.AgeOFCar between 15 and 25 ;

/*
==============
Problem - 33
==============
- Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
*/

select 
	MIN(Engine_CC) as  [Minimum Engine CC] ,
	Max(Engine_CC) as  [Maximum Engine CC] ,
	AVG(Engine_CC) as  [Average Engine CC]
from VehicleDetails ;
/*
==============
Problem - 34
==============
- Get all vehicles that have the minimum Engine_CC
*/

select VehicleDetails.Vehicle_Display_Name 
from VehicleDetails
where Engine_CC = (select MIN(Engine_CC) as MinEngineCC from VehicleDetails) ;

/*
==============
Problem - 35
==============
- Get all vehicles that have the Maximum Engine_CC
*/

select VehicleDetails.Vehicle_Display_Name
from VehicleDetails
where Engine_CC = (select MAX(Engine_CC) as MaxEngineCC from VehicleDetails) ;

/*
==============
Problem - 36
==============
- Get all vehicles that have Engin_CC below average
*/

select VehicleDetails.Vehicle_Display_Name
from VehicleDetails
where Engine_CC < (select AVG(Engine_CC) as AverageEngineCC from VehicleDetails) ;

/*
==============
Problem - 37
==============
- Get total vehicles that have Engin_CC above average
*/

select count(*) as NumberOfVehiclesAboveAverageEngineCC 
from
(
	select VehicleDetails.Vehicle_Display_Name
	from VehicleDetails
	where Engine_CC > (select AVG(Engine_CC) as AverageEngineCC from VehicleDetails)
) Result;

/*
==============
Problem - 38
==============
- Get all unique Engin_CC and sort them Desc
*/

select distinct [Engine_CC]
from VehicleDetails
order by [Engine_CC] DESC;


/*
==============
Problem - 39
==============
- Get the maximum 3 Engine CC
*/

select distinct top(3) [Engine_CC]
from VehicleDetails
order by [Engine_CC] DESC;
/*
==============
Problem - 40
==============
- Get all vehicles that has one of the Max 3 Engine CC
*/

select [Vehicle_Display_Name] 
from VehicleDetails
where [Engine_CC] in 
	(
		(
			select distinct top (3) [Engine_CC] 
			from VehicleDetails 
			order by [Engine_CC]  DESC
		)
	);

/*
==============
Problem - 41
==============
- Get all Makes that manufactures one of the Max 3 Engine CC
*/


select distinct Makes.Make 
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
and VehicleDetails.[Engine_CC] in 
	(
		select distinct top 3 [Engine_CC] 
		from VehicleDetails 
		order by [Engine_CC] DESC  
	)
Order By Makes.Make;

/*
==============
Problem - 42
==============
- Get a table of unique Engine_CC and calculate tax per Engine CC
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0
*/

select distinct Engine_CC , Tax = 
case
	when Engine_CC between 0	and 1000 then 100
	when Engine_CC between 1001 and 2000 then 200
	when Engine_CC between 2001 and 4000 then 300
	when Engine_CC between 4001 and 6000 then 400
	when Engine_CC between 6001 and 8000 then 500
	when Engine_CC > 8000				 then 600
	else 0
end
from VehicleDetails
order by Engine_CC;


/*
==============
Problem - 43
==============
- Get Make and Total Number Of Doors Manufactured Per Make
*/

select Makes.Make , sum(NumDoors) as TotalNumberDoors
from VehicleDetails 
inner join Makes on VehicleDetails.MakeID = Makes.MakeID 
group by Makes.Make
Order By TotalNumberDoors desc;

/*
==============
Problem - 44
==============
- Get Total Number Of Doors Manufactured by 'Ford'
*/

--Solution Using (SubQuery) 
select Result.Make , sum(Result.NumDoors)
from (
select Makes.Make  , NumDoors
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
where Makes.Make = N'Ford'
)as Result
group by Result.Make;

-- Other Solution Using (Having)
select Makes.Make , sum(VehicleDetails.NumDoors) 
from VehicleDetails
inner join Makes on VehicleDetails.MakeID = Makes.MakeID
group by Makes.Make
having Makes.Make = N'Ford';

/*
==============
Problem - 45
==============
- Get Number of Models Per Make and order by Number of Models Desc
*/

select Makes.make , count(MakeModels.ModelID) as NumberOfModels
from Makes 
inner join MakeModels on Makes.MakeID = MakeModels.MakeID
group by Makes.Make
order by NumberOfModels Desc;

/*
==============
Problem - 46
==============
- Get the highest 3 manufacturers that make the highest number of models
*/

select top 3 Makes.make , count(MakeModels.ModelID) as NumberOfModels
from Makes 
inner join MakeModels on Makes.MakeID = MakeModels.MakeID
group by Makes.make 
order by NumberOfModels DESC;

/*
==============
Problem - 47
==============
- Get the highest number of models manufactured
*/

select top 1 Makes.Make , count (MakeModels.ModelID) as NumberOfModels
from Makes 
inner join MakeModels on Makes.MakeID = MakeModels.MakeID
group by Makes.Make
Order by NumberOfModels DESC;

/*
==============
Problem - 48
==============
- Get the highest Manufacturers manufactured the highest number of models , 
	remember that they could be more than one manufacturer have 
	the same high number of models
*/

select Makes.Make , count (MakeModels.ModelID) as NumberOfModels
from Makes 
inner join MakeModels on Makes.MakeID = MakeModels.MakeID
group by Makes.Make
having count (*) = 
	(
		select top 1 count(MakeModels.ModelID) as NumberOfModels
		from MakeModels 
		group by  MakeModels.MakeID
		order by NumberOfModels DESC 
	);

/*
==============
Problem - 49
==============
- Get the Lowest Manufacturers manufactured the lowest number of models , 
	remember that they could be more than one manufacturer have 
	the same lowest number of models
*/

select Makes.Make , count(*) as NumberOfModels
from Makes 
inner join MakeModels on Makes.MakeID = MakeModels.MakeID
group by Makes.Make 
having count(*) = 
	(
		select top 1 count(*) as NumberOfModels
		from MakeModels 
		group by MakeID
		order by NumberOfModels
	);

/*
==============
Problem - 50
==============
- Get all Fuel Types , each time the result should be showed in random order
*/	

select * 
from FuelTypes
order by NEWID();


/* Self Referential Queries
======
Note
======
- Restore this simple database first, it contains only one table that represents 
	Employeess and their managers in the same table.
*/

restore database EmployeessDB
from disk = 'C:\EmployeessDB.bak'
use EmployeessDB;

/*
==============
Problem - 51
==============
- Get all Employeess that have manager along with Manager's name.
*/

select Employeess.Name , Employeess.ManagerID , Employeess.Salary , emp.name as ManagerName
from Employeess 
inner join Employeess as emp on Employeess.ManagerID = emp.EmployeesID;

/*
==============
Problem - 52
==============
- Get all Employeess that have manager or does not have manager 
	along with Manager's name, incase no manager name show null
*/

select Employeess.Name , Employeess.ManagerID , Employeess.Salary , emp.name as ManagerName
from Employeess 
left join Employeess as emp on Employeess.ManagerID = emp.EmployeesID;

/*
==============
Problem - 53
==============
- Get all Employeess that have manager or does not have manager 
	along with Manager's name, incase no manager name show null
*/

select Employeess.Name , Employeess.ManagerID , Employeess.Salary , 
ManagerName = 
case 
	when Employeess.ManagerID is null then Employeess.Name
	else Managers.Name
end
from Employeess 
left join Employeess as Managers  on Employeess.ManagerID = Managers .EmployeesID;

/*
==============
Problem - 54
==============
- Get All Employeess managed by 'Mohammed'
*/

select Employeess.Name , Employeess.ManagerID , Employeess.Salary , managers.name
from Employeess 
inner join Employeess as managers on Employeess.ManagerID = managers.EmployeesID
where managers.Name = N'Mohammed';

--------
restore database EmployeessDB
from disk = 'C:\EmployeessDB.bak'
use MyCompany;
/*
==============
Problem - 55
==============
- Display all the Employeess Data.
*/

SELECT *
FROM Employeess;
/*
==============
Problem - 56
==============
- Display the Employees First name, last name, Salary and Department number.
*/

SELECT Fname , Lname , Salary , Dno
FROM Employees
WHERE Dno IS NOT NULL;
/*
==============
Problem - 57
==============
- Display all the projects names, locations and the department which is responsible for it.
*/

SELECT pro.Pname , pro.Plocation , Dep.Dname
FROM Project pro INNER JOIN Departments Dep
ON Dep.Dnum = pro.Dnum;
/*
==============
Problem - 58
==============
- If you know that the company policy is to pay an annual commission for 
	each Employees with specific percent equals 10% of his/her annual salary. 
	Display each Employees full name and his annual commission in an ANNUAL COMM column 
	(alias).
*/

SELECT CONCAT(Fname , ' ' ,Lname ) as [full name] ,salary * 12  * 10 / 100 as [annual comm]
FROM Employeess

/*
==============
Problem - 59
==============
- Display the Employeess Id, name who earns more than 1000 LE monthly.
*/

SELECT SSN , Fname
FROM Employees
WHERE Salary > 1000;

/*
==============
Problem - 60
==============
- Display the Employeess Id, name who earns more than 10000 LE annually.
*/

SELECT SSN , Fname
FROM Employees
WHERE Salary * 12  > 10000

/*
==============
Problem - 61
==============
- Display the names and salaries of the female Employeess
*/

SELECT Fname , salary
FROM Employees
WHERE Sex = 'F'

/*
==============
Problem - 62
==============
- Display each department id, name which is managed by a manager with id equals 968574.
*/

SELECT Dnum [Depart ID] , Dname [Depart Name] , CONCAT(Employees.Fname , ' ' , Employees.Lname ) Manager
FROM Departments 
INNER JOIN Employees ON Employees.SSN = Departments.MGRSSN
And Employees.SSN  = 968574;

/*
==============
Problem - 63
==============
- Display the ids, names and locations of  the projects which are 
	controlled with department 10.
*/

SELECT Pro.Pnumber , Pro.Pname , Pro.Plocation
FROM Project Pro 
INNER JOIN Departments Dep ON Dep.Dnum = Pro.Dnum
And Pro.Dnum IN (10)

/*
==============
Problem - 64
==============
- Get all instructors Names without repetition
*/

SELECT DISTINCT Ins_Name
FROM Instructor;

/*
==============
Problem - 65
==============
- Display instructor Name and Department Name 
	-- Note: display all the instructors if they are attached to a department or not
*/

SELECT Ins.Ins_Name , Dep.Dept_Name
FROM Instructor Ins
LEFT JOIN Department Dep ON Dep.Dept_Id = Ins.Dept_Id;


/*
==============
Problem - 66
==============
- Display student full name and the name of the course he is taking
	-- For only courses which have a grade
*/

SELECT CONCAT(S.St_Fname , ' ' ,S.St_Lname) as [FUll Name] , Co.Crs_Name [Course Name]
FROM Student S
INNER JOIN Stud_Course St_Co ON  S.St_Id = St_Co.St_Id
INNER JOIN Course Co ON Co.Crs_Id = St_Co.Crs_Id
And St_Co.Grade IS NOT NULL
ORDER BY [FUll Name];

/*
==============
Problem - 67
==============
- Display the Department id, name and id and the name of its manager.
*/

SELECT Dnum , Dname , M.SSN [SSN] , M.Fname [Manager Name]
FROM Departments 
INNER JOIN Employees M ON M.SSN = Departments.MGRSSN
/*
==============
Problem - 68
==============
- Display the name of the departments and the name of the projects under its control.
*/

SELECT Dep.Dname [Department Name] , Pro.Pname [Project Name]
FROM Departments Dep 
INNER JOIN Project Pro ON Dep.Dnum = Pro.Dnum
ORDER BY [Department Name]

/*
==============
Problem - 69
==============
- Display the full data about all the dependence associated with the name of 
	the Employees they depend on .
*/

SELECT Depe.ESSN, Depe.Dependent_name, Depe.Sex ,
	CONCAT(YEAR(Depe.Bdate) ,'/' , MONTH(Depe.Bdate) ,'/', DAY(Depe.Bdate)) [Depe_Date],
	CONCAT(Em.Fname , ' ' , Em.Lname) [Emp:Full Name ]

FROM Dependent Depe 
INNER JOIN Employees Em ON Em.SSN = Depe.ESSN
ORDER BY Em.SSN 

/*
==============
Problem - 70
==============
- Display the Id, name and location of the projects in Cairo or Alex city.
*/

SELECT Pnumber , Pname , Plocation
FROM Project
WHERE City IN('Alex' ,'Cairo')
ORDER BY City

/*
==============
Problem - 71
==============
- Display the Projects full data of the projects with a name starting with "a" letter.
*/

SELECT *
FROM Project
WHERE Pname LIKE 'a%' 

/*
==============
Problem - 72
==============
- display all the Employeess in department 30 whose salary from 1000 to 2000 LE monthly
*/

SELECT *
FROM Employees
WHERE Salary BETWEEN 1000 And 2000

/*
==============
Problem - 73
==============
- Retrieve the names of all Employeess in department 10 who work more than 
	or equal 10 hours per week on the "AL Rabwah" project.
*/

SELECT CONCAT(Fname , ' ' ,Lname) [EMP:Full Name] , Hours
FROM Employees 
INNER JOIN Works_for ON Employees.SSN = Works_for.ESSn
INNER JOIN Project ON Project.Pnumber = Works_for.Pno
And Employees.Dno = 10 AND Hours >=10 And Project.Pname = 'AL Rabwah';

/*
==============
Problem - 74
==============
- Retrieve the names of all employees and the names of the projects they are working on, 
	sorted by the project name.
*/

SELECT Fname [First Name] , Lname [Last Name]  , Project.Pname [Project Name]
FROM Employee 
INNER JOIN Works_for ON Employee.SSN = Works_for.ESSn
INNER JOIN Project ON Project.Pnumber = Works_for.Pno
ORDER BY [Project Name]	;

/*
==============
Problem - 75
==============
- For each project located in Cairo City , find the project number, the controlling 
	department name ,the department manager last name ,address and birthdate.
*/

SELECT Pro.Pnumber[Project Number], Dep.Dname [Department], Emp.Lname [Manager],
	Emp.Address [Emp Address ] , CONCAT(YEAR(Emp.Bdate) , '-' , MONTH(Emp.Bdate) , '-' , DAY(Emp.Bdate)) [Emp Birthdate]
FROM Project Pro 
INNER JOIN Departments Dep ON Dep.Dnum = Pro.Dnum
INNER JOIN Employee Emp ON Emp.SSN = Dep.MGRSSN;

/*
==============
Problem - 76
==============
- Try to get the max 2 salaries using subquery
*/

SELECT MAX(Salary) [First Max Salary] , 
	(
		select MAX(Salary) FROM Employee
		WHERE Salary != (SELECT MAX(Salary) FROM Employee )
	) [Second Max Salary]
FROM Employee;

/*
==============
Problem - 77
==============
- For each department-- if its average salary is less than the average salary 
	of all employees display its number, name and number of its employees.
*/

select Dno [Department ID], Departments.Dname [Department Name] , COUNT(SSN) [Count Of Employees In Department]
from Employee
INNER JOIN Departments ON Departments.Dnum = Employee.Dno
WHERE Dno IS NOT NULL
GROUP BY Dno , Departments.Dname
HAVING AVG(Salary) < 
	(
		select AVG(Salary)
		from Employee
	);

/*
==============
Problem - 78
==============
- List the last name of all managers who have no dependents
*/

SELECT Lname , ISNULL(Dependent.Dependent_name , 'Not Found dependent') [Dependent Name]
FROM Employee 
INNER JOIN Departments ON Employee.SSN = Departments.MGRSSN
LEFT OUTER JOIN Dependent ON Employee.SSN = Dependent.ESSN
WHERE Dependent.Dependent_name IS NULL;
/*
==============
Problem - 79
==============
- Get All Employeess managed by 'Mohammed'
*/

SELECT Employee.SSN [Smallest Employee ID], Departments.Dname, Departments.Dnum , Departments.MGRSSN ,
	ISNULL(convert(varchar(50) , [MGRStart Date])  , ' Not Found Date') [Manager Start Date]
FROM Employee
INNER JOIN Departments ON Departments.Dnum = Employee.Dno
WHERE Employee.SSN =  
	(
		Select MIN(Employee.SSN)
		FROM Employee
		WHERE Dno IS NOT NULL;
	)

/*
==============
Problem - 80
==============
- Get All Employeess managed by 'Mohammed'
*/

SELECT Project.Pnumber [Project Number], Dname [Department Name] , Employee.Lname  [Department Nanager Last Name] ,
	Employee.Address  [Address Manager], FORMAT(Employee.Bdate , 'dd-MM-yyy')  [BirthDate Manager]
FROM Departments 
INNER JOIN Project ON Departments.Dnum = Project.Dnum
INNER JOIN Employee ON Employee.SSN = Departments.MGRSSN
WHERE Project.City = 'Cairo';

