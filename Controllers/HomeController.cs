using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using UserManagerApp.Models;
using UserManagerApp.Services;

namespace UserManagerApp.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IUserService _userService;

        public HomeController(ILogger<HomeController> logger, IUserService userService)
        {
            _logger = logger;
            _userService = userService;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            var requestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier;
            return View(new ErrorViewModel { RequestId = requestId });
        }

        [HttpGet]
        public async Task<IActionResult> UserList()
        {
            var users = await _userService.GetAllUsersAsync();
            return View(users);
        }

        [HttpPost]
        public async Task<IActionResult> Block(string[] userIds)
        {
            await _userService.BlockUsersAsync(userIds);
            return RedirectToAction("UserList");
        }

        [HttpPost]
        public async Task<IActionResult> Unblock(string[] userIds)
        {
            await _userService.UnblockUsersAsync(userIds);
            return RedirectToAction("UserList");
        }

        [HttpPost]
        public async Task<IActionResult> Delete(string[] userIds)
        {
            await _userService.DeleteUsersAsync(userIds);
            return RedirectToAction("UserList");
        }
    }
}
