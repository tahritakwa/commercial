using Persistence.Entities;
using Services.Generic.Interfaces;
using System;
using System.Collections.Generic;
using Utils.Utilities.DataUtilities;
using Utils.Utilities.PredicateUtilities;
using ViewModels.DTO.Payment;

namespace Services.Specific.Payment.Interfaces
{
    public interface IServicePaymentSlip : IService<PaymentSlipViewModel, PaymentSlip>
   {
        void AddPaymentSlip(PaymentSlipViewModel model, List<int> settlementIds, string userMail);
        DataSourceResult<ReducedPaymentSlipViewModel> GetPaymentSlip(DateTime? startDate, DateTime? endDate, PredicateFormatViewModel predicateModel);
        void ValidatePaymentSlip(PaymentSlipViewModel model, List<int> settlementIds, string userMail);
   }  
}
