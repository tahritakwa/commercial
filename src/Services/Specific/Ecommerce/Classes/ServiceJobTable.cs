using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Persistence.Entities;
using Persistence.Repository.Interfaces;
using Persistence.UnitOfWork.Interfaces;
using Serilog.Events;
using Services.Generic.Classes;
using Services.Specific.Ecommerce.Interfaces;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Utils.Constants;
using Utils.Enumerators.CommercialEnumerators;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Specific.Administration.Interfaces;
using ViewModels.Builders.Specific.Ecommerce.Interfaces;
using ViewModels.DTO.Ecommerce;
using ViewModels.DTO.Inventory;

namespace Services.Specific.Ecommerce.Classes
{
    public class ServiceJobTable : Service<JobTableViewModel, JobTable>, IServiceJobTable
    {

        private new readonly AppSettings _appSettings;
        private readonly IServiceItem _serviceItem;
        private readonly IServiceEcommerce _serviceTriggerItem;
        private readonly IServiceTriggerItemLog _serviceTriggerItemLog;

        public ServiceJobTable(IRepository<JobTable> entityRepo, IUnitOfWork unitOfWork,
          IJobTableBuilder entityBuilder, IOptions<AppSettings> appSettings,
          IRepository<EntityAxisValues> entityRepoEntityAxisValues,
          IEntityAxisValuesBuilder builderEntityAxisValues, IServiceItem serviceItem, IServiceEcommerce serviceTriggerItem, IServiceTriggerItemLog serviceTriggerItemLog)
           : base(entityRepo, unitOfWork, entityBuilder, builderEntityAxisValues, entityRepoEntityAxisValues)
        {
            _appSettings = appSettings.Value;
            _serviceItem = serviceItem;
            _serviceTriggerItem = serviceTriggerItem;
            _serviceTriggerItemLog = serviceTriggerItemLog;
        }
        static readonly SemaphoreSlim semaphoreSlim = new SemaphoreSlim(1, 1);
        public async Task<bool> SynchronizeAllProdcutsWithDetailsToEcommerceAsync(string generatedConnectionString)
        {
            var count = semaphoreSlim.CurrentCount;
            if (count == 1)
            {
                await semaphoreSlim.WaitAsync();
                try
                {
                    List<ItemViewModel> itemViewModels = GetListItemsForUpdate(generatedConnectionString);

                    if (itemViewModels.Any())
                    {
                        BeginTransactionunReadUncommitted(generatedConnectionString);
                        ListProductsViewModel listProductsViewModel = ((dynamic)PrepareSendAndReceiveProductsNowAsync(itemViewModels)).Result;
                        EndTransaction();

                        foreach (ProductViewModel product in listProductsViewModel.Products)
                        {
                            BeginTransactionunReadUncommitted(generatedConnectionString);
                            int id = product.IdProductStark;
                            ItemViewModel itemViewModel = _serviceItem.GetModelAsNoTracked(p => p.Id == id);
                            if (product.State == "success")
                            {
                                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                                    Constants.SUCCESS_SYNCHRONIZATION + itemViewModel.Code);
                                itemViewModel.SynchonizationStatus = (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed;
                                itemViewModel.LastUpdateEcommerce = null;
                            }
                            else
                            {
                                GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Error,
                                    Constants.ERROR_SYNCHRONIZATION_MESSAGE + product.Message);
                                TriggerItemLogViewModel triggerItemLogViewModel = new TriggerItemLogViewModel
                                {
                                    IdItem = id,
                                    Code = product.Code,
                                    Message = product.Message,
                                    DateLog = DateTime.UtcNow
                                };
                                _serviceTriggerItemLog.AddModelWithoutTransaction(triggerItemLogViewModel, null, null);
                                itemViewModel.LastUpdateEcommerce = DateTime.UtcNow;
                            }
                            _serviceItem.UpdateModelWithoutTransaction(itemViewModel, null, null);

                            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                                Constants.SUCCESS_UPDATE_STARK + itemViewModel.Code);
                            EndTransaction();

                        }
                    }



                }
                catch (Exception e)
                {
                    RollBackTransaction();
                    throw;
                }
                finally
                {
                    // When the task is ready, release the semaphore. It is vital to ALWAYS release the semaphore when 
                    // we are ready, or else we will end up with a Semaphore that is forever locked.
                    // This is why it is important to do the Release within a try...finally clause; program execution may crash 
                    // or take a different path, this way you are guaranteed execution
                    semaphoreSlim.Release();
                }

                return true;
            }
            else
            {
                return false;
            }


        }

        private List<ItemViewModel> GetListItemsForUpdate(string generatedConnectionString)
        {
            BeginTransactionunReadUncommitted(generatedConnectionString);

            DateTime nextExecuteDate = UpdateJobAndGetPreviousExecuteDate();

            List<ItemViewModel> itemViewModels = _serviceItem.FindModelsByNoTracked(x => x.SynchonizationStatus != null && x.SynchonizationStatus != (int)ItemSynchronizationWithEcommerceStatusEnumerator.Succeed
            && x.LastUpdateEcommerce < nextExecuteDate, x => x.IdProductItemNavigation, x => x.TaxeItem).ToList();

            EndTransaction();

            return itemViewModels;
        }

        private async Task<ListProductsViewModel> PrepareSendAndReceiveProductsNowAsync(List<ItemViewModel> itemViewModels)
        {
            ListProductsViewModel listProductsViewModel = new ListProductsViewModel
            {
                Products = new List<ProductViewModel>()
            };
            if (string.IsNullOrEmpty(_appSettings.ECommerceConfig.BaseEcommerceURL))
            {
                return listProductsViewModel;
            }

            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                       Constants.PREPARING_PRODUCTS_TO_SYNCHRONIZE);


            foreach (dynamic itemViewModel in itemViewModels)
            {
                ProductViewModel productViewModel = _serviceTriggerItem.ConvertProductToJson(itemViewModel, itemViewModel.IsEcommerce);
                listProductsViewModel.Products.Add(productViewModel);
            }

            string jsonContent = JsonConvert.SerializeObject(listProductsViewModel);

            Uri baseUri = new Uri(_appSettings.ECommerceConfig.BaseEcommerceURL);
            Uri myUri = new Uri(baseUri, _appSettings.ECommerceConfig.synchronizeAllProductsDetailsUrl);

            dynamic jsonResponse;

            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                   Constants.SENDING_PRODUCTS_TO_SYNCHRONIZE);

            jsonResponse = await _serviceTriggerItem.GetHttpResponseFromRequest(HttpMethod.Post, myUri, jsonContent, itemViewModels);

            GenericLogger.LogMessage(Constants.ECOMMERCE_LOG_FILE_NAME, LogEventLevel.Information,
                        Constants.RECEIVING_ECOMMERCE_RESPONSE);
            listProductsViewModel = JsonConvert.DeserializeObject<ListProductsViewModel>(jsonResponse);
            return listProductsViewModel;

        }

        private DateTime UpdateJobAndGetPreviousExecuteDate()
        {
            JobTableViewModel jobTableViewModel = GetAllModelsAsNoTracking().FirstOrDefault();
            DateTime previousExecuteDate;
            DateTime nextExecuteDate;
            if (jobTableViewModel == null)
            {
                previousExecuteDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0, DateTimeKind.Utc);
                jobTableViewModel = new JobTableViewModel
                {
                    Id = 0,
                    LastExecuteDate = previousExecuteDate,
                    NextExecuteDate = previousExecuteDate.AddMinutes(_appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceSendPriceQuantity)
                };
                AddModelWithoutTransaction(jobTableViewModel, null, null);
            }
            else
            {
                previousExecuteDate = (DateTime)jobTableViewModel.LastExecuteDate;
                jobTableViewModel.LastExecuteDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0, DateTimeKind.Utc);
                jobTableViewModel.NextExecuteDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0, DateTimeKind.Utc)
                .AddMinutes(_appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceSendPriceQuantity);
                /*DateTime dateTime = DateTime.Now;
                DateTime other = DateTime.SpecifyKind(dateTime, DateTimeKind.Utc);
                jobTableViewModel.LastExecuteDate = other;
                jobTableViewModel.NextExecuteDate = other.AddMinutes(_appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceSendPriceQuantity);*/
                UpdateModelWithoutTransaction(jobTableViewModel, null, null);
            }
            nextExecuteDate = jobTableViewModel.NextExecuteDate ?? new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0, DateTimeKind.Utc)
                    .AddMinutes(_appSettings.ECommerceConfig.FrequencyByMinuteForExecuteJobForEcommerceSendPriceQuantity);
            return nextExecuteDate;
        }


    }


}
