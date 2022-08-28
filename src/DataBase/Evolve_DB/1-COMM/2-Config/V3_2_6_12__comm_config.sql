-- Ameni : update CostPrice value 18/11/2021
update Inventory.Item
set CostPrice =t2.CostPrice
from Inventory.Item
INNER join Sales.DocumentLine as t2
on Inventory.Item.Id = t2.Iditem
where t2.CostPrice >0

update Sales.DocumentLine
set CostPrice = t2.CostPrice
from Sales.DocumentLine
INNER join Inventory.Item as t2
on Sales.DocumentLine.IdItem = t2.Id
INNER join Sales.Document as t3
on Sales.DocumentLine.IdDocument = t3.Id
where t3.DocumentTypeCode like '%SA%'
