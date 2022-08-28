namespace Utils.Enumerators.CommercialEnumerators
{
    public static class HelpDeskEnumerator
    {


        public static string Defective
        {
            get
            {
                return "D";
            }
        }

        public static string Missing
        {
            get
            {
                return "M";
            }
        }

        public static string Remaining
        {
            get
            {
                return "R";
            }
        }

        public static string Shortage
        {
            get
            {
                return "S";
            }
        }

        public static string Extra
        {
            get
            {
                return "E";
            }
        }

    }


    public enum ClaimStatusEnumerator
    {
        NEW_CLAIM = 1,
        SUBMITTED_CLAIM = 2,
        ACCEPTED_CLAIM = 3,
        REFUSED_CLAIM = 4,
        CLOSED_CLAIM = 5,
    }
}
