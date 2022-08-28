using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceReviewFormation : IService<ReviewFormationViewModel, ReviewFormation>
    {
        void DeleteReviewFormationModelwithouTransaction(int id, string tableName, string userMail, bool hasRight);
    }
}
