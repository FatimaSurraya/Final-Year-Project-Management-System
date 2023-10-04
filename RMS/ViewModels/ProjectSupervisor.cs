using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace RMS.ViewModels
{
    public class ProjectSupervisor
    {
        public int ProjectId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Skills { get; set; }
        public string Domain { get; set; }
        public string Tools { get; set; }
        public string StudentsAllowed { get; set; }
        public int SupervisorID { get; set; }
        public string SupervisorName { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }

    }
}