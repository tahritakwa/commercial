using DataMapping.Models;
using Infrastruture.Builder;
using ModelView.Inventory;
using System;
using System.Collections.Generic;
using System.Text;

namespace Application.Builder.Inventory.Interfaces
{
    public interface IOemItemBuilder : IBuilder<OemItemViewModel, OemItem>
    {
    }
}
