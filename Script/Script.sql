--Script
--> Tao database Meta data
create database MetaData_ChicagoCrime;

create table data_flow
(
 source_id int,
 source_name varchar(30),
 LSET datetime,
 CET datetime
);
--->>Stage
create database Stage_ChicagoCrime;
--Census_Stage
CREATE TABLE [Census_Stage] (
    [Community Area Number] smallint,
    [COMMUNITY AREA NAME] varchar(200),
    [PERCENT OF HOUSING CROWDED] real,
    [PERCENT HOUSEHOLDS BELOW POVERTY] real,
    [PERCENT AGED 16+ UNEMPLOYED] real,
    [PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA] real,
    [PERCENT AGED UNDER 18 OR OVER 64] real,
    [PER CAPITA INCOME] int,
    [HARDSHIP INDEX] smallint
);
-- [FBICode_Stage]
CREATE TABLE [FBICode_Stage] (
    [Code] varchar(5),
    [Categories] varchar(25),
    [Definition] varchar(360)
);
--[DataNull_Stage]

CREATE TABLE [DataNull_Stage] (
    [Case Number] varchar(10),
    [Date] datetime,
    [IUCR] varchar(10),
    [Description] varchar(100),
    [Arrest] bit,
    [Domestic] bit,
    [Community Area] real,
    [Year] smallint,
    [FBI Code] varchar(5),
    [Location] varchar(100),
    [Primary Type] varchar(50)
);

--[Crime_Stage]
CREATE TABLE [Crime_Stage] (
    [Case Number] varchar(10),
    [Date] datetime,
    [IUCR] varchar(10),
    [Description] varchar(100),
    [Arrest] bit,
    [Domestic] bit,
    [Community Area] real,
    [Year] smallint,
    [FBI Code] varchar(5),
    [Location] varchar(100),
    [Primary Type] varchar(50),
    [Location Description] varchar(100)
);
---Truncate stage
truncate table Crime_Stage;
truncate table Census_Stage;
truncate table FBICode_Stage;

----------------
--->>NDS
create database NDS_ChicagoCrime;
-- [FBICode]
CREATE TABLE [FBICode] (
    [Code] varchar(5),
    [Categories] varchar(25),
    [Definition] varchar(360),
    [SourceID] int,
    [FBICodeKey] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
	primary key([FBICodeKey])
);
--[LocationDescription]
CREATE TABLE [LocationDescription] (
    [LocationDescriptionKey] int,
    [Location Description] varchar(100),
    [SourceID] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
	primary key([LocationDescriptionKey])
);
--[IUCR]
CREATE TABLE [IUCR] (
    [IUCRKey] int,
    [IUCR] varchar(10),
    [Description] varchar(100),
    [Primary Type] varchar(50),
    [SourceID] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
	primary key([IUCRKey])
);
--[CommunityArea]
CREATE TABLE [CommunityArea] (
    [CommunityAreaKey] int,
    [Community Area Number] smallint,
    [COMMUNITY AREA NAME] varchar(200),
    [PERCENT OF HOUSING CROWDED] real,
    [PERCENT HOUSEHOLDS BELOW POVERTY] real,
    [PERCENT AGED 16+ UNEMPLOYED] real,
    [PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA] real,
    [PERCENT AGED UNDER 18 OR OVER 64] real,
    [PER CAPITA INCOME] int,
    [HARDSHIP INDEX] smallint,
    [SourceID] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
	primary key ([CommunityAreaKey])
);
--[Crime]
CREATE TABLE [Crime] (
    [Case Number] varchar(10),
    [IUCR] varchar(10),
    [Arrest] bit,
    [Domestic] bit,
    [Community Area] real,
    [Location Description] varchar(100),
    [FBI Code] varchar(5),
    [Date] datetime,
    [Year] smallint,
    [Primary Type] varchar(50),
    [FBICodeKey] int,
    [IUCRKey] int,
    [LocationDescriptionKey] int,
    [Copy of Community Area] smallint,
    [CommunityAreaKey] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
    [SourceID] int,
    [CrimeKey] int,
	primary key ([CrimeKey])
);
---Create foreign key in database NDS_ChicagoCrime

alter table Crime
add constraint fk_Crime_IUCR
foreign key (IUCRKey) 
references IUCR(IUCRKey);
Go
alter table Crime
add constraint fk_Crime_CommunityArea
foreign key (CommunityAreaKey) 
references CommunityArea(CommunityAreaKey);
Go
alter table Crime
add constraint fk_Crime_LocationDescription
foreign key (LocationDescriptionKey) 
references LocationDescription(LocationDescriptionKey);
Go
alter table Crime
add constraint fk_Crime_FBICode
foreign key (FBICodeKey) 
references FBICode(FBICodeKey);



---Truncate NDS_ChicagoCrime
truncate table CommunityArea;
truncate table FBICode;
truncate table IUCR;
truncate table LocationDescription;
truncate table Crime;

---Drop constraint database NDS_ChicagoCrime
alter table Crime
drop constraint fk_Crime_IUCR;
go
alter table Crime
drop constraint fk_Crime_CommunityArea;
go
alter table Crime
drop constraint fk_Crime_LocationDescription;
go
alter table Crime
drop constraint fk_Crime_FBICode;
go

---------------
--->>DDS
create database DDS_ChicagoCrime;
--[Dim_CommunityArea]
CREATE TABLE [Dim_CommunityArea] (
    [CommunityAreaKey] int,
    [Community Area Number] smallint,
    [COMMUNITY AREA NAME] varchar(200),
    [PERCENT OF HOUSING CROWDED] real,
    [PERCENT HOUSEHOLDS BELOW POVERTY] real,
    [PERCENT AGED 16+ UNEMPLOYED] real,
    [PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA] real,
    [PERCENT AGED UNDER 18 OR OVER 64] real,
    [PER CAPITA INCOME] int,
    [HARDSHIP INDEX] smallint,
    [SourceID] int,
    [CreateDate] datetime,
    [UpdateDate] datetime,
	primary key
);
--[Dim_Location]
CREATE TABLE [Dim_Location] (
    [LocationDescriptionKey] int,
    [LocationDescriptionName] varchar(100),
    [SourceID] int,
    [CreatedDate] datetime,
    [UpdatedDate] datetime,
    [CreateDate] datetime,
    [UpdateDate] datetime,
	primary key
);

--[Dim_Date]
CREATE TABLE [Dim_Date] (
    [DateKey] int,
    [Date] datetime,
    [Year] int,
    [DayOfWeek] int,
    [DayOfMonth] int,
    [MonthNumber] int,
	[WeekNumber] int,
	[MonthName] nvarchar(3),
    [SourceID] int,
    [CreateDate] datetime,
    [UpdateDate] datetime,
	primary key([DateKey])
);
--[Dim_FBICode]
CREATE TABLE [Dim_FBICode] (
    [FBICodeKey] int,
    [Code] varchar(5),
    [Categories] varchar(25),
    [Definition] varchar(360),
    [SourceID] int,
    [CreateDate] datetime,
    [UpdateDate] datetime,
	primary key([FBICodeKey])
);

--[Dim_IUCR]
CREATE TABLE [Dim_IUCR] (
    [IUCRKey] int,
    [IUCR] varchar(10),
    [Description] varchar(100),
    [Primary Type] varchar(50),
    [SourceID] int,
    [CreateDate] datetime,
    [UpdateDate] datetime,
	primary key([IUCRKey])
);
--[Fact_Crime]
CREATE TABLE [Fact_Crime] (
    [CrimeKey] int,
    [Case Number] varchar(10),
    [Arrest] bit,
    [Domestic] bit,
    [Date] datetime,
    [FBICodeKey] int,
    [IUCRKey] int,
    [LocationDescriptionKey] int,
    [CommunityAreaKey] int,
    [SourceID] int,
    [Primary Type] varchar(50),
    [DateKey] int,
    [CreateDate] datetime,
    [UpdateDate] datetime,
    [Theft] int,
    [Thefts] bit,
	primary key([CrimeKey])
);


---Truncate DDS_ChicagoCrime
truncate table Dim_CommunityArea;
truncate table Dim_FBICode;
truncate table Dim_IUCR;
truncate table Dim_Location;
truncate table Dim_Date;
truncate table Fact_Crime;

---
---Create foreign key in database DDS_ChicagoCrime
alter table Fact_Crime
add constraint fk_Fact_Crime_Dim_IUCR
foreign key (IUCRKey) 
references Dim_IUCR(IUCRKey);
Go
alter table Fact_Crime
add constraint fk_Fact_Crime_Dim_CommunityArea
foreign key (CommunityAreaKey) 
references Dim_CommunityArea(CommunityAreaKey);
Go
alter table Fact_Crime
add constraint fk_Fact_Crime_Dim_Location
foreign key (LocationDescriptionKey) 
references Dim_Location(LocationDescriptionKey);
Go
alter table Fact_Crime
add constraint fk_Fact_Crime_Dim_FBICode
foreign key (FBICodeKey) 
references Dim_FBICode(FBICodeKey);
Go
alter table Fact_Crime
add constraint fk_Fact_Crime_Dim_Date
foreign key(DateKey)
references Dim_Date(DateKey);





---Drop constraint database DDS_ChicagoCrime
alter table Fact_Crime
drop constraint fk_Fact_Crime_Dim_IUCR;
go
alter table Fact_Crime
drop constraint fk_Fact_Crime_Dim_CommunityArea;
go
alter table Fact_Crime
drop constraint fk_Fact_Crime_Dim_Location;
go
alter table Fact_Crime
drop constraint fk_Fact_Crime_Dim_FBICode;
go
alter table Fact_Crime
drop constraint fk_Fact_Crime_Dim_Date;
go


create view stastic_theft as SELECT [CrimeKey]
      ,f.[Case Number]
      ,f.[Arrest]
      ,f.[Domestic]
      ,f.[FBICodeKey]
      ,f.[IUCRKey]
      ,f.[LocationDescriptionKey]
      ,f.[CommunityAreaKey]
      ,f.[DateKey]
      ,f.[CreateDate]
      ,f.[UpdateDate]
      ,f.[SourceID], 
	  d.MonthName
  FROM [DDS_ChicagoCrime].[dbo].[Fact_Crime] f join Dim_Date d on d.DateKey = f.DateKey  where Theft = 1;