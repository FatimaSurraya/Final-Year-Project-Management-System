using RMS.Models;
using RMS.ViewModels;
using System;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using System.Collections.Generic;
using RMS.Services;

namespace RMS.Controllers
{
    public class HomeController : Controller
    {
        FYPMS_Entities db1 = new FYPMS_Entities();
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Register(User user)
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
                var userType = db1.UserTypes.FirstOrDefault(x => x.UserTypeId == user.UserTypeId);
                user.UserType = userType;
                db1.Users.Add(user);
                db1.SaveChanges();
                return Json(1);
            }
            catch (Exception ex)
            {
                return Json(0);
            }
        }

        [HttpPost]
        public JsonResult Login(string userName, string password)
        {
            try
            {
                var userObj = db1.Users.FirstOrDefault(x => x.Email == userName && x.Password == password);
                if (userObj != null)
                {
                    Session["Email"] = userObj.Email;
                    Session["UserID"] = userObj.UserId;

                    var roleName = db1.UserTypes.FirstOrDefault(x => x.UserTypeId == userObj.UserTypeId);
                    if (roleName != null)
                    {
                        Session["RoleName"] = roleName.TypeName;
                        Session["RoleID"] = roleName.UserTypeId;
                    }
                    if(roleName.TypeName == "Admin")
                        return Json(1);
                    if (roleName.TypeName == "Supervisor")
                        return Json(2);
                    if (roleName.TypeName == "Student")
                        return Json(3);
                }
                return Json(-1);
            }
            catch (Exception ex)
            {
                return Json(-2);
            }
        }

        public ActionResult Login()
        {
            return View();
        }
        public ActionResult Logout()
        {
            Session["Email"] = "";
            Session["Email"] = null; //it's my session variable
            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut(); //you write this when you use FormsAuthentication
            return Redirect("/Home/Login");
        }
    }
}