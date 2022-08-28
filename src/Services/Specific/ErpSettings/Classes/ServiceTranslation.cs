using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.ErpSettings.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.ErpSettings.Interfaces;
using ViewModels.DTO.ErpSettings;

namespace Services.Specific.ErpSettings.Classes
{
    public class ServiceTranslation : Service<FunctionalityViewModel, Functionality>, IServiceTranslation
    {
        private readonly IRepository<Functionality> _entityRepoFunctionality;
        public readonly IRepository<Notification> _entityRepoNotification;
        private readonly IRepository<Axis> _entityRepoAxis;
        private readonly IRepository<Information> _entityRepoInformation;

        public ServiceTranslation(IUnitOfWork unitOfWork,IRepository<Information> entityRepoInformation,
            IRepository<Functionality> entityRepoFunctionality, IRepository<Axis> entityRepoAxis, IRepository<Notification> entityRepoNotification,
            IOptions<AppSettings> appSettings,
            IFunctionalityBuilder functionalityBuilder, IRepository<Entity> entityRepoEntity, IRepository<Company> entityRepoCompany,
            IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues,
            IRepository<EntityCodification> entityRepoEntityCodification, IRepository<Codification> entityRepoCodification)
            : base(entityRepoFunctionality, unitOfWork, functionalityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues, appSettings, entityRepoCompany,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)

        {
            _entityRepoFunctionality = entityRepoFunctionality;
            _entityRepoNotification = entityRepoNotification;
            _entityRepoAxis = entityRepoAxis;
            _entityRepoInformation = entityRepoInformation;
        }

        public string GetLanguage(string lang, string directoryConfig)
        {
            string companyName = getCurrentConnectedCompany();
            string path = Directory.GetCurrentDirectory() + directoryConfig + companyName + "_" + lang + "_Translat" + ".json";
            string jsonToSend = "";
            //check if exist directory 
            if (!Directory.Exists(Directory.GetCurrentDirectory() + directoryConfig))
                Directory.CreateDirectory(Directory.GetCurrentDirectory() + directoryConfig);

            // check if exist file in directory 
            if (File.Exists(path))
            {
                using (StreamReader r = File.OpenText(path))
                {
                    string json = r.ReadToEnd();
                    jsonToSend = JsonConvert.DeserializeObject(json).ToString();
                }
            }
            // Get translation 
            else
            {
                string result = "{";

                if (lang != null)
                {
                    List<dynamic> words = new List<dynamic>();
                    switch (lang.ToLower())
                    {
                        case "fr":
                            {

                                var wordsFunctionality = _entityRepoFunctionality.QuerableGetAll().Select(i => new { Id = i.IdFunctionality, Value = i.Fr }).ToList();
                                var listNotifications = _entityRepoNotification.QuerableGetAll().Select(i => new { Id = i.IdNotification.ToString(CultureInfo.CurrentCulture), Value = i.Fr }).ToList();
                                var wordsAxis = _entityRepoAxis.QuerableGetAll().Select(i => new { Id = i.Label, Value = i.Fr }).ToList();
                                var wordsEntity = _entityRepoEntity.QuerableGetAll().Select(i => new { Id = i.EntityName, Value = i.Fr }).ToList();
                                var wordsInformation = _entityRepoInformation.QuerableGetAll().Select(i => new { Id = i.IdInfo, Value = i.Fr }).ToList();
                                words.AddRange(wordsFunctionality);
                                words.AddRange(listNotifications);
                                words.AddRange(wordsAxis);
                                words.AddRange(wordsEntity);
                                words.AddRange(wordsInformation);
                                break;
                            }
                        case "en":
                            {
                                var wordsFunctionality = _entityRepoFunctionality.QuerableGetAll().Select(i => new { Id = i.IdFunctionality, Value = i.En }).ToList();
                                var listNotifications = _entityRepoNotification.QuerableGetAll().Select(i => new { Id = i.IdNotification.ToString(CultureInfo.CurrentCulture), Value = i.En }).ToList();
                                var wordsAxis = _entityRepoAxis.QuerableGetAll().Select(i => new { Id = i.Label, Value = i.En }).ToList();
                                var wordsEntity = _entityRepoEntity.QuerableGetAll().Select(i => new { Id = i.EntityName, Value = i.En }).ToList();
                                var wordsInformation = _entityRepoInformation.QuerableGetAll().Select(i => new { Id = i.IdInfo, Value = i.En }).ToList();
                                words.AddRange(wordsFunctionality);
                                words.AddRange(listNotifications);
                                words.AddRange(wordsAxis);
                                words.AddRange(wordsEntity);
                                words.AddRange(wordsInformation);
                                break;
                            }
                        case "de":
                            {
                                var wordsFunctionality = _entityRepoFunctionality.QuerableGetAll().Select(i => new { Id = i.IdFunctionality, Value = i.De }).ToList();
                                var listNotifications = _entityRepoNotification.QuerableGetAll().Select(i => new { Id = i.IdNotification.ToString(CultureInfo.CurrentCulture), Value = i.De }).ToList();
                                var wordsAxis = _entityRepoAxis.QuerableGetAll().Select(i => new { Id = i.Label, Value = i.De }).ToList();
                                var wordsEntity = _entityRepoEntity.QuerableGetAll().Select(i => new { Id = i.EntityName, Value = i.De }).ToList();
                                var wordsInformation = _entityRepoInformation.QuerableGetAll().Select(i => new { Id = i.IdInfo, Value = i.De }).ToList();
                                words.AddRange(wordsFunctionality);
                                words.AddRange(listNotifications);
                                words.AddRange(wordsAxis);
                                words.AddRange(wordsEntity);
                                words.AddRange(wordsInformation);

                                break;
                            }
                        case "ar":
                            {
                                var wordsFunctionality = _entityRepoFunctionality.QuerableGetAll().Select(i => new { Id = i.IdFunctionality, Value = i.Ar }).ToList();
                                var listNotifications = _entityRepoNotification.QuerableGetAll().Select(i => new { Id = i.IdNotification.ToString(CultureInfo.CurrentCulture), Value = i.Ar }).ToList();
                                var wordsAxis = _entityRepoAxis.QuerableGetAll().Select(i => new { Id = i.Label, Value = i.Ar }).ToList();
                                var wordsEntity = _entityRepoEntity.QuerableGetAll().Select(i => new { Id = i.EntityName, Value = i.Ar }).ToList();
                                var wordsInformation = _entityRepoInformation.QuerableGetAll().Select(i => new { Id = i.IdInfo, Value = i.Ar }).ToList();
                                words.AddRange(wordsFunctionality);
                                words.AddRange(listNotifications);
                                words.AddRange(wordsAxis);
                                words.AddRange(wordsEntity);
                                words.AddRange(wordsInformation);

                                break;
                            }
                    }
                    if (words.Any())
                    {
                        foreach (var word in words)
                        {
                            result += "\"" + word.Id + "\":\"" + word.Value + "\",";
                        }
                        result = result.Substring(0, result.Length - 1);
                        result += "}";
                    }

                }
                if (IsValidJson(result))
                {
                    jsonToSend = JsonConvert.SerializeObject(JObject.Parse(result),
                           Formatting.None,
                           new JsonSerializerSettings
                           {
                               NullValueHandling = NullValueHandling.Ignore
                           });
                    File.WriteAllText(path, jsonToSend);
                }
            }
            return jsonToSend;
        }


        private static bool IsValidJson(string strInput)
        {
            string jsonInput = strInput.Trim();
            const StringComparison comparison = StringComparison.InvariantCulture;
            if ((jsonInput.StartsWith("{", comparison) && jsonInput.EndsWith("}", comparison)) || //For object
                (jsonInput.StartsWith("[", comparison) && jsonInput.EndsWith("]", comparison))) //For array
            {
                try
                {
                    JToken.Parse(jsonInput);
                    return true;
                }
                catch (JsonReaderException)
                {
                    //Exception in parsing json
                    return false;
                }
                catch (Exception) //some other exception
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public string getCurrentConnectedCompany()
        {
            return _entityRepoCompany.GetFirst().Name;
        }
    }
    public class LangDictionnary
    {
        public string Id { get; set; }
        public string Value { get; set; }
    }
}
