using System;
using System.Collections.Generic;

namespace ViewModels.DTO.ErpSettings
{
    public class NotificationItemViewModel
    {
        public int IdTargetUser { get; set; }
        public int IdNotification { get; set; }
        public bool Viewed { get; set; }
        public string Link { get; set; }
        public int IdInfo { get; set; }
        public string Lang { get; set; }
        public DateTime? CreationDate { get; set; }
        public string CodeEntity { get; set; }
        public int? NotificationType { get; set; }
        public DateTime FinancialCommitmentDate { get; set; }
        public string TranslationKey { get; set; }
        public int? IdTiers { get; set; }
        public NotificationCreatorViewModel Creator { get; set; }
        public NotificationItemEndContractViewModel DataOfEndContract { get; set; }
        public IDictionary<string, dynamic> Parameters;
        public string ConnectedCompany { get; set; }
    }
}
