using System;

namespace ViewModels.DTO.Models
{
    public class FeedViewModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public int MatchId { get; set; }
    }
}
