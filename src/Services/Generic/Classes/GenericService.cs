using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Persistence.Entities;
using Services.Generic.Interfaces;
using Settings.Exceptions;
using System;
using Serilog;
using System.Collections.Generic;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Extensions;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Utils;
using System.Data.SqlClient;
using Persistence.UnitOfWork.Interfaces;
using Persistence.Repository.Interfaces;
using Settings.Config;
using ViewModels.Builders.Generic.Interfaces;
using Persistence.Repository.Classes;
using Persistence;
using ViewModels.DTO.Common;
using ViewModels.DTO.DBConfig;
using System.IO;
using Utils.Enumerators.CommercialEnumerators;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System.Net.Http;
using Microsoft.AspNetCore.Http;
using System.Net.Http.Headers;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity> : IGenericService<TModel, TEntity>, IDisposable
        where TModel : class
        where TEntity : class
    {
        //Generic Parameters
        protected IGenericRepository<TEntity> _entityRepo;
        protected IGenericUnitOfWork _unitOfWork;
        protected IBuilder<TModel, TEntity> _builder;
        protected IGenericRepository<EntityAxisValues> _entityRepoEntityAxisValues;
        protected IBuilder<EntityAxisValuesViewModel, EntityAxisValues> _builderEntityAxisValues;

        private readonly ILogger<TEntity> _logger;
        //File Parameters
        protected AppSettings _appSettings;
        //Codification Parameters
        protected IGenericRepository<Entity> _entityRepoEntity;
        protected IGenericRepository<EntityCodification> _entityRepoEntityCodification;
        protected IGenericRepository<Codification> _entityRepoCodification;

        // Company repo
        protected IGenericRepository<Company> _entityRepoCompany;

        public GenericService(IGenericRepository<TEntity> entityRepo, IGenericUnitOfWork unitOfWork, ILogger<TEntity>? logger = null)
        {
            _entityRepo = entityRepo;
            _unitOfWork = unitOfWork;
            _logger = logger;
        }

        public virtual object AddModel(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)
        {
            try
            {
                BeginTransaction();
                var addedEntity = AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
                EndTransaction();
                if (isFromModal)
                {
                    return GetDataDropdown();
                }
                return addedEntity;
            }
            catch (CustomException ex)
            {
                // rollback transaction
                RollBackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntityToAdd", model.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(model.GetType()+ "*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name: AddModel(TModel model,IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("model = "+ JsonConvert.SerializeObject(model));
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("userMail = "+ userMail);
                throw ex;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        public virtual object AddModelWithoutTransaction(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            dynamic entity = _builder.BuildModel(model);

            // Generate Codification
            GenerateCodification(entity, property, false);

            // add entity
            _entityRepo.Add(entity);
            // add entityAxesValues
            //AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entity.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        /// <summary>
        /// Make bulk insert with transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkAdd(IList<TModel> models, string userMail, string property = null)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }
            try
            {
                BeginTransaction();
                BulkAddWithoutTransaction(models, userMail, property);
                EndTransaction();
            }
            catch (CustomException ex)
            {
                // rollback transaction
                RollBackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntitiesTypeToAdd", models.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(models.GetType()+ "*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name: BulkAdd(IList<TModel> models, string userMail, string property = null)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("models = "+ JsonConvert.SerializeObject(models));
                throw ex;
            }
            catch (Exception e)
            {
                // rollback transaction
                RollBackTransaction();
                VerifyDuplication(e);
                throw;
            }
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkAddWithoutTransaction(IList<TModel> models, string userMail, string property = null)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }
            IList<TEntity> entities = new List<TEntity>();
            models.ToList().ForEach(model =>
            {
                entities.Add(_builder.BuildModel(model));
            });

            // Generate Codification
            entities.ToList().ForEach(entity =>
            {
                GenerateCodification(entity, property, false);
            });

            // add entity
            _entityRepo.BulkAdd(entities);
            // commit
            _unitOfWork.Commit();
        }

        public void BulkAddWithoutTransactionMultiCodification(IList<TModel> models, string property, string value)
        {

            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }
            IList<TEntity> entities = new List<TEntity>();
            models.ToList().ForEach(model =>
            {
                entities.Add(_builder.BuildModel(model));
            });

            var codificationCounter = GetCodificationCounter(entities.FirstOrDefault(), property, value);
            if (entities.Count != NumberConstant.Zero)
            {
                SetCodification(entities, codificationCounter);
            }

            // add entity
            _entityRepo.BulkAdd(entities);
            // commit
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void BulkAddWithoutTransaction(IList<TEntity> models)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }

            // add entity
            _entityRepo.BulkAdd(models);
            // commit
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void BulkAddWithoutTransaction(IList<TModel> models)
        {
            var addedList = models.Select(x => _builder.BuildModel(x)).ToList();
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }
            // add entity
            _entityRepo.BulkAdd(addedList);
            // commit
            _unitOfWork.Commit();
        }


        /// <summary>
        ///   AddWithoutTransaction(TEntity models)
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void AddWithoutTransaction(TEntity models)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }

            // add entity
            _entityRepo.Add(models);
            // commit
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Bulk delete with transaction
        /// </summary>
        /// <param name="models"></param>
        public void BulkDelete(IList<TEntity> models)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                BulkDeleteWithoutTransaction(models);
                EndTransaction();
            }
            catch (CustomException ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntitiesTypeToDelete", models.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(models.GetType());
                ex.SpecificMessage.Append(" Sended Object data: ");
                ex.SpecificMessage.Append(models.ToString());
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append("  Method name:  BulkDelete(IList<TEntity> models)");
                // throw exception
                throw ex;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkDeleteWithoutTransaction(IList<TEntity> models)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }

            // remoove entity
            _entityRepo.RemoveRange(models.ToArray());
            // commit
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void BulkUpdateWithoutTransaction(IList<TEntity> models)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }

            // add entity
            _entityRepo.BulkUpdate(models);
            // commit
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Bulk update with transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        public virtual void BulkUpdateModel(IList<TModel> models, string userMail)
        {
            try
            {
                BeginTransaction();
                BulkUpdateModelWithoutTransaction(models, userMail);
                EndTransaction();
            }
            catch (CustomException ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntitiesTypeToUpdate", models.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(models.GetType()+ "*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name:  BulkUpdateModel(IList<TModel> models, string userMail)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("models = "+ JsonConvert.SerializeObject(models));
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("userMail = "+ userMail);
                // throw exception
                throw ex;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }

        /// <summary>
        /// Make bulk update without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkUpdateModelWithoutTransaction(IList<TModel> models, string userMail)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }
            IList<TEntity> entities = new List<TEntity>();
            models.ToList().ForEach(model =>
            {
                entities.Add(_builder.BuildModel(model));
            });

            // update entity
            _entityRepo.BulkUpdate(entities);
            // commit 
            _unitOfWork.Commit();

        }

        /// <summary>
        /// Make bulk update without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkUpdateModelWithoutTransaction(IList<TEntity> entities)
        {
            if (entities == null)
            {
                throw new ArgumentException(nameof(entities));
            }
            // update entity
            _entityRepo.BulkUpdate(entities);
            // commit 
            _unitOfWork.Commit();

        }


        /// <summary>
        /// Make bulk update without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public virtual void BulkUpdateModel(IList<TEntity> entities)
        {
            try
            {
                BeginTransaction();
                BulkUpdateModelWithoutTransaction(entities);
                EndTransaction();
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }

        }




        /// <summary>
        /// Bulk delete physically with transaction
        /// </summary>
        /// <param name="ids"></param>
        /// <param name="userMail"></param>
        public virtual void BulkDeleteModelsPhysically(IList<TModel> models, string userMail)
        {
            try
            {
                BeginTransaction();
                BulkDeleteModelsPhysicallyWhithoutTransaction(models, userMail);
                EndTransaction();
            }
            catch (CustomException ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntitiesTypeToDelete", models.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(models.GetType()+"*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name:  BulkDeleteModelsPhysically(IList<TModel> models, string userMail)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("models = " + JsonConvert.SerializeObject(models));
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("userMail = " + userMail);
                // throw exception
                throw;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }
        /// <summary>
        /// Bulk Delete physically an array of entities 
        /// </summary>
        /// <param name="ids"></param>
        /// <param name="userMail"></param>
        public virtual void BulkDeleteModelsPhysicallyWhithoutTransaction(IList<TModel> models, string userMail)
        {
            IList<TEntity> entitiesToDelete = new List<TEntity>();
            models.ToList().ForEach(model =>
            {
                //Get Entity With relations
                TEntity entityToDelete = _builder.BuildModel(model);
                entityToDelete = GetEntityWithCollectionsValues(entityToDelete);
                //Add entity to list
                entitiesToDelete.Add(entityToDelete);
            });
            // Bulk delete
            _entityRepo.BulkDeletePhysically(entitiesToDelete);
            // commit transaction
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Bulk Delete physically an array of entities 
        /// </summary>
        /// <param name="ids"></param>
        /// <param name="userMail"></param>
        public virtual void BulkDeleteModelsPhysicallyWhithoutTransaction(IList<TModel> models)
        {
            IList<TEntity> entitiesToDelete = models.Select(x => _builder.BuildModel(x)).ToList();
            _entityRepo.BulkDeletePhysically(entitiesToDelete);
            // commit transaction
            _unitOfWork.Commit();
        }

        /// <summary>
        /// Make bulk insert without transaction
        /// </summary>
        /// <param name="models"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public void BulkDeletePhysicallyWithoutTransaction(IList<TEntity> models)
        {
            if (models == null)
            {
                throw new ArgumentException(nameof(models));
            }

            // add entity
            _entityRepo.BulkDeletePhysically(models);
            // commit
            _unitOfWork.Commit();
        }

        public GenericService<TModel, TEntity> GetBase()
        {
            return this;
        }

        public virtual object UpdateModel(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)
        {
            try
            {
                BeginTransaction();
                var addedEntity = UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail);
                EndTransaction();
                return addedEntity;
            }
            catch (CustomException ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntityToUpdate", model.GetType() }
            };
                ex.Paramtrs = paramtrs;
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(model.GetType()+ "*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name:  UpdateModel(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("model = "+ JsonConvert.SerializeObject(model));
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("userMail = "+ userMail);
                // throw exception
                throw ex;
            }
            catch (Exception e)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // throw Exception
                VerifyDuplication(e);
                throw;
            }
        }

        public virtual object UpdateModelWithoutTransaction(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            // save entity traceability
            dynamic entity = _builder.BuildModel(model);

            // update collection entity                
            UpdateCollections(entity, userMail);

            // update entity
            _entityRepo.Update(entity);
            // update entityAxesValues
            if (entityAxisValuesModelList != null && entityAxisValuesModelList.Any())
            {
                UpdateEntityAxesValues(entityAxisValuesModelList.Select(_builderEntityAxisValues.BuildModel).ToList(), entity.Id, userMail);
            }
            // commit 
            _unitOfWork.Commit();
            if (GetPropertyName(entity) != null)
            {
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)), EntityName = entity.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entity.Id, EntityName = entity.GetType().Name.ToUpper() };
        }

        /// <summary>
        /// Trace the Operation update
        /// </summary>
        /// <param name="entity"></param>
        public virtual void UpdateCollections(dynamic entity, string userMail)
        {

            Type myType = entity.GetType();
            IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());
            // get collection properties
            IList<PropertyInfo> icollectionProps = props.Where(p => p.PropertyType.Name.Equals("ICollection`1")).ToList();
            foreach (PropertyInfo icollectionProperty in icollectionProps)
            {
                // get new collection list from entity to update
                var newListEntityCollection = icollectionProperty.GetValue(entity, null);
                // get the type of the collection
                Type genericEntityArg = icollectionProperty.PropertyType.GetGenericArguments().First();
                // instanciate the repository of the collection type
                Type repositoryType = typeof(GenericRepository<>).MakeGenericType(genericEntityArg);
                dynamic repository = Activator.CreateInstance(repositoryType, _unitOfWork);
                if (newListEntityCollection != null)
                {
                    foreach (dynamic newEntityCollection in newListEntityCollection)
                    {
                        var type = newEntityCollection.GetType();
                        PropertyInfo identity = type.GetProperty("Id") != null ? type.GetProperty("Id") : type.GetProperty("Id" + type.Name);
                        var identityValue = identity.GetValue(newEntityCollection);
                        PropertyInfo foreignKey = type.GetProperty("Id" + myType.Name);
                        foreignKey.SetValue(newEntityCollection, entity.Id);
                        if (identityValue == 0) // add
                        {
                            repository.Add(newEntityCollection);
                        }
                        else // update
                        {
                            if (type.GetProperty("IsDeleted") != null && (bool)type.GetProperty("IsDeleted").GetValue(newEntityCollection))
                            {
                                newEntityCollection.DeletedToken = Guid.NewGuid().ToString();
                            }
                            repository.Update(newEntityCollection);

                        }
                    }
                }
            }
        }

        public virtual object DeleteModel(int id, string tableName, string userMail)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                var deletedEntity = DeleteModelwithouTransaction(id, tableName, userMail);
                EndTransaction();
                return deletedEntity;
            }
            catch (CustomException ex)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(tableName + "*");
                ex.SpecificMessage.Append(" Id parameter: ");
                ex.SpecificMessage.Append(id + "*");
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("Method name:  DeleteModel(int id, string tableName, string userMail)");
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("id =" + id);
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("tableName =" + tableName);
                ex.SpecificMessage.Append(Environment.NewLine);
                ex.SpecificMessage.Append("userMail =" + userMail);
                // thorw exception
                throw ex ;
            }
            catch (Exception)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }

        }

        public virtual void DeleteModelPhysically(int id, string userMail)
        {
            try
            {
                //Begin transaction
                BeginTransaction();
                DeleteModelPhysicallyWhithoutTransaction(id, userMail);
                EndTransaction();
            }
            catch (CustomException)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;
            }
            catch (Exception)
            {
                // rollback transaction
                _unitOfWork.RollbackTransaction();
                // thorw exception
                throw;

            }
        }

        /// <summary>
        /// Make the physical delete of model
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public virtual void DeleteModelPhysicallyWhithoutTransaction(int id, string userMail)
        {
            // Predicate ==> get Entity By Id
            PredicateFormatViewModel predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = id } }
            };
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, Operator.And);
            dynamic entityToDelete = _entityRepo.GetSingle(predicateWhere);
            if (entityToDelete != null)
            {
                //Get Entity With relations
                entityToDelete = GetEntityWithCollectionsValues(entityToDelete);
                _entityRepo.Remove(entityToDelete);
                // commit transaction
            }
            else
            {
                throw new CustomException(CustomStatusCode.AlreadyDeletedEntity);
            }
            _unitOfWork.Commit();
        }

        public virtual object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            // Predicate ==> get Entity By Id
            PredicateFormatViewModel predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = id } }
            };
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, Operator.And);
            dynamic entityToDelete = _entityRepo.FindByAsNoTracking(predicateWhere).SingleOrDefault();
            if (entityToDelete == null)
            {
                throw new CustomException(CustomStatusCode.AlreadyDeletedEntity);
            }
            //Get Entity With relations
            entityToDelete = GetEntityWithCollectionsValues(entityToDelete);
            //Get Context
            var context = _unitOfWork.GetContext();
            //DeleteRecrsive
            DeleteRecursive(context, entityToDelete, tableName, null, userMail);
            if (entityToDelete.GetType().GetProperty("IsDeleted") != null)
            {
                //Change value of isDeleted to True
                entityToDelete.IsDeleted = true;
                entityToDelete.DeletedToken = Guid.NewGuid().ToString();
            }
            //Update entity
            _entityRepo.Update(entityToDelete);
            DeleteEntityAxisValue(id, tableName, userMail);
            // commit transaction
            _unitOfWork.Commit();
            if (GetPropertyName(entityToDelete) != null)
            {
                return new CreatedDataViewModel { Id = (int)entityToDelete.Id, Code = getModelCode(entityToDelete, GetPropertyName(entityToDelete)), EntityName = entityToDelete.GetType().Name.ToUpper() };
            }

            return new CreatedDataViewModel { Id = (int)entityToDelete.Id, EntityName = entityToDelete.GetType().Name.ToUpper() };

        }

        /// <summary>
        /// Delete entity with relations
        /// </summary>
        /// <param name="context"></param>
        /// <param name="entityToDelete"></param>
        /// <param name="tableName"></param>
        /// <param name="releatedTableName"></param>
        public virtual void DeleteRecursive(dynamic context, dynamic entityToDelete, string tableName, string releatedTableName, string userMail)
        {

            var table = releatedTableName != null ? releatedTableName : tableName;
            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
            {
                { "EntityToDelete", table }
            };
            // Get List of entities in DBContext
            foreach (var entityType in context.Model.GetEntityTypes())
            {
                //Get list of foreignKey from entityType
                foreach (var foreignKey in entityType.GetForeignKeys())
                {
                    if (foreignKey.PrincipalEntityType != null && foreignKey.PrincipalEntityType.ClrType != null
                        && foreignKey.PrincipalEntityType.ClrType.Name != null && foreignKey.PrincipalEntityType.ClrType.Name == table
                        && entityToDelete.GetType() != null && foreignKey.PrincipalToDependent != null && foreignKey.PrincipalToDependent.Name != null)
                    {
                        //Recuperate value of related entity
                        var entitiesReleated = entityToDelete.GetType().GetProperty(foreignKey.PrincipalToDependent.Name).GetValue(entityToDelete);
                        if (releatedTableName != null)
                        {
                            //Instantiation of repository dynamically 
                            Type repositoryType = typeof(GenericRepository<>).MakeGenericType(foreignKey.DeclaringEntityType.ClrType);
                            dynamic repository = Activator.CreateInstance(repositoryType, _unitOfWork);
                            //Get list of entities in releated table
                            dynamic entitiesOfReleatedTable = repository.GetAll();
                            //Recuperate relaeted entiies from related table
                            foreach (dynamic entitieOfReleatedTable in entitiesOfReleatedTable)
                            {
                                if (entitieOfReleatedTable.GetType().GetProperty(foreignKey.Properties[0].Name).GetValue(entitieOfReleatedTable) == entityToDelete.Id)
                                {
                                    entitiesReleated.Add(entitieOfReleatedTable);
                                }
                            }
                        }
                        //Test if value of related entity is null
                        if (entitiesReleated != null && entitiesReleated.GetType().GetProperty("Count") != null && entitiesReleated.Count > 0)
                        {
                            //If DeleteBehavior is Restrict==> trow exception (Entity is already used)
                            if (foreignKey.DeleteBehavior == DeleteBehavior.ClientSetNull)
                            {
                                //loop releated entities 
                                // verify if all related element are deleted
                                // if there is an element that aren't deleted we can't deleted the main entity
                                // if all related element are deleted we can delet the main entity 
                                foreach (var entityReleated in entitiesReleated)
                                {
                                    PropertyInfo propertyEntityRelated = entityReleated.GetType().GetProperty("IsDeleted");
                                    if (propertyEntityRelated == null)
                                    {
                                        paramtrs.Add("EntityNameReleated", entityType.ClrType.Name);
                                        //The entity is already used
                                        throw new CustomException(CustomStatusCode.DeleteError, paramtrs);
                                    }
                                    else
                                    {
                                        if (!entityReleated.IsDeleted)
                                        {
                                            paramtrs.Add("EntityNameReleated", entityType.ClrType.Name);
                                            //The entity is already used
                                            throw new CustomException(CustomStatusCode.DeleteError, paramtrs);
                                        }
                                    }
                                }
                            }
                            //If DeleteBehavior is Cascade==> delete entity and related entity
                            else if (foreignKey.DeleteBehavior == DeleteBehavior.Cascade)
                            {
                                //loop releated entities
                                foreach (var entityReleated in entitiesReleated)
                                {
                                    if (entityReleated.GetType().GetProperty("IsDeleted") != null)
                                    {
                                        //Instantiation of repository dynamically 
                                        Type repositoryType = typeof(GenericRepository<>).MakeGenericType(entityReleated.GetType());
                                        Activator.CreateInstance(repositoryType, _unitOfWork);
                                        DeleteRecursive(context, entityReleated, table, entityType.ClrType.Name, userMail);
                                        //Change value of isDeleted to True
                                        entityReleated.IsDeleted = true;
                                        entityReleated.DeletedToken = Guid.NewGuid().ToString();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Return entity with all relation
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>entity</returns>
        public dynamic GetEntityWithCollectionsValues(dynamic entity)
        {
            dynamic entityToReturn;
            Type myType = entity.GetType();
            IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());
            // get collection properties
            IList<PropertyInfo> icollectionProps = props.Where(p => p.PropertyType.Name.Equals("ICollection`1")).ToList();
            PredicateFormatViewModel predicate = new PredicateFormatViewModel
            {
                Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = entity.Id } }
            };
            List<RelationViewModel> relations = new List<RelationViewModel>();
            //loop list of Collection in entity
            foreach (PropertyInfo icollectionProperty in icollectionProps)
            {
                relations.Add(new RelationViewModel { Prop = icollectionProperty.Name });
            }
            predicate.Relation = relations;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, Operator.And);
            Expression<Func<TEntity, object>>[] predicateRelations = PredicateUtility<TEntity>.PredicateRelation(predicate.Relation);
            //Get Entity with relation
            entityToReturn = _entityRepo.GetAllWithConditionsRelations(predicateWhere, predicateRelations).FirstOrDefault();
            return entityToReturn;
        }

        public long GetRowsNumber()
        {
            return _entityRepo.GetCount();
        }
        public virtual IList<TModel> GetAllModels()
        {
            var entities = _entityRepo.GetAll();
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }

        public virtual IList<TModel> GetAllModelsAsNoTracking()
        {
            var entities = _entityRepo.GetAllAsNoTracking().ToList();
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }

        public virtual IQueryable<TEntity> GetAllModelsQueryable(params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            return _entityRepo.QuerableGetAll(relationPredicate);
        }

        public virtual IQueryable<TModel> GetAllModelsQueryable(Expression<Func<TEntity, bool>> predicate, params Expression<Func<TEntity, object>>[] relationPredicate)
        {
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(predicate, relationPredicate);
            return entities.Select(c => _builder.BuildEntity(c));
        }

        public virtual IQueryable<TEntity> GetAllQueryableWithRelation(Expression<Func<TEntity, bool>> filter, params Expression<Func<TEntity, object>>[] relation)
        {
            return _entityRepo.GetAllWithConditionsRelationsQueryable(filter, relation);
        }

        public virtual IQueryable<TModel> GetAllModelsQueryableWithRelation(Expression<Func<TEntity, bool>> filter, params Expression<Func<TEntity, object>>[] relation)
        {
            var entities = _entityRepo.GetAllWithConditionsRelationsQueryable(filter, relation);
            return entities.Select(c => _builder.BuildEntity(c));
        }

        public virtual IList<TModel> FindByAsNoTracking(Expression<Func<TEntity, bool>> filter)
        {
            var entities = _entityRepo.FindByAsNoTracking(filter);
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }


        public TModel GetModel(Expression<Func<TEntity, bool>> predicate)
        {
            var entity = _entityRepo.GetSingle(predicate);
            return _builder.BuildEntity(entity);
        }

        /// <summary>
        /// Recuperat elment Related to Id 
        /// </summary>
        /// <param name="id"> Id Item</param>
        /// <returns></returns>
        public virtual TModel GetModelById(int id)
        {
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            List<FilterViewModel> filters = new List<FilterViewModel>(){
                        new FilterViewModel { Prop = "Id", Operation = Operation.Equals, Value = id }
                    };
            predicate.Filter = filters;
            return FindModelBy(predicate).FirstOrDefault();
        }

        public TModel GetModelAsNoTracked(Expression<Func<TEntity, bool>> condition, params Expression<Func<TEntity, object>>[] relations)
        {
            var entity = _entityRepo.GetSingleWithRelationsNotTracked(condition, relations);
            return _builder.BuildEntity(entity);
        }

        public TEntity GetEntityAsNoTracked(Expression<Func<TEntity, bool>> condition, params Expression<Func<TEntity, object>>[] relations)
        {
            var entity = _entityRepo.GetSingleWithRelationsNotTracked(condition, relations);
            return entity;
        }

        public IList<TModel> FindModelBy(Expression<Func<TEntity, bool>> predicate)
        {
            var entities = _entityRepo.FindBy(predicate);
            return entities.Select(c => _builder.BuildEntity(c)).ToList();
        }

        /// <summary>
        /// FindModelByNoTracked
        /// </summary>
        /// <param name="conditions"></param>
        /// <param name="relations"></param>
        /// <returns></returns>
        public IList<TModel> FindModelsByNoTracked(Expression<Func<TEntity, bool>> conditions, params Expression<Func<TEntity, object>>[] relations)
        {
            var entity = _entityRepo.GetAllWithConditionsRelationsAsNoTracking(conditions, relations);
            return entity.Select(c => _builder.BuildEntity(c)).ToList();
        }


        public TModel FindSingleModelBy(PredicateFormatViewModel predicate)
        {
            Operator key = predicate.Operator == 0 ? Operator.And : predicate.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            TEntity entity = _entityRepo.FindSingleBy(predicateWhere);
            return _builder.BuildEntity(entity);
        }

        public TModel FindSingleModelByNoTracked(PredicateFormatViewModel predicate)
        {
            Operator key = predicate.Operator == 0 ? Operator.And : predicate.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            TEntity entity = _entityRepo.FindSingleBy(predicateWhere);
            return _builder.BuildEntity(entity);
        }


        public IList<TModel> GetAllModelsWithRelations(params Expression<Func<TEntity, object>>[] predicate)
        {
            var entities = _entityRepo.GetAllWithRelations(predicate);
            return entities.Select(_builder.BuildEntity).ToList();
        }

        public virtual TModel GetModelWithRelations(Expression<Func<TEntity, bool>> predicate1, params Expression<Func<TEntity, object>>[] predicate2)
        {
            var entity = _entityRepo.GetSingleWithRelations(predicate1, predicate2);
            return _builder.BuildEntity(entity);
        }
        /// <summary>
        /// Gets the model with relations.
        /// The method receive a generic predicate
        /// and return the model with relations according to the predicate
        /// and the where condition included on the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>TModel.</returns>
        public virtual TModel GetModelWithRelations(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator;
            Expression<Func<TEntity, bool>> predicate1 = PredicateUtility<TEntity>.PredicateFilter(predicateModel, key);
            Expression<Func<TEntity, object>>[] predicate2 = PredicateUtility<TEntity>.PredicateRelation(predicateModel.Relation);
            var entity = _entityRepo.GetSingleWithRelations(predicate1, predicate2);
            return _builder.BuildEntity(entity);
        }

        public virtual PredicateFilterRelationViewModel<TEntity> PreparePredicate(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicateModel, key);
            Expression<Func<TEntity, object>>[] predicateRelations = PredicateUtility<TEntity>.PredicateRelation(predicateModel.Relation);
            return new PredicateFilterRelationViewModel<TEntity>(predicateWhere, predicateRelations);
        }

        public virtual DataSourceResult<dynamic> GetDropdownListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            IList<dynamic> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList<dynamic>();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList<dynamic>();
            }

            IList<dynamic> model = entities.Select(x => _builder.BuildEntity(x)).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<dynamic> { data = model, total = total };
        }

        public virtual DataSourceResult<TModel> GetListWithSpecificPredicat(PredicateFormatViewModel predicateModel, PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            IList<TEntity> entities;

            if (predicateModel.page > 0 && predicateModel.pageSize > 0)
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).Skip((predicateModel.page - 1) * predicateModel.pageSize).
                    Take(predicateModel.pageSize).ToList();
            }
            else
            {
                entities = _entityRepo.QuerableGetAll(predicateFilterRelationModel.PredicateRelations)
                    .OrderByRelation(predicateModel.OrderBy).
                    Where(predicateFilterRelationModel.PredicateWhere).ToList();
            }

            IList<TModel> model = entities.Select(_builder.BuildEntity).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<TModel> { data = model, total = total };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="predicateModel"></param>
        /// <param name="predicateFilterRelationModel"></param>
        /// <returns></returns>
        public virtual DataSourceResult<TModel> GetListWithSpecificPredicatAsNoTracking(PredicateFormatViewModel predicateModel,
            PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel)
        {
            if ((predicateModel == null) || (predicateFilterRelationModel == null))
            {
                throw new ArgumentNullException();
            }
            IList<TEntity> entities = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(predicateFilterRelationModel.PredicateWhere,
                    predicateFilterRelationModel.PredicateRelations).OrderByRelation(predicateModel.OrderBy).ToList();
            IList<TModel> model = entities.Select(_builder.BuildEntity).ToList();
            var total = _entityRepo.GetCountWithPredicate(predicateFilterRelationModel.PredicateWhere);
            return new DataSourceResult<TModel> { data = model, total = total };
        }


        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public virtual DataSourceResult<TModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel = PreparePredicate(predicateModel);
            return GetListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }
        /// <summary>
        /// Finds the model by Generic Predicate and filters from kendo Grid.
        /// The method receive a generic predicate , filters and pagination info
        /// and return the collection of model found according to the predicate and the total .
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public virtual DataSourceResult<TModel> FindDataSourceModelByAsNoTracking(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel = PreparePredicate(predicateModel);
            return GetListWithSpecificPredicatAsNoTracking(predicateModel, predicateFilterRelationModel);
        }

        /// <summary>
        /// Finds the model by Generic Predicate.
        /// The method receive a generic predicate
        /// and return the collection of model found according to the predicate.
        /// </summary>
        /// <param name="predicateModel">The predicate model.</param>
        /// <returns>IEnumerable&lt;TModel&gt;.</returns>
        public virtual IList<TModel> FindModelBy(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicateModel, key);
            Expression<Func<TEntity, object>>[] predicateRelations = PredicateUtility<TEntity>.PredicateRelation(predicateModel.Relation);
            IList<TEntity> entities = _entityRepo.QuerableGetAll(predicateRelations).OrderByRelation(predicateModel.OrderBy).Where(predicateWhere).ToList();
            return entities.Select(_builder.BuildEntity).ToList();
        }

        /************************************************************************************/
        public virtual IList<TModel> FindNoTrackedModelBy(List<FilterViewModel> filters)
        {
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            predicate.Filter = filters;
            Operator key = predicate.Operator == 0 ? Operator.And : predicate.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            IList<TEntity> entities = _entityRepo.FindByAsNoTracking(predicateWhere).ToList();
            IList<TModel> model = entities.Select(_builder.BuildEntity).ToList();
            return model.ToList();
        }

        /************************************************************************************/
        public bool CheckExistence(PredicateFormatViewModel predicateModel)
        {
            Operator key = predicateModel.Operator;
            Expression<Func<TEntity, bool>> predicat = PredicateUtility<TEntity>.PredicateFilter(predicateModel, key);
            if (_entityRepo.FindByAsNoTracking(predicat).Count() != 0)
            {
                throw new CustomException(CustomStatusCode.duplicateEntry);
            }
            return false;
        }
        public virtual bool CheckUnicity(UnicityViewModel unicityModel)
        {
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            List<FilterViewModel> filters = new List<FilterViewModel>
            {
                new FilterViewModel { Prop = unicityModel.property, Operation = Operation.Equals, Value = unicityModel.value },
                new FilterViewModel { Prop = "Id", Operation = Operation.NotEquals, Value = unicityModel.valueBeforUpdate }
            };
            predicate.Filter = filters;
            Operator key = Operator.And;
            if (predicate != null)
            {
                key = predicate.Operator;
            }
            Expression<Func<TEntity, bool>> predicat = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            var test = _entityRepo.FindByAsNoTracking(predicat);
            if (_entityRepo.FindByAsNoTracking(predicat).Count() != 0)
            {
                return true;
            }
            return false;
        }

        public bool ExcelCheckUnicity(DataRow row, PropertyInfo property)
        {
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            List<FilterViewModel> filters = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = property.Name, Operation = Operation.Equals, Value = row[property.Name].ToString() },
                    new FilterViewModel { Prop = _identificationColumn,
                        Operation = Operation.NotEquals, Value = row[_identificationColumn].ToString() }
                };
            predicate.Filter = filters;
            Operator key = Operator.And;
            if (predicate != null)
            {
                key = predicate.Operator;
            }
            Expression<Func<TEntity, bool>> predicat = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            var test = _entityRepo.FindByAsNoTracking(predicat);
            if (_entityRepo.FindByAsNoTracking(predicat).Count() != 0)
            {
                return true;
            }
            return false;
        }




        public virtual int FindIndiceFromDataSource(PredicateFormatViewModel predicateModel, ValueMapperViewModel valueMapperModel)
        {
            Operator key = predicateModel.Operator == 0 ? Operator.And : predicateModel.Operator;
            Expression<Func<TEntity, bool>> predicateWhere = PredicateUtility<TEntity>.PredicateFilter(predicateModel, key);
            PredicateFormatViewModel predicate = new PredicateFormatViewModel();
            List<FilterViewModel> filters = new List<FilterViewModel>
                {
                    new FilterViewModel {Prop = valueMapperModel.Property, Operation = Operation.Equals, Value = valueMapperModel.Value}
                };
            predicate.Filter = filters;
            Expression<Func<TEntity, bool>> predicateValue = PredicateUtility<TEntity>.PredicateFilter(predicate, key);
            int rowNumber = FilteredData(predicateWhere, predicateValue, predicateModel.OrderBy, valueMapperModel) - 1;

            return rowNumber;
        }



        public int FilteredData(Expression<Func<TEntity, bool>> predicate, Expression<Func<TEntity, bool>> predicate2, ICollection<OrderByViewModel> orderBy, ValueMapperViewModel valueMapperModel)
        {
            string orderByExpression = GenerateOrderbyExpression(orderBy);
            IQueryable<TEntity> param1 = _unitOfWork.Set<TEntity>().Where(predicate);
            IQueryable<TEntity> param2 = _unitOfWork.Set<TEntity>().Where(predicate2);
            return GetDataIndex(valueMapperModel, param1, param2, orderByExpression);
        }

        private int GetDataIndex(ValueMapperViewModel valueMapperModel, IQueryable<TEntity> sqlCommand, IQueryable<TEntity> clauseWhere, string orderByExpression)
        {
            string firstQuery = sqlCommand.ToQueryString();
            string gatheredQuery = firstQuery.Substring(firstQuery.IndexOf("FROM"));
            string secondRequest = clauseWhere.ToQueryString().Replace(getAlias(clauseWhere.ToQueryString()), "[vc]");
            int indice = 0;
            string aliasCommand = getAlias(firstQuery) + ".";
            string commandText = "select RowNumber from (SELECT DENSE_RANK() OVER(order by " +
                aliasCommand + orderByExpression + ") AS RowNumber, " + aliasCommand + "id " +
                gatheredQuery + ") t1 INNER JOIN (" + secondRequest + ") t2 ON t1.id = t2.id";
            using (SqlConnection connection = new SqlConnection(_unitOfWork.GetContext().Database.GetDbConnection().ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand();
                command.Connection = connection;
                command.Parameters.Add("@id", SqlDbType.NVarChar);
                command.Parameters["@id"].Value = valueMapperModel.Value;
                command.CommandText = commandText;
                using (SqlDataReader reader = command.ExecuteReader(CommandBehavior.SingleRow))
                {
                    while (reader.Read())
                    {
                        indice = (int)(long)reader["RowNumber"];
                    }
                }
            }
            return indice;
        }

        public virtual DataSourceResult<dynamic> GetDataDropdown()
        {
            var entityList = _entityRepo.GetAll().ToList();
            IList<dynamic> list = entityList.Select(x => _builder.BuildEntity(x)).ToList<dynamic>();
            long total = _entityRepo.GetCount();
            return new DataSourceResult<dynamic>
            {
                data = list.ToList(),
                total = total
            };

        }

        public virtual DataSourceResult<dynamic> GetDataDropdownBy(PredicateFormatViewModel predicateModel)
        {
            PredicateFilterRelationViewModel<TEntity> predicateFilterRelationModel = PreparePredicate(predicateModel);
            return GetDropdownListWithSpecificPredicat(predicateModel, predicateFilterRelationModel);
        }

        private string GenerateOrderbyExpression(ICollection<OrderByViewModel> orderBy)
        {
            StringBuilder orderByExpression = new StringBuilder("id");
            if (orderBy != null && orderBy.Any())
            {
                orderByExpression.Clear();
                int i = 0;
                foreach (var item in orderBy)
                {
                    if (i > 0)
                    {
                        orderByExpression.Append(",");
                    }
                    orderByExpression.Append(" ");
                    orderByExpression.Append(item.Prop);
                    if (item.Direction == OrderByDirection.DESC)
                    {
                        orderByExpression.Append(" DESC");
                    }
                    i++;
                }
            }
            return orderByExpression.ToString();

        }

        private string getAlias(string ch)
        {
            const string pattern = @"\[(.)\]";
            var matches = Regex.Matches(ch, pattern);
            if (matches.Count > 0)
            {
                return matches[0].Value;
            }
            return " ";
        }

        public List<string> GetConcernedProperties(string constraint)
        {
            return _entityRepo.GetPropertiesByConstraint(constraint);
        }

        public TModel GetModelWithRelationsAsNoTracked(Expression<Func<TEntity, bool>> predicate1, params Expression<Func<TEntity, object>>[] predicate2)
        {
            var entity = _entityRepo.GetSingleWithRelationsNotTracked(predicate1, predicate2);
            if (entity != null)
            {
                return _builder.BuildEntity(entity);
            }
            return null;
        }

        /// <summary>
        /// Return a collection with its relations that respect the conditions
        /// </summary>
        /// <param name="conditions"></param>
        /// /// <param name="relations"></param>
        /// <returns>IEnumerable<TModel></returns>
        public virtual IList<TModel> GetModelsWithConditionsRelations(Expression<Func<TEntity, bool>> conditions, params Expression<Func<TEntity, object>>[] relations)
        {
            return _entityRepo.GetAllWithConditionsRelations(conditions, relations).Select(x => _builder.BuildEntity(x)).ToList();

        }



        protected virtual string GetExceptionMsg(string exception)
        {
            var x = exception.IndexOf("«");
            var y = exception.IndexOf("»");
            if (x < 0 || y < 0)
            {
                x = exception.IndexOf("'");
                y = exception.IndexOf("'", exception.IndexOf("'") + 1);
            }
            return exception.Substring(x + 1, y - x - 1).Trim();
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool isdisposing)
        {
            if (isdisposing)
            {
                _entityRepo.Dispose();
                _unitOfWork.Dispose();
            }
        }

        public void VerifyDuplication(Exception e)
        {
            if (e != null && e.GetBaseException().GetType() == typeof(Microsoft.Data.SqlClient.SqlException) && ((Microsoft.Data.SqlClient.SqlException)e.InnerException).Number == 2627)
            {
                List<string> results = GetConcernedProperties(GetExceptionMsg(e.InnerException.Message));
                CustomException customException = new CustomException();
                customException.Paramtrs.Add("DUPLICATED_PARAMETERS", results);
                customException.OriginalException = e;
                switch (results.Count)
                {
                    case 1:
                        customException.StatusCode = CustomStatusCode.duplicateEntry;
                        break;
                    case 2:
                        customException.StatusCode = CustomStatusCode.duplicateEntryCouple;
                        break;
                    default:
                        customException.StatusCode = CustomStatusCode.duplicateEntryGroup;
                        break;
                }
                throw customException;
            }
            else
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
        }

        /// <summary>
        /// Update an entity without its dependencies with transaction
        /// </summary>
        /// <param name="model"></param>
        public void UpdateWithoutCollections(TModel model)
        {
            try
            {
                // Begin the transaction
                BeginTransaction();
                // Update an entity wihout its dependencies
                UpdateWithoutCollectionsWithoutTransaction(model);
                // End the transaction
                EndTransaction();
            }
            catch (CustomException ex)
            {
                // Rollback transaction
                _unitOfWork.RollbackTransaction();
                ex.SpecificMessage = new StringBuilder();
                ex.SpecificMessage.Append("Entity name: ");
                ex.SpecificMessage.Append(model.GetType());
                ex.SpecificMessage.Append(" Sended Object data: ");
                ex.SpecificMessage.Append(model.ToString());
                ex.SpecificMessage.Append(" Service Name: GenericService");
                ex.SpecificMessage.Append("  Method name: UpdateWithoutCollections(TModel model)");
                // Throw exception
                throw ex;
            }
            catch (Exception e)
            {
                // Rollback transaction
                _unitOfWork.RollbackTransaction();
                // Throw exception
                VerifyDuplication(e);
                throw;
            }
        }

        /// <summary>
        /// Update an entity without its dependencies
        /// </summary>
        /// <param name="model"></param>
        public void UpdateWithoutCollectionsWithoutTransaction(TModel model)
        {
            // Build entity from model
            TEntity entity = _builder.BuildModel(model);
            // Get entity type
            Type type = entity.GetType();
            // Get all properties of type
            IList<PropertyInfo> propertyInfos = new List<PropertyInfo>(type.GetProperties());
            // Filter properties on those that are collections
            IList<PropertyInfo> collectionProps = propertyInfos.Where(p => p.PropertyType.Name.Equals("ICollection`1")).ToList();
            // Foreach collection property
            foreach (PropertyInfo propertyInfo in collectionProps)
            {
                // Get the propertyinfo of each collection
                PropertyInfo prop = type.GetProperty(propertyInfo.Name);
                // Set the value of the collection to null
                prop.SetValue(entity, null, null);
            }
            // Update entity
            _entityRepo.Update(entity);
            // Commit
            _unitOfWork.Commit();
        }
        /// <summary>
        /// Check the unicity per month
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>       
        public bool CheckUnicityPerMonth(dynamic model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            if (!typeof(TModel).Equals(model.GetType()))
            {
                if (model[GenericConstants.NUMBER] == null)
                {
                    model[GenericConstants.NUMBER] = 0;
                }
                model = JsonConvert.DeserializeObject<TModel>(model.ToString());
            }
            Type type = model.GetType();
            PropertyInfo monthProp = type.GetProperty(GenericConstants.MONTH);
            PropertyInfo idProp = type.GetProperty(GenericConstants.ID);
            PropertyInfo numberProp = type.GetProperty(GenericConstants.NUMBER);
            if (monthProp != null && idProp != null && numberProp != null)
            {
                DateTime month = (DateTime)monthProp.GetValue(model);
                month = new DateTime(month.Year, month.Month, NumberConstant.One);
                int number = (int)numberProp.GetValue(model);
                int id = (int)idProp.GetValue(model);
                return FindModelBy(x => ((int)x.GetType().GetProperty(GenericConstants.NUMBER).GetValue(x)) == number &&
                ((DateTime)x.GetType().GetProperty(GenericConstants.MONTH).GetValue(x)) == month &&
                (id == NumberConstant.Zero || id != ((int)x.GetType().GetProperty(GenericConstants.ID).GetValue(x)))).Any();
            }
            return false;
        }

        public bool PrepareFilterDate(DateTime propertyDate, DateTime dateFilter, Operation operation)
        {
            DateTime currentDate = new DateTime(propertyDate.Year, propertyDate.Month, propertyDate.Day);
            switch (operation)
            {
                case Operation.Equals:
                    return currentDate == dateFilter;
                case Operation.NotEquals:
                    return currentDate != dateFilter;
                case Operation.GreaterThan:
                    return currentDate > dateFilter;
                case Operation.GreaterThanOrEquals:
                    return currentDate >= dateFilter;
                case Operation.LessThan:
                    return currentDate < dateFilter;
                case Operation.LessThanOrEquals:
                    return currentDate <= dateFilter;
                default:
                    return true;
            }
        }
        public dynamic DecryptToken()
        {
            AppHttpContext.Current.Request.Headers.TryGetValue("Authorization", out StringValues userToken);
            if (userToken != "")
            {
                var jwt = userToken.ToString().Replace("Bearer ", string.Empty);
                if (jwt != "" && jwt != "null")
                {
                    JwtSecurityToken token = new JwtSecurityToken(jwt);
                    return token.Payload;
                }
                return null;
            }
            return null;
        }



        public async Task<bool> GenerateDataBase(DBConfigViewModel informationsUser, HttpRequest httpContent)
        {
            // If appsetting is null==> read the file and get the appsettings info
            if (_appSettings == null)
            {
                ReadAppSettingsFile();
            }
            // If appSettings is not null and list of modules contains commercial module ==> generate database
            if (_appSettings != null && informationsUser.ListOfModules != null && informationsUser.ListOfModules.Any() &&
                   informationsUser.ListOfModules.Contains("COMMERCIALE"))
            {
                // message 
                StringBuilder message = new StringBuilder();
                // Execute sequence file and get value of sequence 
                string sequenceNumber = ExecuteSequenceAndGetSequenceNumber();
                // Code company
                string codeCompany = "C" + sequenceNumber;
                // fetch list of modules
                informationsUser.ListOfModules.ForEach(modules =>
                {
                    // If the module is Comm ==> create comm database
                    if (modules == "COMMERCIALE")
                    {

                        // Data base name
                        string dataBaseName = codeCompany + "_Commercial";
                        // Create Slave Data Base
                        bool isCreatedDB = CreateSlaveDB(dataBaseName);
                        if (isCreatedDB)
                        {
                            // If Slave data base is created ==> config master data base
                            bool isExecuted = ExecuteScriptConfigDBMaster(dataBaseName, informationsUser, codeCompany, informationsUser.ListOfModules.Contains("B2B"));
                            //ExecuteScriptConfigDBMaster(dataBaseName, informationsUser.FirstName, informationsUser.SecondName, informationsUser.EmailUser, codeCompany, informationsUser.ListOfModules.Contains("B2B"),
                            //    informationsUser.Currency, informationsUser.ActivityArea, informationsUser.IsWithTecDoc);

                        }
                    }
                    // If the module is RH ==> create RH database
                    if (modules == "RH")
                    {
                    }
                    // If the module is GARAGE ==> create GARAGE database
                    if (modules == "GARAGE")
                    {
                    }
                    // If the module is SETTINGS ==> create SETTINGS database
                    if (modules == "SETTINGS")
                    {
                    }
                    // If the module is CRM ==> create CRM database
                    if (modules == "CRM")
                    {
                    }
                    // If the module is COMPTABILITY ==> create COMPTABILITY database
                    if (modules == "COMPTABILITY")
                    {
                        // Data base name
                        string dataBaseName = "Stark-COMPTA-" + codeCompany;
                        CreateComptabilityDataBase(dataBaseName, codeCompany,
                            informationsUser.EmailUser, informationsUser.Language, httpContent);
                       
                    }
                });

            }
            var isExecuted = IsDataBaseCreated(informationsUser.SubscriptionId, informationsUser.EmailUser);
            return false;
        }


    /// <summary>
    /// Read env file 
    /// </summary>
    private void ReadAppSettingsFile()
        {
            string envName = ReadDataFileEnv();
            using (StreamReader r = new StreamReader(Path.Combine("Env", "env." + envName + ".json")))
            {
                string jsonEnv = r.ReadToEnd();
                dynamic dynamicJsonEnv = JsonConvert.DeserializeObject(jsonEnv);
                Newtonsoft.Json.Linq.JObject appSettingsString = dynamicJsonEnv["AppSettings"];
                _appSettings = JsonConvert.DeserializeObject<AppSettings>(appSettingsString.ToString());
            }
        }
        /// <summary>
        /// get env name
        /// </summary>
        /// <returns></returns>
        private string ReadDataFileEnv()
        {
            using (StreamReader r = new StreamReader($"./Env/env.json"))
            {
                string json = r.ReadToEnd();
                dynamic dataEnv = JsonConvert.DeserializeObject<dynamic>(json);
                return dataEnv.EnviromentName.Value;
            }
        }
        /// <summary>
        /// Create sequence if not exist and get number of seq
        /// </summary>
        /// <returns></returns>
        private string ExecuteSequenceAndGetSequenceNumber()
        {
            string sequenceNumber = null;
            string locationSequenceScript = Path.Combine(Path.Combine(_appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptMaster").Split("/"));
           // string locationSequenceScript = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), _appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptMaster").Split("/"));// Path.Combine("..", "DataBase", "ScriptEspaceDemo", "GenerateDB", "ScriptSlave");
            if (Directory.Exists(locationSequenceScript))
            {
                string connectionString = ConnectToMaster();
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();
                        using (StreamReader r = new StreamReader(Path.Combine(locationSequenceScript, "Create_sequence_catalog.sql")))
                        {
                            string commandText = r.ReadToEnd();
                            SqlCommand command = new SqlCommand(commandText, connection);
                            command.ExecuteNonQuery();
                        }

                        string commandTextGetSequence = string.Format("SELECT NEXT VALUE FOR dbo.CodeCompany_seq");
                        SqlCommand commandGetSeq = new SqlCommand(commandTextGetSequence, connection);

                        sequenceNumber = commandGetSeq.ExecuteScalar().ToString();
                        // Verify if existing DB
                        var commandTextToGetDB = "select count(*) from master.dbo.sysdatabases where name='C" + sequenceNumber + "_Commercial'";
                        SqlCommand commandToGetDB = new SqlCommand(commandTextToGetDB, connection);
                        // if data base tec doc conf exist ==> add user to tecDoc
                        if (Convert.ToInt32(commandToGetDB.ExecuteScalar()) == 1)
                        {
                            connection.Close();
                            ExecuteSequenceAndGetSequenceNumber();
                        }
                        connection.Close();
                    }
                    catch
                    {
                        throw;
                    }
                }

            }

            return sequenceNumber;
        }
        /// <summary>
        /// connect to master DB
        /// </summary>
        /// <returns></returns>
        private string ConnectToMaster()
        {

            return string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                   _appSettings.MasterDbSettings.Server, _appSettings.MasterDbSettings.DataBaseName, _appSettings.MasterDbSettings.UserId, _appSettings.MasterDbSettings.UserPassword);
        }
        /// <summary>
        /// Create slave DB
        /// </summary>
        /// <param name="dataBaseName"></param>
        /// <param name="pathSqlFile"></param>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="userCompany"></param>
        /// <param name="codeCompany"></param>
        /// <returns></returns>
        private bool CreateSlaveDB(string dataBaseName)
        {
            string commandTextCreateDB = "CREATE DATABASE " + dataBaseName;
            //+
            //         "(NAME = " + dataBaseName + ", FILENAME = '" + pathSqlFile + dataBaseName + ".mdf' , SIZE =" + _appSettings.DataBaseAutoCreationConfig.SizeMDFFile + " , MAXSIZE = " + _appSettings.DataBaseAutoCreationConfig.MaxSizeMDFFile +
            //         ", FILEGROWTH = " + _appSettings.DataBaseAutoCreationConfig.FileGrowthMDFFile + " ) LOG ON (NAME = '" + dataBaseName + "_log', FILENAME = '" + pathSqlFile + dataBaseName +
            //         "_log.ldf' , SIZE = " + _appSettings.DataBaseAutoCreationConfig.SizeLDFFile + " , MAXSIZE = " + _appSettings.DataBaseAutoCreationConfig.MaxSizeLDFFile +
            //         " , FILEGROWTH = " + _appSettings.DataBaseAutoCreationConfig.FileGrowthLDFFile + " )";
            string connectionStringMaster = ConnectToMaster();
            using (SqlConnection connection = new SqlConnection(connectionStringMaster))
            {
                SqlCommand command = new SqlCommand(commandTextCreateDB, connection);
                try
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
                catch
                {
                    throw;
                }
            }

            return ExecuteScriptConfigDBSlave(dataBaseName);


        }
        /// <summary>
        /// Config slave DB
        /// </summary>
        /// <param name="dataBaseName"></param>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="userCompany"></param>
        /// <param name="codeCompany"></param>
        /// <returns></returns>
        private bool ExecuteScriptConfigDBSlave(string dataBaseName)
        {
            //string locationSequenceScript = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), _appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptSlave").Split("/"));// Path.Combine("..", "DataBase", "ScriptEspaceDemo", "GenerateDB", "ScriptSlave");

            string locationSequenceScript = Path.Combine(Path.Combine(_appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptSlave").Split("/"));
            if (Directory.Exists(locationSequenceScript))
            {
                string connectionStringSlave = ConnectToSlave(dataBaseName);
                using (SqlConnection connection = new SqlConnection(connectionStringSlave))
                {
                    try
                    {
                        var evolve = new Evolve.Evolve(connection, msg => Serilog.Log.Information(msg))
                        {
                            Locations = new[] { locationSequenceScript }
                        };

                        evolve.Migrate();

                        // get evolve Data from DataBase ref and insert into new DataBase
                        connection.Open();
                        if (_appSettings.DataBaseAutoCreationConfig.RefDataBase != null)
                        {

                            var commandText = "select count(*) from master.dbo.sysdatabases where name='" + _appSettings.DataBaseAutoCreationConfig.RefDataBase + "'";
                            SqlCommand command = new SqlCommand(commandText, connection);
                            // if data base ref exist ==> get data of evolve table
                            if (Convert.ToInt32(command.ExecuteScalar()) == 1)
                            {
                                var commandtxt = "INSERT INTO " + dataBaseName + ".dbo.changelog(type, version, description, name, checksum, installed_by, installed_on, success) SELECT type, version, description, name, checksum, installed_by, installed_on, success  from " + _appSettings.DataBaseAutoCreationConfig.RefDataBase + ".dbo.changelog; ";

                                SqlCommand commandEvolve = new SqlCommand(commandtxt, connection);

                                commandEvolve.ExecuteNonQuery();
                            }
                        }
                        connection.Close();

                    }
                    catch
                    {
                        throw;
                    }
                }
            }
            return true;
        }


        private string ConnectToSlave(string dataBaseName)
        {
            return string.Format("Data Source={0};Initial Catalog={1};Persist Security Info=True;User ID={2};Password={3};MultipleActiveResultSets=True",
                  _appSettings.MasterDbSettings.Server, dataBaseName, _appSettings.MasterDbSettings.UserId, _appSettings.MasterDbSettings.UserPassword);

        }


        private bool ExecuteScriptConfigDBMaster(string dataBaseName, DBConfigViewModel informationsUser, string codeCompany, bool isWithB2B)
        {
            //string locationSequenceScript = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), _appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptMaster").Split("/"));// Path.Combine("..", "DataBase", "ScriptEspaceDemo", "GenerateDB", "ScriptSlave");

            string locationSequenceScript = Path.Combine(Path.Combine(_appSettings.DataBaseAutoCreationConfig.PathOfSqlFiles + "/ScriptMaster").Split("/"));
            if (Directory.Exists(locationSequenceScript))
            {
                string connectionStringMaster = ConnectToMaster();
                using (SqlConnection connection = new SqlConnection(connectionStringMaster))
                {
                    try
                    {
                        connection.Open();

                        using (StreamReader r = new StreamReader(Path.Combine(locationSequenceScript, "ConfigMasterDB.sql")))
                        {
                            string commandText = r.ReadToEnd();
                            commandText = commandText.Replace("GO\r\n", "");
                            commandText = commandText.Replace("GO ", "");
                            commandText = commandText.Replace("GO\t", "");
                            SqlCommand command = new SqlCommand(commandText, connection);

                            // Add generic parameters
                            command.Parameters.AddWithValue("@codecompany", codeCompany);
                            command.Parameters.AddWithValue("@DatabaseName", dataBaseName);

                            // Add Company parameters
                            command.Parameters.AddWithValue("@organisationName", informationsUser.OrganisationName);
                            command.Parameters.AddWithValue("@taxRegistrationNumber", informationsUser.taxRegistrationNumber);
                            command.Parameters.AddWithValue("@OrganisationWebsite", informationsUser.OrganisationWebsite);
                            command.Parameters.AddWithValue("@siret", informationsUser.Siret);
                            command.Parameters.AddWithValue("@organisationPhone", informationsUser.OrganisationPhone);
                            command.Parameters.AddWithValue("@codeCurrency", informationsUser.Currency);


                            command.Parameters.AddWithValue("@OrganisationTimeZone", informationsUser.OrganisationTimeZone);
                            if (informationsUser.ActivityArea == "Auto")
                            {
                                command.Parameters.AddWithValue("@activityArea", ((int)ActivityAreaEnumerator.Auto).ToString());
                            }
                            else if (informationsUser.ActivityArea == "Esn")
                            {
                                command.Parameters.AddWithValue("@activityArea", ((int)ActivityAreaEnumerator.Esn).ToString());
                            }
                            else if (informationsUser.ActivityArea == "Other")
                            {
                                command.Parameters.AddWithValue("@activityArea", ((int)ActivityAreaEnumerator.Other).ToString());
                            }


                            // Add adresse Company
                            command.Parameters.AddWithValue("@CountryName", informationsUser.CountryName);
                            command.Parameters.AddWithValue("@OrganisationAddress", informationsUser.OrganisationAddress);
                            command.Parameters.AddWithValue("@OrganisationCity", informationsUser.OrganisationCity);
                            command.Parameters.AddWithValue("@OrganisationPostalCode", informationsUser.OrganisationPostalCode);
                            command.Parameters.AddWithValue("@OrganisationAdditionalAddress", informationsUser.OrganisationAdditionalAddress);

                            // Add  Liscence company
                            command.Parameters.AddWithValue("@NumberOfUsers", informationsUser.NumberOfUsers);
                            command.Parameters.AddWithValue("@StartDate", informationsUser.StartDate);
                            command.Parameters.AddWithValue("@EndDate", informationsUser.EndDate);

                            // Add User parameters

                            command.Parameters.AddWithValue("@FirstName", informationsUser.FirstName);
                            command.Parameters.AddWithValue("@SecondName", informationsUser.SecondName);
                            command.Parameters.AddWithValue("@EmailUser", informationsUser.EmailUser);
                            command.Parameters.AddWithValue("@Language", informationsUser.Language);
                            command.Parameters.AddWithValue("@Phone", informationsUser.Phone);
                            command.Parameters.AddWithValue("@isWithTecDoc", informationsUser.IsWithTecDoc ? "1" : "0");
                            command.ExecuteNonQuery();
                        }
                        //if (isWithB2B)
                        //{

                        //    using (StreamReader r = new StreamReader(Path.Combine(locationSequenceScript, "ConfigB2BDB.sql")))
                        //    {
                        //        string commandText = r.ReadToEnd();
                        //        commandText = commandText.Replace("GO\r\n", "");
                        //        commandText = commandText.Replace("GO ", "");
                        //        commandText = commandText.Replace("GO\t", "");
                        //        SqlCommand command = new SqlCommand(commandText, connection);

                        //        command.Parameters.AddWithValue("@firstname", firstName);
                        //        command.Parameters.AddWithValue("@lastname", lastName);
                        //        command.Parameters.AddWithValue("@usercompany", userCompany);
                        //        command.Parameters.AddWithValue("@codecompany", codeCompany);
                        //        command.Parameters.AddWithValue("@DatabaseName", dataBaseName);
                        //        command.ExecuteNonQuery();
                        //    }
                        //}
                        // Add user to Data base specific to TecDoc
                        if (informationsUser.IsWithTecDoc && _appSettings.DataBaseAutoCreationConfig.TecDocDataBase != null)
                        {

                            var commandText = "select count(*) from master.dbo.sysdatabases where name='" + _appSettings.DataBaseAutoCreationConfig.TecDocDataBase + "'";
                            SqlCommand command = new SqlCommand(commandText, connection);
                            // if data base tec doc conf exist ==> add user to tecDoc
                            if (Convert.ToInt32(command.ExecuteScalar()) == 1)
                            {

                                using (StreamReader r = new StreamReader(Path.Combine(locationSequenceScript, "AddUserTecDoc.sql")))
                                {
                                    string commdText = r.ReadToEnd();
                                    SqlCommand comd = new SqlCommand(commandText, connection);
                                    comd.Parameters.AddWithValue("@EmailUser", informationsUser.EmailUser);
                                    comd.ExecuteNonQuery();
                                }
                            }
                        }

                        connection.Close();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
            return true;
        }


        private async Task<bool> IsDataBaseCreated(string subscriptionId, string emailUser)
        {
            AccountInformationViewModel informationToSend = new AccountInformationViewModel(int.Parse(subscriptionId), emailUser);
            if (string.IsNullOrEmpty(_appSettings.DataBaseAutoCreationConfig.DataBaseAutoCreationURL))
            {
                return false;
            }
            var baseUri = new Uri(_appSettings.DataBaseAutoCreationConfig.DataBaseAutoCreationURL);
            Uri uri = new Uri(baseUri, _appSettings.DataBaseAutoCreationConfig.AddSubscriptionId);

            using (HttpClient httpClient = new HttpClient())
            {
                try
                {
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = uri,
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(informationToSend), Encoding.UTF8, "application/json")
                    };
                    HttpResponseMessage response = await httpClient.SendAsync(httpRequestMessage);
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    return true;
                }
                catch
                {
                    throw;
                }

            }
        }

        private  bool CreateComptabilityDataBase(string dataBaseName, string codeCompany, string email, string language, HttpRequest httpContent)
        {
            AccountingViewModel informationToSend = new(dataBaseName, codeCompany);
            if (string.IsNullOrEmpty(_appSettings.DataBaseAutoCreationConfig.AccountingBaseURL))
            {
                return false;
            }
            var baseUri = new Uri(_appSettings.DataBaseAutoCreationConfig.AccountingBaseURL);
            Uri uri = new Uri(baseUri, _appSettings.DataBaseAutoCreationConfig.AccountingDataBaseURL);

            using (HttpClient httpClient = new HttpClient())
            {
                try
                {
                    StringValues token;
                    httpContent.Headers.TryGetValue("Authorization", out token);
                    // Add authorization 
                    httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token.ToString().Replace("Bearer ", string.Empty));
                    HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                    {
                        RequestUri = uri,
                        Method = HttpMethod.Post,
                        Content = new StringContent(JsonConvert.SerializeObject(informationToSend), Encoding.UTF8, "application/json")
                    };
                    // Add userEmail
                    httpRequestMessage.Headers.Add("User", email);
                    // Add code company 
                    httpRequestMessage.Headers.Add("Company", codeCompany);
                    // Add language
                    httpRequestMessage.Headers.Add("Language", language);
                    var response = httpClient.SendAsync(httpRequestMessage);
                    Task.WaitAny(response);
                    if (response.Result.IsSuccessStatusCode)
                    {
                        throw new Exception("Comptability module is not created");
                    }
                    return true;
                }
                catch
                {
                    throw;
                }

            }

        }

    }
}
