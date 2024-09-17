using Microsoft.AspNetCore.Identity;

namespace UserManagerApp.Models
{
    public class User : IdentityUser
    {

        public DateTime RegistrationDate { get; set; }
        public DateTime? LastLoginDate { get; set; }
        public bool IsBlocked { get; set; }

        public User()
        {
            RegistrationDate = DateTime.UtcNow;
        }
    }
}
