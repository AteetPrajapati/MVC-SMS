using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Models.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Please Provide Username")]
        [MinLength(4, ErrorMessage = "Minimum length 4 is required.")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Please Provide Password")]
        [MinLength(4, ErrorMessage = "Minimum length 4 is required.")]
        public string Password { get; set; }
    }
}
