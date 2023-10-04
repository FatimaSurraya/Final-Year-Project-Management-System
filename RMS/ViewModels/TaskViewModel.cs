using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.Mvc;

namespace RMS.ViewModels
{
    public class TaskViewModel
    {
        [Display(Name = "Project")]
        public int SelectedProjectId { get; set; }

        [Display(Name = "Assigned To")]
        public List<int> SelectedAssignedTo { get; set; }

        [Display(Name = "Due Date")]
        [DataType(DataType.Date)]
        public DateTime DueDate { get; set; }

        [Display(Name = "Task Status")]
        public string TaskStatus { get; set; }
        public SelectList Projects { get; set; }
        public MultiSelectList AssignedTo { get; set; }
    }
}