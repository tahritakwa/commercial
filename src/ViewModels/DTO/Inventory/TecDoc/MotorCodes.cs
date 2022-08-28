using System.Collections.Generic;

namespace ViewModels.DTO.Inventory.TecDoc
{
    public class MotorCodes
    {
        public List<Code> Array { get; set; }

    }


    public class Code
    {
        public string MotorCode { get; set; }
    }
}
