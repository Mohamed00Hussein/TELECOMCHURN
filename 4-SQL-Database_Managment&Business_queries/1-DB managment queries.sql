--------------------------------- DB managment queries -----------------------------

--    3 stored procuders * the 5 tables
-- first s.p for insert&update
-- second s.p to delete
-- third s.p to rerieve data from table


use telecomchurn;
go
-- Churn CRUD Procudre

-- new churn
create PROCEDURE New_Churn
(
    @ChurnID int,
    @ChurnCategory Varchar(300),
    @ChurnReason Varchar(300)
    
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM churn
        WHERE churn_id = @ChurnID
    )
    BEGIN
        UPDATE churn set churn_reason=@ChurnReason, churn_category=@ChurnCategory
        WHERE churn_id = @ChurnID
    END
ELSE
    BEGIN
        INSERT into churn 
        Values (@ChurnID , @ChurnCategory , @ChurnReason)
    END
END
go
-- New_churn 21 , '1 2' , ' 12'

-- select * from churn

-- Delete churn
Create PROCEDURE Delete_Churn
(
    @ChurnID int
)
AS
delete from churn
where churn_id = @ChurnID

go
Delete_Churn 21
go
-- Get All Churns
create PROCEDURE Get_All_Churns
AS
select * from churn
GO
Get_All_Churns
GO
-- Get Category Churns
create PROCEDURE Get_Category_Churns @Category VARCHAR(300)
AS
select * 
from churn 
where churn_category like '%' + @Category + '%'
GO
Get_Category_Churns 'ice'

------------------------------------- Location ---------------------------------

-- Churn CRUD Procudre

-- new Location
go
create PROCEDURE New_Location
(
    @ZipCode int,
    @City Varchar(100),
    @latitude decimal(12,9),
    @longitude decimal(12,9),
    @population int
    
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [location]
        WHERE zip_code = @ZipCode
    )
    BEGIN
        UPDATE [location] 
        set city=@City,
         latitude=@latitude,
         longitude=@longitude,
         population=@population
        WHERE zip_code = @ZipCode
    END
ELSE
    BEGIN
        INSERT into [location] 
        Values (@ZipCode , @City , @latitude , @longitude , @population)
    END
END
go
-- New_Location 21 , '1 2' , ' 12' , '12' , 60

-- select * from location

-- Delete Location
Create PROCEDURE Delete_Location
(
    @locationID int
)
AS
delete from [location]
where zip_code = @locationID

go
Delete_Location 21
go
-- Get All Locations
create PROCEDURE Get_All_Locations
AS
select * from [location]
GO
Get_All_Locations
GO
-- Get City Locations
create PROCEDURE Get_City_Locations @City VARCHAR(300)
AS
select * 
from [location] 
where city like '%' + @City + '%'
GO
Get_City_Locations 'angeles'
go

------------------------------------- Customer ---------------------------------

-- Customer CRUD Procudre

-- new Customer
go
create PROCEDURE New_Customer
(
    @Customer_Id varchar(50),
    @Age int,
    @Gender varchar(50),
    @Dependents int,
    @Married varchar(50),
    @ZipCode int
    
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [customer]
        WHERE [customer id] = @Customer_Id
    )
    BEGIN
        UPDATE [customer] 
        set age = @Age,
         gender = @Gender,
         dependents = @Dependents,
         married = @Married,
         [zip code] = @ZipCode
        WHERE [customer id] = @Customer_Id
    END
ELSE
    BEGIN
        INSERT into [customer] 
        Values (@Customer_Id , @Age , @Gender, @Dependents , @Married , @ZipCode)
    END
END
go
-- New_Customer 21 , 1 , ' 12' , 1 ,  '12' , 90002
-- select * from location

-- Delete Customer
Create PROCEDURE Delete_Customer
(
    @CustomerID VARCHAR(50)
)
AS
delete from [customer]
where [customer id] = @CustomerID

go
Delete_Customer 21
go
-- Get All Customers
create PROCEDURE Get_All_Customers
AS
select * from [customer]
GO
Get_All_Customers
GO
-- Get City Customers 
create PROCEDURE Get_City_Customers @City VARCHAR(300)
AS
select  s.[customer id] , s.age , s.dependents , s.gender , s.married , l.city 
from [customer]  s , [location] l
where s.[zip code] = l.zip_code and city like '%' + @City + '%'
GO
Get_City_Customers 'angeles'
go

------------------------------------- Status ---------------------------------

-- Status CRUD Procudre

-- new Status
go
create PROCEDURE New_Status
(
    @churnId int,
    @CustomerID varchar(50),
    @TotalRefunds float,
    @TotalCharge float,
    @TotalRevenue float,
    @PaperlessBilling varchar(50),
    @TotalLongDistance float,
    @TotalExtraDataCharges int,
    @Contract varchar(100),
    @TenutreMonths int,
    @NOReferrals int,
    @MonthlyCharges float,
    @PaymentMethod varchar(100),
    @CustomerStatus varchar(100),
    @AverageMonthlyGBDownload int 
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [status]
        WHERE [customer_id] = @CustomerID
    )
    BEGIN
        UPDATE [status] 
        set churn_id = @churnId,
         total_refunds = @TotalRefunds,
         total_charges = @TotalCharge,
         total_revenue = @TotalRevenue,
         paperless_billing = @PaperlessBilling,
         total_longdistance = @TotalLongDistance,
         total_extradatacharges = @TotalExtraDataCharges,
         [contract] = @Contract,
         tenure_months = @TenutreMonths,
         no_referrals = @NOReferrals,
         monthly_charges = @MonthlyCharges,
         payment_method = @PaymentMethod,
         customer_status = @CustomerStatus,
         [Avg Monthly GB Download] = @AverageMonthlyGBDownload
        WHERE customer_id = @CustomerID
    END
ELSE
    BEGIN
        INSERT into [status] 
        Values (
            @churnId,
            @CustomerID,
            @TotalRefunds,
            @TotalCharge,
            @TotalRevenue,
            @PaperlessBilling,
            @TotalLongDistance,
            @TotalExtraDataCharges,
            @Contract,
            @TenutreMonths,
            @NOReferrals,
            @MonthlyCharges,
            @PaymentMethod,
            @CustomerStatus,
            @AverageMonthlyGBDownload
        )
    END
END
go
New_Status null,	'0002-ORFBO',	0,	593.3	,974.81,	Yes,	381.51,	0,	'One Year',	9,	2	,65.6,	'Credit Card',	'Stayed',	16
-- select * from status where customer_id =  '0002-ORFBO'
GO
-- Delete Status
Create PROCEDURE Delete_Status
(
    @CustomerID VARCHAR(50)
)
AS
delete from [status]
where customer_id = @CustomerID

go
Delete_Customer 21
go
-- Get All Status
create PROCEDURE Get_All_Status
AS
select * from [status]
GO
Get_All_Status
GO

-- Get Churn Reason Status 
create PROCEDURE Get_Churn_Reason_Status @Churn_Reason VARCHAR(300)
AS
select  s.* , c.churn_reason
from [status]  s , [churn] c
where s.churn_id = c.churn_id and c.churn_reason like '%' + @Churn_Reason + '%'
GO
Get_Churn_Reason_Status 'price'
go

-- Get Churn Category Status 
create PROCEDURE Get_Churn_Category_Status @Churn_Category VARCHAR(300)
AS
select  s.* , c.churn_category
from [status]  s , [churn] c
where s.churn_id = c.churn_id and c.churn_category like '%' + @Churn_Category + '%'
GO
Get_Churn_Category_Status 'price'
go

------------------------------------- Service ---------------------------------

-- Service CRUD Procudre

-- new Service
go
create PROCEDURE New_Service
(
    @MultipleLines varchar(50),
    @InternetService varchar(50),
    @InternetType varchar(50),
    @OnlineSecurity varchar(50),
    @OnlineBackup varchar(50),
    @ProtectionPLane varchar(50),
    @UnlimitedData varchar(50),
    @PhoneService varchar(50),
    @StreamingTv varchar(50),
    @StreamingMovies varchar(50),
    @StreamingMusic varchar(50),
    @PermiumTecSupport varchar(50),
    @Offer varchar(50),
    @CustomerID varchar(50)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [service]
        WHERE [customer id] = @CustomerID
    )
    BEGIN
        UPDATE [service] 
        set [multipule lines] = @MultipleLines,
         internet_service = @InternetService,
         internet_type = @InternetType,
         online_security = @OnlineSecurity,
         online_backup = @OnlineBackup,
         protection_plan = @ProtectionPLane,
         unlimited_data = @UnlimitedData,
         phone_service = @PhoneService,
         streaming_tv = @StreamingTv,
         streaming_movies = @StreamingMovies,
         streaming_music = @StreamingMusic,
         permium_tecsupport = @PermiumTecSupport,
         offer = @Offer
        WHERE [customer id] = @CustomerID
    END
ELSE
    BEGIN
        INSERT into [service] 
        Values (
        @MultipleLines,
        @InternetService,
        @InternetType,
        @OnlineSecurity,
        @OnlineBackup,
        @ProtectionPLane,
        @UnlimitedData,
        @PhoneService,
        @StreamingTv,
        @StreamingMovies,
        @StreamingMusic,
        @PermiumTecSupport,
        @Offer,
        @CustomerID
        )
    END
END
go
-- New_Service 'No',	'Yes',	'Cable',	'No',	'Yes',	'No',	'Yes',	'Yes',	'Yes',	'No',	'No',	'Yes',	'None',	'0002-ORFBO'
-- select * from status where customer_id =  '0002-ORFBO'

-- Delete Service
Create PROCEDURE Delete_Service
(
    @CustomerID VARCHAR(50)
)
AS
delete from [service]
where [customer id] = @CustomerID

go

-- Get All Services
create PROCEDURE Get_All_Services
AS
select * from [service]
GO
Get_All_Status
GO

-- Get City Services 
create PROCEDURE Get_City_Service @City VARCHAR(300)
AS
select  s.* , l.city
from [service]  s , [location] l , customer c
where s.[customer id] = c.[customer id]  and c.[zip code] = l.zip_code  and l.city like '%' + @City + '%'
GO
Get_City_Service 'ang'
go

-------------------------------------------------------------------------------------

--------------------------------- audit table ---------------------------------------
--Churn Audit table
 Create table Telecom_Churn_Audit_table
(
    TransactionID int not null IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(50),
    ModifiedDate date,
    Details varchar(1000),
    Note varchar(50)
)

go

-------------------------------------------------------------------------------------
--------------------------------- Trigers ---------------------------------------

--    3 Trigers * the 5 tables
-- first Triger for Update
-- second Insert to delete
-- third Delete to rerieve data from table

-- Churn Trigers

-- Churn Update Triger
create TRIGGER ChurnUpdateTriger
ON churn
AFTER UPDATE
AS
DECLARE @OldData varchar(500) , @NewData  varchar(500)
SELECT @OldData = 
'ChurnID = ' +  cast(churn_id as varchar(50))+  
' , ChurnCategory = ' +  churn_category +
' , ChurnReason = ' + churn_reason 
FROM DELETED
SELECT @NewData =  
'ChurnID = ' +  cast(churn_id as varchar(50))+  
' , ChurnCategory = ' +  churn_category +
' , ChurnReason = ' + churn_reason 
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Update Churn : Old Data  : {' +  @OldData  + '} , New Data : {' + @NewData  + '}}',
'Churn Updated'
)

go
-- Churn Insert Triger
create TRIGGER ChurnInsertTriger
ON churn
AFTER Insert
AS
DECLARE  @NewData  varchar(500)
SELECT @NewData =
'ChurnID = ' +  cast(churn_id as varchar(50))+  
' , ChurnCategory = ' +  churn_category +
' , ChurnReason = ' + churn_reason 
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Insert Churn :  Data : {' + @NewData  + '}}',
'Churn Inserted'
)

GO
New_churn 22 , ' d ' , ' '
go
select * from Telecom_Churn_Audit_table
go
-- Churn Delete Triger
create TRIGGER ChurnDeleteTriger
ON churn
AFTER Delete
AS
DECLARE  @OldData  varchar(500)
SELECT @OldData = 
'ChurnID = ' +  cast(churn_id as varchar(50))+  
' , ChurnCategory = ' +  churn_category +
' , ChurnReason = ' + churn_reason 
FROM DELETED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Delete Churn : { Data : {' + @OldData  + '}} }',
'Churn Deleted'
)

Delete_Churn 22

select * from Telecom_Churn_Audit_table

-----------------------

-- Location Trigers
go
-- Location Update Triger
create TRIGGER LocationUpdateTriger
ON location
AFTER UPDATE
AS
DECLARE @OldData varchar(500) , @NewData  varchar(500)
SELECT @OldData = 
'LocationZipCode : ' +  CAST(zip_code as varchar(50)) +  
' , LocationCity : ' +  city +
' , LocationLongitude : ' +  CAST([longitude] as varchar(50))+
' , LocationLatitude : ' +  CAST(latitude as varchar(50))+
' , LocationPopulation : ' + CAST(population as varchar(50))
FROM DELETED
SELECT @NewData =  
'LocationZipCode : ' +  CAST(zip_code as varchar(50)) +  
' , LocationCity : ' +  city +
' , LocationLongitude : ' +  CAST([longitude] as varchar(50))+
' , LocationLatitude : ' +  CAST(latitude as varchar(50))+
' , LocationPopulation : ' + CAST(population as varchar(50))
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Update Location : Old Data  : {' +  @OldData  + '} , New Data : {' + @NewData  + '}}',
'Location Updates'
)

New_Location 50 , '' , 50.50 , -50.50 , 50
select * from Telecom_Churn_Audit_table
use telecomchurn
go
-- Location Insert Triger
Create TRIGGER LocationInsertTriger
ON location
AFTER Insert
AS
DECLARE  @NewData  varchar(500)
SELECT @NewData =  
'LocationZipCode : ' +  CAST(zip_code as varchar(50)) +  
' , LocationCity : ' +  city +
' , LocationLongitude : ' +  CAST([longitude] as varchar(50))+
' , LocationLatitude : ' +  CAST(latitude as varchar(50))+
' , LocationPopulation : ' + CAST(population as varchar(50))
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Insert Location :  Data : {' + @NewData  + '}}',
'Location Inserted'
)

GO
New_Location 70 , '' , 50.50 , -50.50 , 50
go
select * from Telecom_Churn_Audit_table
go
-- Location Delete Triger
create TRIGGER LocationDeleteTriger
ON location
AFTER Delete
AS
DECLARE  @OldData  varchar(500)
SELECT @OldData = 
'LocationZipCode : ' +  CAST(zip_code as varchar(50)) +  
' , LocationCity : ' +  city +
' , LocationLongitude : ' +  CAST([longitude] as varchar(50))+
' , LocationLatitude : ' +  CAST(latitude as varchar(50))+
' , LocationPopulation : ' + CAST(population as varchar(50))
FROM DELETED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Delete Location : { Data : {' + @OldData  + '}} }',
'Location Deleted'
)
go
Delete_Location 50
go
select * from Telecom_Churn_Audit_table

------------------------------------------ 

-- Customer Trigers
go
-- Location Update Triger
create TRIGGER CustomerUpdateTriger
ON Customer
AFTER UPDATE
AS
DECLARE @OldData varchar(500) , @NewData  varchar(500)
SELECT @OldData = 
' CustomerID : ' +  [customer id] +  
' , Age : ' +  CAST([age] as varchar(50)) +
' , Gender: ' +  gender +
' , Dependents : ' +  CAST(dependents as varchar(50))+
' , Married : ' +  married+
' , LocationID : ' + CAST([zip code] as varchar(50))
FROM DELETED
SELECT @NewData =  
' CustomerID : ' +  [customer id] +  
' , Age : ' +  CAST([age] as varchar(50)) +
' , Gender: ' +  gender +
' , Dependents : ' +  CAST(dependents as varchar(50))+
' , Married : ' +  married+
' , LocationID : ' + CAST([zip code] as varchar(50))
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Update Customer : Old Data  : {' +  @OldData  + '} , New Data : {' + @NewData  + '}}',
'Customer Updates'
)
GO
New_Customer 60 , 50 , '50' , 2 , '50' ,90001 
go
select * from location
select * from Telecom_Churn_Audit_table
use telecomchurn
go
-- Customer Insert Triger
Create TRIGGER CustomerInsertTriger
ON Customer
AFTER Insert
AS
DECLARE  @NewData  varchar(500)
SELECT @NewData =  
' CustomerID : ' +  [customer id] +  
' , Age : ' +  CAST([age] as varchar(50)) +
' , Gender: ' +  gender +
' , Dependents : ' +  CAST(dependents as varchar(50))+
' , Married : ' +  married+
' , LocationID : ' + CAST([zip code] as varchar(50))
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Insert Customer :  Data : {' + @NewData  + '}}',
'Customer Inserted'
)

GO
New_Location 70 , '' , 50.50 , -50.50 , 50
go
select * from Telecom_Churn_Audit_table
go
-- Customer Delete Triger
create TRIGGER CustomerDeleteTriger
ON Customer
AFTER Delete
AS
DECLARE  @OldData  varchar(500)
SELECT @OldData = 
' CustomerID : ' +  [customer id] +  
' , Age : ' +  CAST([age] as varchar(50)) +
' , Gender: ' +  gender +
' , Dependents : ' +  CAST(dependents as varchar(50))+
' , Married : ' +  married+
' , LocationID : ' + CAST([zip code] as varchar(50))
FROM DELETED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Delete Customer : { Data : {' + @OldData  + '}} }',
'Customer Deleted'
)
go
Delete_Customer 60
go
select * from Telecom_Churn_Audit_table

------------------------------------------ 

-- Status Trigers
go
-- Status Update Triger
create TRIGGER StatusUpdateTriger
ON Status
AFTER UPDATE
AS
DECLARE @OldData varchar(1000) , @NewData  varchar(1000)
SELECT @OldData = 
' ChurnID : ' +  cast(ISNULL( [churn_id] , 21)  as varchar(50))+  
' , CustomerID : ' +  [customer_id] +  
' , TotalRefunds : ' +  STR([total_refunds], 25, 5)  +  
' , TotalCharges : ' +   STR([total_charges], 25, 5) +  
' , TotalRevenue : ' +  STR([total_revenue], 25, 5) +  
' , PAperlessBilling : ' +  [paperless_billing] +  
' , TotalLongDistance : ' +  STR([total_longdistance], 25, 5)  +  
' , TotalExtraDataCharges : ' +  cast( [total_extradatacharges] as varchar(50)) +  
' , Contract : ' +  [contract] +  
' , TenureMonths : ' +  cast( [tenure_months] as varchar(50)) +  
' , NoReferrals : ' +  cast([no_referrals] as varchar(50)) +  
' , MonthlyCharges : ' + STR([monthly_charges], 25, 5) +  
' , PaymentMethod : ' +  [payment_method] +  
' , CustomerStatus : ' +  [customer_status] +  
' , AvgMonthlyGBDownload] : ' +  cast([Avg Monthly GB Download] as varchar(50))  
FROM DELETED
SELECT @NewData =  
' ChurnID : ' +  cast(ISNULL( [churn_id] , 21)  as varchar(50))+  
' , CustomerID : ' +  [customer_id] +  
' , TotalRefunds : ' +  STR([total_refunds], 25, 5)  +  
' , TotalCharges : ' +   STR([total_charges], 25, 5) +  
' , TotalRevenue : ' +  STR([total_revenue], 25, 5) +  
' , PAperlessBilling : ' +  [paperless_billing] +  
' , TotalLongDistance : ' +  STR([total_longdistance], 25, 5)  +  
' , TotalExtraDataCharges : ' +  cast( [total_extradatacharges] as varchar(50)) +  
' , Contract : ' +  [contract] +  
' , TenureMonths : ' +  cast( [tenure_months] as varchar(50)) +  
' , NoReferrals : ' +  cast([no_referrals] as varchar(50)) +  
' , MonthlyCharges : ' + STR([monthly_charges], 25, 5) +  
' , PaymentMethod : ' +  [payment_method] +  
' , CustomerStatus : ' +  [customer_status] +  
' , AvgMonthlyGBDownload] : ' +  cast([Avg Monthly GB Download] as varchar(50))  
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Update Status : Old Data  : {' +  @OldData  + '} , New Data : {' + @NewData  + '}}',
'Status Updated'
)
GO
select * from location
select * from Telecom_Churn_Audit_table
use telecomchurn
go
-- Status Insert Triger
create TRIGGER StatusInsertTriger
ON Status
AFTER Insert
AS
DECLARE  @NewData  varchar(1000)
SELECT @NewData =  
' ChurnID : ' +  cast(ISNULL( [churn_id] , 21)  as varchar(50))+  
' , CustomerID : ' +  [customer_id] +  
' , TotalRefunds : ' +  cast( [total_refunds] as varchar(50)) +  
' , TotalCharges : ' +   cast( [total_charges] as varchar(50))+  
' , TotalRevenue : ' +  cast( [total_revenue] as varchar(50)) +  
' , PAperlessBilling : ' +  [paperless_billing] +  
' , TotalLongDistance : ' +  cast( [total_longdistance] as varchar(50)) +  
' , TotalExtraDataCharges : ' +  cast( [total_extradatacharges] as varchar(50)) +  
' , Contract : ' +  [contract] +  
' , TenureMonths : ' +  cast( [tenure_months] as varchar(50)) +  
' , NoReferrals : ' +  cast([no_referrals] as varchar(50)) +  
' , MonthlyCharges : ' +  cast([monthly_charges] as varchar(50)) +  
' , PaymentMethod : ' +  [payment_method] +  
' , CustomerStatus : ' +  [customer_status] +  
' , AvgMonthlyGBDownload] : ' +  cast([Avg Monthly GB Download] as varchar(50))   
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Insert Status :  Data : {' + @NewData  + '}}',
'Status Inserted'
)

GO
New_Service 'No',	'Yes',	'Cable',	'No',	'Yes',	'No',	'Yes',	'Yes',	'Yes',	'No',	'No',	'Yes',	'None',	'0002-ORFBO'
go
select * from Telecom_Churn_Audit_table
for xml path('Transaction'),root('Audit')
go
-- Status Delete Triger
create TRIGGER StatusDeleteTriger
ON Status
AFTER Delete
AS
DECLARE  @OldData  varchar(1000)
SELECT @OldData = 
' ChurnID : ' +  cast(ISNULL( [churn_id] , 21)  as varchar(50))+  
' , CustomerID : ' +  [customer_id] +  
' , TotalRefunds : ' +  cast( [total_refunds] as varchar(50)) +  
' , TotalCharges : ' +   cast( [total_charges] as varchar(50))+  
' , TotalRevenue : ' +  cast( [total_revenue] as varchar(50)) +  
' , PAperlessBilling : ' +  [paperless_billing] +  
' , TotalLongDistance : ' +  cast( [total_longdistance] as varchar(50)) +  
' , TotalExtraDataCharges : ' +  cast( [total_extradatacharges] as varchar(50)) +  
' , Contract : ' +  [contract] +  
' , TenureMonths : ' +  cast( [tenure_months] as varchar(50)) +  
' , NoReferrals : ' +  cast([no_referrals] as varchar(50)) +  
' , MonthlyCharges : ' +  cast([monthly_charges] as varchar(50)) +  
' , PaymentMethod : ' +  [payment_method] +  
' , CustomerStatus : ' +  [customer_status] +  
' , AvgMonthlyGBDownload] : ' +  cast([Avg Monthly GB Download] as varchar(50))     
FROM DELETED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Delete Status : { Data : {' + @OldData  + '}} }',
'Status Deleted'
)
go
New_Status null,	'0002-ORFBO',	0,	593.3	,974.81,	Yes,	381.51,	0,	'One Year',	9,	2	,65.6,	'Credit Card',	'Stayed',	16
Delete_Status '0002-ORFBO'
go
select * from Telecom_Churn_Audit_table
select * from Telecom_Churn_Audit_table
for xml path('Transaction'),root('Audit')
------------------------------------------ 


-- Service Trigers
go
-- Service Update Triger
create TRIGGER ServiceUpdateTriger
ON Service
AFTER UPDATE
AS
DECLARE @OldData varchar(1000) , @NewData  varchar(1000)
SELECT @OldData = 
' MultipuleLines : ' +  [multipule lines] +  
' , InternetService : ' + internet_service  +
' , InternetType : ' + internet_type  +
' , OnlineSecurity : ' + online_security  +
' , OnlineBackup : ' + online_backup  +
' , ProtectionPlan : ' + protection_plan  +
' , UnlimitedData : ' + unlimited_data  +
' , PhoneService : ' + phone_service  +
' , StreamingTv : ' + streaming_tv  +
' , StreamingMovies : ' + streaming_movies  +
' , StreamingMusic : ' + streaming_music  +
' , PermiumTecSupport : ' + permium_tecsupport  +
' , Offer : ' + offer  +
' , Age : ' + [customer id]   
FROM DELETED
SELECT @NewData =  
' MultipuleLines : ' +  [multipule lines] +  
' , InternetService : ' + internet_service  +
' , InternetType : ' + internet_type  +
' , OnlineSecurity : ' + online_security  +
' , OnlineBackup : ' + online_backup  +
' , ProtectionPlan : ' + protection_plan  +
' , UnlimitedData : ' + unlimited_data  +
' , PhoneService : ' + phone_service  +
' , StreamingTv : ' + streaming_tv  +
' , StreamingMovies : ' + streaming_movies  +
' , StreamingMusic : ' + streaming_music  +
' , PermiumTecSupport : ' + permium_tecsupport  +
' , Offer : ' + offer  +
' , Age : ' + [customer id] 
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Update Service : Old Data  : {' +  @OldData  + '} , New Data : {' + @NewData  + '}}',
'Service Updated'
)
GO
New_Customer 60 , 50 , '50' , 2 , '50' ,90001 
go
select * from location
select * from Telecom_Churn_Audit_table
use telecomchurn
go
-- Service Insert Triger
create TRIGGER ServiceInsertTriger
ON service
AFTER Insert
AS
DECLARE  @NewData  varchar(1000)
SELECT @NewData =  
' MultipuleLines : ' +  [multipule lines] +  
' , InternetService : ' + internet_service  +
' , InternetType : ' + internet_type  +
' , OnlineSecurity : ' + online_security  +
' , OnlineBackup : ' + online_backup  +
' , ProtectionPlan : ' + protection_plan  +
' , UnlimitedData : ' + unlimited_data  +
' , PhoneService : ' + phone_service  +
' , StreamingTv : ' + streaming_tv  +
' , StreamingMovies : ' + streaming_movies  +
' , StreamingMusic : ' + streaming_music  +
' , PermiumTecSupport : ' + permium_tecsupport  +
' , Offer : ' + offer  +
' , Age : ' + [customer id]  
FROM INSERTED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Insert Service :  Data : {' + @NewData  + '}}',
'Service Inserted'
)

GO

select * from Telecom_Churn_Audit_table
for xml path('Transaction'),root('Audit')
go
-- Service Delete Triger
create TRIGGER ServiceDeleteTriger
ON Service
AFTER Delete
AS
DECLARE  @OldData  varchar(1000)
SELECT @OldData = 
' MultipuleLines : ' +  [multipule lines] +  
' , InternetService : ' + internet_service  +
' , InternetType : ' + internet_type  +
' , OnlineSecurity : ' + online_security  +
' , OnlineBackup : ' + online_backup  +
' , ProtectionPlan : ' + protection_plan  +
' , UnlimitedData : ' + unlimited_data  +
' , PhoneService : ' + phone_service  +
' , StreamingTv : ' + streaming_tv  +
' , StreamingMovies : ' + streaming_movies  +
' , StreamingMusic : ' + streaming_music  +
' , PermiumTecSupport : ' + permium_tecsupport  +
' , Offer : ' + offer  +
' , Age : ' + [customer id]  
FROM DELETED
INSERT INTO Telecom_Churn_Audit_table 
VALUES(
SUSER_NAME() ,
GETDATE() ,
'{Delete Service : { Data : {' + @OldData  + '}} }',
'Service Deleted'
)
go
Delete_Status '0002-ORFBO'
go
select * from Telecom_Churn_Audit_table
go
select * from Telecom_Churn_Audit_table
for xml path('Transaction'),root('Audit')
