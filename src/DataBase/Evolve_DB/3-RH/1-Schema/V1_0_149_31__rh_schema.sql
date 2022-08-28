-- Nesrin : add State 21/12/2020
GO
ALTER TABLE [Payroll].[TransferOrder]
    ADD [State] BIT CONSTRAINT [DF_TransferOrder_State] DEFAULT ((1)) NOT NULL;