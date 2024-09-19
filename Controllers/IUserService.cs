using UserManagerApp.Models;

namespace UserManagerApp.Services
{
    public interface IUserService
    {
        Task BlockUsersAsync(string[] userIds);
        Task UnblockUsersAsync(string[] userIds);
        Task DeleteUsersAsync(string[] userIds);
        Task<IEnumerable<User>> GetAllUsersAsync();
    }
}
