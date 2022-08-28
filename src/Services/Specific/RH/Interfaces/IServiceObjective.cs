using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceObjective : IService<ObjectiveViewModel, Objective>
    {
        void DeleteObjectiveModelwithouTransaction(int id, string tableName, string userMail, bool hasRight);
    }
}
