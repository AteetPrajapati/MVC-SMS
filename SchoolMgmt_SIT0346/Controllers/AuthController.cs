using Newtonsoft.Json;
using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Repositories.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace SchoolMgmt_SIT0346.Controllers
{
    public class AuthController : Controller
    {
        public AuthRepository authObj;
        public AuthController(AuthRepository _authObj)
        {
            authObj = _authObj;
        }
        // GET: Auth
        public ActionResult Index()
        {
            return RedirectToAction("Login");
        }
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(User user)
        {
            if (authObj.FindUser(user))
            {
                user.Id = (authObj.GetUser(user)).Id;
                string userData = JsonConvert.SerializeObject(user);
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket
                    (
                    1, "USER", DateTime.Now, DateTime.Now.AddMinutes(15), true, userData
                    );

                string enTicket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie faCookie = new HttpCookie(FormsAuthentication.FormsCookieName, enTicket);
                Response.Cookies.Add(faCookie);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }
        public ActionResult Signup()
        {
            return View();
        }
        public ActionResult ResetPassword()
        {
            return View();
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index");
        }
    }
}