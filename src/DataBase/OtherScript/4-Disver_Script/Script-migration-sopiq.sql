--- Amounts for FinancialCommitment --
update Sales.FinancialCommitment set AmountWithoutWithholdingTaxWithCurrency = AmountWithCurrency where WithholdingTaxWithCurrency IS NULL
update Sales.FinancialCommitment set AmountWithoutWithholdingTax = Amount where WithholdingTaxWithCurrency IS NULL

--- BL status
 Update Sales.DocumentLine set IdDocumentLineStatus =3 where IdDocument in (select Id from Sales.Document where IdDocumentStatus = 3  and DocumentTypeCode  = 'D-SA' and DocumentRemainingAmountWithCurrency is null)
and  IdDocumentLineStatus =2 and IsDeleted = 0
update [Sales].[Document] set [DocumentRemainingAmountWithCurrency] = DocumentRemainingAmount where DocumentRemainingAmountWithCurrency is null and code like '%BL%'