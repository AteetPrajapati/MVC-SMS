using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Models.Models
{
    public class CountryModel
    {
        [Required(ErrorMessage = "Please Provide Country Name.")]
        [MinLength(4, ErrorMessage = "Minimum Length 4 is required.")]
        public string name { get; set; }
        public int Id { get; set; }
    }
}
