namespace Utils.Constants.TreasuryConstants
{
    public class TreasuryConstant
    {
        private string _lang { get; }

        public TreasuryConstant()
        {

        }

        public TreasuryConstant(string lang)
        {
            _lang = lang;
        }

        public static string DocumentLineToDocumentCode
        {
            get { return "IdDocumentNavigation.Code"; }
        }

        public static string DocumentLineToTiersName
        {
            get { return "IdDocumentNavigation.IdTiersNavigation.Name"; }
        }
        public static string DocumentLineToIdTiers
        {
            get { return "IdDocumentNavigation.IdTiers"; }
        }
        public static string DocumentLineToDocumentDate
        {
            get { return "IdDocumentNavigation.DocumentDate"; }
        }
        public static string DocumentLineToDocumentTtcprice
        {
            get { return "IdDocumentNavigation.DocumentTtcprice"; }
        }

        public static string Code
        {
            get { return "Code"; }
        }
        public static string IdTiersNavigationName
        {
            get { return "IdTiersNavigation.Name"; }
        }
        public static string TiersName
        {
            get { return "TiersName"; }
        }
        public static string IdTiers
        {
            get { return "IdTiers"; }
        }
        public static string DocumentDate
        {
            get { return "DocumentDate"; }
        }
        public static string IdDocument
        {
            get { return "IdDocument"; }
        }
        public static string FinancialCommitmentDate
        {
            get { return "FinancialCommitmentDate"; }
        }
        public static string CommitmentDate
        {
            get { return "CommitmentDate"; }
        }
        public static string DocumentTtcpriceWithCurrency
        {
            get { return "DocumentTtcpriceWithCurrency"; }
        }
        public static string DocumentRemainingAmountWithCurrency
        {
            get { return "DocumentRemainingAmountWithCurrency"; }
        }

        public static string AmountWithCurrency
        {
            get { return "AmountWithCurrency"; }
        }
        public static string RemainingAmountWithCurrency
        {
            get { return "RemainingAmountWithCurrency"; }
        }
        public static string SettlementReference
        {
            get { return "SettlementReference"; }
        }
        public static string SettlementDate
        {
            get { return "SettlementDate"; }
        }
        public static string ResidualAmountWithCurrency
        {
            get { return "ResidualAmountWithCurrency"; }
        }
        public static string WithholdingTaxHasBeenToken
        {
            get { return "WithholdingTaxHasBeenToken"; }
        }
        public static string IdPaymentSlipNavigationIdBankAccount
        {
            get { return "IdPaymentSlipNavigation.IdBankAccount"; }
        }
        public static string TiersType
        {
            get { return "tiersType"; }
        }

        public static string DocumentType
        {
            get { return "documentType"; }
        }

        public string Valid
        {
            get
            {
                if (_lang.Equals("fr"))
                {
                    return "Validé";
                }
                else
                {
                    return "Validated";
                }
            }
        }

        public string PartiallySatisfied
        {
            get
            {
                if (_lang.Equals("fr"))
                {
                    return "Partiellement satisfait";
                }
                else
                {
                    return "Partially satisfied";
                }
            }
        }

        public static string StartDate
        {
            get { return "StartDate"; }
        }

        public static string EndDate
        {
            get { return "EndDate"; }
        }

        public static string Page
        {
            get { return "Page"; }
        }

        public static string PageSize
        {
            get { return "PageSize"; }
        }

        public static string DeliveryFormNotBilled
        {
            get { return "DeliveryFormNotBilled"; }
        }

        public static string UnpaidFinancialCommitment
        {
            get { return "UnpaidFinancialCommitment"; }
        }
    }
}
