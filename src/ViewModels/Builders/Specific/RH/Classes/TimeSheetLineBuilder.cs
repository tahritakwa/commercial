using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;
using ViewModels.DTO.Shared;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class TimeSheetLineBuilder : GenericBuilder<TimeSheetLineViewModel, TimeSheetLine>, ITimeSheetLineBuilder
    {
        private readonly ILeaveBuilder _leaveBuilder;
        private readonly ILeaveTypeBuilder _leaveTypeBuilder;

        public TimeSheetLineBuilder(ILeaveBuilder leaveBuilder, ILeaveTypeBuilder leaveTypeBuilder)
        {
            _leaveBuilder = leaveBuilder;
            _leaveTypeBuilder = leaveTypeBuilder;
        }

        public override TimeSheetLine BuildModel(TimeSheetLineViewModel model)
        {
            model.IdProjectNavigation = null;
            TimeSheetLine timeSheetLine = base.BuildModel(model);
            if ((timeSheetLine.IdLeave.HasValue && ((timeSheetLine.Worked.HasValue && !timeSheetLine.Worked.Value) || !timeSheetLine.Worked.HasValue)) || timeSheetLine.IdDayOff.HasValue)
            {
                timeSheetLine.IdProject = null;
            }
            return timeSheetLine;
        }

        public override TimeSheetLineViewModel BuildEntity(TimeSheetLine entity)
        {
            TimeSheetLineViewModel timeSheetLineViewModel = base.BuildEntity(entity);
            if (entity.IdLeaveNavigation != null)
            {
                timeSheetLineViewModel.IdLeaveNavigation = _leaveBuilder.BuildEntity(entity.IdLeaveNavigation);
                if (timeSheetLineViewModel.IdLeaveNavigation.IdLeaveTypeNavigation != null)
                {
                    timeSheetLineViewModel.WaitingLeaveTypeName = _leaveTypeBuilder.BuildEntity(entity.IdLeaveNavigation.IdLeaveTypeNavigation).Label;
                }
            }
            timeSheetLineViewModel.DayHour = new DayHour();
            return timeSheetLineViewModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="projectViewModel"></param>
        /// <returns></returns>
        public IList<ProjectViewModel> BuildProjectDay(IEnumerable<ProjectViewModel> projectViewModel)
        {
            IList<ProjectViewModel> projectViewModels = new List<ProjectViewModel>();
            projectViewModel.ToList().ForEach(project =>
            {
                projectViewModels.Add(new ProjectViewModel
                {
                    Id = project.Id,
                    Name = project.Name,
                    ProjectLabel = project.ProjectLabel
                });
            });
            return projectViewModels;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="projectViewModel"></param>
        /// <returns></returns>
        public ProjectViewModel BuildProjectDay(ProjectViewModel projectViewModel)
        {
            return new ProjectViewModel
            {
                Id = projectViewModel.Id,
                Name = projectViewModel.Name,
                ProjectLabel = projectViewModel.ProjectLabel
            };
        }
    }
}
