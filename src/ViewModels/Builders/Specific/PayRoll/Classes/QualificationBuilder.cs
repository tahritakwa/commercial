using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class QualificationBuilder : GenericBuilder<QualificationViewModel, Qualification>, IQualificationBuilder
    {
        public override QualificationViewModel BuildEntity(Qualification entity)
        {
            QualificationViewModel model = base.BuildEntity(entity);
            if ((entity != null) && (entity.GraduationYear != null))
            {
                model.GraduationYearDate = new DateTime((int)entity.GraduationYear, 1, 1);
            }

            return model;
        }

        public override Qualification BuildModel(QualificationViewModel model)
        {
            Qualification entity = base.BuildModel(model);

            if ((model != null) && (model.GraduationYearDate != null))
            {
                entity.GraduationYear = model.GraduationYearDate.Value.Year;
            }

            return entity;
        }
    }
}
