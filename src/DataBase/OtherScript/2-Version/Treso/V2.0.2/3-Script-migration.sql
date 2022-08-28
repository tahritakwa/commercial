--- Data --
update Sales.FinancialCommitment set AmountWithoutWithholdingTaxWithCurrency = AmountWithCurrency where WithholdingTaxWithCurrency IS NULL
update Sales.FinancialCommitment set AmountWithoutWithholdingTax = Amount where WithholdingTaxWithCurrency IS NULL
