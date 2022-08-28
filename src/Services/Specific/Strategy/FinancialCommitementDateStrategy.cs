using System;
using ViewModels.DTO.Sales;

namespace Services.Specific.Strategy
{
    public class DateOperations
    {
        protected DateTime GetLastDayOfThisMonth(DateTime date)
        {
            int nbDays = DateTime.DaysInMonth(date.Year, date.Month);
            return new DateTime(date.Year, date.Month, nbDays);
        }

        protected DateTime GetSpecificDayOfMonth(DateTime date, int dayOfSettlement)
        {
            DateTime specificDate = new DateTime(date.Year, date.Month, date.Day);
            if (date.Day > dayOfSettlement)
            {
                specificDate = specificDate.AddMonths(1);

            }
            if (dayOfSettlement > DateTime.DaysInMonth(specificDate.Year, specificDate.Month))
            {
                specificDate = specificDate.AddMonths(1);
            }
            specificDate = new DateTime(specificDate.Year, specificDate.Month, dayOfSettlement);

            return specificDate;
        }
    }
    public class FinDeMoisDateStrategy : DateOperations, IFinancialCommitementDateStrategy
    {
        public void SetFcDate(FinancialCommitmentViewModel financialCommitment, int? settlementDate)
        {
            financialCommitment.CommitmentDate = GetLastDayOfThisMonth(financialCommitment.CommitmentDate);

        }
    }
    public class FinDeMoisLeDateStrategy : DateOperations, IFinancialCommitementDateStrategy
    {
        public void SetFcDate(FinancialCommitmentViewModel financialCommitment, int? settlementDate)
        {
            financialCommitment.CommitmentDate = GetLastDayOfThisMonth(financialCommitment.CommitmentDate);
            financialCommitment.CommitmentDate = GetSpecificDayOfMonth(financialCommitment.CommitmentDate, settlementDate.Value);
        }
    }
    public class NetLeDateStrategy : DateOperations, IFinancialCommitementDateStrategy
    {
        public void SetFcDate(FinancialCommitmentViewModel financialCommitment, int? settlementDate)
        {
            financialCommitment.CommitmentDate = GetSpecificDayOfMonth(financialCommitment.CommitmentDate, settlementDate.Value);

        }
    }
}
