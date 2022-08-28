﻿using System;


namespace ViewModels.DTO.Models
{
    public class ChatMessage
    {
        public int MatchId { get; set; }
        public string Text { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
