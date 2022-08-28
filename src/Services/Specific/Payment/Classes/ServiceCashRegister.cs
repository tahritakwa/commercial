using Microsoft.EntityFrameworkCore;
using Persistence;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Services.Generic.Classes;
using Services.Specific.Payment.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Enumerators.TreasuryEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Payment.Interfaces;
using ViewModels.DTO.ErpSettings;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Classes
{
    public class ServiceCashRegister : Service<CashRegisterViewModel, CashRegister>, IServiceCashRegister
    {
        const string ZONE_PREFIX = "Z_";
        private readonly IRepository<City> _cityRepo;
        private readonly IRepository<User> _userRepo;

        public ServiceCashRegister(IRepository<CashRegister> entityRepo, IUnitOfWork unitOfWork,
           ICashRegisterBuilder CashRegisterBuilder, IRepository<EntityAxisValues> entityRepoEntityAxisValues,
           IEntityAxisValuesBuilder builderEntityAxisValues, IRepository<EntityCodification> entityRepoEntityCodification,
           IRepository<Codification> entityRepoCodification, IRepository<Entity> entityRepoEntity,
           IRepository<City> cityRepo, IRepository<User> userRepo)
            : base(entityRepo, unitOfWork, CashRegisterBuilder, builderEntityAxisValues, entityRepoEntityAxisValues,
                  entityRepoEntity, entityRepoEntityCodification, entityRepoCodification)
        {
            _cityRepo = cityRepo;
            _userRepo = userRepo;
        }

        public override object AddModelWithoutTransaction(CashRegisterViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //If the unicity of the name of the cash
            VerifyCashDuplicateName(model);
            model.Status = (int)CashRegisterStatusEnumerator.Closed;
            return base.AddModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public override object UpdateModelWithoutTransaction(CashRegisterViewModel model, IList<EntityAxisValuesViewModel> entityAxisValuesModelList, string userMail, string property = null)
        {
            //If the unicity of the name of the cash
            VerifyCashDuplicateName(model);
            return base.UpdateModelWithoutTransaction(model, entityAxisValuesModelList, userMail, property);
        }

        public void VerifyCashDuplicateName(CashRegisterViewModel model)
        {

            bool isPrincipalDuplicate = _entityRepo.FindByAsNoTracking(x => (model.Type == (int)CashRegisterTypeEnumerator.Principal) &&
            (x.Type == (int)CashRegisterTypeEnumerator.Principal)
            && (x.IdCity.HasValue && x.IdCity.Value == model.IdCity)
            && x.Name.Trim().Equals(model.Name.Trim())
            && (model.Id > 0 && (x.Id != model.Id) || model.Id <= 0)).Any();

            if (isPrincipalDuplicate)
            {
                string cityName = _cityRepo.GetSingleNotTracked(x => x.Id == model.IdCity)?.Label;
                Dictionary<string, dynamic> param = new Dictionary<string, dynamic>
                {
                    {"CityName" , cityName },
                    {nameof(CashRegister) , model.Name }
                };
                throw new CustomException(CustomStatusCode.DuplicatePrincipaleCashRegisterName, param);
            }

            bool isReceipOrDepenseDuplicate = _entityRepo.FindByAsNoTracking(x =>
            (model.Type == (int)CashRegisterTypeEnumerator.ExpenseFund || model.Type == (int)CashRegisterTypeEnumerator.RecipeBox)
            && (x.Type == (int)CashRegisterTypeEnumerator.ExpenseFund || x.Type == (int)CashRegisterTypeEnumerator.RecipeBox)
            && (x.IdParentCash.HasValue && x.IdParentCash == model.IdParentCash)
            && x.Name.Trim().Equals(model.Name.Trim())
            && (model.Id > 0 && (x.Id != model.Id) || model.Id <= 0)).Any();

            if (isReceipOrDepenseDuplicate)
            {
                CashRegister cashRegister = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == model.IdParentCash.Value, r => r.IdCityNavigation);
                string principaleCashName = cashRegister?.Name + " - " + cashRegister?.IdCityNavigation?.Label;
                Dictionary<string, dynamic> param = new Dictionary<string, dynamic>
                {
                    {"PrincipaleCash" , principaleCashName },
                    {nameof(CashRegister) , model.Name }
                };
                throw new CustomException(CustomStatusCode.DuplicateReceipeOrExpenseCashRegisterName, param);
            }
        }
        public dynamic GetCashRegisterVisibility(string userMail)
        {
            dynamic result = new ExpandoObject();
            bool hasRole = RoleHelper.HasPermission("SHOW_HIERARCHY_CASH_MANAGEMENT");
            if(hasRole)
            {
                result.VisibleCashes = _entityRepo.GetAllAsNoTracking().Select(x => x.Id).ToList();
            }
            else
            {
                CashRegisterViewModel connectedCashRegister = GetCashRegisterAssociatedToConnectedUser(userMail);
                if (connectedCashRegister != null)
                {
                    result.ConnectedCashRegister = connectedCashRegister.Id;
                    // If connected user is responsible of the central so all cashes is visible 
                    if (connectedCashRegister.Type == (int)CashRegisterTypeEnumerator.Central)
                    {
                        result.VisibleCashes = _entityRepo.GetAllAsNoTracking().Select(x => x.Id).ToList();
                    }
                    else if (connectedCashRegister.Type == (int)CashRegisterTypeEnumerator.Principal)
                    {
                        result.VisibleCashes = _entityRepo.GetAllWithConditionsRelations(x => x.Id == connectedCashRegister.Id || x.IdParentCash == connectedCashRegister.Id).Select(x => x.Id).ToList();
                    }
                    else
                    {
                        result.VisibleCashes = new List<int> { connectedCashRegister.Id };
                    }
                }
            }    
            return result;
        }
        private CashRegisterViewModel GetCashRegisterAssociatedToConnectedUser(string userMail)
        {
            User connectedUser = _userRepo.GetSingleWithRelationsNotTracked(x => x.Email == userMail);
            return  _entityRepo.GetAllWithConditionsRelations(x => x.IdResponsible == connectedUser.Id).Select(_builder.BuildEntity).FirstOrDefault();
        }
        public DataSourceResult<CashRegisterItemViewModel> GetCashRegisterHierarchy(string userMail)
        {
            IList<CashRegister> allCashRegisters = _entityRepo.QuerableGetAll().Include(x => x.IdCityNavigation).ToList();
            // Get The Central  
            CashRegister centralCashRegister = allCashRegisters.Where(x => x.Type == (int)CashRegisterTypeEnumerator.Central).FirstOrDefault();
            // Verify if central already added
            if (centralCashRegister == null)
            {
                return new DataSourceResult<CashRegisterItemViewModel> { data = new List<CashRegisterItemViewModel>(), total = NumberConstant.Zero};
            }
            // Add central Cash register which has not parent cash register in a list of CashRegisterItemViewModel
            CashRegisterItemViewModel centralModel = new CashRegisterItemViewModel(Id: centralCashRegister.Id,
                Text: centralCashRegister.Name, Type: (int)CashRegisterItemTypeEnumerator.Central, IdCity: NumberConstant.Zero);
            // in first step we must regroup principal with the cash associated as children items
            var principalQuery = allCashRegisters.Where(x => x.Type == (int)CashRegisterTypeEnumerator.Principal);
            IList<CashRegisterItemViewModel> principalList = principalQuery.Select(x => new CashRegisterItemViewModel(Id: x.Id, Text: x.Name,
                                    Type: (int)CashRegisterItemTypeEnumerator.Principal, IdCity: x.IdCity.Value, CityName: x.IdCityNavigation.Label))
                            .ToList();
            bool hasRole = RoleHelper.HasPermission("SHOW_HIERARCHY_CASH_MANAGEMENT");
            if (hasRole)
            {
              
                principalList.ToList().ForEach(x => {
                    x.Items = allCashRegisters.Where(y => y.IdParentCash == x.Id)
                                            .Select(y => new CashRegisterItemViewModel(Id: y.Id, Text: y.Name,
                                               Type: (int)CashRegisterItemTypeEnumerator.Cash, IdCity: y.IdCity.Value))
                                            .ToList();
                });

          

            }
            else
            {
                // If the connected User is responsible of Register Cash (principal) so add only this cash and all cashs inferior
                CashRegisterViewModel cashRegisterAssociated = GetCashRegisterAssociatedToConnectedUser(userMail);
                if (cashRegisterAssociated == null)
                {
                    CashRegisterItemViewModel central = new CashRegisterItemViewModel(Id: centralCashRegister.Id,
                     Text: centralCashRegister.Name, Type: (int)CashRegisterItemTypeEnumerator.Central, IdCity: NumberConstant.Zero);

                    return new DataSourceResult<CashRegisterItemViewModel> { data = new List<CashRegisterItemViewModel>() { central }, total = NumberConstant.One };
                }
  
                if (cashRegisterAssociated.Type != (int)CashRegisterTypeEnumerator.Central)
                {
                    principalQuery = allCashRegisters.Where(x => (x.Id == cashRegisterAssociated.Id || x.Id == cashRegisterAssociated.IdParentCash)
                                                    && x.Type == (int)CashRegisterTypeEnumerator.Principal);
                }
                principalList = principalQuery.Select(x => new CashRegisterItemViewModel(Id: x.Id, Text: x.Name,
                                    Type: (int)CashRegisterItemTypeEnumerator.Principal, IdCity: x.IdCity.Value, CityName: x.IdCityNavigation.Label))
                            .ToList();
                if (cashRegisterAssociated.Type == (int)CashRegisterTypeEnumerator.Central || cashRegisterAssociated.Type == (int)CashRegisterTypeEnumerator.Principal)
                {
                    // For each Item of the principal list add items 
                    principalList.ToList().ForEach(x => {
                        x.Items = allCashRegisters.Where(y => y.IdParentCash == x.Id)
                                                  .Select(y => new CashRegisterItemViewModel(Id: y.Id, Text: y.Name,
                                                     Type: (int)CashRegisterItemTypeEnumerator.Cash, IdCity: y.IdCity.Value))
                                                  .ToList();
                    });
                }
                else
                {
                    // if the manager is associated with a leaf cash register, it will be associated with a single principal cash register
                    principalList.FirstOrDefault().Items = new List<CashRegisterItemViewModel>{new CashRegisterItemViewModel(Id: cashRegisterAssociated.Id, Text: cashRegisterAssociated.Name,
                                                         Type: (int)CashRegisterItemTypeEnumerator.Cash, IdCity: cashRegisterAssociated.IdCity.Value) };
                }
            }
            // Prepare Zones 
            IList<CashRegisterItemViewModel> zones = principalList.GroupBy(x => new { x.IdCity, x.CityName })
                                                                  .Select(x => new CashRegisterItemViewModel(Id: ZONE_PREFIX.Concat(x.Key.ToString()),
                                                                               Text: x.Key.CityName, Type: (int)CashRegisterItemTypeEnumerator.Zone, IdCity: x.Key.IdCity, Items: x.ToList()))
                                                                  .ToList();


            centralModel.Items = zones;
            return new DataSourceResult<CashRegisterItemViewModel> { data = new List<CashRegisterItemViewModel>() { centralModel }, total = NumberConstant.One };

        }


        public CashRegisterViewModel GetCentralCash()
        {
            return _entityRepo.FindByAsNoTracking(p => !p.IdParentCash.HasValue).Select(_builder.BuildEntity).FirstOrDefault();
        }

        public override object DeleteModel(int id, string tableName, string userMail)
        {
            CashRegisterViewModel cashRegister = base.GetModelById(id);
            if (cashRegister.Status == (int)CashRegisterStatusEnumerator.Opened)
            {
                throw new CustomException(CustomStatusCode.DeleteCashRegisterError);
            }
            var obj = base.DeleteModel(id, tableName, userMail);
            return obj;
        }
    }
}
