-- Nesrin : add State column in CnssDeclaration table 10/12/2020

GO
ALTER TABLE [Payroll].[CnssDeclaration]
    ADD [State] BIT CONSTRAINT [DF_CnssDeclaration_State] DEFAULT ((1)) NOT NULL;

--- Donia : add resignedFromEmployeeExit 14/12/2020
ALTER TABLE [Payroll].[Employee]
    ADD [ResignedFromExitEmployee] BIT CONSTRAINT [DF_Employee_ResignedFromExitEmployee] DEFAULT ((0)) NOT NULL;