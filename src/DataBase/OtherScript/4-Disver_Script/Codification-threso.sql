update x  set x.Code = concat('IS20-000', substring (concat ('000000', x.Deleted_Token),LEN(concat ('00000'-5, x.Deleted_Token)) ,5)) from 

(select Code , ROW_NUMBER() OVER (ORDER BY id) as Deleted_Token from Sales.FinancialCommitment where (IsDeleted =0 and 

 IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-Sa' )))as x 
  
 select code  from Sales.FinancialCommitment where   IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-Sa' )

 
 update x  set x.Code = concat('AS20-000', substring (concat ('000000', x.Deleted_Token),LEN(concat ('00000'-5, x.Deleted_Token)) ,5)) from 

(select Code , ROW_NUMBER() OVER (ORDER BY id) as Deleted_Token from Sales.FinancialCommitment where (IsDeleted =0 and 

 IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'IA-SA' )))as x 
  
 select code  from Sales.FinancialCommitment where   IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'IA-SA' )


 update x  set x.Code = concat('IP20-000', substring (concat ('000000', x.Deleted_Token),LEN(concat ('00000'-5, x.Deleted_Token)) ,5)) from 

(select Code , ROW_NUMBER() OVER (ORDER BY id) as Deleted_Token from Sales.FinancialCommitment where (IsDeleted =0 and 

 IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-PU' )))as x 
  
 select code  from Sales.FinancialCommitment where   IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-PU' )


 update x  set x.Code = concat('AP20-000', substring (concat ('000000', x.Deleted_Token),LEN(concat ('00000'-5, x.Deleted_Token)) ,5)) from 

(select Code , ROW_NUMBER() OVER (ORDER BY id) as Deleted_Token from Sales.FinancialCommitment where (IsDeleted =0 and 

 IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'A-PU' )))as x 
  
 select code  from Sales.FinancialCommitment where   IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'A-PU' )



 update ERPSettings.Codification set LastCounterValue = substring (x.code,6,8)  from ( select top 1 Code as code  from Sales.FinancialCommitment where IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'A-PU' )
order by  Id desc) as x 
where Id = 393

 update ERPSettings.Codification set LastCounterValue = substring (x.code,6,8)  from ( select top 1 Code as code  from Sales.FinancialCommitment where IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-PU' )
order by  Id desc) as x 
where Id = 389


 update ERPSettings.Codification set LastCounterValue = substring (x.code,6,8)  from ( select top 1 Code as code  from Sales.FinancialCommitment where IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'IA-SA' )
order by  Id desc) as x 
where Id = 385


 update ERPSettings.Codification set LastCounterValue = substring (x.code,6,8)  from ( select top 1 Code as code  from Sales.FinancialCommitment where IsDeleted =0 and IdDocument in (select Id from Sales.Document where DocumentTypeCode = 'I-Sa' )
order by  Id desc) as x 
where Id = 284


