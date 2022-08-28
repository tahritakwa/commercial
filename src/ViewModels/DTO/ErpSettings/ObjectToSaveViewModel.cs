using System.Collections.Generic;
using Newtonsoft.Json;
using Utils.Utilities.ConverterUtilities;


namespace ViewModels.DTO.ErpSettings
{
    public class ObjectToSaveViewModel
    {
        public IList<EntityAxisValuesViewModel> EntityAxisValues { get; set; }

        public dynamic model { get; set; }

        public dynamic verifyUnicity { get; set; }
        public bool isFromModal { get; set; }
    }
}
