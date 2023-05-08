using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using SchoolMgmt_SIT0346.Repositories.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SchoolMgmt_SIT0346.Helpers;

namespace SchoolMgmt_SIT0346.Repositories.Services
{
    public class TeacherRepository : ITeacherRepository
    {
        public List<Teacher> GetTeachers()
        {
            List<Teacher> teachers;
            using (AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities())
            {
                teachers = db.Teachers.ToList();
            }
            return teachers;
        }
        public List<Subject> GetSubjects()
        {
            using (AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities())
            {
                return db.Subjects.ToList();
            }
        }
        public void AddTeacher(TeacherModel teacherModel)
        {
            using (AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities())
            {
                Teacher tech = ModelConvertor.BindTeacherModel(teacherModel);

                db.Teachers.Add(tech);
                db.SaveChanges();
                foreach (int i in teacherModel.Subjects)
                {
                    db.TeacherSubjects.Add(new TeacherSubject() { TeacherId = tech.Id, SubjectId = i });
                }
                db.SaveChanges();
            }
        }
        public TeacherModel GetTeacherById(int Id)
        {

            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            TeacherModel teacherModel = ModelConvertor.BindTeacher(db.Teachers.ToList().Find(s => s.Id == Id));
            teacherModel.Subjects = (from ST in db.TeacherSubjects
                                     where ST.TeacherId == Id
                                     select ST.SubjectId).ToList();
            teacherModel.SelectedSubjects = string.Join(",", teacherModel.Subjects.ConvertAll<string>(delegate (int i) { return i.ToString(); }));
            return teacherModel;
        }

        public void EditTeacher(TeacherModel tech)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            List<TeacherSubject> subjects = db.TeacherSubjects.ToList().FindAll(s => s.TeacherId == tech.Id);
            foreach (TeacherSubject i in subjects)
            {
                db.TeacherSubjects.Remove(i);
            }
            db.SaveChanges();
            Teacher Newstudent = ModelConvertor.BindTeacherModel(tech);
            Teacher OldStudent = db.Teachers.First(t => t.Id == tech.Id);
            //OldStudent.FirstName = Newstudent.FirstName;
            db.Entry(OldStudent).CurrentValues.SetValues(Newstudent);
            db.SaveChanges();
            foreach (int i in tech.Subjects)
            {
                db.TeacherSubjects.Add(new TeacherSubject() { TeacherId = tech.Id, SubjectId = i });
            }
            db.SaveChanges();
        }
    }
}
