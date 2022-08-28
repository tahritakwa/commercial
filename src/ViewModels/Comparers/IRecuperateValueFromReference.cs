using System;

namespace ViewModels.Comparers
{
    public interface IRecuperateValueFromReference
    {
        dynamic GetSumFormalismValue(int idEmployee, string referenceChaine, DateTime month);
        dynamic GetSingleFormalismValue(int idEmployee, int idContract, string referenceChaine);
    }
}
