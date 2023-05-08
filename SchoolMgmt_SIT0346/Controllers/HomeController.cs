using SchoolMgmt_SIT0346.Repositories.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SchoolMgmt_SIT0346.Controllers
{
    public class HomeController : Controller
    {
        private HomeRepository homeRepoObj;
        public HomeController(HomeRepository _homeRepoObj)
        {
            homeRepoObj = _homeRepoObj;
        }
        [Authorize]
        public ActionResult Index()
        {
            ViewBag.Totals = homeRepoObj.GetTotals();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}