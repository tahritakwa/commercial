



DECLARE @id int;
DECLARE @code_counter float = 1;

DECLARE fc_cursor CURSOR  FAST_FORWARD 
	FOR SELECT Id FROM [Sales].[FinancialCommitment] 
	WHERE IsDeleted = 0;

OPEN fc_cursor;

FETCH NEXT FROM fc_cursor INTO @id;

WHILE @@FETCH_STATUS = 0

BEGIN

    UPDATE  [Sales].[FinancialCommitment]
    SET Code = CONCAT('FC20-',  FORMAT(@code_counter, '00000000'))
    WHERE Id = @id;
	SET @code_counter= @code_counter + 1;

	FETCH NEXT FROM fc_cursor INTO @id;

END;

UPDATE [ERPSettings].[Codification] SET LastCounterValue = FORMAT(@code_counter, '00000000') WHERE Id = 284;

CLOSE fc_cursor;
DEALLOCATE fc_cursor;
