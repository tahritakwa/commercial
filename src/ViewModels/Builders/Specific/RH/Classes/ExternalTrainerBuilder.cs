using Persistence.Entities;
using System;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ExternalTrainerBuilder : GenericBuilder<ExternalTrainerViewModel, ExternalTrainer>, IExternalTrainerBuilder
    {
        public override ExternalTrainerViewModel BuildEntity(ExternalTrainer entity)
        {
            if (entity == null)
            {
                throw new ArgumentException();
            }
            ExternalTrainerViewModel externalTrainer = base.BuildEntity(entity);
            if (externalTrainer.FirstName != null && externalTrainer.LastName != null)
            {
                externalTrainer.FullName = externalTrainer.FirstName + " " + externalTrainer.LastName;
            }
            return externalTrainer;
        }
    }
}
