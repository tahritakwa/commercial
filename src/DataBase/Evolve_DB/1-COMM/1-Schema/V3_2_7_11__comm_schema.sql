--- Ghofrane : add constraint to category table 02/12/2021
ALTER TABLE [Immobilisation].[Category] DROP  CONSTRAINT [UniqueLabelImmobilisationCategory] 
ALTER TABLE [Immobilisation].[Category] ADD  CONSTRAINT [UniqueLabelImmobilisationCategory] UNIQUE NONCLUSTERED 
(
	[Deleted_Token] ASC,
	[Label] ASC
) ON [PRIMARY]
GO

