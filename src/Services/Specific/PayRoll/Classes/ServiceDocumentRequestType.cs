using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.PayRoll.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace Services.Specific.PayRoll.Classes
{
    public class ServiceDocumentRequestType : Service<DocumentRequestTypeViewModel, DocumentRequestType>, IServiceDocumentRequestType
    {
      
        const string ENTITY_TO_DELETE = "EntityToDelete";
        const string ENTITY_NAME_RELATED = "EntityNameReleated";
        const string DOCUMENT_REQUEST_TYPE = "DocumentRequestType";
        const string SHARED_DOCUMENT = "SharedDocument";

        public ServiceDocumentRequestType(IRepository<DocumentRequestType> entityRepo, IUnitOfWork unitOfWork,
           IDocumentRequestTypeBuilder consultantsCustomerContractBuilder,
            IRepository<Entity> entityRepoEntity, IRepository<EntityAxisValues> entityRepoEntityAxisValues, IEntityAxisValuesBuilder builderEntityAxisValues)
            : base(entityRepo, unitOfWork, consultantsCustomerContractBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        { }
        /// <summary>
        /// delete the DocumentRequestType if its not a value of DocumentRequestTypeEnumerator 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="tableName"></param>
        /// <param name="userMail"></param>
        public override object DeleteModelwithouTransaction(int id, string tableName, string userMail)
        {
            bool isUsed = false;
            foreach (int enumValue in Enum.GetValues(typeof(DocumentRequestTypeEnumerator)))
            {
                if(enumValue == id)
                {
                    isUsed = true; 
                    break; // get out of the loop if id existe in enumValues
                }
            }
            if (isUsed == true)
            {
                // the enums array contains the id and the value is used in business logic
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                {
                    { ENTITY_TO_DELETE, DOCUMENT_REQUEST_TYPE }
                };
                paramtrs.Add(ENTITY_NAME_RELATED, SHARED_DOCUMENT);
                //The entity is already used
                throw new CustomException(CustomStatusCode.DeleteError, paramtrs);
            } 
            else
            {
                return base.DeleteModelwithouTransaction(id, tableName, userMail);
            }
        }
    }
}
