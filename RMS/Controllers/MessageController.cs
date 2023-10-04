using RMS.Models;
using RMS.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;

namespace RMS.Controllers
{
    public class MessageController : Controller
    {
        FYPMS_Entities db = new FYPMS_Entities();

        public ActionResult Message()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            var userRole = Session["RoleName"].ToString();

            var messages = db.Messages.Where(x=>x.ReceiverId ==  userId).ToList();
            foreach (var message in messages)
            {
                var user = db.Users.FirstOrDefault(x => x.UserId == message.SenderId);
                 message.SenderName = user.FirstName +" "+user.LastName;
            }

            var viewModel = new MessageViewModel();
            if (userRole == "Supervisor")
            {
                var assignedTo = db.Users.Where(x => x.UserId != userId && x.UserType.TypeName == "Student")?.Select(x => new
                {
                    UserId = x.UserId,
                    FullName = string.Concat(x.FirstName, " ", x.LastName)
                }).ToList();

                viewModel = new MessageViewModel
                {
                    Messages = messages,
                    AssignedTo = new MultiSelectList(assignedTo, "UserId", "FullName")
                };
            }

            if (userRole == "Student")
            {
                var assignedTo = db.Users.Where(x => x.UserId != userId && x.UserType.TypeName == "Supervisor")?.Select(x => new
                {
                    UserId = x.UserId,
                    FullName = string.Concat(x.FirstName, " ", x.LastName)
                }).ToList();

                viewModel = new MessageViewModel
                {
                    Messages = messages,
                    AssignedTo = new MultiSelectList(assignedTo, "UserId", "FullName")
                };
            }



            return View(viewModel);
        }

        [HttpPost]
        public ActionResult SendMessage(List<int> SelectedAssignedTo, string Message)
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            if(SelectedAssignedTo!=null && SelectedAssignedTo.Count() > 0)
            {
                foreach(var receiverId in SelectedAssignedTo)
                {
                    var message = new Message
                    {
                        MessageText = Message,
                        SenderId = userId,
                        ReceiverId = receiverId,
                        MessageDate = DateTime.Now
                    };
                    db.Messages.Add(message);
                }
                db.SaveChanges();
                return Json(1);
            }
            return Json(-1);
        }

    }
}