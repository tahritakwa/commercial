using Application.Builder.Inventory.Interfaces;
using DataMapping.Models;
using Infrastruture.Builder;
using ModelView.Inventory;
using System;
using System.Collections.Generic;
using System.Text;

namespace Application.Builder.Inventory.Classes
{
    public class OemItemBuilder : GenericBuilder<OemItemViewModel, OemItem>, IOemItemBuilder
    {
        public override OemItemViewModel BuildEntity(OemItem entity)
        {
            return base.BuildEntity(entity);
        }
    }
}
