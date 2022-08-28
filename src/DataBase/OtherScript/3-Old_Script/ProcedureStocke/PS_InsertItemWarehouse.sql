-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertItemWarehouse] 
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

		INSERT INTO [Inventory].[ItemWarehouse] ([IdItem], [IdWarehouse], [MinQuantity], [MaxQuantity], [AvailableQuantity], [ReservedQuantity], [OnOrderQuantity], [IsDeleted], [TransactionUserId], [Deleted_Token]) 
		VALUES (@curr_str, 1, NULL, NULL, 0, NULL, NULL, 0, 0, NULL)
		INSERT INTO [Stock].[StockMovement] ([IdDocumentLine], [IdStockDocumentLine], [IdItem], [IdWarehouse], [CreationDate], [RealStock], [MovementQty], [IsDeleted], [TransactionUserId], [Cump], [Operation], [Status], [Deleted_Token])
		 VALUES 
		 ( NULL, NULL, 
		 @curr_str, 
		 1, '20180301 13:57:23.120', NULL, 100, 0, 0, NULL, N'I', N'R', NULL)


		SELECT @curr_str += 1
	END

END


GO
