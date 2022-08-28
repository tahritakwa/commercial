using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ConstantValueBuilder : GenericBuilder<ConstantValueViewModel, ConstantValue>, IConstantValueBuilder
    {
        public override ConstantValueViewModel BuildEntity(ConstantValue entity)
        {
            if(entity == null)
            {
                throw new ArgumentNullException();
            }
            ConstantValueViewModel model = base.BuildEntity(entity);
            if (entity.IdRuleUniqueReferenceNavigation != null)
            {
                model.Reference = entity.IdRuleUniqueReferenceNavigation.Reference;
            }
            return model;
        }
    }
}
