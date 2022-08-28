using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Persistence.Entities;
using Persistence.Repository.Classes;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.Loader;
using System.Text;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
        where TModel : class
        where TEntity : class
    {
        public void GenerateCodification(TEntity entity, string property, bool isApproved, bool isClaim = false, bool isDepositInvoice = false)
        {
            if (_entityRepoCodification == null)
            {
                return;
            }
            List<object> codification = new List<object>();

            string propertyName = GetPropertyName(entity);
            if (propertyName != null && (entity.GetType().GetProperty(propertyName).GetValue(entity) == null || entity.GetType().GetProperty(propertyName).GetValue(entity).ToString() == ""))
            {
                codification = getCodification(entity, property, isApproved, isClaim, isDepositInvoice);
                if (codification[2] != null && codification[2].ToString() != "")
                {

                    TEntity entityInDB = VerifIfEntityAlreadyExist(entity,propertyName,codification);
                        if (entityInDB != null)
                    {
                        if ((!(entity is Document)) ||
                            (entity is Document && entity.GetType().GetProperty("DocumentTypeCode").GetValue(entity) == entityInDB.GetType().GetProperty("DocumentTypeCode").GetValue(entityInDB)))
                        {
                            IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                        {
                            { "CODE",codification[2].ToString()}
                        };
                            throw new CustomException(CustomStatusCode.CodeAlreadyExist, paramtrs);
                        }

                    }
                }
                entity.GetType().GetProperty(propertyName).SetValue(entity, codification[2].ToString());
            }
            if (codification.Any() && (entity != null && ((Codification)codification[0]).Id != 0))
            {
                ((Codification)codification[0]).LastCounterValue = codification[1].ToString();
                _entityRepoCodification.Update(((Codification)codification[0]));
                _unitOfWork.Commit();
            }
        }
        public virtual TEntity VerifIfEntityAlreadyExist(TEntity entity, string propertyName, List<object>  codification)
        {
            return _entityRepo.GetAll().ToList().Where(x => entity.GetType().GetProperty(propertyName).GetValue(x).ToString() == codification[2].ToString()).FirstOrDefault();

        }
        public CodificationCounter GetCodificationCounter(dynamic entity, string property, string entityValue, bool isApproved = false, bool isClaim = false)
        {
            //List of object that contains counterEntity,counter and chainCodification
            CodificationCounter codificationCounter = new CodificationCounter();
            if (entity != null)
            {
                string entityName = entity.GetType().Name;
                Entity entityByName = _entityRepoEntity.GetSingleNotTracked(p => p.EntityName == entityName);
                IQueryable<EntityCodification> queryEntityCodification = _entityRepoEntityCodification
                    .QuerableGetAll(r => r.IdCodificationNavigation);

                //If entity not null ==> add to filters
                if (entityByName != null)
                {
                    queryEntityCodification = queryEntityCodification.Where(p => p.IdEntity == entityByName.Id);
                }

                //If property and  Value not null ==> add to filters
                if (property != null && entity.GetType().GetProperty(property) != null)
                {
                    entityValue = (entity is Document && entity.IsRestaurn) ? "AF-R" : entityValue;
                    entityValue = (isApproved) ? "A-" + entityValue : entityValue;
                    entityValue = (isClaim) ? "RE-" + entityValue : entityValue;
                    queryEntityCodification = queryEntityCodification.Where(p => p.Property == property.ToString() && p.Value == entityValue);
                }

                List<EntityCodification> ListEntityCodification = queryEntityCodification.ToList();

                if (property != null)
                {
                    ListEntityCodification.RemoveAll(c => c.Property != property || c.Value != entityValue);
                }

                EntityCodification entityCodification = null;

                if (ListEntityCodification != null && ListEntityCodification.Count > 0)
                    entityCodification = ListEntityCodification[0];





                if (entityCodification != null)
                {

                    //Get list of codiffications from entityCodification
                    var listCodification = _entityRepoCodification.
                        GetAllWithRelations(x => x.IdCodificationParentNavigation).
                        Where(x => x.IdCodificationParent == entityCodification.IdCodification).
                        OrderBy(x => x.Rank).ToList();

                    List<ObjectCounteur> objectCounteurList = new List<ObjectCounteur>();

                    //Loop list of codifications
                    foreach (Codification code in listCodification)
                    {
                        ObjectCounteur objectCounteur = new ObjectCounteur();
                        objectCounteur.Rank = code.Rank;
                        //If the code is a counter ==> execute getCounter() to return the counter
                        if (code.IsCounter == true)
                        {
                            codificationCounter.Counteur = code;
                            objectCounteur.IsCompteur = true;
                            objectCounteur.Value = code.LastCounterValue;
                        }

                        //if code has a initValue ==> add initValue of coe to chainCodification
                        else if (code.InitValue != null)
                        {
                            objectCounteur.IsCompteur = false;
                            objectCounteur.Value = code.InitValue;

                        }
                        else if (code.Path != null)
                        {
                            /*If code has a path and format ==> execute a piece of code and add the result 
                                of execution code to chainCodification*/
                            if (code.Format != null)
                            {
                                objectCounteur.IsCompteur = false;
                                objectCounteur.Value = ExecuteCode(code, entity);
                            }
                            //If code has a path and has not format
                            else
                            {
                                //Get properties in path of code
                                string[] properties = code.Path.Split('.');
                                dynamic newPropertyValue = entity;
                                //Loop list of properties and get the newPropertyValue that will contains the value of last property
                                newPropertyValue = getValueFromPropertiesOfPathCode(properties, newPropertyValue);
                                //If newPropertyValue has a value and is a simple object==> add to chainCodification
                                if (newPropertyValue != null && !newPropertyValue.GetType().Namespace.Contains("Persistence.Entities") && !newPropertyValue.GetType().Namespace.Contains("ModelView"))
                                {
                                    objectCounteur.IsCompteur = false;
                                    objectCounteur.Value = newPropertyValue; ;
                                }
                            }
                        }
                        objectCounteurList.Add(objectCounteur);
                    }
                    codificationCounter.ObjectCounteurList = objectCounteurList;

                }
            }
            return codificationCounter;
        }

        public void SetCodification(IList<TEntity> entities, CodificationCounter codificationCounter)
        {
            var propertyName = GetPropertyName(entities.FirstOrDefault());
            if (propertyName == null)
            {
                return;
            }
            foreach (var entity in entities)
            {
                var codeString = new StringBuilder();
                foreach (var code in codificationCounter.ObjectCounteurList.OrderBy(x => x.Rank))
                {
                    if (code.IsCompteur)
                    {
                        var nextCounteur = getCounter(codificationCounter.Counteur);
                        codeString.Append(nextCounteur);
                        codificationCounter.Counteur.LastCounterValue = nextCounteur;
                    }
                    else
                    {
                        codeString.Append(code.Value);
                    }
                }

                entity.GetType().GetProperty(propertyName).SetValue(entity, codeString.ToString());
            }

            _entityRepoCodification.Update(codificationCounter.Counteur);
            _unitOfWork.Commit();

        }

        public string GetPropertyName(TEntity entity)
        {
            string propertyName = null;
            if (entity.GetType().GetProperty("Code") != null)
            {
                propertyName = "Code";
            }
            else if (entity.GetType().GetProperty("Code" + entity.GetType().Name) != null)
            {
                propertyName = "Code" + entity.GetType().Name;
            }
            else if (entity.GetType().GetProperty(entity.GetType().Name + "Code") != null)
            {
                propertyName = entity.GetType().Name + "Code";
            }
            return propertyName;
        }

        public List<object> getCodification(dynamic entity, string property, bool isApproved, bool isClaim = false, bool isDepositInvoice = false)
        {
            //Codification Entity of counter element
            Codification counterEntity = new Codification();
            //Last value of counter
            string counter = "";
            //Generated code 
            StringBuilder chainCodification = new StringBuilder();


            string entityName = entity.GetType().Name;
            Entity entityByName = _entityRepoEntity.GetSingleNotTracked(p => p.EntityName == entityName);


            IQueryable<EntityCodification> queryEntityCodification = _entityRepoEntityCodification
                .QuerableGetAll(r => r.IdCodificationNavigation);
            //If entity not null ==> add to filters
            if (entityByName != null)
            {
                queryEntityCodification = queryEntityCodification.Where(p => p.IdEntity == entityByName.Id);
            }
            string entityValue = string.Empty;
            //If property and  Value not null ==> add to filters
            if (property != null && entity.GetType().GetProperty(property) != null && entity.GetType().GetProperty(property).GetValue(entity, null) != null)
            {
                entityValue = entity.GetType().GetProperty(property).GetValue(entity, null).ToString();
                entityValue = (entity is Document && entity.IsRestaurn) ? "AF-R" : entityValue;
                entityValue = (isDepositInvoice) ? "AC-" + entityValue : entityValue;
                entityValue = (isApproved) ? "A-" + entityValue : entityValue;
                entityValue = (isClaim) ? "RE-" + entityValue : entityValue;
                queryEntityCodification = queryEntityCodification.Where(p => p.Property == property.ToString() && p.Value == entityValue);
            }
            List<EntityCodification> ListEntityCodification = queryEntityCodification.ToList();

            if (property != null)
            {
                ListEntityCodification.RemoveAll(c => c.Property != property || c.Value != entityValue);
            }

            EntityCodification entityCodification = null;
            if (ListEntityCodification != null && ListEntityCodification.Count > 0)
                entityCodification = ListEntityCodification[0];

            //List of object that contains counterEntity,counter and chainCodification
            List<object> codificationObject = new List<object>();
            if (entityCodification != null)
            {
                //Get list of codiffications from entityCodification
                var listCodification = _entityRepoCodification.
                    GetAllWithRelations(x => x.IdCodificationParentNavigation).
                    Where(x => x.IdCodificationParent == entityCodification.IdCodification).
                    OrderBy(x => x.Rank).ToList();
                entityCodification.IdCodificationNavigation.InverseIdCodificationParentNavigation = listCodification;
                //Loop list of codifications
                foreach (Codification code in entityCodification.IdCodificationNavigation.InverseIdCodificationParentNavigation)
                {
                    //If the code is a counter ==> execute getCounter() to return the counter
                    if (code.IsCounter == true)
                    {
                        counterEntity = code;
                        //Get Counter
                        counter = getCounter(code);
                        //Add counter to chainCodification
                        chainCodification.Append(counter);
                    }
                    else
                    {
                        //if code has a initValue ==> add initValue of coe to chainCodification
                        if (code.InitValue != null)
                        {
                            chainCodification.Append(code.InitValue);
                        }
                        else if (code.Path != null)
                        {
                            /*If code has a path and format ==> execute a piece of code and add the result 
                                of execution code to chainCodification*/
                            if (code.Format != null)
                            {
                                chainCodification.Append(ExecuteCode(code, entity));
                            }
                            //If code has a path and has not format
                            else
                            {
                                //Get properties in path of code
                                string[] properties = code.Path.Split('.');
                                dynamic newPropertyValue = entity;
                                //Loop list of properties and get the newPropertyValue that will contains the value of last property
                                newPropertyValue = getValueFromPropertiesOfPathCode(properties, newPropertyValue);
                                //If newPropertyValue has a value and is a simple object==> add to chainCodification
                                if (newPropertyValue != null && !newPropertyValue.GetType().Namespace.Contains("Persistence.Entities") && !newPropertyValue.GetType().Namespace.Contains("ModelView"))
                                    chainCodification.Append(newPropertyValue);

                            }
                        }
                    }
                }
            }


            codificationObject.AddRange(new List<object> { counterEntity, counter, chainCodification });

            return codificationObject;
        }

        public string getModelCode(dynamic entity, string propertyName)
        {
            return entity.GetType().GetProperty(propertyName).GetValue(entity);
        }
        private string ExecuteCode(Codification codification, object entity)
        {
            Codification counterCodification = codification.IdCodificationParentNavigation.InverseIdCodificationParentNavigation.Where(y => y.IsCounter == true).FirstOrDefault();
            string subPath = Path.GetFullPath("temp"); // your code goes here
            if (!Directory.Exists(subPath))
            {
                Directory.CreateDirectory(subPath);
            }
            string guid = Guid.NewGuid().ToString();
            string code = "using System; using Persistence.Entities; public static class ClassToCompile{ public static "
                + codification.Format + " MethodToCompile(object entity, Codification counterCodification){  "
                + codification.Path + "} }";
            var compilation = CSharpCompilation.Create(guid)
                            .WithOptions(new CSharpCompilationOptions(OutputKind.DynamicallyLinkedLibrary))
                            .AddReferences(
                MetadataReference.CreateFromFile(typeof(object).GetTypeInfo().Assembly.Location), MetadataReference.CreateFromFile(typeof(Codification).GetTypeInfo().Assembly.Location))
                               .AddSyntaxTrees(CSharpSyntaxTree.ParseText(code));
            var pathFile = Path.Combine(Path.GetFullPath("temp"), guid);
            string result = "";
            using (MemoryStream memoryStream = new MemoryStream())
            {
                var emit = compilation.Emit(pathFile);
                if (emit.Success)
                {
                    var assempbly = AssemblyLoadContext.Default.LoadFromAssemblyPath(Path.GetFullPath(pathFile));

                    result = assempbly.GetType("ClassToCompile").GetMethod("MethodToCompile").Invoke(null, new object[] { entity, counterCodification }).ToString();
                }
            }
            return result;
        }

        private string getCounter(Codification code)
        {
            StringBuilder compteur = new StringBuilder();
            //If counter has a last value --> increment the last counter value by step
            if (code.LastCounterValue != null)
            {
                int nextCounter = int.Parse(code.LastCounterValue) + (int)code.Step;
                var repeatCount = code.LastCounterValue.Length - nextCounter.ToString().Length;
                repeatCount = repeatCount <= 0 ? 0 : repeatCount;
                compteur.Append('0', repeatCount);
                compteur.Append(nextCounter);
            }
            //if lastCounterValue is null --> initialise counter to initValue
            else if (code.InitValue != null)
            {
                compteur.Append(code.InitValue);
            }
            //Initialise counter to initValue else initialise counter to '1'
            else
            {
                if (code.CounterLength != null)
                    compteur.Append(new string('0', (int)code.CounterLength - 1));
                compteur.Append('1');
            }

            return compteur.ToString();
        }

        public dynamic getValueFromPropertiesOfPathCode(string[] properties, dynamic newPropertyValue)
        {
            dynamic resultProperty = null;
            foreach (dynamic propertyInPath in properties)
            {
                if (newPropertyValue != null)
                {
                    //Get propertyInfo of property
                    PropertyInfo propertyInfo = newPropertyValue.GetType().GetProperty(propertyInPath);
                    if (propertyInfo != null)
                    {

                        if (propertyInfo.PropertyType.Namespace.Contains("Persistence.Entities") || propertyInfo.PropertyType.Namespace.Contains("ModelView"))
                        {

                            // instanciate the repository of the collection type
                            Type repositoryType = typeof(Repository<>).MakeGenericType(propertyInfo.PropertyType);
                            dynamic repository = Activator.CreateInstance(repositoryType, _unitOfWork);
                            //Get Object from DataBase
                            PropertyInfo propertyDB = newPropertyValue.GetType().
                                GetProperty(propertyInPath.Remove(propertyInPath.LastIndexOf("Navigation"), "Navigation".Length).
                                Insert(propertyInPath.LastIndexOf("Navigation"), ""));

                            if (propertyDB != null)
                            {
                                PredicateFormatViewModel predicate = new PredicateFormatViewModel
                                {
                                    Filter = new List<FilterViewModel> { new FilterViewModel { Prop = "Id", Value = propertyDB.GetValue(newPropertyValue, null) } }
                                };
                                var predicateType = typeof(PredicateUtility<>).MakeGenericType(propertyInfo.PropertyType);
                                MethodInfo info = predicateType.GetMethod("PredicateFilter");
                                object[] myStaticMethodArguments = { predicate.Filter, Operator.And };
                                dynamic predicateCollectionWhere = info.Invoke(null, myStaticMethodArguments);
                                resultProperty = repository.GetSingle(predicateCollectionWhere);

                            }
                        }
                        else
                            resultProperty = propertyInfo.GetValue(newPropertyValue, null);
                    }
                }
            }
            return resultProperty;
        }

    }
}
