﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class Timetable
    {
        public Timetable()
        {
            DetailTimetable = new HashSet<DetailTimetable>();
        }

        public int Id { get; set; }
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
        public int? TransactionUserId { get; set; }
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
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }

        public virtual PaymentType IdPaymentTypeNavigation { get; set; }
        public virtual Tiers IdTiersNavigation { get; set; }
        public virtual ICollection<DetailTimetable> DetailTimetable { get; set; }
    }
}