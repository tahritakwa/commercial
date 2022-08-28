using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public class SessionChangedData<T> where T : class
    {
        public ICollection<T> AddedData { get; set; }
        public ICollection<T> UpdatedData { get; set; }
        public ICollection<T> DeletedData { get; set; }

        public SessionChangedData()
        {
            AddedData = new List<T>();
            UpdatedData = new List<T>();
            DeletedData = new List<T>();
        }
    }
}
