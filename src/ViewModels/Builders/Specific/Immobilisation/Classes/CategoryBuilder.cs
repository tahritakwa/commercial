using Persistence.Entities;
using ViewModels.Builders.Generic.Classes;
using ViewModels.Builders.Specific.Immobilisation.Interfaces;
using ViewModels.DTO.Immobilisation;

namespace ViewModels.Builders.Specific.Immobilisation.Classes
{
    /// <summary>
    /// CategoryBuilder
    /// </summary>
    public class CategoryBuilder : GenericBuilder<CategoryViewModel, Category>, ICategoryBuilder
    {
    }
}

