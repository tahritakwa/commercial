/****** Object:  StoredProcedure [dbo].[InsertTiers]    Script Date: 01/03/2018 17:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[InsertTiers] 
	-- Add the parameters for the stored procedure here
	@numberLine int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @curr_str int
	SELECT @curr_str = 1
	WHILE @curr_str <= @numberLine
	DELETE FROM [Sales].[Tiers]
    -- Insert statements for procedure here
	BEGIN
		DECLARE @code_str VARCHAR(MAX)
		DECLARE @desc_str VARCHAR(MAX)
	    SELECT @code_str = RIGHT('0000000' + CAST(@curr_str AS NVARCHAR), 8)
		SELECT @desc_str = RIGHT('Client ' + CAST(@curr_str AS NVARCHAR), 15)
		INSERT INTO [Sales].[Tiers] ( [IdLegalForme], [IdPaymentCondition], [IdTypeTiers], [IdCity], [IdPays], [IdDiscountGroupTiers], [CodeTiers], [Name], [Logo], [Adress], [Region], [AuthorizedSettlement], [Status], [Rib], [CIN], [Discount], [MatriculeFiscale], [IdPaymentMethod], [IsDeleted], [TransactionUserId], [IdAccountingAccount], [CounterPartyAccount], [CommercialRegister], [CP], [AuthorizedAmountOrder], [AuthorizedAmountDelivery], [AuthorizedAmountInvoice], [IdTaxeGroupTiers], [Tiers_int_1], [Tiers_int_2], [Tiers_int_3], [Tiers_int_4], [Tiers_int_5], [Tiers_int_6], [Tiers_int_7], [Tiers_int_8], [Tiers_int_9], [Tiers_int_10], [Tiers_bit_1], [Tiers_bit_2], [Tiers_bit_3], [Tiers_bit_4], [Tiers_bit_5], [Tiers_bit_6], [Tiers_bit_7], [Tiers_bit_8], [Tiers_bit_9], [Tiers_bit_10], [Tiers_float_1], [Tiers_float_2], [Tiers_float_3], [Tiers_float_4], [Tiers_float_5], [Tiers_float_6], [Tiers_float_7], [Tiers_float_8], [Tiers_float_9], [Tiers_float_10], [Tiers_varchar_1], [Tiers_varchar_2], [Tiers_varchar_3], [Tiers_varchar_4], [Tiers_varchar_5], [Tiers_varchar_6], [Tiers_varchar_7], [Tiers_varchar_8], [Tiers_varchar_9], [Tiers_varchar_10], [Tiers_date_1], [Tiers_date_2], [Tiers_date_3], [Tiers_date_4], [Tiers_date_5], [Tiers_date_6], [Tiers_date_7], [Tiers_date_8], [Tiers_date_9], [Tiers_date_10], [IdCurrency], [Deleted_Token]) VALUES 
		(NULL, NULL, 1, NULL, NULL, NULL,
		 @code_str, 
		 @desc_str, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		 2, NULL)
		 SELECT @desc_str = RIGHT('Fournisseur ' + CAST(@curr_str AS NVARCHAR), 15)
		 INSERT INTO [Sales].[Tiers] ( [IdLegalForme], [IdPaymentCondition], [IdTypeTiers], [IdCity], [IdPays], [IdDiscountGroupTiers], [CodeTiers], [Name], [Logo], [Adress], [Region], [AuthorizedSettlement], [Status], [Rib], [CIN], [Discount], [MatriculeFiscale], [IdPaymentMethod], [IsDeleted], [TransactionUserId], [IdAccountingAccount], [CounterPartyAccount], [CommercialRegister], [CP], [AuthorizedAmountOrder], [AuthorizedAmountDelivery], [AuthorizedAmountInvoice], [IdTaxeGroupTiers], [Tiers_int_1], [Tiers_int_2], [Tiers_int_3], [Tiers_int_4], [Tiers_int_5], [Tiers_int_6], [Tiers_int_7], [Tiers_int_8], [Tiers_int_9], [Tiers_int_10], [Tiers_bit_1], [Tiers_bit_2], [Tiers_bit_3], [Tiers_bit_4], [Tiers_bit_5], [Tiers_bit_6], [Tiers_bit_7], [Tiers_bit_8], [Tiers_bit_9], [Tiers_bit_10], [Tiers_float_1], [Tiers_float_2], [Tiers_float_3], [Tiers_float_4], [Tiers_float_5], [Tiers_float_6], [Tiers_float_7], [Tiers_float_8], [Tiers_float_9], [Tiers_float_10], [Tiers_varchar_1], [Tiers_varchar_2], [Tiers_varchar_3], [Tiers_varchar_4], [Tiers_varchar_5], [Tiers_varchar_6], [Tiers_varchar_7], [Tiers_varchar_8], [Tiers_varchar_9], [Tiers_varchar_10], [Tiers_date_1], [Tiers_date_2], [Tiers_date_3], [Tiers_date_4], [Tiers_date_5], [Tiers_date_6], [Tiers_date_7], [Tiers_date_8], [Tiers_date_9], [Tiers_date_10], [IdCurrency], [Deleted_Token]) VALUES 
		(NULL, NULL, 2, NULL, NULL, NULL,
		 @code_str, 
		 @desc_str, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		 2, NULL)

		SELECT @curr_str += 1
	END

END

GO