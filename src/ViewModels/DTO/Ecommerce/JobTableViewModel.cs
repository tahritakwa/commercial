using System;

namespace ViewModels.DTO.Ecommerce
{
    public class JobTableViewModel
    {
        public int Id { get; set; }
        public DateTime? LastExecuteDate { get; set; }
        public DateTime? NextExecuteDate { get; set; }

    }
}

