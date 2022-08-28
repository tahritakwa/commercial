/****** Object:  StoredProcedure [dbo].[InsertItems]    Script Date: 28/02/2018 17:34:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[InsertItems] 
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

    -- Insert statements for procedure here
	BEGIN
		DECLARE @code_str VARCHAR(MAX)
		DECLARE @desc_str VARCHAR(MAX)
	    SELECT @code_str = RIGHT('00000' + CAST(@curr_str AS NVARCHAR), 8)
		SELECT @desc_str = RIGHT('Article ' + CAST(@curr_str AS NVARCHAR), 15)
		INSERT INTO [Inventory].[Item] ([Code], [Description], [IdNature], [BarCode1D], [BarCode2D], [IdUnitStock], [IdUnitSales], [CoeffConversion], [PolicyValorization], [UnitHTPurchasePrice], [UnitHTSalePrice], [UnitTTCPurchasePrice], [UnitTTCSalePrice], [TVARate], [FixedMargin], [VariableMargin], [IsDeleted], [TransactionUserId], [IdDiscountGroupItem], [Item_int_1], [Item_int_2], [Item_bit_1], [Item_bit_2], [Item_float_1], [Item_float_2], [Item_varchar_1], [Item_varchar_2], [Item_varchar_3], [Deleted_Token]) VALUES 
		( @code_str, 
		  @desc_str, 
		2, N'', N'', NULL, NULL, NULL, N'', NULL, 0, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

		SELECT @curr_str += 1
	END

END
