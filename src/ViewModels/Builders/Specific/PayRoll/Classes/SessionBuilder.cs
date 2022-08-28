using Persistence.Entities;
using System;
using System.Linq;
using Utils.Constants;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SessionBuilder : GenericBuilder<SessionViewModel, Session>, ISessionBuilder
    {
        public override Session BuildModel(SessionViewModel model)
        {
            Session session = base.BuildModel(model);
            if (model.DaysOfWeekWorked != null && model.DaysOfWeekWorked.Any())
            {
                model.DaysOfWeekWorked.OrderBy(x => x).ToList().ForEach(m => {
                    session.DaysWorkedInTheWeek += (int)m + ",";
                });
                session.DaysWorkedInTheWeek = session.DaysWorkedInTheWeek.Remove(session.DaysWorkedInTheWeek.Length - NumberConstant.One);
            }
            return session;
        }

        public override SessionViewModel BuildEntity(Session entity)
        {
            SessionViewModel sessionViewModel = base.BuildEntity(entity);
            if (!string.IsNullOrEmpty(entity.DaysWorkedInTheWeek))
            {
                sessionViewModel.DaysOfWeekWorked = entity.DaysWorkedInTheWeek.Split(",").Select(x => (DayOfWeek)Enum.Parse(typeof(DayOfWeek), x)).ToList();
            }
            if (sessionViewModel != null && sessionViewModel.State == (int)SessionStateViewModel.Closed)
            {
                sessionViewModel.CanDelete = false;
                sessionViewModel.CanEdit = false;
            }
            return sessionViewModel;
        }
    }
}
