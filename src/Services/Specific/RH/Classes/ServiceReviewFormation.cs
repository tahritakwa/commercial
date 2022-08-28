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
    public class ServiceReviewFormation : Service<ReviewFormationViewModel, ReviewFormation>, IServiceReviewFormation
    {
        private readonly IRepository<Review> _reviewRepository;
        private readonly IServiceFormation _serviceFormation;
        private readonly IRepository<Employee> _entityRepoEmployee;
        public ServiceReviewFormation(IRepository<ReviewFormation> entityRepo,
       IRepository<EntityAxisValues> entityRepoEntityAxisValues,
       IServiceFormation serviceFormation,
       IRepository<Review> reviewRepository,
       IRepository<Employee> entityRepoEmployee,
       IUnitOfWork unitOfWork,
       IReviewFormationBuilder builder,
       IEntityAxisValuesBuilder builderEntityAxisValues) :
        base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _serviceFormation = serviceFormation;
            _reviewRepository = reviewRepository;
            _entityRepoEmployee = entityRepoEmployee;
        }
        public override void BulkAddWithoutTransaction(IList<ReviewFormationViewModel> models, string userMail, string property = null)
        {
            CheckValidDates(models);
            // Verify if they are no two viewModels which IdFormation are the same
            IEnumerable<IGrouping<int, ReviewFormationViewModel>> duplicatedFormation = models.GroupBy(x => x.IdFormation).Where(x => x.Count() > 1);
            if (duplicatedFormation.Any())
            {
                FormationViewModel formation = _serviceFormation.GetModelAsNoTracked(x => x.Id == duplicatedFormation.FirstOrDefault().Key);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Formation), formation.Label}
                };
                throw new CustomException(CustomStatusCode.DuplicateFormationException, paramtrs);
            }

            Review review = _reviewRepository.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdReview, x => x.IdEmployeeCollaboratorNavigation);

            // Verify if the viewModels has not the formation  which are already exist in reviewFormation
            IList<ReviewFormationViewModel> reviewFormationViewModels = GetAllModelsQueryable(x => x.IdReview == review.Id).ToList();
            reviewFormationViewModels.ToList().ForEach((reviewFormationViewModel) =>
            {
                models.ToList().ForEach((model) =>
                {
                    if (reviewFormationViewModel.IdFormation == model.IdFormation)
                    {
                        FormationViewModel foramation = _serviceFormation.GetModelAsNoTracked(x => x.Id == model.IdFormation);
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            {nameof(Formation), foramation.Label}
                        };
                        throw new CustomException(CustomStatusCode.DuplicateFormationException, paramtrs);
                    }
                });
            });

            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            // For each reviewFormation, set the IdEmployee to the connected employee Id
            models.ToList().ForEach(model =>
            {
                model.IdEmployee = connectedEmployee.Id;
            });
            CheckValidDates(models);
            base.BulkAddWithoutTransaction(models.ToList(), userMail, property);
        }
        public override void BulkUpdateModelWithoutTransaction(IList<ReviewFormationViewModel> models, string userMail)
        {
            // Verify if they are no two viewModels which IdFormation are the same
            IEnumerable<IGrouping<int, ReviewFormationViewModel>> duplicatedFormation = models.GroupBy(x => x.IdFormation).Where(x => x.Count() > 1);
            if (duplicatedFormation.Any())
            {
                FormationViewModel formation = _serviceFormation.GetModelAsNoTracked(x => x.Id == duplicatedFormation.FirstOrDefault().Key);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Formation), formation.Label}
                };
                throw new CustomException(CustomStatusCode.DuplicateFormationException, paramtrs);
            }
            // Get the old reviewFormation list
            IList<ReviewFormationViewModel> oldReviewFormationViewModels = FindModelsByNoTracked(rf => models.Any(m => m.Id == rf.Id)).ToList();
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            Review review = _reviewRepository.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdReview, x => x.IdEmployeeCollaboratorNavigation);
            // ForEach reviewFormation verify the condictions
            models.ToList().ForEach(model =>
            {
                // The old reviewFormation
                ReviewFormationViewModel oldReviewFormationViewModel = oldReviewFormationViewModels.FirstOrDefault(rf => rf.Id == model.Id);
                // if the collaborator  is connected, do not update the manager values
                if (connectedEmployee.Id == review.IdEmployeeCollaboratorNavigation.Id)
                {
                    model.FormationManagerStatus = oldReviewFormationViewModel.FormationManagerStatus;
                    model.ManagerComment = oldReviewFormationViewModel.ManagerComment;
                }
                // if is the superHierarchique or the manager is connected, do not update the collaborator values
                else
                {
                    model.FormationCollaboratorStatus = oldReviewFormationViewModel.FormationCollaboratorStatus;
                    model.CollaboratorComment = oldReviewFormationViewModel.CollaboratorComment;
                }
            });
            base.BulkUpdateModelWithoutTransaction(models, userMail);
        }

        private void CheckValidDates(IEnumerable<ReviewFormationViewModel> models)
        {
            Review currentReview = new Review();
            foreach (ReviewFormationViewModel model in models)
            {
                if (currentReview == null)
                {
                    currentReview = _reviewRepository.FindByAsNoTracking(x => x.Id == model.IdReview).First();
                }
                else if (model.Date.Value.BeforeDate(currentReview.ReviewDate))
                {
                    throw new CustomException(CustomStatusCode.InvalidFormationExpectedDate);
                }
            }
        }
        /// <summary>
        /// DeleteReviewFormationModelwithouTransaction
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        /// <param name="hasRight"></param>
        public void DeleteReviewFormationModelwithouTransaction(int id, string tableName, string userMail, bool hasRight)
        {
            // Only the author or the super hierarchique can delete the ReviewFormation
            if (!hasRight)
            {
                throw new CustomException(CustomStatusCode.DeleteReviewArrayException);
            }
            base.DeleteModelwithouTransaction(id, tableName, userMail);
        }
    }
}
