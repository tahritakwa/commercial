namespace ViewModels.DTO.PayRoll
{
    public class ExitEmailForEmployeeViewModel
    {
        public int Id { get; set; }
        public int IdEmployeeExit { get; set; }
        public int IdEmployee { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }

        public EmployeeViewModel IdEmployeeNavigation { get; set; }
        public ExitEmployeeViewModel IdExitEmployeeNavigation { get; set; }
    }
}
