using System.Collections.Generic;

namespace ViewModels.DTO.Common
{
    public class UserDetailChatDiscussion
    {
        public int Id { get; set; }
        public List<string> ConnectionIds { get; set; }
        public string FullName { get; set; }
        public string UserMail { get; set; }
        public byte[] UserPicture { get; set; }

    }
}
