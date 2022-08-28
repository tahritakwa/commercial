using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Payment;
using ViewModels.DTO.Sales;

namespace ViewModels.DTO.Treasury
{
    public class TimetableViewModel : GenericViewModel
    {
        public int? IdTiers { get; set; }
        public int? IdPaymentType { get; set; }
        public int? IdBankAccount { get; set; }
        public int? IdCaisse { get; set; }
        public string Titre { get; set; }
        public double? TotalPrice { get; set; }
        public DateTime? DateFirstTimetable { get; set; }
        public double? PriceTimetable { get; set; }
        public string Frequence { get; set; }
        public int? NumberOfTimetable { get; set; }
        public int? IdTimetableAxis1 { get; set; }
        public int? IdTimetableAxis2 { get; set; }
        public int? IdTimetableAxis3 { get; set; }
        public int? IdTimetableAxis4 { get; set; }
        public int? IdTimetableAxis5 { get; set; }
        public int? IdTimetableAxis6 { get; set; }
        public int? IdTimetableAxis7 { get; set; }
        public int? IdTimetableAxis8 { get; set; }
        public int? IdTimetableAxis9 { get; set; }
        public int? IdTimetableAxis10 { get; set; }
        public int? IdTimetableAxis11 { get; set; }
        public int? IdTimetableAxis12 { get; set; }
        public int? IdTimetableAxis13 { get; set; }
        public int? IdTimetableAxis14 { get; set; }
        public int? IdTimetableAxis15 { get; set; }
        public int? IdTimetableAxis16 { get; set; }
        public int? IdTimetableAxis17 { get; set; }
        public int? IdTimetableAxis18 { get; set; }
        public int? IdTimetableAxis19 { get; set; }
        public int? IdTimetableAxis20 { get; set; }
        public int? IdTimetableAxis21 { get; set; }
        public int? IdTimetableAxis22 { get; set; }
        public int? IdTimetableAxis23 { get; set; }
        public int? IdTimetableAxis24 { get; set; }
        public int? IdTimetableAxis25 { get; set; }
        public int? IdTimetableAxis26 { get; set; }
        public int? IdTimetableAxis27 { get; set; }
        public int? IdTimetableAxis28 { get; set; }
        public int? IdTimetableAxis29 { get; set; }
        public int? IdTimetableAxis30 { get; set; }
        public string DeletedToken { get; set; }

        public virtual PaymentTypeViewModel IdPaymentTypeNavigation { get; set; }
        public virtual TiersViewModel IdTiersNavigation { get; set; }
        public virtual ICollection<DetailTimetableViewModel> DetailTimetable { get; set; }
    }
}