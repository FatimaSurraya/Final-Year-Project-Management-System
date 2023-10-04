using RMS.Models;
using System.Linq;
using System.Text.RegularExpressions;

namespace RMS.Services
{
    public static class ValidationService
    {
        static FYPMS_Entities dbContext = new FYPMS_Entities();

        public static bool IsValidEmail(string email)
        {
            string emailPattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, emailPattern);
        }

        public static bool IsStrongPassword(string password)
        {
            // Password must be at least 8 characters long and contain at least one uppercase letter,
            // one lowercase letter, one number, and one special character.
            string passwordPattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
            return Regex.IsMatch(password, passwordPattern);
        }

        public static bool DuplicateUser(User user)
        {
            bool anyDuplicate = false;
            anyDuplicate = dbContext.Users.Any(x => x.Email.Equals(user.Email)) || dbContext.Users.Any(x => x.FirstName.Equals(user.FirstName) && x.LastName.Equals(user.LastName));
            return anyDuplicate;
        }
    }

}

