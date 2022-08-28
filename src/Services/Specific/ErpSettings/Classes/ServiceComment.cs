using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Services.Specific.PayRoll.Interfaces;
using System.Collections.Generic;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Utils;

namespace Services.Specific.ErpSettings.Classes
{
    /// <summary>
    /// Class SettingsService.
    /// </summary>
    /// <seealso cref="Infrastruture.Service.Service{ModelView.ErpSettings.ModuleViewModel, DataMapping.Models.Module}" />
    /// <seealso cref="SparkIt.Application.Services.ErpSettings.Interfaces.ISettingsService" />
    public class ServiceComment : Service<CommentViewModel, Comment>, IServiceComment
    {
        internal readonly IServiceEmployeeReduce _employeeServiceReduce;
        private readonly IRepository<User> _entityRepoUser;
        internal readonly ICommentBuilder _entityBuilder;

        public ServiceComment(IRepository<Comment> entityRepo, IUnitOfWork unitOfWork,
           ICommentBuilder entityBuilder,  IRepository<User> entityRepoUser,
           IRepository<EntityAxisValues> entityRepoEntityAxisValues, IRepository<Entity> entityRepoEntity, IEntityAxisValuesBuilder builderEntityAxisValues,
           IServiceEmployeeReduce employeeServiceReduce)
            : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _entityBuilder = entityBuilder;
            _entityRepoUser = entityRepoUser;
            _employeeServiceReduce = employeeServiceReduce;
            _entityRepoEntity = entityRepoEntity;
        }

        /// <summary>
        /// Get list of comments of current entity
        /// </summary>
        /// <param name="entityName"></param>
        /// <param name="idEntityCreated"></param>
        /// <returns></returns>
        public IList<CommentViewModel> GetComments(string entityName, int idEntityCreated)
        {
            IList<CommentViewModel> listOfComments = new List<CommentViewModel>();
            // Recuperate id entity from entityName
            Entity currentEntity = _entityRepoEntity.GetSingleWithRelations(c => c.EntityName == entityName);
            // Get list of comment from table comment
            if (currentEntity != null)
            {
                listOfComments = (_entityRepo.GetAllWithConditionsRelations(c => c.IdEntityReference == currentEntity.Id &&
                    c.IdEntityCreated == idEntityCreated)).Select(_entityBuilder.BuildEntity).ToList();
                //Recuperate employee information
                if (listOfComments != null && listOfComments.Any())
                {
                    foreach (CommentViewModel commentViewModel in listOfComments)
                    {
                        if (commentViewModel.EmailCreator != null)
                        {
                            commentViewModel.Employee = getEmployeeViewModel(commentViewModel.EmailCreator);
                        }
                    }
                }
            }
            //Return list of comment of current entity
            return listOfComments;
        }

        /// <summary>
        /// AddModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(CommentViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // Recuperate id entity from entityName
            Entity currentEntity = _entityRepoEntity.GetSingleWithRelations(c => c.EntityName == model.EntityName);
            model.IdEntityReference = currentEntity.Id;
            int idComment = ((CreatedDataViewModel)base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property)).Id;
            // Get Comment
            CommentViewModel commentViewModel = GetModelById(idComment);
            // Get employee
            commentViewModel.Employee = getEmployeeViewModel(userMail);
            return commentViewModel;
        }

        /// <summary>
        /// get Employee by userMail
        /// </summary>
        /// <param name="userMail"></param>
        /// <returns></returns>
        private EmployeeViewModel getEmployeeViewModel(string userMail)
        {
            EmployeeViewModel employeeViewModel = new EmployeeViewModel();
            // Get employee by email
            User user = _entityRepoUser.GetSingle(p => p.Email.Equals(userMail));
            if (user != null && user.IdEmployee.HasValue)
            {
                // Get employee with image
                employeeViewModel = _employeeServiceReduce.GetModelById(user.IdEmployee.Value);
            }
            else
            {
                employeeViewModel.Email = userMail;
            }
            return employeeViewModel;
        }
    }
}
