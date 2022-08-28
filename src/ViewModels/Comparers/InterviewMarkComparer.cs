using System.Collections.Generic;
using ViewModels.DTO.RH;

namespace ViewModels.Comparers
{
    public class InterviewMarkComparer : IEqualityComparer<InterviewMarkViewModel>
    {
        bool IEqualityComparer<InterviewMarkViewModel>.Equals(InterviewMarkViewModel x, InterviewMarkViewModel y)
        {
            return (x.Id == y.Id);
        }

        int IEqualityComparer<InterviewMarkViewModel>.GetHashCode(InterviewMarkViewModel obj)
        {
            if (ReferenceEquals(obj, null))
                return 0;

            return (obj.IdEmployee.GetHashCode());
        }
    }
}
