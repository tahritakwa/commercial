-- Nesrin add AdditionalHour and AdditionalHourSlot tables 23/12/2020
GO
CREATE TABLE [Payroll].[AdditionalHour] (
    [Id]                 INT             IDENTITY (1, 1) NOT NULL,
    [Code]               NVARCHAR (50)   NOT NULL,
    [Name]               NVARCHAR (255)  NOT NULL,
    [Description]        NVARCHAR (1000) NULL,
    [IsDeleted]          BIT             NOT NULL,
    [TransactionUserId]  INT             NULL,
    [Deleted_Token]      NVARCHAR (255)  NULL,
    [Worked]             BIT             NOT NULL,
    [IncreasePercentage] FLOAT (53)      NOT NULL,
    CONSTRAINT [PK_AdditionalHour] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
CREATE TABLE [Payroll].[AdditionalHourSlot] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [StartTime]         TIME (7)       NOT NULL,
    [EndTime]           TIME (7)       NOT NULL,
    [IsDeleted]         BIT            NOT NULL,
    [TransactionUserId] INT            NULL,
    [Deleted_Token]     NVARCHAR (255) NULL,
    [IdAdditionalHour]  INT            NOT NULL,
    CONSTRAINT [PK_AdditionalHourSlot] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [Payroll].[AdditionalHourSlot] WITH NOCHECK
    ADD CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour] FOREIGN KEY ([IdAdditionalHour]) REFERENCES [Payroll].[AdditionalHour] ([Id]);
GO
ALTER TABLE [Payroll].[AdditionalHourSlot] WITH CHECK CHECK CONSTRAINT [FK_AdditionalHourSlot_AdditionalHour];
-- Amine : change the AssignmentPercentage not null value 23/12/2020
	 ALTER TABLE [Payroll].[EmployeeTeam]
DROP COLUMN [AssignmentPercentage]; 

ALTER TABLE [Payroll].[EmployeeTeam]
ADD [AssignmentPercentage] float DEFAULT ((0)) NOT NULL;

-- Nesrin : add AdditionalHour1, AdditionalHour2, AdditionalHour3, AdditionalHour4 in Attendance 24/12/20202
GO
ALTER TABLE [Payroll].[Attendance]
    ADD [AdditionalHourOne] FLOAT (53) DEFAULT ((0)) NOT NULL,
        [AdditionalHourTwo] FLOAT (53) DEFAULT ((0)) NOT NULL,
        [AdditionalHourThree] FLOAT (53) DEFAULT ((0)) NOT NULL,
        [AdditionalHourFour] FLOAT (53) DEFAULT ((0)) NOT NULL;