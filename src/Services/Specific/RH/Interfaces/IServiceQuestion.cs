using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceQuestion : IService<QuestionViewModel, Question>
    {
        void DeleteQuestionModelwithouTransaction(int id, string tableName, string userMail, bool hasQuestionRight);
    }
}
