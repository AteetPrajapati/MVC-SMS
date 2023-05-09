using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Models.Models
{
    public class SignupModel
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string FirstName { get; set; }
        [Required]
        public string LastName { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        [MinLength(6, ErrorMessage = "Minimum Length Sould be 6.")]
        public string Password { get; set; }
        [Required]
        [Compare("Password", ErrorMessage = "Password is Not Matching")]
        public string ConfirmPassword { get; set; }
    }
}
