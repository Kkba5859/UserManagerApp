using System.ComponentModel.DataAnnotations;

namespace UserManagerApp.Models
{
    public class LogoutModel
    {
        [Required]
        [Display(Name = "Are you sure you want to log out?")]
        public bool ConfirmLogout { get; set; }
    }
}
