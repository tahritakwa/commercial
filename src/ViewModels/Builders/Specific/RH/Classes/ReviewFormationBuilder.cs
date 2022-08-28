using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.RH.Interfaces;
using ViewModels.DTO.RH;

namespace ViewModels.Builders.Specific.RH.Classes
{
    public class ReviewFormationBuilder : GenericBuilder<ReviewFormationViewModel, ReviewFormation>, IReviewFormationBuilder
    {
        private readonly IFormationTypeBuilder _formationTypeBuilder;

        public ReviewFormationBuilder(IFormationTypeBuilder formationTypeBuilder)
        {
            _formationTypeBuilder = formationTypeBuilder;
        }


        public override ReviewFormationViewModel BuildEntity(ReviewFormation entity)
        {
            ReviewFormationViewModel reviewFormationViewModel = base.BuildEntity(entity);
            if (entity.IdFormationNavigation != null && entity.IdFormationNavigation.IdFormationTypeNavigation != null)
            {
                reviewFormationViewModel.IdFormationNavigation.IdFormationTypeNavigation = _formationTypeBuilder.BuildEntity(entity.IdFormationNavigation.IdFormationTypeNavigation);
            }
            return reviewFormationViewModel;
        }
    }
}
