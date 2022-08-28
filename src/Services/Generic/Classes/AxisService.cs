using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using ViewModels.DTO.ErpSettings;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
        where TModel : class
        where TEntity : class
    {

        public void AddEntityAxesValues(IList<EntityAxisValuesViewModel> entityAxisValuesModelList, int id, string userMail)
        {
            if (entityAxisValuesModelList != null)
            {
                foreach (EntityAxisValuesViewModel entityAxisValuesModel in entityAxisValuesModelList)
                {
                    EntityAxisValues entityAxisValuesEntity = _builderEntityAxisValues.BuildModel(entityAxisValuesModel);
                    entityAxisValuesEntity.IdEntityItem = id;
                    _entityRepoEntityAxisValues.Add(entityAxisValuesEntity);
                    // save entityAxisValue traceability
                }
            }
        }

        public void DeleteEntityAxisValue(int id, string tableName, string userMail)
        {
            // get entityAxesValue of current entity
            List<EntityAxisValues> entityAxisValuesEntityList = _entityRepoEntityAxisValues.GetAllWithConditionsRelations(c => c.IdEntityItem == id &&
                    c.IdAxisValueNavigation.IdAxisNavigation.AxisEntity.Any(p => p.IdTableEntityNavigation.TableName.Equals(tableName))).ToList();

            // delete entityAxesValues => update IsDeleted property to true
            foreach (EntityAxisValues entityAxisValuesEntity in entityAxisValuesEntityList)
            {
                entityAxisValuesEntity.IsDeleted = true;
                _entityRepoEntityAxisValues.Update(entityAxisValuesEntity);
            }
        }

        public void UpdateEntityAxesValues(List<EntityAxisValues> entityAxisValuesNewList, int id, string userMail)
        {
            if (entityAxisValuesNewList.Count > 0)
            {

                List<EntityAxisValues> entityAxisValuesOldList = _entityRepoEntityAxisValues.FindBy(c => c.IdEntityItem == id
                 && c.Entity == entityAxisValuesNewList.FirstOrDefault().Entity).ToList();
                // add new entityAxesValues
                foreach (EntityAxisValues entityAxisValuesEntity in entityAxisValuesNewList)
                {
                    // verify Axis existence ==> 
                    // add element if not exist 
                    // update element if exist and isDeleted == true
                    EntityAxisValues entityAxisValuesOldEntity = entityAxisValuesOldList.Find(c => c.IdAxisValue == entityAxisValuesEntity.IdAxisValue
                                                        && c.IdEntityItem == entityAxisValuesEntity.IdEntityItem
                                                        && c.Entity == entityAxisValuesEntity.Entity);
                    if (entityAxisValuesOldEntity == null) //add element if not exist 
                    {
                        entityAxisValuesEntity.IdEntityItem = id;
                        _entityRepoEntityAxisValues.Add(entityAxisValuesEntity);

                    }
                    else //update element if exist and isDeleted == true
                    {
                        if (entityAxisValuesOldEntity.IsDeleted)
                        {
                            entityAxisValuesOldEntity.IsDeleted = false;
                            _entityRepoEntityAxisValues.Update(entityAxisValuesOldEntity);
                        }
                        entityAxisValuesOldList.Remove(entityAxisValuesOldEntity);
                    }
                }
                // delete old entityAxesValues
                foreach (EntityAxisValues entityAxisValuesEntity in entityAxisValuesOldList)
                {
                    EntityAxisValues entityAxisValuesNewEntity = entityAxisValuesNewList.Find(c => c.IdAxisValue == entityAxisValuesEntity.IdAxisValue
                                                        && c.IdEntityItem == entityAxisValuesEntity.IdEntityItem
                                                        && c.Entity == entityAxisValuesEntity.Entity);
                    if (entityAxisValuesNewEntity == null) //add element if not exist 
                    {
                        entityAxisValuesEntity.IsDeleted = true;
                        _entityRepoEntityAxisValues.Update(entityAxisValuesEntity);
                    }
                }

            }
        }
    }
}
