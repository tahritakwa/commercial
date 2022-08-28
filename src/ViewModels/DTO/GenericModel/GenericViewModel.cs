using System;

namespace ViewModels.DTO.GenericModel
{
    [Serializable]
    public class GenericViewModel
    {
        public int Id { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public bool CanEdit { get; set; } = true;
        public bool CanDelete { get; set; } = true;
        public bool CanShow { get; set; } = true;
        public bool CanValidate { get; set; } = true;
        public bool CanPrint { get; set; } = true;
        public string EntityName { get; set; }


        public GenericViewModel()
        {
        }

        public GenericViewModel(dynamic chilDren)
        {
            if (chilDren != null)
            {
                Id = chilDren.Id;
                IsDeleted = chilDren.IsDeleted;
                TransactionUserId = chilDren.TransactionUserId;
                CanEdit = chilDren.CanEdit;
                CanDelete = chilDren.CanDelete;
                CanShow = chilDren.CanShow;
                CanValidate = chilDren.CanValidate;
                CanPrint = chilDren.CanPrint;
            }
        }
    }
}
