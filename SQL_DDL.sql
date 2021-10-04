--SQL DDL


USE [Target_B12021_SChauras]
GO

--1)Table: Customer
CREATE TABLE [dbo].[DIM_Customer_SQL_IN1239] (
  [Customer_id] [float] NOT NULL PRIMARY KEY,
  [Firstname] [nvarchar](255) NULL DEFAULT 'UNK',
  [Lastname] [nvarchar](255) NULL DEFAULT 'UNK',
  [Contactaddress] [nvarchar](255) NULL DEFAULT 'UNK',
  [Contactphone] [nvarchar](255) NULL DEFAULT 'UNK',
  [Contact_email] [nvarchar](255) NULL DEFAULT 'UNK'
)




--2)Table: Users
CREATE TABLE [dbo].[DIM_users_SQL_IN1239] (
  [Surrogate_Key] int IDENTITY (1, 1),
  [UserID] [INT] NOT NULL,
  [FirstName] [nvarchar](255) NULL DEFAULT 'unk',
  [LastName] [nvarchar](255) NULL DEFAULT 'unk',
  [DisplayName] [nvarchar](255) NULL DEFAULT 'unk',
  [Department] [nvarchar](255) NULL DEFAULT 'unk',
  [Title] [nvarchar](255) NULL DEFAULT 'unk',
  [Manager] [nvarchar](255) NULL DEFAULT 'unk',
  [Email] [nvarchar](255) NULL DEFAULT 'unk',
  [Enabled] [nvarchar](1) NULL DEFAULT 'N',
  [Division] [nvarchar](255) NULL DEFAULT 'unk',
  [ManagerUserID] [float] NULL,
  [VERSION] int DEFAULT 0,
  PRIMARY KEY (Surrogate_Key)
)


--3)Table: Location
CREATE TABLE [dbo].[DIM_Location_SQL_IN1239](
	[LocationID] [float] NOT NULL PRIMARY KEY,
	[LocationType] [nvarchar](255) NULL DEFAULT 'UNK',
	[LocationDescription] [nvarchar](255) NULL DEFAULT 'UNK',
	[Region] [nvarchar](255) NULL DEFAULT 'UNK',
	[RegionManagerUserID] [float] NOT NULL,
	[Address] [nvarchar](255) NULL DEFAULT 'UNK',
	[City] [nvarchar](255) NULL DEFAULT 'UNK',
	[PostalCode] [nvarchar](255) NULL DEFAULT 'UNK',
	[PhoneNumber] [nvarchar](255) NULL DEFAULT 'UNK',
	[Fax] [nvarchar](255) NULL DEFAULT 'UNK',
	[Email] [nvarchar](255) NULL DEFAULT 'UNK',
	[StoreManagerUserID] [float] NOT NULL,
	[IsDelegateServiceCenter] [nvarchar](255) NULL DEFAULT 'UNK',
	[Enabled] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsPartWareHouse] [nvarchar](255) NULL DEFAULT 'UNK',
	[FRTRate] [float] NULL DEFAULT 0,
	[CurrencyCode] [nvarchar](255) NULL DEFAULT 'UNK',
	[Market] [nvarchar](255) NULL DEFAULT 'UNK',
	[CriticalPartReportLocationTitle] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsMRBWareHouse] [nvarchar](255) NULL DEFAULT 'UNK',
	[WeekDayWorkHours] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsEngineering] [nvarchar](255) NULL DEFAULT 'UNK',
	[PreferredLanguage] [nvarchar](255) NULL DEFAULT 'UNK'
)




--4)Table: VehicleVIN
CREATE TABLE [dbo].[DIM_VehicleVIN_SQL_IN1239](
	[SurrogateKey] [int] IDENTITY (1, 1),
	[VehicleVINID] [float] NOT NULL,
	[VehicleVIN] [nvarchar](255) NOT NULL,
	[VehicleModelCode] [nvarchar](255) NULL DEFAULT 'UNK',
	[VehicleModel] [nvarchar](255) NULL DEFAULT 'UNK',
	[ModelCategory] [nvarchar](255) NULL DEFAULT 'UNK',
	[ModelYear] [float] NULL DEFAULT 0,
	[DriveOrientation] [nvarchar](255) NULL DEFAULT 'UNK',
	[Actualdeliveryeddate] [nvarchar](255) DEFAULT 'UNK',
	[Enabled] [float] NULL DEFAULT 0,
	[NearestServiceLocationID] [float] NOT NULL,
	[FactoryGateDate] [nvarchar](255) NULL DEFAULT 'UNK',
	[VehicleColor] [nvarchar](255) NULL DEFAULT 'UNK',
	[VehicleTitle] [nvarchar](255) NULL DEFAULT 'UNK',
	[LastOdometer] [float] NULL DEFAULT 0,
	[InventoryVehicle] [float] NULL DEFAULT 0,
	[NewUsed] [nvarchar](255) NULL DEFAULT 'UNK',
	[Market] [nvarchar](255) NULL DEFAULT 'UNK',
	[DeliveryRegion] [nvarchar](255) NULL DEFAULT 'UNK',
	[OdometerType] [nvarchar](255) NULL DEFAULT 'UNK',
	[FromDate] [smalldatetime] DEFAULT '01-01-1900',
	[ToDate] [smalldatetime] DEFAULT NULL,
    PRIMARY KEY (SurrogateKey)
)




--5)Table: CustomerComplaint
CREATE TABLE [dbo].[FACT_CustomerComplaint_SQL_IN1239](
	[CustomerComplaintID] [float] NOT NULL PRIMARY KEY,
	[VIN] [nvarchar](255) NOT NULL,
	[LocationID] [float] NOT NULL FOREIGN KEY REFERENCES DIM_Location_SQL_IN1239(LocationID),
	[Enabled] [float] NULL DEFAULT 0,
	[CreatedDate] [nvarchar](255) NULL DEFAULT 'UNK',
	[Customer_id] [float] NOT NULL FOREIGN KEY REFERENCES DIM_Customer_SQL_IN1239(Customer_id) 
)






--6)Table: CustomerComplaintDetail
CREATE TABLE [dbo].[FACT_CustomerComplaintDetail_SQL_IN1239](
	[CustomerComplaintDetail_ID] [float] NOT NULL PRIMARY KEY,
	[CustomerComplaintID] [float] NOT NULL FOREIGN KEY REFERENCES FACT_CustomerComplaint_SQL_IN1239(CustomerComplaintID),
	[ComplaintStatus] [nvarchar](255) NULL DEFAULT 'UNK',
	[ComplaintType] [nvarchar](255) NULL DEFAULT 'UNK',
	[ActionType] [nvarchar](255) NULL DEFAULT 'UNK',
	[Description] [varchar](3000) NULL DEFAULT 'UNK',
	[ShortDescription] [varchar](255) NULL DEFAULT 'UNK',
	[IsVehicleOperable] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsTow] [nvarchar](255) NULL DEFAULT 'UNK',
	[ServiceLocationID] [float] NOT NULL FOREIGN KEY REFERENCES DIM_Location_SQL_IN1239(LocationID),
	[CreateDate] [smalldatetime] NULL DEFAULT '01-01-1990',
	[ComplaintCloseDate] [smalldatetime] NULL DEFAULT '01-01-1990',
	[CreatedByUserID] [float] NOT NULL
)






--7)Table: Orders
CREATE TABLE [dbo].[FACT_orders_SQL_IN1239](
	[OrderID] [float] NOT NULL PRIMARY KEY,
	[OrderNumber] [nvarchar](255) NULL DEFAULT 'UNK',
	[DateTime] [smalldatetime] NULL DEFAULT '01-01-1900',
	[VIN] [nvarchar](255) NOT NULL,
	[Odometer] [float] NULL DEFAULT 0,
	[ServiceAdvisorUserID] [float] NOT NULL,
	[ServiceLocationID] [float] NOT NULL,
	[PaymentType] [nvarchar](255) NULL DEFAULT 'UNK',
	[PaymentRecievedByUserID] [float] NULL DEFAULT 0,
	[OrderStatus] [nvarchar](255) NULL DEFAULT 'UNK',
	[TotalPartPrice] [float] NULL DEFAULT 0,
	[TotalLaborAmount] [float] NULL DEFAULT 0,
	[TotalTaxAmount] [float] NULL DEFAULT 0,
	[TotalAmount] [float] NULL DEFAULT 0,
	[IsCustomerPickUp] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsRangerDrop] [nvarchar](255) NULL DEFAULT 'UNK',
	[ShippingAmount] [float] NULL DEFAULT 0,
	[OrderCloseDate] [nvarchar](255) NULL DEFAULT 'UNK',
	[DiscountAmount] [float] NULL DEFAULT 0,
	[ReadyForInvoiceDate] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsRepeatedIssueReviewed] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsReadyForDelivery] [nvarchar](255) NULL DEFAULT 'UNK',
	[LeadTechnicianID] [FLOAT] NULL DEFAULT 0,
	[IsCPO] [nvarchar](255) NULL DEFAULT 'UNK',
	[IsCPOCompliant] [nvarchar](255) NULL DEFAULT 'UNK',
	[Customer_id] [float] NOT NULL FOREIGN KEY REFERENCES DIM_Customer_SQL_IN1239(Customer_id)
)





--8)Table: OrderJob

CREATE TABLE [dbo].[FACT_OrderJob_SQL_IN1239](
	[OrderJobID] [int] NOT NULL PRIMARY KEY,
	[OrderID] [float] NOT NULL FOREIGN KEY REFERENCES FACT_orders_SQL_IN1239(OrderID),
	[OrderJobStatus] [nvarchar](30) NULL DEFAULT 'UNK',
	[LaborPrice] [decimal](18, 4) NULL DEFAULT 0,
	[LaborAmount] [decimal](18, 4) NULL DEFAULT 0,
	[TotalAmount] [decimal](18, 4) NULL DEFAULT 0,
	[TotalPartPrice] [decimal](18, 4) NULL DEFAULT 0,
	[PayMethod] [nvarchar](50) NULL DEFAULT 'UNK',
	[ComplaintNarrative] [nvarchar](max) NULL DEFAULT 'UNK',
	[CauseNarrative] [nvarchar](max) NULL DEFAULT 'UNK',
	[Enabled] [nvarchar](50) NULL,
	[CustomerConcernDetailID] [float] NULL DEFAULT 0,
	[VOR] [nvarchar](50) NULL DEFAULT 'UNK',
	[OrderJobCloseDate] [smalldatetime] NULL DEFAULT '01-01-1900',
	[Category] [nvarchar](50) NULL DEFAULT 'UNK',
	[IsDuplicatedSymptom] [nvarchar](50) NULL DEFAULT 'UNK',
	[IsDuplicatedCorrection] [nvarchar](50) NULL DEFAULT 'UNK',
	[IsTow] [nvarchar](50) NULL DEFAULT 'UNK'
)




--9)Table: OrderJob ServiceCorrection
CREATE TABLE [dbo].[FACT_OrderJobServiceCorrection_SQL_IN1239](
	[OrderJobServiceCorrectionId] [int] NOT NULL PRIMARY KEY,
	[OrderJobId] [int] NOT NULL FOREIGN KEY REFERENCES FACT_OrderJob_SQL_IN1239(OrderJobId),
	[ServiceCatalogCode] [nvarchar](50) NULL DEFAULT 'UNK',
	[ServiceCatalog] [nvarchar](200) NULL DEFAULT 'UNK',
	[CorrectionNarrative] [varchar](4000) NULL DEFAULT 'UNK',
	[CorrectionLaborHours] [decimal](18, 4) NULL DEFAULT 0,
	[CorrectionActualLaborHours] [decimal](18, 4) NULL DEFAULT 0,
	[CorrectionLaborPrice] [decimal](18, 4) NULL DEFAULT 0,
	[IsWorkCompleted] [nvarchar](50) NULL DEFAULT 'UNK',
	[Enabled] [nvarchar](50) NULL DEFAULT 'UNK'
)





--10)Table: Part
CREATE TABLE [dbo].[DIM_Part_SQL_IN1239](
	[SurrogateKey] [int] IDENTITY(1,1),
	[PartId] [float] NOT NULL,
	[PartNumber] [nvarchar](255) NOT NULL,
	[PartSystem] [nvarchar](255) NULL DEFAULT 'UNK', 
	[PartSubSystem] [nvarchar](255) NULL DEFAULT 'UNK',
	[SupplierCode] [float] NULL DEFAULT 0,
	[Name] [nvarchar](255) NULL DEFAULT 'UNK',
	[PrevName] [nvarchar](255) NULL DEFAULT 'UNK',
	[SecondPrevName] [nvarchar](255) NULL DEFAULT 'UNK',
	[Description] [nvarchar](255) NULL DEFAULT 'UNK',
	[PlanningLeadtime] [float] NULL DEFAULT 0,
	[UnitPrice] [float] NULL DEFAULT 0,
	[Orderpoint] [float] NULL DEFAULT 0,
	[SafetyStockQuantity] [float] NULL DEFAULT 0,
	[FabricatedFlag] [nvarchar](255) NULL DEFAULT 'UNK',
	[PurchasedFlag] [nvarchar](255) NULL DEFAULT 'UNK',
	[StockedFlag] [nvarchar](255) NULL DEFAULT 'UNK',
	[InspectionRequiredFlag] [nvarchar](255) NULL DEFAULT 'UNK',
	[HazardousMaterialFlag] [nvarchar](255) NULL DEFAULT 'UNK',
	[Version] [nvarchar](255) NULL DEFAULT 'UNK',
	[ENABLED] [nvarchar](255) NULL DEFAULT 'UNK'
)



--11)Table: OrderJob ServiceCorrectionPart
CREATE TABLE [dbo].[FACT_OrderJobServiceCorrectionPart_SQL_IN1239](
	[OrderJobPartId] [int] NOT NULL PRIMARY KEY,
	[OrderJobServiceCorrectionId] [int] NOT NULL FOREIGN KEY REFERENCES FACT_OrderJobServiceCorrection_SQL_IN1239(OrderJobServiceCorrectionId),
	[Partnumber] [nvarchar](255) NOT NULL,
	[Quantity] [decimal](18, 4) NULL DEFAULT 0,
	[Unitprice] [decimal](18, 4) NULL DEFAULT 0,
	[Enabled] [nvarchar](255) NULL DEFAULT 'UNK',
	[Partcost] [decimal](18, 4) NULL DEFAULT 0,
	[IsCustomPart] [nvarchar](255) NULL DEFAULT 'UNK',
	[InventoryQuantityConsumed] [decimal](18, 4) NULL DEFAULT 0,
	[IsInventoryConsumed] [nvarchar](255) NULL DEFAULT 'UNK'
)


