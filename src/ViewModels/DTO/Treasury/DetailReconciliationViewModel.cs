using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;

namespace ViewModels.DTO.Treasury
{
    public class DetailReconciliationViewModel : GenericViewModel
    {
        public int? IdTimetable { get; set; }
        public int? IdPaymentType { get; set; }
        public int? IdBankAccount { get; set; }
        public int? IdCaisse { get; set; }
        public DateTime? DateTimetable { get; set; }
        public double? PriceTimetable { get; set; }
        public bool? IsPaid { get; set; }
        public DateTime? PostponedDate { get; set; }
        public double? RemainingPrice { get; set; }
        public string Meaning { get; set; }
        public string Activity { get; set; }
        public int? IdDetailTimetableAxis1 { get; set; }
        public int? IdDetailTimetableAxis2 { get; set; }
        public int? IdDetailTimetableAxis3 { get; set; }
        public int? IdDetailTimetableAxis4 { get; set; }
        public int? IdDetailTimetableAxis5 { get; set; }
        public int? IdDetailTimetableAxis6 { get; set; }
        public int? IdDetailTimetableAxis7 { get; set; }
        public int? IdDetailTimetableAxis8 { get; set; }
        public int? IdDetailTimetableAxis9 { get; set; }
        public int? IdDetailTimetableAxis10 { get; set; }
        public int? IdDetailTimetableAxis11 { get; set; }
        public int? IdDetailTimetableAxis12 { get; set; }
        public int? IdDetailTimetableAxis13 { get; set; }
        public int? IdDetailTimetableAxis14 { get; set; }
        public int? IdDetailTimetableAxis15 { get; set; }
        public int? IdDetailTimetableAxis16 { get; set; }
        public int? IdDetailTimetableAxis17 { get; set; }
        public int? IdDetailTimetableAxis18 { get; set; }
        public int? IdDetailTimetableAxis19 { get; set; }
        public int? IdDetailTimetableAxis20 { get; set; }
        public int? IdDetailTimetableAxis21 { get; set; }
        public int? IdDetailTimetableAxis22 { get; set; }
        public int? IdDetailTimetableAxis23 { get; set; }
        public int? IdDetailTimetableAxis24 { get; set; }
        public int? IdDetailTimetableAxis25 { get; set; }
        public int? IdDetailTimetableAxis26 { get; set; }
        public int? IdDetailTimetableAxis27 { get; set; }
        public int? IdDetailTimetableAxis28 { get; set; }
        public int? IdDetailTimetableAxis29 { get; set; }
        public int? IdDetailTimetableAxis30 { get; set; }
        public string DeletedToken { get; set; }

        public virtual PaymentTypeViewModel IdPaymentTypeNavigation { get; set; }
        public virtual TimetableViewModel IdTimetableNavigation { get; set; }
        public virtual ICollection<DetailReconciliationViewModel> DetailReconciliation { get; set; }
    }
}