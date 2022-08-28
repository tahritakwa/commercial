using System.Collections.Generic;
using ViewModels.DTO.GenericModel;
using ViewModels.DTO.RH;

namespace ViewModels.DTO.Shared
{
    public class EmailViewModel : GenericViewModel
    {
        public string Subject { get; set; }
        public string Body { get; set; }
        public int Status { get; set; }
        public string Sender { get; set; }
        public string Receivers { get; set; }
        public int AttemptsToSendNumber { get; set; }
        public string DeletedToken { get; set; }
        public string From { get; set; }

        public virtual ICollection<InterviewViewModel> Interview { get; set; }
        public ICollection<OfferViewModel> Offer { get; set; }

        public ICollection<InterviewEmailViewModel> InterviewEmail { get; set; }

    }
}
