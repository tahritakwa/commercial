using System;
using System.ComponentModel.DataAnnotations;
using ViewModels.DTO.GenericModel;

namespace ViewModels.DTO.PayRoll
{
    public class ReducedEmployeeViewModel : GenericViewModel
    {
        [Required(ErrorMessage = "An Employee FirstName is required")]
        public int Id { get; set; }
        public string FirstName { get; set; }
        [Required(ErrorMessage = "An Employee LastName is required")]
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public bool? IsResigned { get; set; }
        public int Status { get; set; }
        public DateTime HiringDate { get; set; }
        public DateTime? ResignationDate { get; set; }

    }
}
