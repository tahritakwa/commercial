using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class EvaluationCriteriaThemeBuilder : GenericBuilder<EvaluationCriteriaThemeViewModel, EvaluationCriteriaTheme>, IEvaluationCriteriaThemeBuilder
    {

        public override EvaluationCriteriaThemeViewModel BuildEntity(EvaluationCriteriaTheme entity)
        {
            if(entity == null)
            {
                throw new ArgumentException();
            }
            EvaluationCriteriaThemeViewModel model = base.BuildEntity(entity);
            if(model.EvaluationCriteria != null)
            {
                model.CriteriaNumber = model.EvaluationCriteria.Count;
            }

            return model;
        }
    }
}
