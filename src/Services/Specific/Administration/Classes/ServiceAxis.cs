using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Administration.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Comparers;
using ViewModels.DTO.Administration;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Utils;

namespace Services.Specific.Administration.Classes
{
    public class ServiceAxis : Service<AxisViewModel, Axis>, IServiceAxis
    {
        private readonly IRepository<Axis> _entityRepoAxis;
        private readonly IRepository<AxisEntity> _entityRepoAxisEntity;
        private readonly IRepository<AxisRelationShip> _entityRepoAxisRelationShip;
        private readonly IServiceAxisRelationShip _serviceAxisRelationShip;
        private readonly IAxisBuilder _axisBuilder;

        public ServiceAxis(IRepository<AxisValue> entityRepoAxisValue, IRepository<Axis> entityRepoAxis, IRepository<Entity> entityRepoEntity,
            IRepository<AxisEntity> entityRepoAxisEntity, IUnitOfWork unitOfWork,
            IAxisBuilder axisBuilder, IRepository<AxisRelationShip> entityRepoAxisRelationShip,
            IRepository<EntityAxisValues> entityEntityAxisValues,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification,
             IOptions<AppSettings> appSettings, IRepository<Company> entityRepoCompany, IServiceAxisRelationShip serviceAxisRelationShip)
            : base(entityRepoAxis, unitOfWork, axisBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings,
                  entityRepoCompany, entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _entityRepoAxis = entityRepoAxis;
            _entityRepoAxisEntity = entityRepoAxisEntity;
            _axisBuilder = axisBuilder;
            _entityRepoAxisRelationShip = entityRepoAxisRelationShip;
            _serviceAxisRelationShip = serviceAxisRelationShip;
        }
        /// <summary>
        /// Recuperate entity from Entity table by its name
        /// </summary>
        /// <param name="entityName">Name of entity</param>
        /// <returns></returns>
        public Entity GetEntityFromName(string entityName)
        {
            return _entityRepoEntity.GetSingleWithRelations(c => c.EntityName == entityName, c => c.AxisEntity);
        }
        /// <summary>
        /// Recuperate axis of an entity
        /// </summary>
        /// <param name="entityName">Name of entity</param>
        /// <returns></returns>
        public IList<AxisViewModel> GetAxisByEntity(string entityName)
        {
            Entity entity = _entityRepoEntity.GetSingleWithRelations(c => c.EntityName == entityName, c => c.AxisEntity);
            List<AxisViewModel> axis = _entityRepoAxisEntity.GetAllWithConditionsRelations(c => c.IdTableEntity == entity.Id && c.IsDeleted == false,
                c => c.IdAxisNavigation, c => c.IdAxisNavigation.AxisRelationShipIdAxisNavigation).OrderBy(p => p.IdAxisNavigation.Rank)
                .Select(c => _axisBuilder.BuildEntity(c.IdAxisNavigation)).ToList();
            IList<AxisViewModel> listAxisWithChildrens = new List<AxisViewModel>();
            List<AxisViewModel> listAxisHavingParent = axis.Where(c => c.AxisRelationShipIdAxisNavigation != null && c.AxisRelationShipIdAxisNavigation.Any(p => p.IdAxisParent == null)).ToList();
            if (listAxisHavingParent.Any())
            {
                listAxisWithChildrens = GetAxisChildren(listAxisHavingParent, axis);
            }
            return listAxisWithChildrens;
        }
        /// <summary>
        /// Recuperate the hierarchy of all entities
        /// </summary>
        /// <returns></returns>
        public IList<AxisTreeListViewModel> GetAxesHierarchy()
        {
            List<AxisTreeListViewModel> globalAxisTreeList = new List<AxisTreeListViewModel>();
            var entities = _entityRepoEntity.GetAllWithConditionsRelations(p => p.AxisEntity.Count != 0, c => c.AxisEntity).OrderBy(p => p.EntityName).ToList();
            foreach (var entity in entities)
            {
                var axisTreeList = GetTreeListAxis(entity.Id);
                if (axisTreeList.Any())
                {
                    axisTreeList.Where(p => p.IdParent == null).ToList().ForEach(c => c.IdParent = entity.Id.ToString());
                    axisTreeList.Add(new AxisTreeListViewModel
                    {
                        Id = entity.Id,
                        Code = entity.EntityName,
                        Fr = entity.EntityName,
                        En = entity.EntityName,
                        Label = entity.EntityName,
                        IdChildren = entity.Id.ToString(),
                        IdParent = null
                    });
                    globalAxisTreeList.AddRange(axisTreeList);
                }
            }
            return globalAxisTreeList;
        }

        /// <summary>
        /// recuperate the axis hierarchy of an entity
        /// </summary>
        /// <param name="entityId"></param>
        /// <returns></returns>
        public IList<AxisTreeListViewModel> GetTreeListAxis(int entityId)
        {
            // get axis of entity
            List<AxisViewModel> axisList = _entityRepoAxisEntity.GetAllWithConditionsRelations(c => c.IdTableEntity == entityId && !c.IsDeleted,
                    c => c.IdAxisNavigation, c => c.IdAxisNavigation.AxisRelationShipIdAxisNavigation)
                .Select(c => _axisBuilder.BuildEntity(c.IdAxisNavigation)).ToList();
            List<AxisTreeListViewModel> axisTreeList = new List<AxisTreeListViewModel>();
            try
            {
                // prepare the axis hierarchy
                foreach (AxisViewModel axis in axisList)
                {
                    if (axis.AxisRelationShipIdAxisNavigation != null)
                    {
                        foreach (AxisRelationShipViewModel axisRelation in axis.AxisRelationShipIdAxisNavigation)
                        {
                            var element = new AxisTreeListViewModel();
                            element = (AxisTreeListViewModel)_axisBuilder.MappingEntity(axis, element);
                            // verify if the axis has an axis parent
                            if (axisRelation.IdAxisParent.HasValue)
                            {
                                // get the axis parent 
                                Axis axisParent = _entityRepoAxis.GetSingleWithRelations(c => c.Id == axisRelation.IdAxisParent.Value, p => p.AxisEntity);
                                // verify if the axis parent belongs to the same entity
                                if (axisParent.AxisEntity.Any(c => c.IdTableEntity == entityId))
                                    element.IdParent = axisRelation.IdAxisParent.Value + "-" + entityId.ToString();
                            }
                            element.IdChildren = element.Id + "-" + entityId;
                            axisTreeList.Add(element);
                        }
                    }

                }
            }
            catch (CustomException)
            {

                throw;
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
            return axisTreeList;
        }

        /// <summary>
        /// Recuperate the children of an axis
        /// </summary>
        /// <param name="parentList">List of parent axis</param>
        /// <param name="globalList">List of axis</param>
        /// <returns></returns>
        private IList<AxisViewModel> GetAxisChildren(List<AxisViewModel> parentList, List<AxisViewModel> globalList)
        {
            if (parentList.Count > 0)
            {
                foreach (AxisViewModel axis in parentList)
                {
                    List<AxisViewModel> listAxisChildren = new List<AxisViewModel>();
                    foreach (AxisViewModel axisCh in globalList)
                    {
                        if (axisCh.AxisRelationShipIdAxisNavigation != null)
                        {
                            List<AxisRelationShipViewModel> listAxisRs = axisCh.AxisRelationShipIdAxisNavigation.Where(p => p.IdAxisParent == axis.Id).ToList();
                            foreach (AxisRelationShipViewModel axisRs in listAxisRs)
                            {
                                listAxisChildren.AddRange(globalList.Where(c => c.Id == axisRs.IdAxis).ToList());
                            }
                        }

                    }
                    axis.AxisChildren = listAxisChildren;
                    GetAxisChildren(axis.AxisChildren.ToList(), globalList);
                }
            }
            return parentList;
        }

        /// <summary>
        /// Override of generic service method AddModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        public override object AddModelWithoutTransaction(AxisViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            if (!model.AxisRelationShipIdAxisNavigation.Any())
            {
                AxisRelationShipViewModel axisRs = new AxisRelationShipViewModel
                {
                    IdAxis = model.Id,
                    IdAxisParent = null
                };
                model.AxisRelationShipIdAxisNavigation.Add(axisRs);
            }
            dynamic entity = _axisBuilder.BuildModel(model);

            // add entity
            _entityRepoAxis.Add(entity);
            _unitOfWork.Commit();

            // add entityAxesValues
            AddEntityAxesValues(entityAxisValuesModelList, (int)entity.Id, userMail);
            _unitOfWork.Commit();

           
            if (GetPropertyName(entity) != null)
                return new CreatedDataViewModel { Id = (int)entity.Id, Code = getModelCode(entity, GetPropertyName(entity)) };
            return new CreatedDataViewModel { Id = (int)entity.Id };
        }



        /// <summary>
        /// Override of generic service method UpdateModelWithoutTransaction
        /// </summary>
        /// <param name="model"></param>
        /// <param name="entityAxisValuesModelList"></param>
        /// <param name="userMail"></param>
        /// <param name="property"></param>
        public override object UpdateModelWithoutTransaction(AxisViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            UpdateAxisParent(model, userMail);
            model.AxisEntity.ToList().ForEach(ars => ars.IdAxis = model.Id);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
            
        }


        private void UpdateAxisParent(AxisViewModel model, string userMail)
        {
            if (model.AxisRelationShipIdAxisNavigation != null && model.AxisRelationShipIdAxisNavigation.Any())
            {
                Axis axis = _axisBuilder.BuildModel(model);

                List<AxisRelationShipViewModel> oldAxisRs = _serviceAxisRelationShip.FindModelBy(p => p.IdAxis == axis.Id).ToList();
                List<AxisRelationShipViewModel> newAxisRs = model.AxisRelationShipIdAxisNavigation.ToList();
                newAxisRs.ForEach(ars => ars.IdAxis = axis.Id);

                List<AxisRelationShipViewModel> addedAxisRs = newAxisRs.Except(oldAxisRs, new AxisRelationShipComparer()).ToList();
                List<AxisRelationShipViewModel> deletedAxisRs = oldAxisRs.Except(newAxisRs, new AxisRelationShipComparer()).ToList();

                foreach (AxisRelationShipViewModel item in addedAxisRs)
                {
                    item.IdAxis = axis.Id;
                    _serviceAxisRelationShip.AddModelWithoutTransaction(item, null, userMail);
                }
                foreach (AxisRelationShipViewModel item in deletedAxisRs)
                {
                    item.IdAxis = axis.Id;
                    _serviceAxisRelationShip.DeleteModelwithouTransaction(item.Id, "AxisRelationShip", userMail);
                }
                model.AxisRelationShipIdAxisNavigation.Clear();
            }
            else
            {
                List<AxisRelationShip> oldAxisRs = _entityRepoAxisRelationShip.FindBy(p => p.IdAxis == model.Id).ToList();
                foreach (AxisRelationShip item in oldAxisRs)
                {
                    item.IdAxisParent = null;
                    _entityRepoAxisRelationShip.Update(item);
                }
            }
        }

        public IList<AxisViewModel> GetEntityAxis(PredicateFormatViewModel predicate)
        {
            List<AxisViewModel> entityAxisValue = new List<AxisViewModel>();
            try
            {
                var filterAxisEntity = predicate.Filter.FirstOrDefault(x => x.Prop.Contains("AxisEntity"));
                if (filterAxisEntity != null && filterAxisEntity.Value != null)
                {
                    int[] listentity = JsonConvert.DeserializeObject<int[]>(filterAxisEntity.Value.ToString());
                    if (listentity != null && listentity.Any())
                    {
                        entityAxisValue = _entityRepoAxisEntity.GetAllWithConditionsRelations(c => listentity.Contains(c.IdTableEntity), x => x.IdAxisNavigation)
                   .Select(c => _axisBuilder.BuildEntity(c.IdAxisNavigation)).ToList();
                    }
                }

                var currentAxis = predicate.Filter.FirstOrDefault(x => x.Prop.Contains("IdCurrentAxis"));
                if (currentAxis != null && currentAxis.Value != null)
                {
                    List<int> listOfChildren = _serviceAxisRelationShip.GetAxisChildren(int.Parse(currentAxis.Value.ToString()), new List<int>()).ToList();
                    entityAxisValue = entityAxisValue.Where(x => !listOfChildren.Contains(x.Id) && x.Id != int.Parse(currentAxis.Value.ToString())).ToList();
                }
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception e)
            {
                throw new CustomException(CustomStatusCode.InternalServerError, e);
            }
            return entityAxisValue;
        }



    }

}



