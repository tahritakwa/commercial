using Persistence.Entities;
using System;
using System.Collections.Generic;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class CandidateBuilder : GenericBuilder<CandidateViewModel, Candidate>, ICandidateBuilder
    {
        private readonly IQualificationBuilder _qualificationBuilder;
        public CandidateBuilder(IQualificationBuilder qualificationBuilder)
        {
            _qualificationBuilder = qualificationBuilder;
        }
        public override CandidateViewModel BuildEntity(Candidate entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            CandidateViewModel model = base.BuildEntity(entity);
            if (entity.FullName != null)
            {
                model.FullName = entity.FirstName + " " + entity.LastName;
            }
            IList<QualificationViewModel> qualificationsViewModel = new List<QualificationViewModel>();
            if (model.Qualification != null)
            {
                foreach (Qualification qualification in entity.Qualification)
                {
                    qualificationsViewModel.Add(_qualificationBuilder.BuildEntity(qualification));
                }
                model.Qualification = qualificationsViewModel;
            }
            return model;

        }

        public override Candidate BuildModel(CandidateViewModel model)
        {
            if (model != null)
            {
                Candidate entity = base.BuildModel(model);
                
                IList<Qualification> qualifications = new List<Qualification>();
                if (model.Qualification != null)
                {
                    foreach (QualificationViewModel qualificationViewModel in model.Qualification)
                    {
                        qualifications.Add(_qualificationBuilder.BuildModel(qualificationViewModel));
                    }
                    entity.Qualification = qualifications;
                }
                return entity;
            }
            return null;
        }

    }
}
