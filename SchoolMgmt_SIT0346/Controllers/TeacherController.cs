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
    public class TeacherController : Controller
    {
        private IStudentRepository studentRepoObj;
        private ITeacherRepository teacherRepoObj;
        private HomeRepository homeRepoObj;
        public TeacherController(IStudentRepository _interfaceobj, ITeacherRepository _teacherRepoObj, HomeRepository _homeRepoObj)
        {
            studentRepoObj = _interfaceobj;
            teacherRepoObj = _teacherRepoObj;
            homeRepoObj = _homeRepoObj;
        }
        // GET: Teacher
        public ActionResult Index()
        {
            List<Teacher> AllTeachers = teacherRepoObj.GetTeachers();
            return View(AllTeachers);
        }
        public ActionResult Add()
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Subjects = teacherRepoObj.GetSubjects();
            return View("AddTeacher", new TeacherModel());
        }
        [HttpPost]
        public ActionResult Add(TeacherModel tech)
        {
            teacherRepoObj.AddTeacher(tech);
            return RedirectToAction("Index");
        }
        public ActionResult EditTeacher(int id)
        {
            TeacherModel teacherModel = teacherRepoObj.GetTeacherById(id);
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Subjects = teacherRepoObj.GetSubjects();
            ViewBag.States = studentRepoObj.GetStates(teacherModel.CountryId);
            ViewBag.Cities = studentRepoObj.GetCitites(teacherModel.StateId, teacherModel.CountryId);
            return View(teacherModel);
        }
        [HttpPost]
        public ActionResult EditTeacher(TeacherModel tech)
        {
            teacherRepoObj.EditTeacher(tech);
            return RedirectToAction("Index");
        }
        public ActionResult DeleteTeacher(int id)
        {
            var flag = homeRepoObj.DeleteEntry("Teacher", id);
            if (!flag)
            {
                TempData["TeacherError"] = "Currently in use.";
            }
            return RedirectToAction("Index");
        }
        public ActionResult ViewTeacher(int id)
        {
            TeacherModel teacherModel = teacherRepoObj.GetTeacherById(id);
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.Subjects = teacherRepoObj.GetSubjects();
            ViewBag.States = studentRepoObj.GetStates(teacherModel.CountryId);
            ViewBag.Cities = studentRepoObj.GetCitites(teacherModel.StateId, teacherModel.CountryId);
            return View(teacherModel);
        }
    }
}