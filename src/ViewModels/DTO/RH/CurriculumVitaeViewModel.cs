using System;
using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.RH
{
    public class CurriculumVitaeViewModel : GenericViewModel
    {
        public string CurriculumVitaePath { get; set; }
        public string DeletedToken { get; set; }
        public DateTime? DepositDate { get; set; }
        public int? IdCandidate { get; set; }
        public IList<FileInfoViewModel> CvFileInfo { get; set; }
        public string Entitled { get; set; }
        public DateTime CreationDate { get; set; }
        public CandidateViewModel IdCandidateNavigation { get; set; }
    }
}
