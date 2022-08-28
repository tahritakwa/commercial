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
    public class ServiceReviewSkills : Service<ReviewSkillsViewModel, ReviewSkills>, IServiceReviewSkills
    {
        private readonly IRepository<Skills> _entityRepoSkills;
        private readonly IRepository<Review> _entityRepoReview;
        private readonly IRepository<EmployeeSkills> _entityRepoEmployeeSkills;
        private readonly IRepository<Employee> _entityRepoEmployee;
        public ServiceReviewSkills(IRepository<ReviewSkills> entityRepo,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IRepository<User> entityRepoUser,
           IRepository<Skills> entityRepoSkills,
           IRepository<Review> entityRepoReview,
           IRepository<EmployeeSkills> entityRepoEmployeeSkills,
           IRepository<Employee> entityRepoEmployee,
           IUnitOfWork unitOfWork,
           IReviewSkillsBuilder builder,
           IEntityAxisValuesBuilder builderEntityAxisValues) :
            base(entityRepo, unitOfWork, builder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityRepoSkills = entityRepoSkills;
            _entityRepoReview = entityRepoReview;
            _entityRepoEmployeeSkills = entityRepoEmployeeSkills;
            _entityRepoEmployee = entityRepoEmployee;
        }

        public override void BulkAddWithoutTransaction(IList<ReviewSkillsViewModel> models, string userMail, string property = null)
        {
            // Verify if they are no two viewModels which IdSkills are the same
            IEnumerable<IGrouping<int, ReviewSkillsViewModel>> duplicatedReviewSkills = models.GroupBy(x => x.IdSkills).Where(x => x.Count() > 1);
            if (duplicatedReviewSkills.Any())
            {
                Skills skills = _entityRepoSkills.GetSingleNotTracked(x => x.Id == duplicatedReviewSkills.FirstOrDefault().Key);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Skills), skills.Label}
                };
                throw new CustomException(CustomStatusCode.DuplicateSkillsException, paramtrs);
            }
            Review review = _entityRepoReview.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdReview, x => x.IdEmployeeCollaboratorNavigation);
            // Verify if the viewModels has not the skills  which are already exist in reviewSkills
            IList<ReviewSkillsViewModel> reviewSkillsViewModels = GetAllModelsQueryable(x => x.IdReview == review.Id).ToList();
            reviewSkillsViewModels.ToList().ForEach((reviewSkill) =>
            {
                models.ToList().ForEach((model) =>
                {
                    if (reviewSkill.IdSkills == model.IdSkills)
                    {
                        Skills skills = _entityRepoSkills.GetSingleNotTracked(x => x.Id == model.IdSkills);
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            {nameof(Skills), skills.Label}
                        };
                        throw new CustomException(CustomStatusCode.DuplicateSkillsException, paramtrs);
                    }
                });
            });

            // Verify if the viewModels has not the skills  which are already exist in employeeSkills
            IList<EmployeeSkills> employeeSkillsViewModels = _entityRepoEmployeeSkills.FindByAsNoTracking(x => x.IdEmployee == review.IdEmployeeCollaboratorNavigation.Id).ToList();
            employeeSkillsViewModels.ToList().ForEach((employeeSkill) =>
            {
                models.ToList().ForEach((model) =>
                {
                    if (employeeSkill.IdSkills == model.IdSkills && !model.IsOld)
                    {
                        Skills  skills = _entityRepoSkills.GetSingleNotTracked(x => x.Id == model.IdSkills);
                        IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            {nameof(Skills), skills.Label}
                        };
                        throw new CustomException(CustomStatusCode.DuplicateSkillsException, paramtrs);
                    }
                });
            });
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));

            // For each reviewSkills, set the IdEmployee to the connected employee Id
            models.ToList().ForEach(model =>
            {
                model.IdEmployee = connectedEmployee.Id;
                // if the reviewSkills is not the employeeSkills
                if (!model.IsOld)
                {
                    model.IsOld = false;
                }
                // if the collaborator  is connected, do not update the manager values
                if (connectedEmployee.Id == review.IdEmployeeCollaboratorNavigation.Id)
                {
                    model.ManagerMark = null;
                }
                // if is the superHierarchique or the manager is connected, do not update the collaborator values
                else
                {
                    model.CollaboratorMark = null;
                }
            });
            base.BulkAddWithoutTransaction(models.ToList(), userMail, property);
        }

        public override void BulkUpdateModelWithoutTransaction(IList<ReviewSkillsViewModel> models, string userMail)
        {
            IEnumerable<IGrouping<int, ReviewSkillsViewModel>> duplicatedReviewSkills = models.GroupBy(x => x.IdSkills).Where(x => x.Count() > 1);
            if (duplicatedReviewSkills.Any())
            {
                Skills skills = _entityRepoSkills.GetSingleNotTracked(x => x.Id == duplicatedReviewSkills.FirstOrDefault().Key);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    {nameof(Skills), skills.Label}
                };
                throw new CustomException(CustomStatusCode.DuplicateSkillsException, paramtrs);
            }

            // Get the old reviewSkills list
            IList<ReviewSkillsViewModel> oldReviewSkillsViewModels = FindModelsByNoTracked(rs => models.Any(m => m.Id == rs.Id)).ToList();
            Employee connectedEmployee = _entityRepoEmployee.GetSingleNotTracked(x => x.Email.Equals(userMail));
            Review review = _entityRepoReview.GetSingleWithRelationsNotTracked(x => x.Id == models.FirstOrDefault().IdReview, x => x.IdEmployeeCollaboratorNavigation);
            // ForEach reviewSkills verify the condictions
            models.ToList().ForEach(model =>
            {
                // get the old reviewSkills
                ReviewSkillsViewModel oldReviewSkillsViewModel = oldReviewSkillsViewModels.FirstOrDefault(o => o.Id == model.Id);
                // If is old skills do not update the IdSkills and his rate
                if (oldReviewSkillsViewModel.IsOld)
                {
                    model.IdSkills = oldReviewSkillsViewModel.IdSkills;
                    model.OldRate = oldReviewSkillsViewModel.OldRate;
                }
                // if the collaborator  is connected, do not update the manager values
                if (connectedEmployee.Id == review.IdEmployeeCollaboratorNavigation.Id)
                {
                    model.ManagerMark = oldReviewSkillsViewModel.ManagerMark;
                }
                // if is the superHierarchique or the manager is connected, do not update the collaborator values
                else
                {
                    model.CollaboratorMark = oldReviewSkillsViewModel.CollaboratorMark;
                }
            });
            base.BulkUpdateModelWithoutTransaction(models, userMail);
        }
        /// <summary>
        /// DeleteReviewSkillsModelwithouTransaction
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        /// <param name="hasRight"></param>
        public void DeleteReviewSkillsModelwithouTransaction(int id, string tableName, string userMail, bool hasRight)
        {
            ReviewSkillsViewModel reviewSkills = GetModelAsNoTracked(x => x.Id == id);

            // Only the author or the super hierarchique can delete the ReviewFormation
            if (!hasRight)
            {
                throw new CustomException(CustomStatusCode.DeleteReviewArrayException);
            }

            // Can't delete the old skills of the employee
            if (reviewSkills.IsOld)
            {
                throw new CustomException(CustomStatusCode.ReviewSkillsDeleteException);
            }
            
            base.DeleteModelwithouTransaction(id, tableName, userMail);
        }
    }
}
