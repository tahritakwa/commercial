using DataMapping.Models;
using Infrastruture.Service.Interfaces;
using ModelView.Inventory;
using System;
using System.Collections.Generic;
using System.Text;

namespace Application.Services.Inventory.Interfaces
{
    public interface IServiceOemItem : IService<OemItemViewModel, OemItem>
    {
    }
}
