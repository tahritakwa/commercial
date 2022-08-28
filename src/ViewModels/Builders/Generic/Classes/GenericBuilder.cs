using Newtonsoft.Json;
using Persistence.Entities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;
using System.Linq;
using System.Reflection;
using Utils.Enumerators;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.Builders.Generic.Interfaces;

/// <summary>
/// The Builder namespace.
/// </summary>
namespace ViewModels.Builders.Generic.Classes
{
    /// <summary>
    /// Class GenericBuilder.
    /// </summary>
    /// <typeparam name="TModel">The type of the t model.</typeparam>
    /// <typeparam name="TEntity">The type of the t entity.</typeparam>
    /// <seealso cref="IBuilder{TModel,TEntity}" />
    public class GenericBuilder<TModel, TEntity> : IBuilder<TModel, TEntity>
    where TModel : class
    where TEntity : class
    {

        /// <summary>
        /// Builds the entity.
        /// This method allow to build a viewModel from database model dynamically.
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual TModel BuildEntity(TEntity entity)
        {
            if (entity == null)
                return null;
            TModel viewModel = Activator.CreateInstance<TModel>();
            int depth = 0;
            CreateModelViewMapper(entity, viewModel, entity.GetType().Name, depth);
            return viewModel;
        }

        /// <summary>
        /// Recursive method for build a model from viewmodel
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="modelTypeName"></param>
        /// <param name="depth"></param>
        public virtual void CreateModelViewMapper(object model, object viewModel, string modelTypeName, int depth)
        {

            List<PropertyInfo> propertiesInfos = viewModel.GetType().GetProperties(BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).ToList();
            foreach (PropertyInfo viewModelPropertyInfo in propertiesInfos)
            {
                PropertyInfo modelPropertyInfo = model.GetType().GetProperty(viewModelPropertyInfo.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (modelPropertyInfo != null)
                {
                    if (modelPropertyInfo.PropertyType.Namespace.Contains("Persistence.Entities")
                        || modelPropertyInfo.PropertyType.Namespace.Contains("Persistence.CatalogEntities"))
                    {
                        BuildModelViewObjectNavigation(model, viewModel, modelTypeName, depth, viewModelPropertyInfo, modelPropertyInfo);
                    }
                    else if (modelPropertyInfo.PropertyType.Name.Equals("ICollection`1"))
                    {
                        BuildModelViewCollectionNavigation(model, viewModel, modelTypeName, depth, viewModelPropertyInfo, modelPropertyInfo);
                    }
                    else
                    {
                        BuildModelViewProperty(model, viewModel, viewModelPropertyInfo, modelPropertyInfo);
                    }
                }
            }
        }

        /// <summary>
        /// Build model object navigation to viewModel object navigation
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="modelTypeName"></param>
        /// <param name="depth"></param>
        /// <param name="viewModelPropertyInfo"></param>
        /// <param name="modelPropertyInfo"></param>
        private void BuildModelViewObjectNavigation(object model, object viewModel, string modelTypeName, int depth, PropertyInfo viewModelPropertyInfo, PropertyInfo modelPropertyInfo)
        {
            var propertyValue = modelPropertyInfo.GetValue(model);
            object navigationViewModel = null;
            if (propertyValue != null && modelTypeName != modelPropertyInfo.Name && modelTypeName != modelPropertyInfo.PropertyType.Name && depth < 3)
            {
                string assemblyQualifiedName = Assembly.CreateQualifiedName("ViewModels", viewModelPropertyInfo.PropertyType.FullName);
                Type destination = Type.GetType(assemblyQualifiedName);
                navigationViewModel = Activator.CreateInstance(destination);
                CreateModelViewMapper(propertyValue, navigationViewModel, modelTypeName, ++depth);
            }
            viewModelPropertyInfo.SetValue(viewModel, navigationViewModel);
        }

        /// <summary>
        /// Build model object collection to viewModel object collection
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="modelTypeName"></param>
        /// <param name="depth"></param>
        /// <param name="viewModelPropertyInfo"></param>
        /// <param name="modelPropertyInfo"></param>
        public void BuildModelViewCollectionNavigation(object model, object viewModel, string modelTypeName, int depth, PropertyInfo viewModelPropertyInfo, PropertyInfo modelPropertyInfo)
        {
            Type[] genericArgs = viewModelPropertyInfo.PropertyType.GetGenericArguments();
            if (genericArgs.Any())
            {
                Type destination = typeof(List<>).MakeGenericType(genericArgs);
                IList relationList = (IList)Activator.CreateInstance(destination);
                Type relationListTElementType = relationList.GetType().GetGenericArguments()[0];
                if (modelPropertyInfo.GetValue(model) is IEnumerable mCollections && modelTypeName != relationListTElementType.Name.Replace("ViewModel", string.Empty) && depth <= 3)
                {
                    if (depth < 3)
                    {
                        ++depth;
                        foreach (object item in mCollections)
                        {
                            object navigationViewModel = Activator.CreateInstance(relationListTElementType);
                            CreateModelViewMapper(item, navigationViewModel, modelTypeName, depth);
                            relationList.Add(navigationViewModel);
                        }
                    }

                }
                viewModelPropertyInfo.SetValue(viewModel, relationList);
            }
        }

        /// <summary>
        /// Build model simple property to modelview simple property
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="viewModelPropertyInfo"></param>
        /// <param name="modelPropertyInfo"></param>
        public void BuildModelViewProperty(object model, object viewModel, PropertyInfo viewModelPropertyInfo, PropertyInfo modelPropertyInfo)
        {
            object propValue = modelPropertyInfo.GetValue(model);
            if (modelPropertyInfo.PropertyType.ToString().Contains("[System.DateTime]"))
            {
                if (propValue != null)
                {
                    propValue = DateTime.Parse(propValue.ToString(), null, DateTimeStyles.RoundtripKind);
                }
            }
            viewModelPropertyInfo.SetValue(viewModel, propValue);
        }

        /// <summary>
        /// Builds the model.
        /// This method allow to build a database model from viewModel dynamically.
        /// </summary>
        /// <param name="viewModel"></param>
        /// <returns></returns>
        public virtual TEntity BuildModel(TModel viewModel)
        {
            if (viewModel == null)
                return null;
            TEntity model = Activator.CreateInstance<TEntity>();
            CreateEntityMapper(viewModel, model);
            return model;
        }

        /// <summary>
        /// Recursive method for build a viewmodel from model
        /// </summary>
        /// <param name="viewModel"></param>
        /// <param name="model"></param>
        private void CreateEntityMapper(object viewModel, object model)
        {
            List<PropertyInfo> propertiesInfos = model.GetType().GetProperties(BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance)
                .Where(x => !x.GetCustomAttributes(typeof(NotMappedAttribute), false).Any()).ToList();
            foreach (PropertyInfo modelPropertyInfo in propertiesInfos)
            {
                PropertyInfo viewModelPropertyInfo = viewModel.GetType().GetProperty(modelPropertyInfo.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (viewModelPropertyInfo != null)
                {
                    if (viewModelPropertyInfo.PropertyType.Namespace.Contains("ViewModels"))
                    {
                        BuildModelObjectNavigation(model, viewModel, modelPropertyInfo, viewModelPropertyInfo);
                    }
                    else if (modelPropertyInfo.PropertyType.Name.Equals("ICollection`1"))
                    {
                        BuildModelCollectionNavigation(model, viewModel, modelPropertyInfo, viewModelPropertyInfo);
                    }
                    else
                    {
                        modelPropertyInfo.SetValue(model, viewModelPropertyInfo.GetValue(viewModel));
                    }
                }
            }
        }

        /// <summary>
        /// Build viewmodel object navigation to model object navigation
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="modelPropertyInfo"></param>
        /// <param name="viewModelPropertyInfo"></param>
        private void BuildModelObjectNavigation(object model, object viewModel, PropertyInfo modelPropertyInfo, PropertyInfo viewModelPropertyInfo)
        {
            var propertyValue = viewModelPropertyInfo.GetValue(viewModel);
            object navigationModel = null;
            if (propertyValue != null && (propertyValue.GetType().GetProperty("Id") == null ||
                (int)propertyValue.GetType().GetProperty("Id").GetValue(propertyValue) == 0
                || !viewModelPropertyInfo.Name.Contains("ViewModel")))
            {
                string assemblyQualifiedName = Assembly.CreateQualifiedName("Persistence", modelPropertyInfo.PropertyType.FullName);
                Type destination = Type.GetType(assemblyQualifiedName);
                navigationModel = Activator.CreateInstance(destination);
                CreateEntityMapper(propertyValue, navigationModel);
            }
            modelPropertyInfo.SetValue(model, navigationModel);
        }

        /// <summary>
        /// Build viewmodel object collection to model object collection
        /// </summary>
        /// <param name="model"></param>
        /// <param name="viewModel"></param>
        /// <param name="modelPropertyInfo"></param>
        /// <param name="viewModelPropertyInfo"></param>
        private void BuildModelCollectionNavigation(object model, object viewModel, PropertyInfo modelPropertyInfo, PropertyInfo viewModelPropertyInfo)
        {
            Type[] genericArgs = modelPropertyInfo.PropertyType.GetGenericArguments();
            if (genericArgs.Any())
            {
                Type destination = typeof(List<>).MakeGenericType(genericArgs);
                IList relationList = (IList)Activator.CreateInstance(destination);
                Type relationListTElementType = relationList.GetType().GetGenericArguments()[0];
                if (viewModelPropertyInfo.GetValue(viewModel) is IList mCollections)
                {
                    foreach (object item in mCollections)
                    {
                        object navigationModel = Activator.CreateInstance(relationListTElementType);
                        CreateEntityMapper(item, navigationModel);
                        relationList.Add(navigationModel);
                    }
                }
                modelPropertyInfo.SetValue(model, relationList);
            }
        }

        /// <summary>
        /// Mapping Entity
        /// </summary>
        /// <param name="oldEntity"></param>
        /// <param name="newEntity"></param>
        /// <returns></returns>
        public object MappingEntity(object oldEntity, object newEntity)
        {
            foreach (PropertyInfo newProp in newEntity.GetType().GetProperties())
            {
                PropertyInfo oldProp = oldEntity.GetType().GetProperty(newProp.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                if (oldProp != null)
                    newProp.SetValue(newEntity, oldProp.GetValue(oldEntity));
            }
            return newEntity;
        }
        public virtual dynamic BuildMasterSlaveModel(dynamic modelToConvert, dynamic modelToReturn)
        {
            if (modelToConvert != null)
            {
                Type myType = modelToConvert.GetType();
                IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());
                foreach (PropertyInfo prop in props)
                {
                    var propValue = prop.GetValue(modelToConvert, null);
                    if (propValue != null && modelToReturn.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance) != null)
                    {
                        /// This part of code make sure that any collection is builded automatically to the viewModel list.
                        if (prop.PropertyType.Name.Equals("ICollection`1"))
                        {
                            if (((IEnumerable)propValue).GetEnumerator().MoveNext())
                            {
                                var typeOfElementModel = modelToReturn.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                                var listType = typeof(List<>);
                                var genericArgs = typeOfElementModel.PropertyType.GetGenericArguments();
                                var concreteType = listType.MakeGenericType(genericArgs);
                                IList relationList = (IList)Activator.CreateInstance(concreteType);
                                Type relationListTElementType = relationList.GetType().GetGenericArguments()[0];
                                foreach (var elementOfListModel in (IEnumerable)propValue)
                                {
                                    Type elementOfListModelType = elementOfListModel.GetType();
                                    IList<PropertyInfo> properties = new List<PropertyInfo>(elementOfListModelType.GetProperties());
                                    var buildedModel = Activator.CreateInstance(relationListTElementType);
                                    foreach (PropertyInfo property in properties)
                                    {
                                        object propertyValue = property.GetValue(elementOfListModel, null);
                                        if (propertyValue != null
                                            && buildedModel.GetType().GetProperty(property.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance) != null
                                           && !property.PropertyType.Name.Equals("ICollection`1"))
                                        {
                                            var res = buildedModel.GetType().GetProperty(property.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                                            res.SetValue(buildedModel, propertyValue);
                                        }
                                    }
                                    relationList.Add(buildedModel);
                                }
                                modelToReturn.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(modelToReturn, relationList);
                            }

                        }
                        else
                        {
                            modelToReturn.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(modelToReturn, propValue);

                        }
                    }
                }
                return modelToReturn;

            }
            return null;

        }
        /// <summary>
        /// Builds the modelview from Drupal model.
        /// </summary>
        /// <param name="DrupalModel"></param>
        /// <param name="ViewModel"></param>
        /// <returns></returns>
        public virtual dynamic BuildModelFromDrupalModel(dynamic DrupalModel, dynamic ViewModel, dynamic serviceProvider)
        {
            if (DrupalModel != null)
            {
                Type myType = DrupalModel.GetType();
                IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());
                foreach (PropertyInfo prop in props)
                {
                    object propValue = prop.GetValue(DrupalModel, null);
                    if (propValue != null && ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance) != null)
                    {
                        // if same Type and same Name
                        if (ViewModel.GetType().GetProperty(prop.Name).PropertyType.Name.Equals(prop.PropertyType.Name))
                        {
                            ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(ViewModel, propValue);

                        }
                        else
                        {
                            // if not equal Type and same Name
                            string Name = string.Concat(prop.Name, "Navigation");
                            // if type is modelview
                            if (ViewModel.GetType().GetProperty(Name) != null && ViewModel.GetType().GetProperty(Name).PropertyType.Namespace.Contains("ViewModels"))
                            {
                                string[] element = ViewModel.GetType().GetProperty(Name).PropertyType.Namespace.Split(".");
                                var ModelViewName = ViewModel.GetType().GetProperty(Name).PropertyType.Name;
                                var entityName = ModelViewName.Replace("ViewModel", string.Empty);
                                DynamicService dynamicService = new DynamicService(serviceProvider);
                                dynamic entityService = dynamicService.CreateDynamicService(element[2], entityName);
                                PredicateFormatViewModel predicate = new PredicateFormatViewModel
                                {
                                    Filter = new List<FilterViewModel>
                                    {
                                     new FilterViewModel { Prop = "NameFr", Value = propValue, Operation = Operation.Equals },
                                    }
                                };
                                var vm = entityService.FindSingleModelBy(predicate);
                                if (vm != null)
                                {
                                    ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(ViewModel, vm.Id);
                                }

                            }
                            // if type is collection
                            else if (ViewModel.GetType().GetProperty(prop.Name) != null
                                   && ViewModel.GetType().GetProperty(prop.Name).PropertyType.Name.Contains("ICollection`1"))
                            {
                                var typeOfElementModel = ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
                                var listType = typeof(List<>);
                                var genericArgs = typeOfElementModel.PropertyType.GetGenericArguments();
                                var concreteType = listType.MakeGenericType(genericArgs);
                                IList relationList = (IList)Activator.CreateInstance(concreteType);
                                Type relationListTElementType = relationList.GetType().GetGenericArguments()[0];
                                var buildedModel = Activator.CreateInstance(relationListTElementType);
                                var ModelView = buildedModel.GetType();
                                buildedModel = JsonConvert.DeserializeObject(propValue.ToString(), ModelView);
                                relationList.Add(buildedModel);
                                ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(ViewModel, relationList);

                            }
                            // if type is not modelview or collection
                            else
                            {
                                var entityName = prop.Name.Replace("Id", string.Empty);
                                DynamicService dynamicService = new DynamicService(serviceProvider);
                                dynamic entityService = dynamicService.CreateDynamicService("Shared", entityName);
                                PredicateFormatViewModel predicate = new PredicateFormatViewModel
                                {
                                    Filter = new List<FilterViewModel>
                                    {
                                     new FilterViewModel { Prop = "OfficeName", Value = propValue, Operation = Operation.Equals }
                                    }
                                };
                                var vm = entityService.FindSingleModelBy(predicate);
                                if (vm != null)
                                {
                                    ViewModel.GetType().GetProperty(prop.Name, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance).SetValue(ViewModel, vm.Id);

                                }
                            }
                        }
                    }
                }
            }
            return ViewModel;
        }

    }

}