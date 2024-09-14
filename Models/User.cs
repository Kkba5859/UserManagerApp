using Microsoft.AspNetCore.Identity;

namespace UserManagerApp.Models
{
    public class User : IdentityUser
    {
        public int id { get; set; }
        public string? Username { get; set; }
        public new string? Email { get; set; }
        public DateTime RegistrationDate { get; set; }
        public DateTime? LastLoginDate { get; set; }
        public bool IsBlocked { get; set; } 
    }
}
