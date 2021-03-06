CREATE DATABASE RentCars

Use RentCars

CREATE TABLE CarBrands(
	ID int primary key identity,
	Name nvarchar(100) not null
)

CREATE TABLE CartTips(
	ID int primary key identity,
	Name nvarchar(100) not null
)

CREATE TABLE DrivingLicenseCategories(
	ID int primary key identity,
	Name nvarchar(100) not null
)

CREATE TABLE PaymentMethods(
	ID int primary key identity,
	Name nvarchar(100) not null
)

CREATE TABLE DrivingLicenses(
	ID int primary key identity,
	ValidThru datetime not null,
	DrivingLicenseCategoryID int references DrivingLicenseCategories(ID)
)

CREATE TABLE CarModels(
	ID int primary key identity,
	Name nvarchar(100) not null,
	BrandID int references CarBrands(ID),
	TipID int references CartTips(ID)
)

CREATE TABLE CarStatuses(
	ID int primary key identity,
	Name nvarchar(100) not null
)

CREATE TABLE Cars(
	ID int primary key identity,
	[Year] nvarchar(4) not null,
	Color nvarchar(50) not null,
	Motor int,
	Number nvarchar(50) not null,
	RegisterName nvarchar(100),
	ModelID int references CarModels(ID)
)

ALTER TABLE Cars
ADD IsDelete int

CREATE TABLE Customers(
	ID int primary key identity,
	Name nvarchar(50),
	Surname nvarchar(100),
	Age Int,
	Gender nvarchar(50),
	Adress nvarchar(150),
	Mobile nvarchar(50),
	DrivingLicenseID int references DrivingLicenses(ID)
)

CREATE TABLE Rents(
	ID int primary key identity,
	StartDate datetime,
	EndDate datetime,
	CustomerID int references Customers(ID),
	StatusID int references CarStatuses(ID),
	CarID int references Cars(ID)
)

CREATE TABLE Payments(
	ID int primary key identity,
	Date datetime,
	Amount decimal,
	RentID int references Rents(ID),
	PaymentMethodID int references PaymentMethods(ID)
)

CREATE TABLE RentCars(
	ID int primary key identity,
	StartDate datetime,
	EndDate datetime,
	RentID int references Rents(ID),
	CarID int references Cars(ID)
)

INSERT INTO CarBrands
VALUES	('Toyota'),
		('Mercedes'),
		('Hyundai'),
		('Kia'),
		('Nissan')

EXEC sp_rename  'CartTips' , 'CarTips'

INSERT INTO CarTips
VALUES	('Sedan'),
		('Universal'),
		('Hatchback'),
		('Coupe'),
		('Crossover')

INSERT INTO DrivingLicenseCategories
VALUES	('A'),
		('B'),
		('C'),
		('E'),
		('D'),
		('BC'),
		('BE'),
		('BD'),
		('ABCDE')

INSERT INTO PaymentMethods
VALUES	('Cash'),
		('Checks'),
		('Debit cards'),
		('Credit cards'),
		('Mobile payments'),		
		('Electronic bank transfers')

INSERT INTO DrivingLicenses
VALUES	('2022-12-28', 5),
		('2026-05-27', 2),
		('2023-03-05', 3),
		('2025-01-22', 2),
		('2028-09-19', 5)

INSERT INTO CarModels
VALUES	('Land-Cruiser',1,2),
		('GLS500',2,2),
		('Santafe',3,2),
		('Optima',4,1),
		('Sunny',5,1)

INSERT INTO CarStatuses
VALUES	('Under repair'),
		('In the customer'),
		('is empty')

INSERT INTO Cars
VALUES	('2014','White',4000,'90-DN-445', 'Best-Rent-Cars', 1,0),
		('2022','Black', 6300, '90-OO-570', 'Best-Rent-Cars', 2,0),
		('2008','Black', 3500, '90-SH-903', 'Best-Rent-Cars', 3,0),
		('2014','WHite', 2400, '90-GF-111', 'Heydarov Namik', 4,0),
		('2001','Gray', 1800, '90-TT-777', 'Best-Rent-Cars', 5,0)

INSERT INTO Customers
VALUES	('Namik','Heydarov',34, 'Male', 'Yasamal','0553237227',2),
		('Eli','Aliyev',17, 'Male', 'Bineqedi','0553237227',1),
		('Jale','Gulushova',24, 'FeMale', 'Ehmedli','0553237227',3),
		('Nergiz','Ahmedova',19, 'FeMale', 'Nerimanov','0553237227',4),
		('Aqil','Quliyev',40, 'Male', 'Genclik','0553237227',5)

INSERT INTO Rents
VALUES	('2022-01-28','2022-02-01',6,2,1),
		('2022-01-28','2022-02-01',6,2,2),
		('2022-01-25','2022-01-30',10,2,3),
		('2022-01-28','2022-02-01',7,2,4)


INSERT INTO Payments
VALUES	('2022-01-28',600,3,1),
		('2022-01-28',400,4,2),
		('2022-01-25',250,5,3),
		('2022-01-28',150,6,4)

INSERT INTO RentCars
VALUES	('2022-01-28','2022-02-01',3,1),
		('2022-01-28','2022-02-01',4,2),
		('2022-01-25','2022-01-30',5,3),
		('2022-01-28','2022-02-01',6,4)

--CREATE VIEW v_SelectAllInformationAboutCars
--AS
--SELECT C.ID, Number, CB.Name + ' ' + CM.Name 'Cars', C.Motor, C.Color, [Year], CT.Name, RegisterName, 
--RC.StartDate 'Changed Start Date', RC.EndDate 'Changed End Date', R.StartDate 'In Date', R.EndDate 'Out Date',
--Cus.Name + ' ' + Cus.Surname 'FullName', Cus.Gender, Cus.Adress, Cus.Mobile,
--DLC.Name 'Driving category', DL.ValidThru 'Driving License Valid Thru'
--FROM Cars C
--LEFT JOIN CarModels CM ON CM.ID = C.ModelID
--LEFT JOIN CarBrands CB ON CB.ID = CM.BrandID
--LEFT JOIN CarTips CT ON CT.ID = CM.TipID
--LEFT JOIN RentCars RC ON RC.CarID = C.ID
--LEFT JOIN Rents R ON R.CarID = C.ID
--LEFT JOIN Customers Cus ON Cus.ID = R.CustomerID
--LEFT JOIN DrivingLicenses DL ON DL.ID = Cus.DrivingLicenseID
--Left JOIN DrivingLicenseCategories DLC ON DLC.ID = Dl.DrivingLicenseCategoryID

--CREATE PROCEDURE SelectAllCarsByYear @Motor nvarchar(4), @color nvarchar(50)
--AS
--Begin
--SELECT * FROM Cars Where Motor > @Motor and Color  Like @color
--ENd

--CREATE Function Select_All_Cars()
--returns table
--AS
--Return (SELECT * From Cars)

--CREATE FUNCTION BigMotor(@Color nvarchar(50))
--RETURNS int
--AS
--BEGIN
--	return (SELECT MAX(Motor) from Cars where Color like @Color)
--END

--CREATE FUNCTION CountCars(@ModelID int)
--Returns int
--AS
--Begin
--declare @sumMotors int
--	Select @sumMotors = Count(ModelID) from Cars where ModelID like @ModelID
--	return @sumMotors
--End

--CREATE TRIGGER dbo.myTriggers3 ON Cars
--INSTEAD OF Delete
--AS
--BEGIN
--	Update Cars SET IsDelete = 1 where ID =(select ID from deleted)
--END

--drop trigger dbo.myTriggers3

--CREATE TRIGGER dbo.myTriggers ON Cars
--INSTEAD OF Delete
--AS
--BEGIN
--	Update Cars SET IsDelete = 1 where ID =(select ID from deleted)
--END

SELECT * FROM v_SelectAllInformationAboutCars --custom view ile car info cagirmaq

EXEC SelectAllCarsByYear 4000, 'black' --call my procedure

SELECT * From dbo.Select_All_Cars() --cal my simple function

SELECT dbo.BigMotor('Black') 'max motor' --Big motor with car color

SELECT dbo.CountCars(1) 'Sum Motors' --ModelID ile Avtomobil sayi

DELETE Cars Where ID = 1 --trigger on cars table instead of delete