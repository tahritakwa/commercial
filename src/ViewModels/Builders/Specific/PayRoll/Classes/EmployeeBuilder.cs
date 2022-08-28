using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using Utils.Utilities.DataUtilities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.PayRoll.Interfaces;
using ViewModels.DTO.PayRoll;

namespace ViewModels.Builders.Specific.PayRoll.Classes
{
    public class EmployeeBuilder : GenericBuilder<EmployeeViewModel, Employee>, IEmployeeBuilder
    {
        private readonly IContractBuilder _contractBuilder;
        private readonly IQualificationBuilder _qualificationBuilder;
        private readonly IJobEmployeeBuilder _jobEmployeeBuilder;
        private readonly IGradeBuilder _gradeBuilder;

        public EmployeeBuilder(IContractBuilder contractBuilder,
            IQualificationBuilder qualificationBuilder,
            IJobEmployeeBuilder jobEmployeeBuilder, IGradeBuilder gradeBuilder)
        {
            _contractBuilder = contractBuilder;
            _qualificationBuilder = qualificationBuilder;
            _jobEmployeeBuilder = jobEmployeeBuilder;
            _gradeBuilder = gradeBuilder;
        }

        public override EmployeeViewModel BuildEntity(Employee entity)
        {
            if (entity != null)
            {
                EmployeeViewModel model = base.BuildEntity(entity);
                if (entity.FullName != null)
                {
                    model.FullName = entity.FirstName + " " + entity.LastName;
                }
                if (entity.Qualification != null)
                {
                    model.Qualification = entity.Qualification.Select(_qualificationBuilder.BuildEntity).ToList();
                }
                if (entity.Contract != null)
                {
                    model.Contract = entity.Contract.Select(_contractBuilder.BuildEntity).ToList();
                }

                IList<JobEmployeeViewModel> jobEmployeeViewModel = new List<JobEmployeeViewModel>();
                if (model.JobEmployee != null)
                {
                    foreach (JobEmployee jobEmployee in entity.JobEmployee)
                    {
                        jobEmployeeViewModel.Add(_jobEmployeeBuilder.BuildEntity(jobEmployee));
                    }
                    model.JobEmployee = jobEmployeeViewModel;
                }
                if (entity.IdGradeNavigation != null)
                {
                    model.IdGradeNavigation = _gradeBuilder.BuildEntity(entity.IdGradeNavigation);
                }

                if (entity.InverseIdUpperHierarchyNavigation != null)
                {
                    model.InverseIdUpperHierarchyNavigation = entity.InverseIdUpperHierarchyNavigation.Select(BuildEntity).ToList();
                }
                return model;
            }
            return null;
        }

        public override Employee BuildModel(EmployeeViewModel model)
        {
            if (model != null)
            {
                Employee entity = base.BuildModel(model);
                if (model.Contract != null)
                {
                    entity.Contract = model.Contract.Select(_contractBuilder.BuildModel).ToList();
                }
                if (model.Qualification != null)
                {
                    entity.Qualification = model.Qualification.Select(_qualificationBuilder.BuildModel).ToList();
                }
                return entity;
            }
            return null;
        }
    }
}
