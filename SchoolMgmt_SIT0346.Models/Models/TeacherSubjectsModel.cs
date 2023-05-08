using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Models.Models
{
    public class TeacherSubjectsModel
    {
        public int TeacherId { get; set; }
        public int SubjectId { get; set; }
        public string TeacherName { get; set; }
        public string SubjectName { get; set; }
    }
}
