
GO
:setvar DatabaseName "MasterGuidTN"
:setvar DefaultFilePrefix "MasterGuidTN"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END

IF EXISTS (SELECT * FROM master.sys.databases WHERE name='MasterGuidTN')
BEGIN
USE [master]
ALTER DATABASE [$(DatabaseName)]  SET SINGLE_USER WITH ROLLBACK IMMEDIATE
END
GO

DROP DATABASE IF EXISTS [$(DatabaseName)]
GO

CREATE DATABASE [$(DatabaseName)]

GO