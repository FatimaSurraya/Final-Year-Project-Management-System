using RMS.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using RMS.ViewModels;
using Ionic.Zip;

namespace RMS.Controllers
{
    public class ProjectController : Controller
    {
        FYPMS_Entities dbContext = new FYPMS_Entities();

        public ActionResult ListAllProjects()
        {
            var role = Convert.ToString(Session["RoleName"]);
            List<ProjectDetail> projectList = new List<ProjectDetail>();
            if (role == "Supervisor")
            {
                var userId = Convert.ToInt32(Session["UserID"]);
                projectList = dbContext.ProjectDetails.Where(x => x.SupervisorID == userId).ToList();
            }
            return View("ProjectGrid", projectList);
        }

        public ActionResult AddProject()
        {
            return View();
        }

        [HttpPost]
        public JsonResult InsertProject(ProjectDetail projectDetail, List<HttpPostedFileBase> UploadDocuments)
        {
            projectDetail.SupervisorID = Convert.ToInt32(Session["UserID"]);
            projectDetail.CreatedDate = DateTime.Now;
            var user = dbContext.Users.FirstOrDefault(x => x.UserId == projectDetail.SupervisorID);
            projectDetail.User = user;
            dbContext.ProjectDetails.Add(projectDetail);
            dbContext.SaveChanges();

            foreach (var file in UploadDocuments)
            {
                if (file != null && file.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(file.FileName);
                    string documentPath = Path.Combine(Server.MapPath("~/Uploads/"), fileName);
                    file.SaveAs(documentPath);

                    var projectDocument = new ProjectDocument
                    {
                        ProjectId = projectDetail.ProjectId,
                        DocumentName = fileName,
                        DocumentPath = documentPath
                    };

                    dbContext.ProjectDocuments.Add(projectDocument);
                    dbContext.SaveChanges();
                }
            }

            return Json(1);
        }

        [HttpPost]
        public ActionResult Delete(int id)
        {
            var project = GetProjectById(id);

            if (project != null)
            {
                dbContext.ProjectDocuments.RemoveRange(project.ProjectDocuments);
                var tasks = dbContext.Tasks.Where(x => x.ProjectId == id);
                dbContext.Tasks.RemoveRange(tasks);
                dbContext.ProjectDetails.Remove(project);
                dbContext.SaveChanges();
            }
            return RedirectToAction("ListAllProjects");
        }


        private ProjectDetail GetProjectById(int id)
        {
            return dbContext.ProjectDetails.FirstOrDefault(p => p.ProjectId == id);
        }

        [HttpPost]
        public JsonResult GetStudents()
        {
            var students = dbContext.Users
                .Where(u => u.UserType.TypeName == "Student")
                .Select(x => new
                {
                    UserId = x.UserId,
                    FullName = x.FirstName + " " + x.LastName
                })
                .ToList();

            return Json(students);
        }

        #region Tasks
        public ActionResult ListAllTasks()
        {
            List<Task> tasks = dbContext.Tasks.ToList();
            return View("Task", tasks);
        }

        public ActionResult AddTask()
        {
            var projects = GetProjects()?.Select(x => new
            {
                ProjectId = x.ProjectId,
                Title = x.Title
            })
                                    .ToList();

            var assignedTo = GetAssignedToUsers()?.Select(x => new
            {
                UserId = x.UserId,
                FullName = string.Concat(x.FirstName, " ", x.LastName)
            }).ToList();

            var viewModel = new TaskViewModel
            {
                Projects = new SelectList(projects, "ProjectId", "Title"),
                AssignedTo = new MultiSelectList(assignedTo, "UserId", "FullName")
            };

            return View("AddTask", viewModel);
        }


        [HttpPost]
        public JsonResult SaveTask(TaskViewModel task)
        {
            if (ModelState.IsValid && task.SelectedAssignedTo != null && task.SelectedAssignedTo.Count() > 0)
            {
                var project = dbContext.ProjectDetails.FirstOrDefault(x => x.ProjectId == task.SelectedProjectId);
                foreach (var item in task.SelectedAssignedTo)
                {
                    var taskDbo = new Task
                    {
                        TaskName = project.Title,
                        TaskDescription = project.Description,
                        TaskStatus = "Not Started",
                        DueDate = task.DueDate,
                        AssignedTo = item,
                        ProjectId = project.ProjectId
                    };
                    dbContext.Tasks.Add(taskDbo);
                }
                dbContext.SaveChanges();
                return Json(1);
            }
            return Json(-1);
        }

        public ActionResult EditTask(int id)
        {
            var task = dbContext.Tasks.FirstOrDefault(x => x.TaskId == id);
            var taskViewModel = new TaskViewModel
            {
                SelectedProjectId = task.ProjectId,
                SelectedAssignedTo = new List<int>() { task.AssignedTo },
                DueDate = (DateTime)task.DueDate
            };
            var projects = GetProjects()?.Select(x => new
            {
                ProjectId = x.ProjectId,
                Title = x.Title
            }).ToList();
            var assignedTo = GetAssignedToUsers()?.Select(x => new
            {
                UserId = x.UserId,
                FullName = string.Concat(x.FirstName, " ", x.LastName)
            }).ToList();
            taskViewModel.Projects = new SelectList(projects, "ProjectId", "Title");
            taskViewModel.AssignedTo = new MultiSelectList(assignedTo, "UserId", "FullName", taskViewModel.SelectedAssignedTo);
            return View("EditTask", taskViewModel);
        }

        private List<ProjectDetail> GetProjects()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            var projectList = dbContext.ProjectDetails.Where(x => x.SupervisorID == userId).ToList();
            return projectList;
        }

        private List<User> GetAssignedToUsers()
        {
            return dbContext.Users.Where(x => x.UserType.TypeName == "Student").ToList();
        }


        [HttpPost]
        public ActionResult DeleteTask(int id)
        {
            var task = dbContext.Tasks.FirstOrDefault(t => t.TaskId == id);

            if (task != null)
            {
                dbContext.Tasks.Remove(task);
                dbContext.SaveChanges();
            }
            return RedirectToAction("ListAllProjects");
        }
        #endregion

        #region student
        public ActionResult ListAllStudentProjects()
        {
            return View("StudentProjectGrid", dbContext.ProjectDetails.ToList());
        }

        public ActionResult ShowAllTasks()
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            List<Task> tasks = dbContext.Tasks.Where(x => x.AssignedTo == userId).ToList();
            return View("StudentTask", tasks);
        }

        public ActionResult DownloadDocuments(int projectId)
        {
            var documents = dbContext.ProjectDocuments?.Where(x => x.ProjectId == projectId)?.Select(x => new
            {
                x.DocumentPath,
                x.DocumentName
            }).ToList();

            if (documents != null && documents.Count() > 0)
            {
                using (MemoryStream zipStream = new MemoryStream())
                {
                    using (ZipFile zipFile = new ZipFile())
                    {
                        foreach (var document in documents)
                        {
                            if (!string.IsNullOrEmpty(document.DocumentPath) && System.IO.File.Exists(document.DocumentPath))
                            {
                                byte[] fileBytes = System.IO.File.ReadAllBytes(document.DocumentPath);
                                string fileName = document.DocumentName;
                                zipFile.AddEntry(fileName, fileBytes);
                            }
                        }

                        zipFile.Save(zipStream);
                    }

                    string zipFileName = "task_documents.zip";

                    return File(zipStream.ToArray(), "application/zip", zipFileName);
                }
            }

            return HttpNotFound();
        }

        [HttpPost]
        public JsonResult UpdateTaskStatus(int taskId, int studentId, string newStatus)
        {
            var task = dbContext.Tasks.FirstOrDefault(t => t.TaskId == taskId && t.AssignedTo == studentId);
            if (task != null)
            {
                task.TaskStatus = newStatus;
                dbContext.SaveChanges();
                return Json(new { success = true });
            }
            return Json(new { success = false, message = "Task not found." });
        }

        public ActionResult RegisterProject(int projectId)
        {
            var userId = Convert.ToInt32(Session["UserID"]);
            var user = dbContext.Users.FirstOrDefault(u => u.UserId == userId);
            var project = dbContext.ProjectDetails.FirstOrDefault(p => p.ProjectId == projectId);

            var message = new Message
            {
                MessageText = user.FirstName + " " + user.LastName + " requested for the " + project.Title + " project.",
                SenderId = user.UserId,
                ReceiverId = project.SupervisorID,
                MessageDate = DateTime.Now
            };
            dbContext.Messages.Add(message);
            dbContext.SaveChanges();
            return Json(1);
        }

        #endregion
    }
}