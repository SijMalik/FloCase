--SMJ - 28/10/2011: Add new column to Case table

ALTER TABLE [Case] ADD Case_CostsAssgn BIT NULL
GO

ALTER TABLE [Case] ADD Case_CostsOnly BIT NULL
GO