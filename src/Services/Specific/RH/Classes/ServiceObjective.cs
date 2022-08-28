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
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace Services.Specific.RH.Classes
{
    public class ServiceObjective : Service<ObjectiveViewModel, Objective>, IServiceObjective
    {

        private readonly IRepository<Review> _reviewRepository;
        private readonly IRepository<Employee> _entityRepoEmployee;
        public ServiceObjective(IRepository<Objective> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<User> entityRepoUser,
           IRepository<Employee> entityRepoEmployee,
           IRepository<Review> reviewRepository,
           IUnitOfWork unitOfWork,
           IObjectiveBuilder builder,
           IEntityAxisValuesBuilder builderEntityAxisValues) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _reviewRepository = reviewRepository;
            _entityRepoEmployee = entityRepoEmployee;
        }

        public override void BulkAddWithoutTransaction(IList<ObjectiveViewModel> models, string userMail, string property = null)
        {
            CheckValidDates(models);
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            models.ToList().ForEach((objective) =>
            {
                objective.IdEmployee = connectedEmployee.Id;
            });
            base.BulkAddWithoutTransaction(models, userMail, property);
        }

        public override void BulkUpdateModelWithoutTransaction(IList<ObjectiveViewModel> models, string userMail)
        {
            // Get the old objective list
            IList<ObjectiveViewModel> oldObjectiveViewModels = FindModelsByNoTracked(o => models.Any(m => m.Id == o.Id)).ToList();
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            Review review = _reviewRepository.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdReview, x => x.IdEmployeeCollaboratorNavigation);
            // ForEach objective verify the condictions
            models.ToList().ForEach(model =>
            {
                // The old objective
                ObjectiveViewModel oldObjectiveViewModel = oldObjectiveViewModels.FirstOrDefault(o => o.Id == model.Id);
                // If is pastObjective do not update the label and the excpected date
                
                // if the collaborator  is connected, do not update the manager values
                if (connectedEmployee.Id == review.IdEmployeeCollaboratorNavigation.Id)
                {
                    model.ObjectiveManagerStatus = oldObjectiveViewModel.ObjectiveManagerStatus;
                    model.DescriptionManager = oldObjectiveViewModel.DescriptionManager;
                }
                // if is the superHierarchique  or the manager is connected, do not update the collaborator values
                else
                {
                    model.ObjectiveCollaboratorStatus = oldObjectiveViewModel.ObjectiveCollaboratorStatus;
                    model.DescriptionCollaborator = oldObjectiveViewModel.DescriptionCollaborator;
                }
            });
            base.BulkUpdateModelWithoutTransaction(models, userMail);
        }
        /// <summary>
        /// DeleteObjectiveModelwithouTransaction
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        /// <param name="hasRight"></param>
        public void DeleteObjectiveModelwithouTransaction(int id, string tableName, string userMail, bool hasRight)
        {
            // Only the author or the super hierarchique can delete the objective
            if (!hasRight)
            {
                throw new CustomException(CustomStatusCode.DeleteReviewArrayException);
            }
            base.DeleteModelwithouTransaction(id, tableName, userMail);
        }

        private void CheckValidDates (IEnumerable<ObjectiveViewModel> models)
        {
            Review currentReview = new Review();
            foreach(ObjectiveViewModel model in models)
            {
                if (currentReview == null)
                {
                    currentReview = _reviewRepository.FindByAsNoTracking(x => x.Id == model.IdReview).First();
                } else if (model.ExpectedDate.BeforeDate(currentReview.ReviewDate))
                {
                    throw new CustomException(CustomStatusCode.InvalidObjectifExpectedDate);
                }
            }
        }
        
    }
}
