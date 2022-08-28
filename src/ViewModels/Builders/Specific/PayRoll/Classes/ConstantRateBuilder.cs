using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class ConstantRateBuilder : GenericBuilder<ConstantRateViewModel, ConstantRate>, IConstantRateBuilder
    {
        public override ConstantRateViewModel BuildEntity(ConstantRate entity)
        {
            if (entity == null)
            {
                throw new ArgumentNullException();
            }
            ConstantRateViewModel model = base.BuildEntity(entity);
            if (entity.IdRuleUniqueReferenceNavigation != null)
            {
                model.Reference = entity.IdRuleUniqueReferenceNavigation.Reference;
            }
            return model;
        }

        //public override ConstantRate BuildModel(ConstantRateViewModel model)
        //{
        //    ConstantRate entity = base.BuildModel(model);
        //    //if (entity != null)
        //    //{
        //    //    model.Reference = model.IdRuleUniqueReferenceNavigation.Reference;
        //    //}
        //    return entity;
        //}
    }
}
