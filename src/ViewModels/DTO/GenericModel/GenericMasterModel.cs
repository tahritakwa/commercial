using System;

namespace ViewModels.DTO.GenericModel
{
    [Serializable]
    public class GenericMasterViewModel
    {
        public int Id { get; set; }
        public bool IsDeleted { get; set; }

    }
}
