using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class TeamBuilder : GenericBuilder<TeamViewModel, Team>, ITeamBuilder
    {
        public TeamBuilder()
        {
        }

        public override TeamViewModel BuildEntity(Team entity)
        {
            TeamViewModel model = base.BuildEntity(entity);
            if(model != null && model.IdManagerNavigation != null)
            {
                model.IdManagerNavigation.FullName = model.IdManagerNavigation.FirstName + " " + model.IdManagerNavigation.LastName;
            }
            
            return model;
        }
    }
}
