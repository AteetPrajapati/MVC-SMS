using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using SchoolMgmt_SIT0346.Repositories.Repositories;
using SchoolMgmt_SIT0346.Repositories.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SchoolMgmt_SIT0346.Controllers
{
    [Authorize]
    public class StudentController : Controller
    {
        private IStudentRepository studentRepoObj;
        private HomeRepository homeRepoObj;
        public StudentController(IStudentRepository _interfaceobj, HomeRepository _homeRepoObj)
        {
            studentRepoObj = _interfaceobj;
            homeRepoObj = _homeRepoObj;
        }
        // GET: Student
        public ActionResult Index()
        {
            List<Student> AllStudents = studentRepoObj.GetStudents();
            return View(AllStudents);
        }
        public ActionResult Add()
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Teachers = studentRepoObj.GetTeachers();
            return View("AddStudent", new StudentModel());
        }
        [HttpPost]
        public ActionResult Add(StudentModel std)
        {
            studentRepoObj.AddStudent(std);
            return RedirectToAction("Index");
        }
        public ActionResult EditStudent(int id)
        {
            StudentModel studentModel = studentRepoObj.GetStudentById(id);
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Teachers = studentRepoObj.GetTeachers();
            ViewBag.States = studentRepoObj.GetStates(studentModel.CountryId);
            ViewBag.Cities = studentRepoObj.GetCitites(studentModel.StateId, studentModel.CountryId);
            return View(studentModel);
        }
        public ActionResult ViewStudent(int id)
        {
            StudentModel studentModel = studentRepoObj.GetStudentById(id);
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Teachers = studentRepoObj.GetTeachers();
            ViewBag.States = studentRepoObj.GetStates(studentModel.CountryId);
            ViewBag.Cities = studentRepoObj.GetCitites(studentModel.StateId, studentModel.CountryId);
            return View(studentModel);
        }
        [HttpPost]
        public ActionResult EditStudent(StudentModel std)
        {
            studentRepoObj.EditStudent(std);
            return RedirectToAction("Index");
        }
        public ActionResult DeltetStudent(int id)
        {
            var flag = homeRepoObj.DeleteEntry("Student", id);
            if (!flag)
            {
                TempData["StudentError"] = "Currently in use.";
            }
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult GetStates(int countryId)
        {
            List<State> states = studentRepoObj.GetStates(countryId);
            return Json(states, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetCitites(int stateId, int countryId)
        {
            return Json(studentRepoObj.GetCitites(stateId, countryId), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult GetTeacherSubjects(List<int> teacherList)
        {
            return Json(studentRepoObj.GetTeacherSubjects(teacherList), JsonRequestBehavior.AllowGet);
        }
    }
}