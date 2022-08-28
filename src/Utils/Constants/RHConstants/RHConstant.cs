using System.IO;

namespace Utils.Constants.RHConstants
{
    public static class RHConstant
    {
        public static string TimeSpanFormat
        {
            get { return "{0:00}:{1:00}"; }
        }
        public static string RhFileRootPath
        {
            get { return Path.Combine("RH", "TimeSheet", " ").Trim(); }
        }
        public static string ProjectFileRootPath
        {
            get { return Path.Combine("Sales", "Project", " ").Trim(); }
        }
        public static string Date
        {
            get { return "Date"; }
        }
        public static string VALIDATE_TIMESHEET
        {
            get { return "VALIDATE_TIMESHEET"; }
        }
        public static string VALIDATE_LEAVE
        {
            get { return "VALIDATE_LEAVE"; }
        }
        public static string NUMBER_OF_OFFER
        {
            get { return "NumberOfOffer"; }
        }
        public static string TOTAL_AVERAGE_MARK
        {
            get { return "TotalAverageMark"; }
        }

        public static string RHTrainingPictureFileRootPath
        {
            get { return Path.Combine("RH", "Training", "Pictures", " ").Trim(); }
        }
        public static string RHTrainingSessionPlanFileRootPath
        {
            get { return Path.Combine("RH", "Training", "Sessions", " ").Trim(); }
        }
        public static string RHOfferPictureFileRootPath
        {
            get { return Path.Combine("RH", "recruitment-offer", " ").Trim(); }
        }
        public static string FileDriveRootPath
        {
            get { return Path.Combine("RH", "Starkdrive", " ").Trim(); }
        }
        public static string NextPath
        {
            get { return Path.Combine(" ").Trim(); }
        }
        public static readonly string ID_CANDIDATE = "IdCandidate";
    }
}
