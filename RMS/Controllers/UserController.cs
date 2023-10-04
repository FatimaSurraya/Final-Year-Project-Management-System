using RMS.Models;
using RMS.Services;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;

namespace RMS.Controllers
{
    public class UserController : Controller
    {
        FYPMS_Entities db = new FYPMS_Entities();

        public ActionResult UsersDetail()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            return View(db.Users.Where(x => x.UserId != userId).ToList());
        }

        public ActionResult CreateUser()
        {
            return View();
        }

        [HttpPost]
        public JsonResult CreateUser(User user)
        {
            if (!ValidationService.IsValidEmail(user.Email))
            {
                return Json(-1);
            }
            if (!ValidationService.IsStrongPassword(user.Password))
            {
                return Json(-2);
            }
            if (ValidationService.DuplicateUser(user))
            {
                return Json(-3);
            }
            try
            {
                user.CreatedDate = DateTime.Now;
                var userType = db.UserTypes.FirstOrDefault(x => x.UserTypeId == user.UserTypeId);
                user.UserType = userType;
                db.Users.Add(user);
                db.SaveChanges();
                return Json(1);
            }
            catch (Exception ex)
            {
                return Json(0);
            }
        }

        public ActionResult Edit(int id)
        {
            var user = GetUserById(id);
            return View(user);
        }

        [HttpPost]
        public ActionResult Edit(User updatedUser)
        {
            try
            {
                var existingUser = GetUserById(updatedUser.UserId);
                existingUser.FirstName = updatedUser.FirstName;
                existingUser.LastName = updatedUser.LastName;
                existingUser.Email = updatedUser.Email;
                var userType = db.UserTypes.FirstOrDefault(x => x.TypeName == updatedUser.UserType.TypeName);
                existingUser.UserType = userType;
                db.SaveChanges();
                return RedirectToAction("UsersDetail");
            }
            catch
            {
                return View(updatedUser);
            }
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            var user = GetUserById(id);
            var tasks = db.Tasks.Where(x => x.AssignedTo == id);
            db.Tasks.RemoveRange(tasks);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("UsersDetail");
        }

        private User GetUserById(int id)
        {
            return db.Users.FirstOrDefault(u => u.UserId == id);
        }
    }
}