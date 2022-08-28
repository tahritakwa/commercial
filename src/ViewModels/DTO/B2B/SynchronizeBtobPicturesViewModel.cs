using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModels.DTO.Models;

namespace ViewModels.DTO.B2B
{
    public class SynchronizeBtobPicturesViewModel
    {
        public int IdItem { get; set; }
        public List<FileInfoBtoBViewModel> Data { get; set; }
    }
}
