-- Nesrin : Update report template name for OSA, QSA and DSA	01/10/2021

BEGIN TRANSACTION
ALTER TABLE [ERPSettings].[ReportTemplate] DROP CONSTRAINT [FK_ReportTemplate_Entity]
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'documentReport_fr', [TemplateNameEn]=N'documentReport_en', [ReportName]=N'documentReport' WHERE [Id]=2
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'documentReport_fr', [TemplateNameEn]=N'documentReport_en', [ReportName]=N'documentReport' WHERE [Id]=4
UPDATE [ERPSettings].[ReportTemplate] SET [TemplateNameFr]=N'documentReport_fr', [TemplateNameEn]=N'documentReport_en', [ReportName]=N'documentReport' WHERE [Id]=8
ALTER TABLE [ERPSettings].[ReportTemplate]
    ADD CONSTRAINT [FK_ReportTemplate_Entity] FOREIGN KEY ([IdEntity]) REFERENCES [ERPSettings].[Entity] ([Id])
COMMIT TRANSACTION