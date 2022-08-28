-- Ahmed : update report template 12/10/2021
update [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'genericDocumentReport_fr',[TemplateNameEn]=N'genericDocumentReport_en',[ReportName] =N'genericDocumentReport' where [ReportCode] in ('BE-PU', 'BS-SA'); 
update [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'documentReport_fr',[TemplateNameEn]=N'documentReport_en',[ReportName] =N'documentReport' where [ReportCode] in ('Q-SA', 'O-SA', 'D-SA') ;
update [ERPSettings].[ReportTemplate] SET [IdEntity] = 87 where [ReportCode] like 'D-SA';
