using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Shared.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Shared.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Reporting.Generic;

namespace Services.Specific.Shared.Classes
{
    public class ServiceTaxe : Service<TaxeViewModel, Taxe>, IServiceTaxe
    {

        private readonly IReducedTaxeBuilder _reducedBuilder;
        private readonly IRepository<Document> _entityRepoDocument;

        public ServiceTaxe(IRepository<Taxe> entityRepo,
            IUnitOfWork unitOfWork,
            ITaxeBuilder builder, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IReducedTaxeBuilder reducedBuilder,
            IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<Document> entityRepoDocument)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _reducedBuilder = reducedBuilder;
            _entityRepoDocument = entityRepoDocument;
        }

        public override DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _reducedBuilder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };
        }

        public DateTime? GenerateDate(string date)
        {
            return (!date.Equals("-1")) ? new DateTime(int.Parse(date.Split(",")[0]), int.Parse(date.Split(",")[1]), int.Parse(date.Split(",")[2])) : (DateTime?)null;
        }
        public void getUsedCurrency(DownloadReportDataViewModel data)
        {
            UpdateReportSettings(data);
            DateTime? sdate = GenerateDate(data.Reportparameters.startdate.Value);
            DateTime? edate = GenerateDate(data.Reportparameters.enddate.Value);
            int idtier = (int)data.Reportparameters.idTier.Value;
            bool ispurchase = data.Reportparameters.isPurchaseType.Value;
            List<int> idsCurrency = new List<int>();
            if (ispurchase)
            {
                idsCurrency = _entityRepoDocument.GetAllWithConditionsQueryable(
                    x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero && DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero &&
            x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft &&
            x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Supplier && x.DocumentTypeCode == DocumentEnumerator.PurchaseInvoice &&
            (idtier > 0 ? x.IdTiers == idtier : true) && x.IdUsedCurrency != null).Select(x => (int)x.IdUsedCurrency).Distinct().ToList();
            }
            else
            {
                idsCurrency = _entityRepoDocument.GetAllWithConditionsQueryable(
                    x => DateTime.Compare(x.DocumentDate.Date, sdate.Value.Date) >= NumberConstant.Zero && DateTime.Compare(x.DocumentDate.Date, edate.Value.Date) <= NumberConstant.Zero &&
            x.IdDocumentStatus != (int)DocumentStatusEnumerator.Provisional && x.IdDocumentStatus != (int)DocumentStatusEnumerator.Draft &&
            x.IdTiersNavigation.IdTypeTiers == (int)TiersType.Customer && x.DocumentTypeCode == DocumentEnumerator.SalesInvoice &&
            (idtier > 0 ? x.IdTiers == idtier : true) && x.IdUsedCurrency != null).Select(x => (int)x.IdUsedCurrency).Distinct().ToList();
            }
            data.ListIds = idsCurrency.ToArray();
        }

        public override object UpdateModelWithoutTransaction(TaxeViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            TaxeViewModel currentTaxe = GetModelAsNoTracked(x => x.Id == model.Id);
            if(currentTaxe != null && currentTaxe.CodeTaxe != null && currentTaxe.CodeTaxe == "TVA_Avance0%")
            {
                model = currentTaxe;
            }
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
           
        }

        }
}
