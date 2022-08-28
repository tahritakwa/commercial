BEGIN TRANSACTION

UPDATE sales.Document
SET AttachmentUrl = REPLACE(AttachmentUrl, '\wwwroot\content\uploadFiles\', '')

UPDATE shared.Company
SET AttachmentUrl = REPLACE(AttachmentUrl, '\wwwroot\content\uploadFiles\', '')

UPDATE sales.Prices
SET AttachmentUrl = REPLACE(AttachmentUrl, '\wwwroot\content\uploadFiles\', '')

UPDATE payment.Settlement
SET AttachmentUrl = REPLACE(AttachmentUrl, '\wwwroot\content\uploadFiles\', '')

COMMIT TRANSACTION