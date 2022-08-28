-- Nesrin : add constraint to Tiers table 10/12/2021

GO
ALTER TABLE [Sales].[Tiers] WITH NOCHECK
    ADD CONSTRAINT [FK_Tiers_SettlementMode] FOREIGN KEY ([IdSettlementMode]) REFERENCES [Sales].[SettlementMode] ([Id]);

GO
ALTER TABLE [Sales].[Tiers] WITH CHECK CHECK CONSTRAINT [FK_Tiers_SettlementMode];

