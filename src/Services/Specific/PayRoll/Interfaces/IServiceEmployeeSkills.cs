using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Interfaces
{
    public interface IServiceEmployeeSkills : IService<EmployeeSkillsViewModel, EmployeeSkills>
    {
        DataSourceResult<EmployeeSkillsMatrixLine> GetSkillsMatrix(EmployeeSkillsMatrixFilter employeeSkillsMatrixFilter);
        object changeRating(EmployeeSkillsViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        DataSourceResult<EmployeeSkillsViewModel> GetPastReviewSkillsList(int idReview);
    }  
}
