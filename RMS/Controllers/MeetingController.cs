using RMS.Models;
using RMS.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace RMS.Controllers
{
    public class MeetingController : Controller
    {
        FYPMS_Entities dbContext = new FYPMS_Entities();

        public ActionResult ListAllMeetings()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            List<Meeting> meetings = dbContext.Meetings.Where(x=>x.SupervisorID==userId).ToList();
            return View("Meeting", meetings);
        }

        public ActionResult ListAllStudentMeetings()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            List<Meeting> meetings = dbContext.Meetings.Where(x => x.StudentID == userId).ToList();
            return View("StudentMeeting", meetings);
        }

        public ActionResult AddMeeting()
        {

            var assignedTo = GetAssignedToUsers()?.Select(x => new
            {
                UserId = x.UserId,
                FullName = string.Concat(x.FirstName, " ", x.LastName)
            }).ToList();

            var viewModel = new MeetingViewModel
            {
                AssignedTo = new MultiSelectList(assignedTo, "UserId", "FullName")
            };

            return View("AddMeeting", viewModel);
        }


        [HttpPost]
        public JsonResult SaveMeeting(MeetingViewModel meeting)
        {
            if (ModelState.IsValid && meeting.SelectedAssignedTo != null && meeting.SelectedAssignedTo.Count() > 0)
            {
                foreach (var item in meeting.SelectedAssignedTo)
                {
                    var MeetingDbo = new Meeting
                    {
                        MeetingType = meeting.MeetingType,
                        StudentID = item,
                        SupervisorID = Convert.ToInt32(Session["UserID"]),
                        ScheduledDate = meeting.ScheduledDate,
                    };
                    dbContext.Meetings.Add(MeetingDbo);
                }
                dbContext.SaveChanges();
                return Json(1);
            }
            return Json(-1);
        }

        private List<User> GetAssignedToUsers()
        {
            return dbContext.Users.Where(x => x.UserType.TypeName == "Student").ToList();
        }


        [HttpPost]
        public ActionResult Delete(int id)
        {
            var meeting = dbContext.Meetings.FirstOrDefault(t => t.MeetingId == id);

            if (meeting != null)
            {
                dbContext.Meetings.Remove(meeting);
                dbContext.SaveChanges();
            }
            return RedirectToAction("ListAllMeetngs");
        }

        public ActionResult SendMeetingUpdate(int supervisorId, string msg )
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            var user = dbContext.Users.FirstOrDefault(u => u.UserId == userId);

            var message = new Message
            {
                MessageText = user.FirstName + " " + user.LastName + " " + msg + " meeting.",
                SenderId = user.UserId,
                ReceiverId = supervisorId,
                MessageDate = DateTime.Now
            };
            dbContext.Messages.Add(message);
            dbContext.SaveChanges();
            return Json(1);
        }

    }
}