using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utils.Enumerators.TreasuryEnumerators
{
    public enum OperationCashtypeEnumerator
    {
        CashDeposit = 1,
        CashWithDrawal = 2,
        CashAssistedTransfer = 3,
        PaymentOfInvoicesAssistedByCashRegister = 4,
        LoadMandatedAgentAccount = 5,
        OffloadMandatedAgentAccount = 6
    }

    public static class OperationCashTypeEnum
    {
        public static int GetOperationType(string type)
        {

            switch (type)
            {
                case "CashDeposit":
                    return (int)OperationCashtypeEnumerator.CashDeposit;
                case "CashWithDrawal":
                    return (int)OperationCashtypeEnumerator.CashWithDrawal;
                case "CashAssistedTransfer":
                    return (int)OperationCashtypeEnumerator.CashAssistedTransfer;
                case "PaymentOfInvoicesAssistedByCashRegister":
                    return (int)OperationCashtypeEnumerator.PaymentOfInvoicesAssistedByCashRegister;
                case "LoadMandatedAgentAccount":
                    return (int)OperationCashtypeEnumerator.LoadMandatedAgentAccount;
                case "OffloadMandatedAgentAccount":
                    return (int)OperationCashtypeEnumerator.OffloadMandatedAgentAccount;
                default: return 0;
            }
        }
    } 
}
