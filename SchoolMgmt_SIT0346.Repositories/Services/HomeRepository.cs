using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using SchoolMgmt_SIT0346.Repositories.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Repositories.Services
{
    public class HomeRepository : IHomeRepository
    {
        public TotalsModel GetTotals()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            TotalsModel totals = new TotalsModel();
            totals.TotalTeachers = db.Teachers.Count();
            totals.TotalSubjects = db.Subjects.Count();
            totals.TotalStudents = db.Students.Count();
            totals.TotalStates = db.States.Count();
            totals.TotalCities = db.Cities.Count();
            totals.TotalCountries = db.Countries.Count();
            return totals;
        }
        public bool DeleteEntry(string typeName, int id)
        {
            using (AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities())
            {
                switch (typeName)
                {
                    case "City":
                        if (db.Teachers.ToList().FindIndex(t => t.City == id) == -1 &&
                        db.Students.ToList().FindIndex(t => t.City == id) == -1)
                        {
                            db.Cities.Remove(db.Cities.Find(id));
                            db.SaveChanges();
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    case "State":
                        if (db.Teachers.ToList().FindIndex(t => t.State == id) == -1 &&
                        db.Students.ToList().FindIndex(t => t.State == id) == -1)
                        {
                            db.States.Remove(db.States.Find(id));
                            foreach (var c in db.Cities.ToList().FindAll(t => t.StateID == id))
                            {
                                db.Cities.Remove(c);
                            }
                            db.SaveChanges();
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    case "Country":
                        if (db.Teachers.ToList().FindIndex(t => t.Country == id) == -1 &&
                        db.Students.ToList().FindIndex(t => t.Country == id) == -1)
                        {
                            db.Countries.Remove(db.Countries.Find(id));
                            foreach (var c in db.Cities.ToList().FindAll(t => t.CountryID == id))
                            {
                                db.Cities.Remove(c);
                            }
                            foreach (var c in db.States.ToList().FindAll(t => t.CountryId == id))
                            {
                                db.States.Remove(c);
                            }
                            db.SaveChanges();
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    case "Teacher":
                        if (db.StudentTeachers.ToList().FindIndex(t => t.TeacherId == id) == -1
                            && db.TeacherSubjects.ToList().FindIndex(s => s.TeacherId == id) == -1)
                        {
                            db.Teachers.Remove(db.Teachers.Find(id));
                            foreach (var c in db.StudentTeachers.ToList().FindAll(t => t.TeacherId == id))
                            {
                                db.StudentTeachers.Remove(c);
                            }
                            db.SaveChanges();
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    case "Student":
                        foreach (var c in db.StudentTeachers.ToList().FindAll(t => t.StudentId == id))
                        {
                            db.StudentTeachers.Remove(c);
                        }
                        db.Students.Remove(db.Students.Find(id));
                        db.SaveChanges();
                        return true;
                    default:
                        // code block
                        return false;
                }

            }
        }
    }
}
