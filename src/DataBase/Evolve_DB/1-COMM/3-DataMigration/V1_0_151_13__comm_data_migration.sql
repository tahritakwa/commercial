-- Youssef update documentLineTaxe 11/01/2021
GO
DECLARE @idTaxe int;
DECLARE @taxeAmount float;
DECLARE @taxeAmountWithCurrency float;
DECLARE @taxeBase float;
DECLARE @IdDocumentLine int;
DECLARE @taxeBaseWithCurrency float;
DECLARE @HtTotalLine float;
DECLARE @HtTotalLineWithCurrency float;
DECLARE @ExcVatTaxAmount float;
DECLARE @ExcVatTaxAmountWithCurrency float;
DECLARE @VatTaxAmount float;
DECLARE @VatTaxAmountWithCurrency float;
DECLARE @TaxeType int;
DECLARE @TaxeValue int;

 

DECLARE dlt_cursor CURSOR
    FOR SELECT IdTaxe,IdDocumentLine, TaxeValue, TaxeValueWithCurrency,TaxeBase, TaxeBaseWithCurrency FROM [Sales].[DocumentLineTaxe] 
    WHERE IsDeleted = 0 ;

 

    OPEN dlt_cursor;

 

    FETCH NEXT FROM dlt_cursor INTO @idTaxe ,@IdDocumentLine, @taxeAmount , @taxeAmountWithCurrency , @taxeBase , @taxeBaseWithCurrency;

 

    WHILE @@FETCH_STATUS = 0

 

    BEGIN

 

    SELECT @HtTotalLine = HtTotalLine , @HtTotalLineWithCurrency = HtTotalLineWithCurrency,
    @ExcVatTaxAmount=ExcVatTaxAmount, @ExcVatTaxAmountWithCurrency = ExcVatTaxAmountWithCurrency,
    @VatTaxAmount = VatTaxAmount , @VatTaxAmountWithCurrency = VatTaxAmountWithCurrency
     FROM Sales.DocumentLine 
    WHERE Id = @IdDocumentLine;

 

    SELECT @TaxeType = TaxeType ,@TaxeValue = TaxeValue FROM Shared.Taxe
    WHERE Id = @idTaxe;

 

    IF @HtTotalLine is not null and @ExcVatTaxAmount is not null
        IF @TaxeType = 1
            SET @taxeBase = @HtTotalLine + @ExcVatTaxAmount
        ELSE SET @taxeBase = @HtTotalLine
    ELSE SET @taxeBase = 0;    
        
    IF @VatTaxAmount > 0 and @taxeBase is not null
        SET @taxeAmount = @taxeBase * (CAST(@TaxeValue as float) / 100.0)
    ELSE SET @taxeAmount = 0;

 

    IF @HtTotalLineWithCurrency is not null and @ExcVatTaxAmountWithCurrency is not null
        IF @TaxeType = 1
            SET @taxeBaseWithCurrency = @HtTotalLineWithCurrency + @ExcVatTaxAmountWithCurrency
        ELSE SET @taxeBaseWithCurrency = @HtTotalLineWithCurrency
    ELSE SET @taxeBaseWithCurrency = 0;    
        
    IF @VatTaxAmountWithCurrency > 0 and @taxeBaseWithCurrency is not null
        SET @taxeAmountWithCurrency = @taxeBaseWithCurrency * (@TaxeValue / 100)
    ELSE SET @taxeAmountWithCurrency = 0;

 

    UPDATE Sales.DocumentLineTaxe 
    SET TaxeValue = @taxeAmount, TaxeValueWithCurrency = @taxeAmountWithCurrency,
    TaxeBase = @taxeBase , TaxeBaseWithCurrency = @taxeBaseWithCurrency  where CURRENT OF dlt_cursor
    
    FETCH NEXT FROM dlt_cursor INTO @idTaxe ,@IdDocumentLine, @taxeAmount , @taxeAmountWithCurrency , @taxeBase , @taxeBaseWithCurrency;
    END;
CLOSE dlt_cursor;
DEALLOCATE dlt_cursor;


-- Youssef update documentTaxResume 11/01/2021
GO
DECLARE @id int;
DECLARE @exchangeRate float = 1;
DECLARE @DocumentTtcprice float;
DECLARE @DocumentHtprice float;
DECLARE @DocumentOtherTaxes float;
DECLARE @idTaxe int;
DECLARE @taxeValue float;
DECLARE @taxeValueWithCurrency float;
DECLARE @taxeBase float;
DECLARE @taxeBaseWithCurrency float,@message VARCHAR(800);
DECLARE @idUsedCurrency int;
DECLARE @TiersPrecision int;
DECLARE @CompanyPrecision int;
DECLARE @DiscountAmount float;
DECLARE @DiscountAmountWithCurrency float;
DECLARE @ExcVatTaxAmount float;
DECLARE @ExcVatTaxAmountWithCurrency float;

 


DECLARE dc_cursor CURSOR  FAST_FORWARD 
    FOR SELECT Id, ExchangeRate,DocumentTtcprice,DocumentHTPrice,DocumentOtherTaxes, IdUsedCurrency FROM [Sales].[Document] 
    WHERE IsDeleted = 0 ;

 

OPEN dc_cursor;

 

FETCH NEXT FROM dc_cursor INTO @id , @exchangeRate,@DocumentTtcprice,@DocumentHtprice,@DocumentOtherTaxes, @idUsedCurrency;

 

WHILE @@FETCH_STATUS = 0

 

BEGIN
/*
    set exchangeRate
*/
IF @exchangeRate  is Null
    SET @exchangeRate = 1
    

 

IF @DocumentOtherTaxes  is Null
    SET @DocumentOtherTaxes = 0

 

SET @DocumentTtcprice = @DocumentHtprice + @DocumentOtherTaxes;
    /*
    update taxeValueWithCurrency et taxeBaseWithCurrency into documentLineTaxe
*/
    
    /*
    getTiersPrecision
*/
    SELECT @TiersPrecision= Precision FROM Administration.Currency
    WHERE id = @idUsedCurrency;

 

    /*
    get CompanyPrecision
*/
    SELECT @CompanyPrecision = Precision FROM Administration.Currency 
    WHERE id = (SELECT IdCurrency FROM Shared.Company LIMIT1)

 

    DECLARE dlt_cursor CURSOR  FAST_FORWARD 
    FOR SELECT IdTaxe, sum(d.TaxeValue), sum(d.TaxeValueWithCurrency),sum(TaxeBase), sum(d.TaxeBaseWithCurrency),
    sum(ROUND((dl.DiscountPercentage /100) * dl.HtUnitAmountWithCurrency,@TiersPrecision) * @exchangeRate * dl.MovementQty),sum((dl.DiscountPercentage /100) * dl.HtUnitAmountWithCurrency * dl.MovementQty),
    sum(dl.ExcVatTaxAmount), sum(dl.ExcVatTaxAmountWithCurrency) FROM [Sales].[DocumentLineTaxe] d,
    [Sales].[DocumentLine] dl
        WHERE d.IsDeleted = 0 and d.IdDocumentLine = dl.Id and d.IdDocumentLine IN (SELECT Id FROM [Sales].[DocumentLine] WHERE IdDocument = @id and IsDeleted = 0)
    group by IdTaxe;

 

    OPEN dlt_cursor;

 

    FETCH NEXT FROM dlt_cursor INTO @idTaxe , @taxeValue , @taxeValueWithCurrency , @taxeBase , @taxeBaseWithCurrency ,@DiscountAmount , @DiscountAmountWithCurrency , @ExcVatTaxAmount,@ExcVatTaxAmountWithCurrency;

 

    WHILE @@FETCH_STATUS = 0

 

    BEGIN
    
    INSERT INTO [Sales].[DocumentTaxsResume] (Id_Tax,HtAmount,HtAmountWithCurrency,TaxAmount,TaxAmountWithCurrency,IsDeleted,IdDocument,DiscountAmount,DiscountAmountWithCurrency ,ExcVatTaxAmount, ExcVatTaxAmountWithCurrency) VALUES(@idTaxe,ROUND(@taxeBase,@CompanyPrecision),ROUND(@taxeBaseWithCurrency,@TiersPrecision),ROUND(@taxeValue,@CompanyPrecision),ROUND(@taxeValueWithCurrency,@TiersPrecision),0, @id, ROUND(@DiscountAmount,@CompanyPrecision),ROUND(@DiscountAmountWithCurrency,@TiersPrecision),ROUND(@ExcVatTaxAmount,@CompanyPrecision),ROUND(@ExcVatTaxAmountWithCurrency,@TiersPrecision));
    
    
    
    FETCH NEXT FROM dlt_cursor INTO @idTaxe , @taxeValue , @taxeValueWithCurrency , @taxeBase , @taxeBaseWithCurrency ,@DiscountAmount , @DiscountAmountWithCurrency , @ExcVatTaxAmount,@ExcVatTaxAmountWithCurrency;
    END;

 


    CLOSE dlt_cursor;
	DEALLOCATE dlt_cursor;
FETCH NEXT FROM dc_cursor INTO @id , @exchangeRate,@DocumentTtcprice,@DocumentHtprice,@DocumentOtherTaxes, @idUsedCurrency;
END;

CLOSE dc_cursor;
DEALLOCATE dc_cursor;