CREATE TABLE State 
(
StateID INT  CONSTRAINT  State_StateID_PkAuto PRIMARY KEY IDENTITY(1,1),
[Name] VARCHAR (25) CONSTRAINT State_Name_NotNull NOT NULL
)

CREATE TABLE City
(
CityID INT CONSTRAINT City_CityID_Pk PRIMARY KEY IDENTITY(1,1),
CityName VARCHAR (25) CONSTRAINT City_CityName_NotNull NOT NULL,
StateID INT CONSTRAINT City_StateID_FkNotNull NOT NULL FOREIGN KEY REFERENCES State(StateID) ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE ConnectionType	
(
TypeID	INT CONSTRAINT  Connection_TypeID_PkAuto PRIMARY KEY IDENTITY(1,1),
Type VARCHAR(30) CONSTRAINT Connection_Type_NotNull NOT NULL
)


CREATE TABLE Customer
(
CustomerID INT CONSTRAINT Customer_CustomerID_PkAuto PRIMARY KEY IDENTITY(1,1),
[Name] VARCHAR (50) CONSTRAINT Customer_NameNull_NotNull NOT NULL,
Make VARCHAR(25) CONSTRAINT Customer_Make_NotNull NOT NULL,
Model VARCHAR(25) CONSTRAINT Customer_Model_NotNull NOT NULL,
ConnectionID INT CONSTRAINT Customer_ConnectionID_FK_NotNull NOT NULL FOREIGN KEY REFERENCES ConnectionType(TypeID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
VehicalNo VARCHAR(17) CONSTRAINT Customer_VehicalNo_NotNull NOT NULL, 
PhoneNumber NUMERIC(10) CONSTRAINT Customer_phonenumber_NotNull_Chk NOT NULL CHECK (PhoneNumber BETWEEN 1000000000 AND 9999999999), 
EmailId VARCHAR(30) CONSTRAINT Customer_Email_Chk CHECK (EmailId LIKE '[a-z,0-9,_,-]%@[a-z]%.[a-z][a-z]%'),
[Address] VARCHAR(100) CONSTRAINT Customer_Address_NotNull NOT NULL,
Pincode NUMERIC(6) CONSTRAINT Customer_Pincode_NotNull NOT NULL,
CityId INT CONSTRAINT Customer_City_FK_NotNull NOT NULL FOREIGN KEY REFERENCES City(CityID) ON DELETE NO ACTION ON UPDATE NO ACTION,
)

CREATE TABLE Status
(
StatusID INT CONSTRAINT Status_StatusID_PkAuto PRIMARY KEY IDENTITY(1,1),
StatusName VARCHAR(30) CONSTRAINT Status_StatusName_NotNull NOT NULL
)

CREATE TABLE Aminities
(
AminityID INT CONSTRAINT Aminities_AminitiesID_PkAuto PRIMARY KEY IDENTITY(1,1),
AminityName VARCHAR(60) CONSTRAINT Aminities_AminityName_NotNull NOT NULL
)

CREATE TABLE ChargingStation
(
StationID INT CONSTRAINT ChargingStation_StationID_PkAuto PRIMARY KEY IDENTITY(1,1),
StationName VARCHAR(50) CONSTRAINT ChargingStation_StationName_NotNull NOT NULL,
[Owner] VARCHAR (50) CONSTRAINT ChargingStation_Owner_NotNull NOT NULL,
StatusID INT CONSTRAINT ChargingStation_StatusID_FK_NotNull FOREIGN KEY REFERENCES Status(StatusID) ON DELETE SET NULL ON UPDATE CASCADE,
Timing VARCHAR(50) CONSTRAINT ChargingStation_Timing_NotNull NOT NULL,
AminityList VARCHAR(50),
[Address] VARCHAR (100) CONSTRAINT ChargingStation_Address_NotNull NOT NULL,
Longitude DECIMAL(10,6) CONSTRAINT ChargingStation_Longitude_NotNull NOT NULL,
Latitude DECIMAL(10,6) CONSTRAINT ChargingStation_Latitude_NotNull NOT NULL,
CityID INT CONSTRAINT ChargingStation_City_FK_NotNull NOT NULL FOREIGN KEY REFERENCES City(CityID) ON DELETE NO ACTION ON UPDATE NO ACTION
)      


        
CREATE TABLE Port   
(
PortID    INT CONSTRAINT Port_PortID_PkAuto PRIMARY KEY IDENTITY(1,1) ,
StationId INT CONSTRAINT Port_StationId_Fk FOREIGN KEY REFERENCES ChargingStation(StationID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
Port_Voltage DECIMAL(6,3)  CONSTRAINT Port_Voltage_NotNull NOT NULL,
ConnectionID INT  CONSTRAINT Connection_Type_Fk_NotNull FOREIGN KEY REFERENCES ConnectionType(TypeID) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
[Availability]  BIT  CONSTRAINT Port_Availability_Chk NOT NULL CHECK ( [Availability] IN (0,1)),
[Chargesper_kwh(Unit)] SMALLMONEY  CONSTRAINT Port_Chargesper_kw_NotNull NOT NULL,
)


CREATE TABLE PaymentMode
(
ID INT CONSTRAINT PaymentMode_ID_Pk PRIMARY KEY IDENTITY(1,1),
Mode VARCHAR(20) CONSTRAINT PaymentMode_Mode_NotNull NOT NULL
)

CREATE TABLE [Session]
(
SessionID INT CONSTRAINT Session_SessionID_PkAuto PRIMARY KEY IDENTITY(1,1),
CustomerID INT CONSTRAINT Session_CustomerID_Fk_NotNull NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID) ON DELETE NO ACTION ON UPDATE NO ACTION,
PortID INT CONSTRAINT Session_PortID_Fk_NotNull NOT NULL FOREIGN KEY REFERENCES [Port](PortID) ON DELETE NO ACTION ON UPDATE NO ACTION,
StartTime DATETIME CONSTRAINT Session_StartTime_NotNull NOT NULL,
EndTime DATETIME CONSTRAINT Session_EndTime_NotNull NOT NULL,
Amount MONEY CONSTRAINT Session_Amount_NotNull NOT NULL,
Units DECIMAL(5,2) CONSTRAINT Session_Units_NotNull NOT NULL,
PaymentID VARCHAR(25) CONSTRAINT Session_PaymentID_DefNull DEFAULT NULL,
PaymentMode INT CONSTRAINT Session_PaymentID_Fk_NotNull NOT NULL FOREIGN KEY REFERENCES PaymentMode(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
[Date] DATETIME CONSTRAINT Session_Date_Default NOT NULL DEFAULT GETDATE()
)

CREATE TABLE Employees
(
EmployeeID INT  CONSTRAINT  Employees_EmployeeID_PkAuto PRIMARY KEY IDENTITY(1,1),
StationID INT CONSTRAINT Employees_ChargingStationID_Fk FOREIGN KEY REFERENCES ChargingStation(StationID) ON DELETE SET NULL ON UPDATE CASCADE,
[Name] VARCHAR(50) CONSTRAINT Employees_Name_NotNull NOT null,
PhoneNumber NUMERIC(10) CONSTRAINT Employees_phonenumber_NotNull_Chk NOT NULL CHECK (PhoneNumber BETWEEN 1000000000 AND 9999999999), 
EmailId VARCHAR(30) CONSTRAINT Employees_Email_Chk CHECK (EmailId LIKE '[a-z,0-9,_,-]%@[a-z]%.[a-z][a-z]%'),
Salary MONEY CONSTRAINT Employees_Salary_NotNull NOT NULL
)

CREATE TABLE Feedback
(
FeedbackID INT CONSTRAINT Feedback_FeedbackID_Pk PRIMARY KEY IDENTITY(1,1),
CustomerID INT CONSTRAINT Feedback_CustomerID_Fk_NotNull NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID) ON DELETE NO ACTION ON UPDATE CASCADE,
StationId INT CONSTRAINT Feedback_StationId_Fk NOT NULL FOREIGN KEY REFERENCES ChargingStation(StationID) ON DELETE CASCADE ON UPDATE CASCADE,
Rating TINYINT CONSTRAINT Feedback_Rating_Chk1to5_NotNull NOT NULL CHECK (Rating >= 1 AND Rating <=5),
Comment VARCHAR(500)
)




INSERT INTO Customer VALUES
('Harsh',1,'WBA3X5C51ED235114',9998885555,'abcs222@gmail.com','Virat Nagar',12,12),
('Jaydeep',2,'5N3AA08A95N863813',8988956234,'csdv55@gmail.com','M.G. Road',1,8),
('Kevin',5,'19XFA1F56BE004421',8787874555,'sdddd455@gmail.com','Market Road',7 ,15),
('Rohit',2,'2MEFM74V87X658365',9879875654,'ughgdf33@gmail.com','S.G. Highway',1,8),
('John',5,'4T1BD1FK7FU102405',7878956520,'gfydhg222@gmail.com','Hospital Road',3,8)


INSERT INTO  ChargingStation VALUES
('KKV','ANIL','KKV ROAD',4,8),
('C2','SHREYASH','RING ROAD',3,8),
('NOVA','Nikhil','CLUB ROAD',2,8),
('MG','Vikas','raiya road',4,8),
('TATA','Raj','university road',1,8)

INSERT INTO Port VALUES
(1,260,5,1,8.4),
(1,260,5,1,8.4),
(1,260,5,1,8.4),
(1,240,2,1,9),
(2,240,2,1,9),
(2,240,2,1,9),
(2,240,5,1,8.5),
(2,260,5,1,8.4),
(3,240,2,1,9),
(3,240,2,1,9),
(3,240,2,1,9),
(3,240,5,1,8.5),
(3,260,5,0,8.4),
(3,240,9,0,7.2),
(4,240,2,1,9),
(4,240,2,0,9),
(4,240,5,0,8.5),
(4,260,5,1,8.4),
(5,240,2,1,9),
(5,240,2,1,9),
(5,240,2,0,9),
(5,240,5,1,8.5),
(5,260,5,0,8.4),
(5,240,9,0,7.2)

INSERT INTO  Employees
VALUES(1,'Virat',9824685963,22000),
    (2,'Umesh',8564293846,20000),
    (3,'Chirag',9654821563,25000),
    (4,'Hardik',9265861573,23000),
    (5,'Ravi',8320046042,24000)
 select * from Employees

INSERT INTO [Session] VALUES
(2,4,'08/01/2021 09:30','08/01/2021 10:30',100,'P134987256LJS',1,'08/01/2021'),
(1,17,'08/01/2021 09:30','08/01/2021 10:30',90,'P134987257LJS',2,'08/01/2021'),
(5,18,'08/12/2021 05:00','08/12/2021 06:00',75,'P134987258LJS',1,'08/12/2021'),
(3,22,'08/14/2021 12:00','08/14/2021 13:30',110,'P134987259LJS',4,'08/14/2021'),
(4,14,'08/27/2021 07:30','08/27/2021 08:30',80,'P134987260LJS',5,'08/27/2021')

INSERT INTO Feedback VALUES
(2,3,5,'Fast charging and good facility'),
(1,4,4,'Good management'),
(5,2,4,'Good experience'),
(3,2,5,'Clean campus,fast charge, good facility'),
(4,5,3,'Good facility but management should be improve')

INSERT INTO City VALUES
('Ahmedabad'),
('Baroda'),
('Surat'),
('Rajkot'),
('Jamnagar'),
('Gandhinagar'),
('Mumbai'),
('New Delhi'),
('Kalkata'),
('Chennai'),
('Pune'),
('Bengaluru'),
('Mysore'),
('Bhopal'),
('Indore'),
('Amritsar'),
('Jalandhar'),
('Chandigarh'),
('Jaypur'),
('Jaisalmer'),
('Jodhpur')

INSERT INTO PaymentMode VALUES ('Credit Card'),('Debit Card'),('Net Banking'),('PayTM'),('UPI'),('Cash')


INSERT INTO  State
VALUES('Andhra Pradesh'),
      ('Arunachal Pradesh'),
	  ('Assam'),
	  ('Bihar'),
	  ('Chhattisgarh'),
	  ('Delhi'),
	  ('Goa'),
	  ('Gujrat'),
	  ('Haryana'),
	  ('Himachal Pradesh'),
	  ('Jharkhand'),
	  ('Karnataka'),
	  ('Kerala'),
	  ('Madhya Pradesh'),
	  ('Maharashtra'),
	  ('Manipur'),
	  ('Meghalaya'),
	  ('Mizoram'),
	  ('Nagaland'),
	  ('Odisha'),
	  ('Punjab'),
	  ('Rajasthan'),
	  ('sikkim'),
	  ('Tamil Nadu'),
	  ('Tripura'),
	  ('Uttar Pradesh'),
	  ('Uttarakhand'),
	  ('West Bengal')
	  
	  
	  INSERT INTO Connection_Type VALUES
		('CCS-1'),
		('CCS-2'),
		('BG/T'),
		('Tesla Charger'),
		('CHAdeMO'),
		('GB/T'),
		('AC TYPE-1'),
		('AC TYPE-2'),
		('AC0001'),
		('AC PLUG POINT')
    