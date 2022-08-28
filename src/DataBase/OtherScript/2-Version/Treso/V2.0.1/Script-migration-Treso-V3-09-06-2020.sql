--- Eliminate ReflectiveSettlement
DELETE FROM [Payment].[ReflectiveSettlement] WHERE [Id]=1
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1934, 579, 105.915, 105.915, 0, NULL, 1, 1, 1)

--- Do Round 
update Sales.FinancialCommitment set RemainingAmount = ROUND(RemainingAmount,3)
update Sales.FinancialCommitment set RemainingAmountWithCurrency = ROUND(RemainingAmountWithCurrency,3)
update Sales.FinancialCommitment set Amount = ROUND(Amount,3)
update Sales.FinancialCommitment set AmountWithCurrency = ROUND(AmountWithCurrency,3)
update Payment.SettlementCommitment set AssignedAmount = ROUND(AssignedAmount,3)
update Payment.SettlementCommitment set AssignedAmountWithCurrency = ROUND(AssignedAmountWithCurrency,3)
update Payment.Settlement set ResidualAmount = ROUND(ResidualAmount,3)
update Payment.Settlement set ResidualAmountWithCurrency = ROUND(ResidualAmountWithCurrency,3)
update Payment.Settlement set Amount = ROUND(Amount,3)
update Payment.Settlement set AmountWithCurrency = ROUND(AmountWithCurrency,3)

--- WithholdingTax strategy changed
begin

	declare @my_settlement_Commitment_id int;
    declare @my_settlement_id int;
	declare @withholding_tax float; 
	
    declare settlement_commitment_Cursor cursor for select Id, SettlementId from Payment.SettlementCommitment 
	where SettlementId IN (2,3,5,6,7,15,16,22,28,36,39,40,47,48,62,66,67,69,75,77,83,84,119,177,190,
    194,195,197,212,214,216,219,220,223,229,233,235,236,237,240,244);

    open settlement_commitment_Cursor;
        fetch next from settlement_commitment_Cursor INTO @my_settlement_Commitment_id, @my_settlement_id
        while @@FETCH_STATUS = 0
			begin 
				select @withholding_tax = WithholdingTax from Payment.Settlement where id = @my_settlement_id;
				update Payment.SettlementCommitment set AssignedAmountWithCurrency = Round(AssignedAmountWithCurrency + @withholding_tax,3) where Id = @my_settlement_Commitment_id
				update Payment.SettlementCommitment set AssignedAmount = Round(AssignedAmount + @withholding_tax,3) where Id = @my_settlement_Commitment_id
			fetch next from settlement_commitment_Cursor INTO  @my_settlement_Commitment_id, @my_settlement_id
			set @withholding_tax = Null
			end
     close settlement_commitment_Cursor
     DEALLOCATE settlement_commitment_Cursor
end

--- Assets not added
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1640, 261, 250.89, 250.89, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1638, 271, 1509.442, 1509.442, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3270, 275, 54.188 , 54.188 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1639, 276, 270.054 , 270.054 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3273, 294, 2105.288 , 2105.288 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3277, 302, 135.320, 135.320 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3266, 308, 25.066, 25.066, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5561, 314, 772.932, 772.932, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3258, 492, 1040.137, 1040.137, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5565, 496, 2325.494, 2325.494, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3269, 501, 951.086, 951.086, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5564, 545, 1081.378, 1081.378, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5566, 1504, 1405.314, 1405.314, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3260, 1516, 1512.135, 1512.135, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3274, 1520, 53.623, 53.623, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1641, 1531, 1348.218, 1348.218, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3271, 1563, 1448.554, 1448.554, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3263, 1581, 259.015, 259.015, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3268, 1595, 64.588,  64.588, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3265, 1600, 412.127,  412.127, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3261, 1641, 114.044,  114.044, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3267, 1676, 769.391,  769.391, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1642, 260, 56.280,  56.2801, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1635, 263, 172.527, 172.527, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3275, 266, 223.944, 223.944, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5563, 530, 28.586, 28.586, 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1636, 1510, 275.853 , 275.853 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1632, 1541, 109.115 , 109.115 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3262, 1541, 113.313 , 113.313 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (1644, 1561, 298.828 , 298.828 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (5567, 1571, 134.803 , 134.803 , 0, NULL, 1, 1, 1)
INSERT INTO [Payment].[SettlementCommitment] ([CommitmentId], [SettlementId], [AssignedAmount], [AssignedAmountWithCurrency], [IsDeleted], [Deleted_Token], [Direction], [RemplacedBy], [ExchangeRate]) VALUES (3259, 1623, 352.805 , 352.805 , 0, NULL, 1, 1, 1)

--- Eliminate Status NotSatisfied
update Sales.FinancialCommitment set IdStatus = 2 where IdStatus = 8 

--- delete invalid settlement 
DELETE FROM [Payment].[Settlement] WHERE [Id]=457
DELETE FROM [Payment].[Settlement] WHERE [Id]=458






