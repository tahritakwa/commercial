﻿using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ExitEmloyeeLeaveLineBuilder : GenericBuilder<ExitEmployeeLeaveLineViewModel, ExitEmployeeLeaveLine>, IExitEmloyeeLeaveLineBuilder
    {
    }
}
