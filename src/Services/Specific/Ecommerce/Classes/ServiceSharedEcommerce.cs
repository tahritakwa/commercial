using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Serilog.Events;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Services.Specific.Sales.Interfaces;
using Settings.Config;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Inventory.Interfaces;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Utils;

namespace Services.Specific.Ecommerce.Classes
{
    public class ServiceSharedEcommerce : IServiceSharedEcommerce

    {
        private readonly IServiceDocument _serviceDocument;
        private readonly IServiceStockDocument _serviceStockDocument;
        private readonly IServiceItem _serviceItem;
        private readonly IRepository<StockDocument> _entityRepoStockDocument;
        private readonly IServiceStockDocumentLine _serviceStockDocumentLine;
        private readonly IStockDocumentBuilder _stockDocumentBuilder;
        private readonly IRepository<ItemWarehouse> _repoEntityItemWarehouse;
        private readonly IServiceEcommerce _serviceTriggerItem;
        private readonly IUnitOfWork _unitOfWork;
        private IOptions<AppSettings> _appSettings;
        


        public ServiceSharedEcommerce(IOptions<AppSettings> appSettings,IUnitOfWork unitOfWork, IServiceDocument serviceDocument
            , IServiceItem serviceItem, IServiceStockDocumentLine serviceStockDocumentLine, IServiceStockDocument serviceStockDocument, 
           IRepository<StockDocument> entityRepoStockDocument, IStockDocumentBuilder stockDocumentBuilder, IRepository<ItemWarehouse> repoEntityItemWarehouse,  
           IServiceEcommerce serviceTriggerItem) 
        {
            
            _serviceDocument = serviceDocument;
            _serviceItem = serviceItem;
            _serviceStockDocumentLine = serviceStockDocumentLine;
            _serviceStockDocument = serviceStockDocument;
            _entityRepoStockDocument = entityRepoStockDocument;
            _stockDocumentBuilder = stockDocumentBuilder;
            _unitOfWork = unitOfWork;
            _appSettings = appSettings;
            _repoEntityItemWarehouse = repoEntityItemWarehouse;
            _serviceTriggerItem = serviceTriggerItem;
        }
        /// <summary>
        /// validate Ecommerce Transfert Movement
        /// </summary>
        /// <param name="id"></param>       
        public void ValidateEcommerceTransfertMovement(int id)
        {
            try
            {
                _unitOfWork.BeginTransaction();
                // Get stockDocument  by Id
                StockDocumentViewModel stockDocumentViewModel = _serviceStockDocument.GetModelWithRelationsAsNoTracked(c => c.Id == id, c => c.StockDocumentLine);
                // Change status of Stock movement
                _serviceStockDocument.ChangeStatusOfStockMovement(stockDocumentViewModel, OperationEnumerator.Output);
                // Change status of stock document to Valide
                stockDocumentViewModel.IdDocumentStatus = (int)DocumentStatusEnumerator.Transferred;
                // Update stock document
                bool isSuccess = false;
                List<int> errorsIds = CreateStockDocumentForECommerce(id, out isSuccess);
                if (isSuccess)
                {
                    ValidateMvtTransfertFroEcommerce(stockDocumentViewModel);
                }
                else
                {
                    StockDocumentViewModel createdData = null;
                    CreatedDataViewModel addedEntity = null;
                    StockDocumentViewModel stockDocumentViewModelForErrors = new StockDocumentViewModel();
                    // Adding system Time to stock document creation date
                    DateTime? dateTimeNow = DateTime.Now;
                    stockDocumentViewModelForErrors.DocumentDate = new DateTime(stockDocumentViewModelForErrors.DocumentDate.Value.Year, stockDocumentViewModelForErrors.DocumentDate.Value.Month
                        , stockDocumentViewModelForErrors.DocumentDate.Value.Day, dateTimeNow.Value.Hour, dateTimeNow.Value.Minute, dateTimeNow.Value.Second);
                    stockDocumentViewModelForErrors.IdDocumentStatus = stockDocumentViewModel.IdDocumentStatus;
                    stockDocumentViewModelForErrors.IdWarehouseDestination = stockDocumentViewModel.IdWarehouseDestination;
                    stockDocumentViewModelForErrors.IdWarehouseSource = stockDocumentViewModel.IdWarehouseSource;
                    stockDocumentViewModelForErrors.TypeStockDocument = stockDocumentViewModel.TypeStockDocument;

                    // Add stockDocument
                    addedEntity = (CreatedDataViewModel)_serviceStockDocument.AddModelWithoutTransaction(stockDocumentViewModelForErrors, null, null, "TypeStockDocument");
                    createdData = _serviceStockDocument.GetModelAsNoTracked(x => x.Id == addedEntity.Id, x => x.StockDocumentLine);

                    foreach (int errorId in errorsIds)
                    {
                        StockDocumentLineViewModel stockDocumentLine = stockDocumentViewModel.StockDocumentLine.FirstOrDefault(s => s.IdItem == errorId);
                        stockDocumentLine.IdStockDocument = createdData.Id;
                        stockDocumentViewModel.StockDocumentLine.Remove(stockDocumentLine);
                        _serviceStockDocumentLine.UpdateModel(stockDocumentLine, null, null);
                    }

                    ValidateMvtTransfertFroEcommerce(stockDocumentViewModel);
                }
                _unitOfWork.Commit();
                //EndTransaction
                _unitOfWork.CommitTransaction();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        
        private void ValidateMvtTransfertFroEcommerce(StockDocumentViewModel stockDocumentViewModel)
        {
            // Change status of Stock movement
            _serviceStockDocument.ChangeStatusOfStockMovement(stockDocumentViewModel, OperationEnumerator.Input);
            // Change status of stock document to Valide
            stockDocumentViewModel.IdDocumentStatus = (int)DocumentStatusEnumerator.Received;
            _serviceStockDocument.VerifyAndUpdateReservedStockMovementFromTransferMovement(stockDocumentViewModel);
            // Update stock document
            StockDocument stockDocument = _stockDocumentBuilder.BuildModel(stockDocumentViewModel);
            _entityRepoStockDocument.Update(stockDocument);
        }

        /// <summary>
        /// Create stock document for Ecommerce 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="isSuccess"></param>
        /// <returns></returns>
        public List<int> CreateStockDocumentForECommerce(int id, out bool isSuccess)
        {
            List<int> errorIds = new List<int>();
            StockDocumentViewModel stockDocumentViewModel = _entityRepoStockDocument.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.Id == id)
                .Include(x => x.StockDocumentLine)
                .ThenInclude(x => x.IdItemNavigation)
                .Include(x => x.IdWarehouseSourceNavigation).Select(_stockDocumentBuilder.BuildEntity).FirstOrDefault();
          

            MovementQuantityViewModel movementQuantityViewModel = new MovementQuantityViewModel
            {
                trans = "L" ?? "",
                Prod = new List<StockQuantityViewModel>()
            };

            if (stockDocumentViewModel.IdWarehouseSourceNavigation.IsCentral)
            {
                movementQuantityViewModel.trans = "R" ?? "";
            }

            // Verification quantity
            ItemWarehouse itemWarehouseSource = null;
            stockDocumentViewModel.StockDocumentLine.ToList().ForEach(x =>
            {
                // Controle of Available qte
                itemWarehouseSource = _repoEntityItemWarehouse.GetAllWithConditionsRelationsAsNoTracking(y => y.IdItem == x.IdItem && y.IdWarehouse == stockDocumentViewModel.IdWarehouseSource).FirstOrDefault();
                int qty = (int)x.ActualQuantity;
                StockQuantityViewModel productViewModel = new StockQuantityViewModel
                {
                    sku = x.IdItemNavigation.Code,
                    qty = qty
                };
                movementQuantityViewModel.Prod.Add(productViewModel);
                //CreateOrUpdateItemWarehouseForECommerce(stockDocumentViewModel, x);
            });

            string jsonContent = JsonConvert.SerializeObject(movementQuantityViewModel);

            string response;

            try
            {
                response = (string)((dynamic)_serviceTriggerItem.EcommerceMovement(jsonContent)).Result;
            }
            catch (Exception e)
            {
                GenericLogger.LogMessageAndException(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                    Constants.ECOMMERCE_BADGATEWAY_ERROR_MSG, e);
                throw new CustomException(CustomStatusCode.EcommerceException, e);

            }
            if (response == "successful")
            {
                isSuccess = true;
            }
            else
            {
                isSuccess = false;
                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Warning,
                    Constants.LIBERATION_QTE_EXCEPTION_MSG);
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { Constants.FULL_NAME,response}
                    };
                throw new CustomException(CustomStatusCode.LiberationQteException, paramtrs);

            }
            return errorIds;
        }
       


    }
}
