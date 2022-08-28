using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Threading.Tasks;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Common;
using ViewModels.DTO.DBConfig;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace Services.Generic.Interfaces
{
    public interface IGenericService<TModel, TEntity>
        where TModel : class
        where TEntity : class
    {
        object AddModel(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null, bool isFromModal = false);
        object AddModelWithoutTransaction(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        void BulkAddWithoutTransaction(IList<TEntity> models);
        void BulkAddWithoutTransaction(IList<TModel> models);
        object UpdateModel(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail);
        object UpdateModelWithoutTransaction(TModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null);
        void BulkUpdateWithoutTransaction(IList<TEntity> models);
        object DeleteModel(int id, string tableName, string userMail);
        void DeleteModelPhysically(int id, string userMail);
        object DeleteModelwithouTransaction(int id, string tableName, string userMail);
        void BulkDelete(IList<TEntity> models);
        void BulkDeletePhysicallyWithoutTransaction(IList<TEntity> models);
        IList<TModel> GetAllModels();
        DataSourceResult<dynamic> GetDataDropdown();
        IList<TModel> GetAllModelsAsNoTracking();
        IQueryable<TEntity> GetAllModelsQueryable(params Expression<Func<TEntity, object>>[] relationPredicate);
        IQueryable<TModel> GetAllModelsQueryable(Expression<Func<TEntity, bool>> predicate, params Expression<Func<TEntity, object>>[] relationPredicate);
        IList<TModel> GetAllModelsWithRelations(params Expression<Func<TEntity, object>>[] predicate);
        IList<TModel> FindModelBy(Expression<Func<TEntity, bool>> predicate);
        TModel GetModel(Expression<Func<TEntity, bool>> predicate);
        TModel GetModelWithRelations(Expression<Func<TEntity, bool>> predicate1, params Expression<Func<TEntity, object>>[] predicate2);
        long GetRowsNumber();
        DataSourceResult<TModel> FindDataSourceModelBy(PredicateFormatViewModel predicateModel);
        void UpdateCollections(dynamic entity, string userMail);
        IList<TModel> FindModelBy(PredicateFormatViewModel predicateModel);
        bool CheckExistence(PredicateFormatViewModel predicateModel);
        IList<TModel> FindNoTrackedModelBy(List<FilterViewModel> filters);
        List<string> GetConcernedProperties(string constraint);
        int FindIndiceFromDataSource(PredicateFormatViewModel predicateModel, ValueMapperViewModel valueMapperModel);
        void GenerateCodification(TEntity entity, string property, bool isApproved, bool isClaim = false, bool isDepositInvoice = false);
        void CopyFiles(string url, IList<IFormFile> files);
        void AddEntityAxesValues(IList<EntityAxisValuesViewModel> entityAxisValuesModelList, int id, string userMail);
        void DeleteUploadedFiles(string url, ICollection<string> files);
        void DeleteDirectoryFiles(string url);
        TModel GetModelWithRelationsAsNoTracked(Expression<Func<TEntity, bool>> predicate1, params Expression<Func<TEntity, object>>[] predicate2);
        void DeleteRecursive(dynamic context, dynamic entityToDelete, string tableName, string releatedTableName, string userMail);
        TModel FindSingleModelBy(PredicateFormatViewModel predicate);
        TModel FindSingleModelByNoTracked(PredicateFormatViewModel predicate);
        TModel GetModelAsNoTracked(Expression<Func<TEntity, bool>> condition, params Expression<Func<TEntity, object>>[] relations);
        void VerifyDuplication(Exception e);
        IList<TModel> GetModelsWithConditionsRelations(Expression<Func<TEntity, bool>> conditions, params Expression<Func<TEntity, object>>[] relations);
        bool CheckUnicity(UnicityViewModel unicityModel);
        IList<TModel> FindModelsByNoTracked(Expression<Func<TEntity, bool>> conditions, params Expression<Func<TEntity, object>>[] relations);
        void DeleteModelPhysicallyWhithoutTransaction(int id, string userMail);
        TModel GetModelById(int id);
        void CopyFiles(string url, IList<FileInfoViewModel> filesUploaded);
        void BulkAdd(IList<TModel> models, string userMail, string property = null);
        void BulkAddWithoutTransaction(IList<TModel> models, string userMail, string property = null);
        void BulkUpdateModel(IList<TModel> models, string userMail);
        void BulkUpdateModel(IList<TEntity> entities);
        void BulkUpdateModelWithoutTransaction(IList<TEntity> entities);
        void BulkUpdateModelWithoutTransaction(IList<TModel> models, string userMail);
        void BulkDeleteWithoutTransaction(IList<TEntity> models);
        void BulkDeleteModelsPhysically(IList<TModel> models, string userMail);
        void BulkDeleteModelsPhysicallyWhithoutTransaction(IList<TModel> models, string userMail);
        IQueryable<TModel> GetAllModelsQueryableWithRelation(Expression<Func<TEntity, bool>> filter, params Expression<Func<TEntity, object>>[] relation);
        void UpdateWithoutCollections(TModel model);
        void UpdateWithoutCollectionsWithoutTransaction(TModel model);
        TModel GetModelWithRelations(PredicateFormatViewModel predicateModel);
        IList<FileInfoViewModel> GetFilesContent(string url);
        string PrepareImageForReporting(string imageUrl, string imagePath);
        FileInfoViewModel DownloadZipFile(IList<int> ids);
        PredicateFilterRelationViewModel<TEntity> PreparePredicate(PredicateFormatViewModel predicateModel);
        void CreatFile(FileInfoViewModel file, string path);
        IList<TModel> FindByAsNoTracking(Expression<Func<TEntity, bool>> filter);
        void BeginTransaction();
        void BeginTransaction(string connectionString);
        void EndTransaction();
        void RollBackTransaction();
        void AddWithoutTransaction(TEntity models);

        bool CheckUnicityPerMonth(dynamic model);
        void BulkDeleteModelsPhysicallyWhithoutTransaction(IList<TModel> models);
        TEntity GetEntityAsNoTracked(Expression<Func<TEntity, bool>> condition, params Expression<Func<TEntity, object>>[] relations);
        void BulkAddWithoutTransactionMultiCodification(IList<TModel> models, string property, string value);
        IQueryable<TEntity> GetAllQueryableWithRelation(Expression<Func<TEntity, bool>> filter, params Expression<Func<TEntity, object>>[] relation);

        IList<FileInfoViewModel> GetFilesContents(List<string> urls);
        bool ExcelCheckUnicity(DataRow row, PropertyInfo property);
         Task<bool> GenerateDataBase(DBConfigViewModel informationsUser, HttpRequest httpContent);
        TEntity VerifIfEntityAlreadyExist(TEntity entity, string propertyName, List<object> codification);
    }
}
