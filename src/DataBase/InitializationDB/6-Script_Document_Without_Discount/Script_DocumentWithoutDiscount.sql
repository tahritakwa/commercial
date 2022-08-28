--Ahmed : add document without discount : 12/10/2021 
INSERT INTO [ERPSettings].[ReportTemplate] ([IdEntity], [TemplateCode], [TemplateNameFr], [TemplateNameEn], [ReportCode], [ReportName]) VALUES 
(87,NULL, N'documentReportWithoutDiscount_fr', N'documentReportWithoutDiscount_en', N'D-SA', N'documentReportWithoutDiscount');
update [ERPSettings].[ReportTemplate] SET [TemplateCode]='BL_WITHOUT_DISCOUNT' where [ReportCode] like 'D-SA' and [ReportName] like 'documentReportWithoutDiscount';
update [ERPSettings].[ReportTemplate] SET [TemplateCode]='BL_WITH_DISCOUNT' where [ReportCode] like 'D-SA' and [ReportName] like 'documentReport';