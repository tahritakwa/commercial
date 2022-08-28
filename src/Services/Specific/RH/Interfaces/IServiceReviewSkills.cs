using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceReviewSkills : IService<ReviewSkillsViewModel, ReviewSkills>
    {
        void DeleteReviewSkillsModelwithouTransaction(int id, string tableName, string userMail, bool hasRight);
    }
}
