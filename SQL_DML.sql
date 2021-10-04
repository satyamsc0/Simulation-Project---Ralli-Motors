--SQL INSERT SCRIPT


--Table: Customer

MERGE INTO [Target_B12021_SChauras].[dbo].[DIM_Customer_SQL_IN1239] AS TGT
USING (SELECT
  Customer_id,
  UPPER(LEFT(Firstname, 1)) + SUBSTRING(Firstname, 2, LEN(Firstname)) AS Firstname,
  UPPER(LEFT(Lastname, 1)) + SUBSTRING(Lastname, 2, LEN(Lastname)) AS Lastname,
  'No:' + (SUBSTRING(Contactaddress, 1, CHARINDEX(' ', Contactaddress, 1) - 1)) + ',' + SUBSTRING(Contactaddress, CHARINDEX(' ', Contactaddress), LEN(Contactaddress)) AS Contactaddress,
  SUBSTRING(Contactphone, CHARINDEX(' ', Contactphone, 1) + 1, LEN(Contactphone)) AS Contactphone,
  [Contact_email]
FROM [RALLI].[dbo].[Customer]) AS SRC
ON (TGT.[Customer_id] = SRC.[Customer_id])

WHEN NOT MATCHED THEN
INSERT ([Customer_id], [Firstname], [Lastname], [Contactaddress], [Contactphone], [Contact_email])
VALUES (SRC.[Customer_id], SRC.[Firstname], SRC.[Lastname], SRC.[Contactaddress], SRC.[Contactphone], SRC.[Contact_email])

WHEN MATCHED AND SRC.[Contactphone] <> TGT.[Contactphone] THEN
UPDATE
SET TGT.[Contactphone] = SRC.[Contactphone];

GO

--Table: CustomerComplaint
TRUNCATE TABLE [dbo].[FACT_CustomerComplaint_SQL_IN1239];
INSERT INTO [dbo].[FACT_CustomerComplaint_SQL_IN1239]
  SELECT [CustomerComplaintID]
      ,[VIN]
      ,[LocationID]
      ,[Enabled]
,FORMAT([CreatedDate],'dd/MM/yyyy HH:mm:ss') As [CreatedDate]
      ,[Customer_id]
  FROM [RALLI].[dbo].[CustomerComplaint];

GO


--Table: CustomerComplaintDetail
MERGE INTO [dbo].[FACT_CustomerComplaintDetail_SQL_IN1239] AS TGT
USING (SELECT 
	   [CustomerComplaintDetail_ID]
      ,[CustomerComplaintID]
      ,[ComplaintStatus]
      ,[ComplaintType]
      ,[ActionType]
      ,LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Description], CHAR(9), ''), '-', ''), '@', ''), '?', ''), CHAR(34), ''), ':', '')) AS [Description]
      ,LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([ShortDescription], CHAR(9), ''), '-', ''), '@', ''), '?', ''), CHAR(34), ''), ':', '')) AS [ShortDescription]
      ,CASE
		WHEN [IsVehicleOperable] = 1 THEN 'Y'
		ELSE 'N'
	   END AS [IsVehicleOperable]
      ,CASE
		WHEN [IsTow] = 1 THEN 'Y'
		ELSE 'N'
	   END AS [IsTow]
      ,[ServiceLocationID]
      ,[CreateDate]
      ,[ComplaintCloseDate]
      ,[CreatedByUserID]
  FROM [RALLI].[dbo].[CustomerComplaintDetail] ) AS SRC
ON (TGT.[CustomerComplaintDetail_ID] = SRC.[CustomerComplaintDetail_ID])

WHEN NOT MATCHED THEN
INSERT VALUES (SRC.[CustomerComplaintDetail_ID]
      ,SRC.[CustomerComplaintID]
      ,SRC.[ComplaintStatus]
      ,SRC.[ComplaintType]
      ,SRC.[ActionType]
      ,SRC.[Description]
      ,SRC.[ShortDescription]
      ,SRC.[IsVehicleOperable]
      ,SRC.[IsTow]
      ,SRC.[ServiceLocationID]
      ,SRC.[CreateDate]
      ,SRC.[ComplaintCloseDate]
      ,SRC.[CreatedByUserID])

WHEN MATCHED AND (SRC.[CreateDate] <> TGT.[CreateDate]) THEN
UPDATE SET TGT.[CreateDate] = SRC.[CreateDate];


GO




--Table: Location
INSERT INTO [dbo].[DIM_Location_SQL_IN1239]
SELECT
  LocationID,
  LocationType,
  concat(UPPER(SUBSTRING(LocationDescription, 1, 1)), SUBSTRING(LocationDescription, 2, LEN(LocationDescription) - 1), '.') AS LocationDescription,

  LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Region, 'south', ' South '), 'west', ' West '), 'north', 'North'), 'east', ' East '), '  ', ' ')) AS Region,
  RegionManagerUserID,
  'No:' + SUBSTRING(Address, 1, CHARINDEX(' ', Address) - 1) + ',' + SUBSTRING(Address, CHARINDEX(' ', Address) + 1, LEN(Address) - CHARINDEX(' ', Address)) + '.' AS Address,
  City,
  PostalCode,
  REPLACE(PhoneNumber, '-', ' ') AS PhoneNumber,
  REPLACE(Fax, '-', ' ') AS Fax,
  Email,
  StoreManagerUserID,
  REPLACE(REPLACE(IsDelegateServiceCenter, '0', 'N'), '-1', 'Y') AS IsDelegateServiceCenter,
  REPLACE(REPLACE(Enabled, '-1', 'Y'), '0', 'N') AS Enabled,
  REPLACE(REPLACE(IsPartWareHouse, '0', 'N'), '-1', 'Y') AS IsPartWareHouse,
  FRTRate,
  CurrencyCode,
  Market,
  CriticalPartReportLocationTitle,
  REPLACE(REPLACE(IsMRBWareHouse, '0', 'N'), '-1', 'Y') AS IsMRBWareHouse,
  WeekDayWorkHours,
  REPLACE(REPLACE(IsEngineering, '0', 'N'), '-1', 'Y') AS IsEngineering,
  UPPER(PreferredLanguage) AS PreferredLanguage
FROM [RALLI].[dbo].[Location]

GO


--Table: OrderJob
INSERT INTO [dbo].[FACT_OrderJob_SQL_IN1239]
SELECT
  OrderJobID,
  OrderID,
  OrderJobStatus,
  ROUND(LaborPrice, 2) AS LaborPrice,
  ROUND(LaborAmount, 2) AS LaborAmount,
  ROUND(TotalAmount, 2) AS TotalAmount,
  ROUND(TotalPartPrice, 2) AS TotalPartPrice,
  PayMethod,
  ComplaintNarrative,
  CauseNarrative,
  REPLACE(REPLACE(Enabled, '0', 'N'), '1', 'Y') AS Enabled,
  CustomerConcernDetailID,
  REPLACE(REPLACE(VOR, '0', 'N'), '1', 'Y') AS VOR,
  OrderJobCloseDate,
  Category,
  REPLACE(REPLACE(IsDuplicatedSymptom, '0', 'N'), '1', 'Y') AS IsDuplicatedSymptom,
  REPLACE(REPLACE(IsDuplicatedCorrection, '0', 'N'), '1', 'Y') AS IsDuplicatedCorrection,
  REPLACE(REPLACE(IsTow, '0', 'N'), '1', 'Y') AS IsTow
FROM [RALLI].[dbo].[OrderJob]


GO



--Table: OrderJobServiceCorrection
INSERT INTO [dbo].[FACT_OrderJobServiceCorrection_SQL_IN1239]

SELECT
  OrderJobServiceCorrectionId,
  OrderJobId,
  ServiceCatalogCode,
  ServiceCatalog,
  CorrectionNarrative,
  ROUND(CorrectionLaborHours, 2) AS CorrectionLaborHours,
  ROUND(CorrectionActualLaborHours, 2) AS CorrectionActualLaborHours,
  ROUND(CorrectionLaborPrice, 2) AS CorrectionLaborPrice,
  REPLACE(REPLACE(IsWorkCompleted, '0', 'N'), '1', 'Y') AS IsWorkCompleted,
  REPLACE(REPLACE(Enabled, '0', 'N'), '1', 'Y') AS Enabled
FROM [RALLI].[dbo].[OrderJobServiceCorrection]

GO

--Table: OrderJobServiceCorrectionPart
INSERT INTO [dbo].[FACT_OrderJobServiceCorrectionPart_SQL_IN1239]

SELECT
  OrderJobPartId,
  OrderJobServiceCorrectionId,
  Partnumber,
  Quantity,
  ROUND(Unitprice, 2) AS Unitprice,
  REPLACE(REPLACE(Enabled, '1', 'Y'), '0', 'N') AS Enabled,
  ROUND(Partcost, 2) AS Unitprice,
  REPLACE(REPLACE(IsCustomPart, '1', 'Y'), '0', 'N') AS IsCustomPart,
  InventoryQuantityConsumed,
  REPLACE(REPLACE(IsInventoryConsumed, '1', 'Y'), '0', 'N') AS IsInventoryConsumed
FROM [RALLI].[dbo].[OrderJobServiceCorrectionPart]


GO


--Table: Orders
INSERT INTO [dbo].[FACT_Orders_SQL_IN1239]
SELECT
  OrderID,
  OrderNumber,
  DateTime,
  VIN,
  Odometer,
  ServiceAdvisorUserID,
  ServiceLocationID,
  PaymentType,
  PaymentRecievedByUserID,
  OrderStatus,
  ROUND(TotalPartPrice, 2) AS TotalPartPrice,
  ROUND(TotalLaborAmount, 2) AS TotalLaborAmount,
  ROUND(TotalTaxAmount, 2) AS TotalTaxAmount,
  ROUND(TotalAmount, 2) AS TotalAmount,
  REPLACE(REPLACE(IsCustomerPickUp, '-1', 'Y'), '0', 'Y') AS IsCustomerPickUp,
  REPLACE(REPLACE(IsRangerDrop, '-1', 'Y'), '0', 'Y') AS IsRangerDrop,
  ShippingAmount,
  FORMAT(OrderCloseDate, 'dd/MM/yyyy HH:mm:ss') AS OrderCloseDate,
  DiscountAmount,
  FORMAT(ReadyForInvoiceDate, 'dd/MM/yyyy HH:mm:ss') AS ReadyForInvoiceDate,
  REPLACE(REPLACE(IsRepeatedIssueReviewed, '-1', 'Y'), '0', 'Y') AS IsRepeatedIssueReviewed,
  REPLACE(REPLACE(IsReadyForDelivery, '-1', 'Y'), '0', 'Y') AS IsReadyForDelivery,
  LeadTechnicianID,
  REPLACE(REPLACE(IsCPO, '-1', 'Y'), '0', 'Y') AS IsCPO,
  REPLACE(REPLACE(IsCPOCompliant, '-1', 'Y'), '0', 'Y') AS IsCPOComplaint,
  Customer_id
FROM [RALLI].[dbo].[Orders]


GO


--Table: Part
MERGE INTO [Target_B12021_SChauras].[dbo].[DIM_Part_SQL_IN1239] AS TGT
USING (
SELECT
	  PartId,
	  PartNumber,
	  concat(UPPER(SUBSTRING(PartSystem, 1, 1)), SUBSTRING(PartSystem, 2, LEN(PartSystem) - 1)) AS PartSystem,
	  concat(UPPER(SUBSTRING(PartSubSystem, 1, 1)), SUBSTRING(PartSubSystem, 2, LEN(PartSubSystem) - 1)) AS PartSubSystem,
	  SupplierCode,
	  REPLACE(Name, '"', '') AS Name,
	  concat(UPPER(SUBSTRING(Description, 1, 1)), SUBSTRING(Description, 2, LEN(Description) - 1)) AS Description,
	  PlanningLeadtime,
	  UnitPrice,
	  Orderpoint,
	  SafetyStockQuantity,
	  REPLACE(REPLACE(FabricatedFlag, '-1', 'Y'), '0', 'N') AS FabricatedFlag,
	  REPLACE(REPLACE(PurchasedFlag, '-1', 'Y'), '0', 'N') AS PurchasedFlag,
	  REPLACE(REPLACE(StockedFlag, '-1', 'Y'), '0', 'N') AS StockedFlag,
	  REPLACE(REPLACE(InspectionRequiredFlag, '-1', 'Y'), '0', 'N') AS InspectionRequiredFlag,
	  REPLACE(REPLACE(HazardousMaterialFlag, '-1', 'Y'), '0', 'N') AS HazardousMaterialFlag,
	  Version,
	  REPLACE(REPLACE(ENABLED, '-1', 'Y'), '0', 'N') AS Enabled
	FROM [RALLI].[dbo].[Part]) AS SRC
	ON SRC.[PartId] = TGT.[PartId]

	WHEN NOT MATCHED THEN
	INSERT 
	VALUES (SRC.[PartId]
      ,SRC.[PartNumber]
      ,SRC.[PartSystem]
      ,SRC.[PartSubSystem]
      ,SRC.[SupplierCode]
      ,SRC.[Name]
	  ,'UNK'
	  ,'UNK'
      ,SRC.[Description]
      ,SRC.[PlanningLeadtime]
      ,SRC.[UnitPrice]
      ,SRC.[Orderpoint]
      ,SRC.[SafetyStockQuantity]
      ,SRC.[FabricatedFlag]
      ,SRC.[PurchasedFlag]
      ,SRC.[StockedFlag]
      ,SRC.[InspectionRequiredFlag]
      ,SRC.[HazardousMaterialFlag]
      ,SRC.[Version]
      ,SRC.[ENABLED])

	WHEN MATCHED AND (SRC.[Name] <> TGT.[Name]) THEN 
	UPDATE SET TGT.[SecondPrevName] = TGT.[PrevName],
			   TGT.[PrevName] = TGT.[Name],
			   TGT.[Name] = SRC.[Name];


GO



--Table: Users
INSERT INTO [Target_B12021_SChauras].[dbo].[DIM_users_SQL_IN1239]
  SELECT
    [UserID],
    [FirstName],
    [LastName],
    [DisplayName],
    [Department],
    [Title],
    [Manager],
    [Email],
    [Enabled],
    [Division],
    [ManagerUserID],
    VS
  FROM (
  MERGE [Target_B12021_SChauras].[dbo].[DIM_users_SQL_IN1239] AS TGT
  USING (SELECT
    [UserID],
    UPPER(SUBSTRING([Firstname], 1, 1)) + LOWER(SUBSTRING([Firstname], 2, LEN([Firstname]))) AS Firstname,
    UPPER(SUBSTRING([Lastname], 1, 1)) + LOWER(SUBSTRING([Lastname], 2, LEN([Lastname]))) AS Lastname,
    [FirstName] + ' ' + [LastName] AS [DisplayName],
    ISNULL([Department], 'UNK') [Department],
    ISNULL([Title], 'UNK') [Title],
    [Manager],
    [Email],
    REPLACE(REPLACE([Enabled], '-1', 'Y'), '0', 'N') AS Enabled,
    ISNULL([Division], 'UNK') [Division],
    ISNULL([ManagerUserID], 0) [ManagerUserID]
  FROM [RALLI].[dbo].[users]) AS SRC
  ON (TGT.UserID = SRC.UserID)

  WHEN NOT MATCHED THEN
  INSERT
  VALUES (SRC.[UserID], SRC.[FirstName], SRC.[LastName], SRC.[DisplayName],
  SRC.[Department], SRC.[Title], SRC.[Manager], SRC.[Email], SRC.[Enabled],
  SRC.[Division], SRC.[ManagerUserID], 0)
  
  WHEN MATCHED AND (SRC.[Title] <> TGT.[Title])
  THEN UPDATE
  SET [VERSION] = TGT.[VERSION] + 1


  OUTPUT $ACTION Action_Out,
  SRC.[UserID], SRC.[FirstName], SRC.[LastName], SRC.[DisplayName],
  SRC.[Department], SRC.[Title], SRC.[Manager], SRC.[Email], SRC.[Enabled],
  SRC.[Division], SRC.[ManagerUserID], 0 VS

  ) AS MERGE_OUT
  
  WHERE MERGE_OUT.Action_Out = 'UPDATE';

GO

--Table: VehicleVIN

INSERT INTO [Target_B12021_SChauras].[dbo].[DIM_VehicleVIN_SQL_IN1239]
SELECT [VehicleVINID]
      ,[VehicleVIN]
      ,[VehicleModelCode]
      ,[VehicleModel]
      ,[ModelCategory]
      ,[ModelYear]
      ,[DriveOrientation]
      ,[Actualdeliveryeddate]
      ,[Enabled]
      ,[NearestServiceLocationID]
      ,[FactoryGateDate]
      ,[VehicleColor]
      ,[VehicleTitle]
      ,[LastOdometer]
      ,[InventoryVehicle]
      ,[NewUsed]
      ,[Market]
      ,[DeliveryRegion]
      ,[OdometerType]
	  ,[FromDate]
	  ,[ToDate]
 FROM (
 MERGE [Target_B12021_SChauras].[dbo].[DIM_VehicleVIN_SQL_IN1239] AS TGT
 USING (SELECT
  VehicleVINID,
  VehicleVIN,
  VehicleModelCode,
  VehicleModel,
  ModelCategory,
  ModelYear,
  DriveOrientation,
  CONVERT(varchar, Actualdeliveryeddate, 0) AS Actualdeliveryeddate,
  Enabled,
  NearestServiceLocationID,
  FORMAT(FactoryGateDate, 'yyyyMMdd') AS FactoryGateDate,
  VehicleColor,
  VehicleTitle,
  LastOdometer,
  InventoryVehicle,
  NewUsed,
  REPLACE(REPLACE(REPLACE([Market], 'EU', 'European Union'), 'NA', 'Northern America'), 'APAC', 'Asian Pacific') AS Market,
  REPLACE(DeliveryRegion, ' ', '') AS DeliveryRegion,
  REPLACE(REPLACE(OdometerType, 'Kilometers', 'KM'), 'Miles', 'Mi') AS OdometerType
FROM [RALLI].[dbo].[VehicleVIN]) AS SRC
ON SRC.VehicleVINID = TGT.VehicleVINID

WHEN NOT MATCHED THEN
INSERT VALUES (
	   SRC.[VehicleVINID]
      ,SRC.[VehicleVIN]
      ,SRC.[VehicleModelCode]
      ,SRC.[VehicleModel]
      ,SRC.[ModelCategory]
      ,SRC.[ModelYear]
      ,SRC.[DriveOrientation]
      ,SRC.[Actualdeliveryeddate]
      ,SRC.[Enabled]
      ,SRC.[NearestServiceLocationID]
      ,SRC.[FactoryGateDate]
      ,SRC.[VehicleColor]
      ,SRC.[VehicleTitle]
      ,SRC.[LastOdometer]
      ,SRC.[InventoryVehicle]
      ,SRC.[NewUsed]
      ,SRC.[Market]
      ,SRC.[DeliveryRegion]
      ,SRC.[OdometerType]
	  ,GETDATE()
	  ,NULL
	  )

  WHEN MATCHED AND (SRC.[NearestServiceLocationID] <> TGT.[NearestServiceLocationID])
  THEN UPDATE
  SET TGT.[ToDate] = GETDATE()

  OUTPUT $ACTION Action_Out,
  SRC.[VehicleVINID]
      ,SRC.[VehicleVIN]
      ,SRC.[VehicleModelCode]
      ,SRC.[VehicleModel]
      ,SRC.[ModelCategory]
      ,SRC.[ModelYear]
      ,SRC.[DriveOrientation]
      ,SRC.[Actualdeliveryeddate]
      ,SRC.[Enabled]
      ,SRC.[NearestServiceLocationID]
      ,SRC.[FactoryGateDate]
      ,SRC.[VehicleColor]
      ,SRC.[VehicleTitle]
      ,SRC.[LastOdometer]
      ,SRC.[InventoryVehicle]
      ,SRC.[NewUsed]
      ,SRC.[Market]
      ,SRC.[DeliveryRegion]
      ,SRC.[OdometerType]
	  ,GETDATE() [FromDate]
	  ,NULL [ToDate]

  ) AS MERGE_OUT
  
  WHERE MERGE_OUT.Action_Out = 'UPDATE';

GO
