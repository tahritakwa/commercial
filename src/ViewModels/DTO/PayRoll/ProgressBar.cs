using System.Collections.Generic;

namespace ViewModels.DTO.PayRoll
{
    public enum ProgressBarState
    {
        Started = 1,
        Pending = 2,
        Completed = 3
    }

    public class ProgressBar
    {
        public int Id { get; set; }
        public int MaximalValue { get; set; }
        public int Treated { get; set; }
        public double Progression { get; set; }
        public ProgressBarState State { get; set; }
        public IList<dynamic> SuccesseFullyGeneratedObjects { get; set; }
        public IList<dynamic> WrongGeneratedObjects { get; set; }

        public ProgressBar()
        {

        }

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="MaximalValue"></param>
        public ProgressBar(int id, int MaximalValue)
        {
            Id = id;
            Progression = 0;
            Treated = 0;
            this.MaximalValue = MaximalValue;
            State = ProgressBarState.Started;
            SuccesseFullyGeneratedObjects = new List<dynamic>();
            WrongGeneratedObjects = new List<dynamic>();
        }
    }
}
