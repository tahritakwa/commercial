using Persistence.Entities;
using Services.Generic.Interfaces;
using ViewModels.DTO.Shared;

namespace Services.Specific.Administration.Interfaces
{

    public interface IServiceCountry : IService<CountryViewModel, Country>
    {
    }

}
