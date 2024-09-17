using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using UserManagerApp.Models;

namespace UserManagerApp.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<User>? _userManager;
        private readonly SignInManager<User>? _signInManager;

        public AccountController(UserManager<User>? userManager, SignInManager<User>? signInManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
        }

        [HttpGet]
        public IActionResult Register() => View();

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new User
                {
                    UserName = model.UserName,
                    Email = model.Email,
                    RegistrationDate = DateTime.Now
                };

                var result = await _userManager!.CreateAsync(user, model.Password ?? string.Empty);

                if (result.Succeeded)
                {
                    await _signInManager!.SignInAsync(user, isPersistent: false);
                    TempData["SuccessMessage"] = "Registration successful!";
                    return RedirectToAction("Index", "UserManager");
                }

                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }
            }

            return View(model);
        }

        [HttpGet]
        public IActionResult Login() => View();

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var result = await _signInManager!.PasswordSignInAsync(
                    model.UserName!,
                    model.Password!,
                    model.RememberMe,
                    lockoutOnFailure: false
                );

                if (result.Succeeded)
                {
                    TempData["SuccessMessage"] = "Login successful!";
                    return RedirectToAction("Index", "UserManager");
                }

                if (result.IsLockedOut)
                {
                    TempData["ErrorMessage"] = "Your account is locked out.";
                }
                else
                {
                    TempData["ErrorMessage"] = "Invalid login attempt.";
                }
            }

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await _signInManager!.SignOutAsync();
            TempData["SuccessMessage"] = "You have been logged out.";
            return RedirectToAction("Index", "Home");
        }
    }
}
