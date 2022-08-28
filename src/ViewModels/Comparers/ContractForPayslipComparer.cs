using Persistence.Entities;
using System;
using System.Collections.Generic;

namespace ViewModels.Comparers
{
    public class ContractForPayslipComparer : IEqualityComparer<Contract>
    {
        public bool Equals(Contract contractBeforeUpdate, Contract updatedContract)
        {
            if (contractBeforeUpdate is null || updatedContract is null)
            {
                return false;
            }
            return contractBeforeUpdate.Id == updatedContract.Id && contractBeforeUpdate.IdSalaryStructure == updatedContract.IdSalaryStructure && 
                contractBeforeUpdate.IdEmployee == updatedContract.IdEmployee && contractBeforeUpdate.IdCnss == updatedContract.IdCnss;
        }

        public int GetHashCode(Contract obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("");
            }
            return obj.Id.GetHashCode();
        }
    }
}
