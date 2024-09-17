using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using UserManagerApp.Data;
using UserManagerApp.Models;

namespace UserManagerApp.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly UserManager<User> _userManager;
        private readonly ApplicationDbContext _context;

        public HomeController(ILogger<HomeController> logger, UserManager<User> userManager, ApplicationDbContext context)
        {
            _logger = logger;
            _userManager = userManager;
            _context = context;
        }

        // Action method for the home page
        public IActionResult Index()
        {
            return View();
        }

        // Action method for the privacy policy page
        public IActionResult Privacy()
        {
            return View();
        }

        // Action method for handling errors
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            var requestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier;
            return View(new ErrorViewModel { RequestId = requestId });
        }

        // Display list of users
        [HttpGet]
        public async Task<IActionResult> UserList()
        {
            // Retrieve users from the database using Entity Framework LINQ
            var users = await _context.Users.ToListAsync();
            return View(users);
        }

        // Block users
        [HttpPost]
        public async Task<IActionResult> Block(string[] userIds)
        {
            foreach (var userId in userIds)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    user.IsBlocked = true;
                    await _userManager.UpdateAsync(user);
                }
            }
            return RedirectToAction("UserList");
        }

        // Unblock users
        [HttpPost]
        public async Task<IActionResult> Unblock(string[] userIds)
        {
            foreach (var userId in userIds)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    user.IsBlocked = false;
                    await _userManager.UpdateAsync(user);
                }
            }
            return RedirectToAction("UserList");
        }

        // Delete users
        [HttpPost]
        public async Task<IActionResult> Delete(string[] userIds)
        {
            foreach (var userId in userIds)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    await _userManager.DeleteAsync(user);
                }
            }
            return RedirectToAction("UserList");
        }
    }
}
