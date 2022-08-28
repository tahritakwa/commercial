using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Linq.Expressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Sales.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Sales;
using ViewModels.DTO.Utils;

namespace Services.Specific.Sales.Classes
{
    public class ServiceExpense : Service<ExpenseViewModel, Expense>, IServiceExpense
    {
        const string entityToDelete = "EntityToDelete";
        const string expenseConst = "Expense";
        const string documntLine = "DocumentLine";
        const string entityNameRelated = "EntityNameReleated";
        private readonly IServiceItem _serviceItem;
        private readonly IServiceNature _serviceNature;
        private readonly IServiceTaxeItem _serviceTaxeItem;
        private readonly IRepository<ItemTiers> _itemTiersRepo;
        private readonly IRepository<Tiers> _tiersRepo;
        private readonly IServiceItemTiers _serviceItemTiers;
        public ServiceExpense(IRepository<Expense> entityRepo, IUnitOfWork unitOfWork,

          IExpenseBuilder expenseBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceItem serviceItem, IServiceNature serviceNature,

          IRepository<Entity> entityRepoEntity, IRepository<EntityCodification> entityRepoEntityCodification,
          IRepository<Codification> entityRepoCodification, IServiceTaxeItem serviceTaxeItem, IRepository<ItemTiers> itemTiersRepo,
          IRepository<Tiers> tiersRepo, IServiceItemTiers serviceItemTiers)
            : base(entityRepo, unitOfWork, expenseBuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _serviceItem = serviceItem;
            _serviceNature = serviceNature;
            _serviceTaxeItem = serviceTaxeItem;
            _itemTiersRepo = itemTiersRepo;
            _tiersRepo = tiersRepo;
            _serviceItemTiers = serviceItemTiers;
        }

        /// <summary>
        /// Add a new Expense and new Item related to the new expense 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(ExpenseViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {

            dynamic entity = _builder.BuildModel(model);

            var existingExpense = _entityRepo.FindSingleBy(x => x.Code == model.Code);
            if (existingExpense != null)
            {
                throw new CustomException(CustomStatusCode.DuplicatedExpenseCode);
            }

            // Generate Codification
            GenerateCodification(entity, property, false);

            // Create Item Form Expense Model
            List<ItemTiersViewModel> expenseTiersList = new List<ItemTiersViewModel>();
            if (model.ItemTiers != null && model.ItemTiers.Any())
            {
                expenseTiersList = model.ItemTiers.ToList();
            }
            ItemViewModel itemToCreate = new ItemViewModel
            {
                Id = 0,
                Description = model.Description,
                IdNature = _serviceNature.GetModel(nature => nature.Code == Constants.EXPENSE).Id,
                ItemTiers = expenseTiersList
            };
            itemToCreate.TaxeItem.Add(new TaxeItemViewModel
            {
                IdTaxe = model.IdTaxe
            });

            // add entity
            object itemRelatedToExpense = _serviceItem.AddModelWithoutTransaction(itemToCreate, entityAxisValuesModelList, userMail, null);
            entity.IdItem = ((CreatedDataViewModel)itemRelatedToExpense).Id;
            _entityRepo.Add(entity);
            _unitOfWork.Commit();

            // add entityAxesValues
            AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entity.GetType().Name.ToUpper() };
            }
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };

        }
        /// <summary>
        /// Update expense and the related Item
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object UpdateModelWithoutTransaction(ExpenseViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            var existingExpense = _entityRepo.FindByAsNoTracking(x => x.Code == model.Code).FirstOrDefault();
            if (existingExpense != null && existingExpense.Id != model.Id)
            {
                throw new CustomException(CustomStatusCode.DuplicatedExpenseCode);
            }
            // Update Item related to Item Form Expense Model
            ItemViewModel itemRelatedToExpense = _serviceItem.GetModelWithRelationsAsNoTracked(item => item.Id == model.IdItem, r => r.TaxeItem, r => r.ItemTiers);
            if (itemRelatedToExpense.ItemTiers == null && model.ListTiers != null)
            {
                itemRelatedToExpense.ItemTiers = new List<ItemTiersViewModel>();
                model.ListTiers.ToList().ForEach(y => {
                    ItemTiersViewModel itemtierToAdd = new ItemTiersViewModel
                    {
                        IdItem = model.IdItem,
                        IdTiers = y.Id
                    };
                    itemRelatedToExpense.ItemTiers.Add(itemtierToAdd);
                    _serviceItemTiers.AddModelWithoutTransaction(itemtierToAdd, new List<EntityAxisValuesViewModel>(), userMail);
                });
            }
            else if(model.ListTiers == null && itemRelatedToExpense.ItemTiers != null && itemRelatedToExpense.ItemTiers.Any())
            {
                _itemTiersRepo.QuerableGetAll().Where(x => x.IdItem == itemRelatedToExpense.Id).UpdateFromQuery(p => new ItemTiers
                {
                    IsDeleted = true,
                    DeletedToken = Guid.NewGuid().ToString()
                });
                itemRelatedToExpense.ItemTiers = null;
            }
            else if(model.ListTiers != null && itemRelatedToExpense.ItemTiers != null && itemRelatedToExpense.ItemTiers.Any())
            {
                List<ItemTiersViewModel> toDelete = new List<ItemTiersViewModel>();
                List<ItemTiersViewModel> listTiers = _serviceItemTiers.FindModelsByNoTracked(x => x.IdItem == model.IdItem).ToList();

                List<ItemTiersViewModel> newListTiers = model.ItemTiers != null ? model.ItemTiers.ToList() : null;
                if (newListTiers != null && newListTiers.Any())
                {
                    List<ItemTiersViewModel> toAdd = newListTiers.FindAll(x => x.Id == 0);
                    foreach (ItemTiersViewModel itemTier in toAdd)
                    {
                        itemTier.IdItem = model.IdItem;
                        itemTier.IdItemNavigation = null;
                        itemTier.IdTiersNavigation = null;
                        _serviceItemTiers.AddModelWithoutTransaction(itemTier, new List<EntityAxisValuesViewModel>(), userMail);
                    }
                    var newTiersId = newListTiers.Select(x => x.IdTiers);
                    toDelete = listTiers.FindAll(x => !newTiersId.Contains(x.IdTiers));
                }
                else
                {
                    toDelete = listTiers;
                }


                if (toDelete != null && toDelete.Any())
                {
                    foreach (ItemTiersViewModel itemTier in toDelete)
                    {
                        _serviceItemTiers.DeleteModelPhysicallyWhithoutTransaction(itemTier.Id, userMail);
                    }
                }
                itemRelatedToExpense.ItemTiers = _serviceItemTiers.GetAllModelsAsNoTracking().Where(x => x.IdItem == itemRelatedToExpense.Id).ToList();
            }
            itemRelatedToExpense.ListTiers = null;
            itemRelatedToExpense.ItemTiers = null;
            itemRelatedToExpense.Description = model.Description;
            itemRelatedToExpense.TaxeItem = new List<TaxeItemViewModel>();
            var taxeItem = _serviceTaxeItem.GetModelAsNoTracked(x => x.IdItem == model.IdItem);
            taxeItem.IdTaxe = model.IdTaxe;
            _serviceTaxeItem.UpdateModelWithoutTransaction(taxeItem, entityAxisValuesModelList, userMail);
            _serviceItem.UpdateModelWithoutTransaction(itemRelatedToExpense, entityAxisValuesModelList, userMail, property);
            dynamic entity = _builder.BuildModel(model);
            _entityRepo.Update(entity);
            _unitOfWork.Commit();

            // update entityAxesValues
            if (entityAxisValuesModelList != null && entityAxisValuesModelList.Any())
            {
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
            }
            // commit 
            _unitOfWork.Commit();
            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };

        }

        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            Expense expense = _entityRepo.GetSingleWithRelations(p => p.Id == id, r => r.IdItemNavigation, r => r.IdItemNavigation.DocumentLine, r => r.IdItemNavigation.ItemTiers,
            r => r.DocumentExpenseLine);
            if (!expense.DocumentExpenseLine.Any() && !expense.IdItemNavigation.DocumentLine.Any())
            {
                expense.IsDeleted = true;
                expense.DeletedToken = Guid.NewGuid().ToString("D", CultureInfo.InvariantCulture);
                expense.IdItemNavigation.IsDeleted = true;
                expense.IdItemNavigation.ItemTiers.ToList().ForEach(x =>
                x.IsDeleted = true);
                expense.IdItemNavigation.DeletedToken = Guid.NewGuid().ToString("D", CultureInfo.InvariantCulture);
                _entityRepo.Update(expense);
                _unitOfWork.Commit();
                if (GetPropertyName(expense) != null)
                {
                    return new CreatedDataViewModel { Id = (int)expense.Id, Code = getModelCode(expense, GetPropertyName(expense)), EntityName = expense.GetType().Name.ToUpper() };
                }

                return new CreatedDataViewModel { Id = (int)expense.Id, EntityName = expense.GetType().Name.ToUpper() };
            }
            else
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { entityToDelete, expenseConst }
                };
                paramtrs.Add(entityNameRelated, documntLine);
                //The entity is already used
                throw new CustomException(CustomStatusCode.DeleteError, paramtrs);
            }
        }
        public override ExpenseViewModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator;
            Expression<Func<Expense, bool>> predicate1 = PredicateUtility<Expense>.PredicateFilter(predicateModel, key);
            Expression<Func<Expense, object>>[] predicate2 = PredicateUtility<Expense>.PredicateRelation(predicateModel.Relation);
            var entity = _entityRepo.GetSingleWithRelations(predicate1, predicate2);
            
            var Listtiers = _tiersRepo.GetAllWithConditionsRelationsAsNoTracking(x => entity.IdItemNavigation.ItemTiers.Select(y => y.IdTiers).Contains(x.Id));
            entity.IdItemNavigation.ItemTiers.ToList().ForEach(x =>
            {
                x.IdTiersNavigation = Listtiers.Where(y => y.Id == x.IdTiers).FirstOrDefault();
            });
            var item = _builder.BuildEntity(entity);
            return item;
        }
        public override DataSourceResult<ExpenseViewModel> GetDataWithSpecificFilter(List<PredicateFormatViewModel> predicateModel)
        {
            PredicateFormatViewModel predicateModelWithSpecificFilters = new PredicateFormatViewModel();
            IQueryable<Expense> entities = null;
            PredicateFilterRelationViewModel<Expense> predicateFilterRelationModel = null;
            if (predicateModel != null)
            {
                GetDataWithGenericFilterRelation(predicateModel, ref predicateModelWithSpecificFilters, ref entities, predicateFilterRelationModel);
            }

            var result = GetDataWithSpecificFilterRelation(predicateModelWithSpecificFilters, entities, predicateFilterRelationModel);
            result.data.ToList().ForEach(p =>
            {
                if (p.ListTiers != null && p.ListTiers.Any())
                {
                    p.NamesTiers = p.ListTiers.Select(x => x.Name).ToList();
                    p.TiersNamesString = String.Join(", ", p.NamesTiers);
                }
            });
            return result;


        }
        public override DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<Expense> predicateFilterRelationModel)
        {
            IList<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).Include("IdItemNavigation.ItemTiers.IdTiersNavigation.IdCurrencyNavigation")
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList<dynamic>();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations).Include("IdItemNavigation.ItemTiers.IdTiersNavigation.IdCurrencyNavigation")
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList<dynamic>();
            }

            IList<dynamic> model = entities.Select(x => _builder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }


    }
}
