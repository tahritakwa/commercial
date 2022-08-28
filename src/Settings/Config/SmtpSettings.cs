namespace Settings.Config
{
    public class SmtpSettings
    {
        public string AdministratorMail { get; set; }
        public string AdministratorPassword { get; set; }
        public string SmtpMailServer { get; set; }
        public int SmtpMailPort { get; set; }
        public bool EnableSsl { get; set; }
    }
}
