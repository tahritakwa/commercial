using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Reporting.Interfaces;
using ViewModels.DTO.Administration;
using ViewModels.DTO.Reporting;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.Reporting.Classes
{
    public class DocumentReportingBuilder : GenericBuilder<DocumentReportingViewModel, Document>, IDocumentReportingBuilder
    {

        //private readonly IDocumentLineReportingBuilder _documentLineReportingBuilder;

        //public DocumentReportingBuilder(IDocumentLineReportingBuilder documentLineReportingBuilder)
        //{
        //    _documentLineReportingBuilder = documentLineReportingBuilder;
        //}

        public override DocumentReportingViewModel BuildEntity(Document entity)
        {

            DocumentReportingViewModel model = base.BuildEntity(entity);

            /**************************** Document Line*************************/
            //
            //if (entity.DocumentLine != null && entity.DocumentLine.Count > 0)
            //{
            //    model.DocumentLine = entity.DocumentLine.Select(_documentLineReportingBuilder.BuildEntity).ToList();
            //}


            /****************************Tiers*************************/
            // Set tiers
            if (model.IdTiersNavigation == null)
            {
                model.IdTiersNavigation = new TiersViewModel();
            }
            // Affect codeTiers of tiers if null
            if (model.IdTiersNavigation.CodeTiers == null)
            {
                model.IdTiersNavigation.CodeTiers = string.Empty;
            }
            // Affect name of tiers if null
            if (model.IdTiersNavigation.Name == null)
            {
                model.IdTiersNavigation.Name = string.Empty;
            }
            // Affect adress of tiers if null
            if (model.IdTiersNavigation.Adress == null)
            {
                model.IdTiersNavigation.Adress = string.Empty;
            }
            // Affect region of tiers if null
            if (model.IdTiersNavigation.Region == null)
            {
                model.IdTiersNavigation.Region = string.Empty;
            }
            // Affect MatriculeFiscale of tiers if null
            if (model.IdTiersNavigation.MatriculeFiscale == null)
            {
                model.IdTiersNavigation.MatriculeFiscale = string.Empty;
            }



            /****************************Contact*************************/
            // Set contact
            if (model.IdContactNavigation == null)
            {
                model.IdContactNavigation = new ContactViewModel();
            }
            // Affect FirstName of contact if null
            if (model.IdContactNavigation.FirstName == null)
            {
                model.IdContactNavigation.FirstName = string.Empty;
            }
            // Affect LastName of contact if null
            if (model.IdContactNavigation.LastName == null)
            {
                model.IdContactNavigation.LastName = string.Empty;
            }
            // Affect Fonction of contact if null
            if (model.IdContactNavigation.Fonction == null)
            {
                model.IdContactNavigation.Fonction = string.Empty;
            }
            // Affect Tel1 of contact if null
            if (model.IdContactNavigation.Tel1 == null)
            {
                model.IdContactNavigation.Tel1 = string.Empty;
            }
            // Affect Email of contact if null
            if (model.IdContactNavigation.Email == null)
            {
                model.IdContactNavigation.Email = string.Empty;
            }




            /****************************Currency*************************/
            // Set used currency
            if (model.IdUsedCurrencyNavigation == null)
            {
                model.IdUsedCurrencyNavigation = new CurrencyViewModel();
            }
            // Affect symbol of currency if null
            if (model.IdUsedCurrencyNavigation.Symbole == null)
            {
                model.IdUsedCurrencyNavigation.Symbole = string.Empty;
            }


            /****************************bank account*************************/
            // Set bank account
            if (model.IdBankAccountNavigation == null)
            {
                model.IdBankAccountNavigation = new BankAccountViewModel();
            }
            // Affect iban of BankAccount if null
            if (model.IdBankAccountNavigation.Iban == null)
            {
                model.IdBankAccountNavigation.Iban = string.Empty;
            }
            // Affect bic of BankAccount if null
            if (model.IdBankAccountNavigation.Bic == null)
            {
                model.IdBankAccountNavigation.Bic = string.Empty;
            }



            /****************************settlement mode*************************/
            // Set settlement mode
            if (model.IdSettlementModeNavigation == null)
            {
                model.IdSettlementModeNavigation = new SettlementModeViewModel();
            }
            // Affect label of SettlementMode if null
            if (model.IdSettlementModeNavigation.Label == null)
            {
                model.IdSettlementModeNavigation.Label = string.Empty;
            }

            // Affect Tel1
            if (!string.IsNullOrEmpty(entity.Tel1))
            {
                model.TelTiers = entity.Tel1;
            }
            else
            {
                model.TelTiers = string.Empty;
            }
            // Affect Reference
            if (!string.IsNullOrEmpty(entity.Reference))
            {
                model.Reference = entity.Reference;
            }
            else
            {
                model.Reference = string.Empty;
            }
            // Affect MatriculeFiscale
            if (!string.IsNullOrEmpty(entity.MatriculeFiscale))
            {
                model.MFTiers = entity.MatriculeFiscale;
            }
            else
            {
                model.MFTiers = entity.IdTiersNavigation!=null && entity.IdTiersNavigation.MatriculeFiscale!=null ? entity.IdTiersNavigation.MatriculeFiscale : string.Empty;
            }
            // Affect Name
            if (!string.IsNullOrEmpty(entity.Name))
            {
                model.NameTiers = entity.Name;
            }
            else
            {
                model.NameTiers = entity.IdTiersNavigation != null && entity.IdTiersNavigation.Name != null ? entity.IdTiersNavigation.Name : string.Empty;
            }




            return model;
        }


    }
}
