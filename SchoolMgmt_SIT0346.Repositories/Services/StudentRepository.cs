using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using SchoolMgmt_SIT0346.Helpers;
using SchoolMgmt_SIT0346.Repositories.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using System.Web;

namespace SchoolMgmt_SIT0346.Repositories.Services
{
    public class StudentRepository : IStudentRepository
    {
        public List<Student> GetStudents()
        {
            List<Student> StudentData;
            using (AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities())
            {
                StudentData = db.Students.ToList();
            }
            return StudentData;
        }
        public List<Models.Context.Country> GetCountries()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Configuration.ProxyCreationEnabled = false;
            return db.Countries.ToList();
        }
        public List<State> GetStates(int countryId)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Configuration.ProxyCreationEnabled = false;
            return db.States.Where(c => c.CountryId == countryId).ToList();
        }
        public List<City> GetCitites(int stateId, int countryId)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Configuration.ProxyCreationEnabled = false;
            return db.Cities.Where(c => c.StateID == stateId && c.CountryID == countryId).ToList();
        }
        public void AddStudent(StudentModel std, HttpRequestBase Request)
        {
            User CurrentUser = ModelConvertor.GetUser(Request);
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            Student student = ModelConvertor.ConvertToDataObj(std);
            student.CreatedBy = CurrentUser.Id;
            db.Students.Add(student);
            db.SaveChanges();
            foreach (int i in std.Teachers)
            {
                db.StudentTeachers.Add(new StudentTeacher() { StudentId = student.Id, TeacherId = i });
            }
            db.SaveChanges();
        }
        public void EditStudent(StudentModel std)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            List<StudentTeacher> students = db.StudentTeachers.ToList().FindAll(s => s.StudentId == std.Id);
            foreach (StudentTeacher i in students)
            {
                db.StudentTeachers.Remove(i);
            }
            db.SaveChanges();
            Student Newstudent = ModelConvertor.ConvertToDataObj(std);
            Student OldStudent = db.Students.First(s => s.Id == std.Id);
            //OldStudent.FirstName = Newstudent.FirstName;
            db.Entry(OldStudent).CurrentValues.SetValues(Newstudent);
            db.SaveChanges();
            foreach (int i in std.Teachers)
            {
                db.StudentTeachers.Add(new StudentTeacher() { StudentId = std.Id, TeacherId = i });
            }
            db.SaveChanges();
        }

        public List<Teacher> GetTeachers()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.Teachers.ToList();
        }
        public List<TeacherSubjectsModel> GetTeacherSubjects(List<int> teacherList)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Configuration.ProxyCreationEnabled = false;
            List<TeacherSubject> temp = db.TeacherSubjects.Include("Teacher").Include("Subject").ToList().FindAll(i => teacherList.Contains(i.TeacherId));
            List<TeacherSubjectsModel> newList = new List<TeacherSubjectsModel>();
            foreach (TeacherSubject item in temp)
            {
                newList.Add(new TeacherSubjectsModel
                {
                    SubjectId = item.SubjectId,
                    TeacherId = item.TeacherId,
                    SubjectName = item.Subject.Name,
                    TeacherName = item.Teacher.FirstName + " " + item.Teacher.LastName
                });
            }
            return newList;
        }
        public StudentModel GetStudentById(int Id)
        {

            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            StudentModel studentModel = ModelConvertor.ConvertToStudentModel(db.Students.ToList().Find(s => s.Id == Id));
            studentModel.Teachers = (from ST in db.StudentTeachers
                                     where ST.StudentId == Id
                                     select ST.TeacherId).ToList();
            studentModel.SelectedTeachers = string.Join(",", studentModel.Teachers.ConvertAll<string>(delegate (int i) { return i.ToString(); }));
            return studentModel;
        }
    }
}
