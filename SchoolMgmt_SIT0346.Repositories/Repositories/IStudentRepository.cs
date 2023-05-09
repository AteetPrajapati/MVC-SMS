using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SchoolMgmt_SIT0346.Repositories.Repositories
{
    public interface IStudentRepository
    {
        List<Student> GetStudents();
        List<Country> GetCountries();
        List<State> GetStates(int countryId);
        List<City> GetCitites(int stateId, int countryId);
        List<Teacher> GetTeachers();

        StudentModel GetStudentById(int Id);
        void AddStudent(StudentModel std, HttpRequestBase Request);
        void EditStudent(StudentModel std);
        List<TeacherSubjectsModel> GetTeacherSubjects(List<int> teacherList);
    }
}
