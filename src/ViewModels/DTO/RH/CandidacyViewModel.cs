using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Shared;

namespace ViewModels.DTO.RH
{
    public class CandidacyViewModel : GenericViewModel
    {
        public int State { get; set; }
        public int? IdRecruitment { get; set; }
        public int IdCandidate { get; set; }
        public string DeletedToken { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime DepositDate { get; set; }
        public double? TotalAverageMark { get; set; }
        public int? NumberOfOffer { get; set;}
        public bool HasAlreadyAnOffer { get; set; }
        public int? IdEmail { get; set; }
        public virtual EmailViewModel IdEmailNavigation { get; set; }
        public  CandidateViewModel IdCandidateNavigation { get; set; }
        public  RecruitmentViewModel IdRecruitmentNavigation { get; set; }
        public  ICollection<InterviewViewModel> Interview { get; set; }
        public  ICollection<OfferViewModel> Offer { get; set; }
        
    }
}
