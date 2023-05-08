using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Repositories.Repositories
{
    public interface ITeacherRepository
    {
        List<Teacher> GetTeachers();
        List<Subject> GetSubjects();
        void AddTeacher(TeacherModel teacherModel);
        TeacherModel GetTeacherById(int Id);
        void EditTeacher(TeacherModel std);
    }
}
