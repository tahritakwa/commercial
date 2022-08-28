using Persistence.Entities;
using Services.Generic.Interfaces;
using System.Collections.Generic;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace Services.Specific.RH.Interfaces
{
    public interface IServiceInterview : IService<InterviewViewModel, Interview>
    {
        EmailViewModel GenerateInterviewEmailById(InterviewViewModel interview, string lang);
        void MakeTheInterviewAsRequestedToCandidate(InterviewViewModel interview, string userMail);
        void ConfirmTheCandidateDisponibility(InterviewViewModel interview);
        List<InterviewViewModel> FromInterviewToNextStep(int recruitmentId);
        List<InterviewViewModel> FromEvaluationToNextStep(int recruitmentId);
        List<InterviewViewModel> GetCandidacyInterviewDetails(int idCandidacy);
        void CancelInterview(InterviewViewModel interview, string userMail);
        void ResendEmailToInterviewer(InterviewViewModel interview, int idInterviewer, string userMail);
        void ConfirmAvailabilityForTheInterview(InterviewMarkViewModel interviewMark, string userMail);
        int ConfirmTheCandidateDisponibilityFromLink(string connectionString, string token);
        bool CheckInterviewerHasAnotherInterview(InterviewViewModel interview);
    }
}
