USE [Catalog]
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CodeCompany_seq]') AND type = 'SO')
  CREATE SEQUENCE CodeCompany_seq
  AS int
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 99999
  NO CYCLE
  CACHE 10;
  go

