using Microsoft.AspNetCore.Identity;

namespace UserManagerApp.Models
{
    public class User : IdentityUser
    {
        public string? Username { get; set; }

        public DateTime RegistrationDate { get; set; }
        public DateTime? LastLoginDate { get; set; }
        public bool IsBlocked { get; set; }

        public User()
        {
            RegistrationDate = DateTime.UtcNow;
        }
    }
}
