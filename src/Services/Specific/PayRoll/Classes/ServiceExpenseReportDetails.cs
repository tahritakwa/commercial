using Microsoft.Extensions.Options;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.IO;
using Utils.Constants;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceExpenseReportDetails : Service<ExpenseReportDetailsViewModel, ExpenseReportDetails>, IServiceExpenseReportDetails
    {

        public ServiceExpenseReportDetails(IRepository<ExpenseReportDetails> entityRepo, IUnitOfWork unitOfWork,
            IExpenseReportDetailsBuilder builder, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues,
            IRepository<Company> entityRepoCompany,
            IOptions<AppSettings> appSettings)
            : base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues,
                   appSettings, entityRepoCompany)
        {
        }

        /// <summary>
        /// Save Pictures and update the attachement Url
        /// </summary>
        /// <param name="model"></param>
        private void ManageFiles(ExpenseReportDetailsViewModel model)
        {

            if (string.IsNullOrEmpty(model.AttachmentUrl))
            {
                if (model.FilesInfos != null && model.FilesInfos.Count > NumberConstant.Zero)
                {
                    model.AttachmentUrl = Path.Combine("PayRoll", "ExpenseReport", Guid.NewGuid().ToString());
                    CopyFiles(model.AttachmentUrl, model.FilesInfos);
                }
            }
            else
            {
                if (model.FilesInfos != null)
                {
                    DeleteFiles(model.AttachmentUrl, model.FilesInfos);
                    CopyFiles(model.AttachmentUrl, model.FilesInfos);
                }
            }


        }
        /// <summary>
        /// Add ExpenseReportDetails with files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public object AddModelWithFiles(ExpenseReportDetailsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // Add Files
            ManageFiles(model);
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, null);
        }

        /// <summary>
        /// Update ExpenseReportDetails with files
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public void UpdateModelWithFiles(ExpenseReportDetailsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            // Add Files
            ManageFiles(model);
            base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
        }
    }
}
