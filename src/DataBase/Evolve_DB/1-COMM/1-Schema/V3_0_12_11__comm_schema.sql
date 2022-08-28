---Ghazoua add WasLead to tiers and contact table , add creationDate to contact 31/05/2021
ALTER TABLE [Sales].[Tiers]
    ADD  [WasLead] BIT            DEFAULT ('false') NOT NULL;

ALTER TABLE [Shared].[Contact]
     ADD  [WasLead]  BIT            DEFAULT ('false') NOT NULL; 

        ALTER TABLE [Shared].[Contact]
    ADD [CreationDate] DATE NULL;
