-- Before Indexes
SET STATISTICS IO ON;
SET STATISTICS TIME ON;


SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,[ProductID]
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[rowguid]
      ,[ModifiedDate]
FROM [AdventureWorks2022].[Sales].SalesOrderDetail
WHERE [ProductID] = 870;


-- Indexes for [AdventureWorks2022].[Sales].[SalesOrderDetail]

-- Unique index on [rowguid]
CREATE UNIQUE INDEX AK_SalesOrderDetail_rowguid
ON [AdventureWorks2022].[Sales].SalesOrderDetail ([rowguid]);

-- Non-clustered index on [ProductID]
CREATE INDEX IX_SalesOrderDetail_ProductID
ON [AdventureWorks2022].[Sales].SalesOrderDetail ([ProductID]);

-- Primary Key index on [SalesOrderID], [SalesOrderDetailID]
CREATE CLUSTERED INDEX PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID
ON [AdventureWorks2022].[Sales].SalesOrderDetail ([SalesOrderID], [SalesOrderDetailID]);

-- Indexes for [AdventureWorks2022].[Production].[TransactionHistory]

-- Non-clustered index on [ProductID]
CREATE INDEX IX_TransactionHistory_ProductID
ON [AdventureWorks2022].[Production].[TransactionHistory] ([ProductID]);

-- Non-clustered index on [ReferenceOrderID], [ReferenceOrderLineID]
CREATE INDEX IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID
ON [AdventureWorks2022].[Production].[TransactionHistory] ([ReferenceOrderID], [ReferenceOrderLineID]);

-- Primary Key index on [TransactionID]
CREATE CLUSTERED INDEX PK_TransactionHistory_TransactionID
ON [AdventureWorks2022].[Production].[TransactionHistory] ([TransactionID]);


-- after Indexes
SET STATISTICS IO ON;
SET STATISTICS TIME ON;


SELECT [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,[ProductID]
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
      ,[rowguid]
      ,[ModifiedDate]
FROM [AdventureWorks2022].[Sales].SalesOrderDetail
WHERE [ProductID] = 870;



-- Remove indexes and primary key from SalesOrderDetail table
USE [AdventureWorks2022];
GO

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'SalesOrderDetail';


-- Drop primary key constraint
DROP INDEX [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] ON [Sales].[SalesOrderDetail] WITH ( ONLINE = OFF )
GO

-- Drop other indexes
DROP INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail];
DROP INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail];


-- Drop primary key constraint
ALTER TABLE [Production].[TransactionHistory] DROP CONSTRAINT PK_TransactionHistory_TransactionID;

-- Drop other indexes
DROP INDEX IX_TransactionHistory_ProductID ON [Production].[TransactionHistory];
DROP INDEX IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID ON [Production].[TransactionHistory];

