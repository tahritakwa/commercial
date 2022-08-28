using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class SkillsBuilder : GenericBuilder<SkillsViewModel, Skills>, ISkillsBuilder
    {
        public override Skills BuildModel(SkillsViewModel model)
        {
            if (model == null)
            {
                throw new ArgumentException("");
            }
            Skills entity = base.BuildModel(model);
            if (model.IdFamilyNavigation != null)
            {
                entity.IdFamilyNavigation = null;
            }
            return entity;
        }
    }
}
