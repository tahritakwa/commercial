ALTER TABLE [Shared].[ZipCode] DROP CONSTRAINT [UniqueCodeZipCode];

-- Youssef : add category label unicity 27/01/2021 ---
ALTER TABLE [Immobilisation].[Category]
    ADD CONSTRAINT [UniqueLabelImmobilisationCategory] UNIQUE NONCLUSTERED ([Label] ASC);