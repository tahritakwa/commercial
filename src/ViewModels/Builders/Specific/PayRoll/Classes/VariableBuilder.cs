using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class VariableBuilder : GenericBuilder<VariableViewModel, Variable>, IVariableBuilder
    {
        public override VariableViewModel BuildEntity(Variable entity)
        {
            if (entity == null)
            {
                throw new ArgumentException("");
            }
            var model = base.BuildEntity(entity);

            if (entity.IdRuleUniqueReferenceNavigation != null)
            {
                model.Reference = entity.IdRuleUniqueReferenceNavigation.Reference;
            }
            return model;
        }
    }
}
