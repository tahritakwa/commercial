using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.RH.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceQuestion : Service<QuestionViewModel, Question>, IServiceQuestion
    {
        private readonly IRepository<Employee> _entityRepoEmployee;
        private readonly IRepository<Review> _reviewRepository;
        private readonly IRepository<Interview> _interviewRepository;
        public ServiceQuestion(IRepository<Question> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<User> entityRepoUser,
           IRepository<Review> reviewRepository, IRepository<Interview> interviewRepository,
           IUnitOfWork unitOfWork,
           IQuestionBuilder builder,
           IRepository<Employee> entityRepoEmployee,
           IEntityAxisValuesBuilder builderEntityAxisValues) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoEmployee = entityRepoEmployee;
            _reviewRepository = reviewRepository;
            _interviewRepository = interviewRepository;
        }

        public override void BulkUpdateModelWithoutTransaction(IList<QuestionViewModel> models, string userMail)
        {
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            Interview interview = _interviewRepository.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdInterview, x => x.IdReviewNavigation);
            // Only superHierarchic or the manager can add review questions
            if (connectedEmployee.Id == interview.IdReviewNavigation.IdEmployeeCollaborator)
            {
                throw new CustomException(CustomStatusCode.ReviewEditException);
            }
            base.BulkUpdateModelWithoutTransaction(models, userMail);
        }
        /// <summary>
        /// DeleteModelwithouTransaction
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public void DeleteQuestionModelwithouTransaction(int id, string tableName, string userMail, bool hasQuestionRight)
        {
            // Only the Super hierarchic can delete the question
            if (!hasQuestionRight)
            {
                throw new CustomException(CustomStatusCode.ReviewQuestionException);
            }
            base.DeleteModelwithouTransaction(id, tableName, userMail);
        }
    }
}
