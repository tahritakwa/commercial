namespace Utils.Enumerators.RHEnumerators
{
    public enum RecruitmentStateEnumerator
    {
        // The recruitment is not valid
        Draft = 1,
        // The recruitment is valid and the candidates can postulate
        Candidacy = 2,
        // Selection of the candidacy for which an intervew will be prepared
        PreSelection = 3,
        // Interview State
        Interview = 4,
        // Evaluation of the Interviews
        Evaluation = 5,
        // Selection
        Selection = 6,
        // Offer preparation
        Offer = 7,
        // Hiring status
        Hiring = 8,
        // Closed of the recruitment process
        Closed = 9
    }
}
