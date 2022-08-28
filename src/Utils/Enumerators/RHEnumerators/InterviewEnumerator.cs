namespace Utils.Enumerators.RHEnumerators
{
    public enum InterviewEnumerator
    {
        InterviewRequestedToAllInterviewers = 1,
        AllInterviewersAvailabilityConfirmed = 2,
        InterviewRequestedToCandidate = 3,
        InterviewConfirmedByCandidate = 4,
        InterviewDone = 5,
        InterviewRefused = 6,
        InterviewReported = 7
    }

    public enum InterviewMarkEnumerator
    {
        InterviewMarkRequestedToInterviewer = 1,
        InterviewerAvailabilityConfirmed = 2,
        InterviewMarkToBeEvaluated = 3,
        InterviewMarkEvaluated = 4
    }
    public enum InterviewConfirmationEnumerator
    {
        InterviewConfirmed = 1,
        InterviewAlreadyConfirmed = 2,
        InvalidUrl = 3,
    }
}
