using RMS.Models;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace RMS.ViewModels
{
    public class MessageViewModel
    {
        [Display(Name = "Assigned To")]
        public List<int> SelectedAssignedTo { get; set; }
        public MultiSelectList AssignedTo { get; set; }
        public List<Message> Messages { get; set; }
    }
}