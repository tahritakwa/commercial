BEGIN TRANSACTION
ALTER TABLE [Sales].[DocumentType] DROP CONSTRAINT [FK_DocumentType_DocumentType]
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1, [FinancialCommitmentDirection]=1 WHERE [CodeType]=N'A-PU'
UPDATE [Sales].[DocumentType] SET [IsFinancialCommitmentAffected]=1, [FinancialCommitmentDirection]=2 WHERE [CodeType]=N'A-SA'
UPDATE [Sales].[DocumentType] SET [FinancialCommitmentDirection]=2 WHERE [CodeType]=N'I-PU'
UPDATE [Sales].[DocumentType] SET [FinancialCommitmentDirection]=1 WHERE [CodeType]=N'I-SA'
ALTER TABLE [Sales].[DocumentType]
    ADD CONSTRAINT [FK_DocumentType_DocumentType] FOREIGN KEY ([DefaultCodeDocumentTypeAssociated]) REFERENCES [Sales].[DocumentType] ([CodeType])
	
---- Update Financial Commitment
UPDATE [Sales].[FinancialCommitment]
   SET [Direction] = (Select FinancialCommitmentDirection From Sales.DocumentType
						Where Sales.DocumentType.CodeType = (Select DocumentTypeCode From Sales.Document Where Id = [Sales].[FinancialCommitment].IdDocument))

COMMIT TRANSACTION