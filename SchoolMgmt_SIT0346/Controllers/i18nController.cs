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
    public class i18nController : Controller
    {
        public i18nRepository i18nObj;
        private IStudentRepository studentRepoObj;
        private HomeRepository homeRepoObj;
        public i18nController(i18nRepository _i18nObj, IStudentRepository _studentRepoObj, HomeRepository _homeRepoObj)
        {
            i18nObj = _i18nObj;
            studentRepoObj = _studentRepoObj;
            homeRepoObj = _homeRepoObj;
        }
        // GET: Country
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AllCountry()
        {
            return View(i18nObj.GetCountries());
        }
        public ActionResult AddCountry()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddCountry(CountryModel countryModel)
        {
            bool isExists = i18nObj.AddCountry(new Country()
            {
                Id = countryModel.Id,
                name = countryModel.name
            });
            if (isExists)
            {
                return RedirectToAction("AllCountry");
            }
            else
            {
                TempData["couuntryError"] = "Country is Already Exists.";
                return View();
            }
        }
        public ActionResult EditCountry(int id)
        {
            Country country = i18nObj.GetCountryById(id);

            return View(new CountryModel()
            {
                Id = country.Id,
                name = country.name
            });
        }
        [HttpPost]
        public ActionResult EditCountry(CountryModel country)
        {
            i18nObj.EditCountry(country);
            return RedirectToAction("AllCountry");
        }
        public ActionResult AllStates()
        {
            return View(i18nObj.GetStates());
        }
        public ActionResult AddState()
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            return View();
        }
        [HttpPost]
        public ActionResult AddState(StateModel state)
        {
            bool isExists = i18nObj.AddState(new State()
            {
                name = state.name,
                CountryId = state.countryId
            });
            if (isExists)
            {
                return RedirectToAction("AllStates");
            }
            else
            {
                TempData["stateError"] = "State is Already Exists.";
                return View();
            }
        }
        public ActionResult EditState(int id)
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            State state = i18nObj.GetStateById(id);
            StateModel stateModel = new StateModel() { Id = state.Id, name = state.name, countryId = state.CountryId ?? 0 };
            return View(stateModel);
        }
        [HttpPost]
        public ActionResult EditState(StateModel stateModel)
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            State state = new State() { Id = stateModel.Id, name = stateModel.name, CountryId = stateModel.countryId };
            bool isExists = i18nObj.EditState(state);
            if (isExists)
            {
                return RedirectToAction("AllStates");
            }
            else
            {
                TempData["stateError"] = "State is Already Exists.";
                return View();
            }
        }
        public ActionResult AllCities()
        {
            return View(i18nObj.GetCities());
        }
        public ActionResult AddCity()
        {
            ViewBag.Countries = studentRepoObj.GetCountries();
            return View();
        }
        [HttpPost]
        public ActionResult AddCity(CityModel city)
        {
            bool isExists = i18nObj.AddCity(new City() { name = city.name, CountryID = city.countryId, StateID = city.stateId });
            if (isExists)
            {
                return RedirectToAction("AllCities");
            }
            else
            {
                TempData["cityError"] = "City is Already Exists.";
                return View();
            }
        }
        public ActionResult EditCity(int id)
        {
            City city = i18nObj.GetCityById(id);
            CityModel cityModel = new CityModel()
            {
                Id = city.Id,
                name = city.name,
                countryId = city.CountryID ?? 0,
                stateId = city.StateID ?? 0
            };
            ViewBag.Countries = studentRepoObj.GetCountries();
            ViewBag.States = i18nObj.GetStatesByCountryId(city.CountryID ?? 1);
            return View(cityModel);
        }
        [HttpPost]
        public ActionResult EditCity(CityModel city)
        {
            bool isExists = i18nObj.EditCity(new City() { Id = city.Id, name = city.name, CountryID = city.countryId, StateID = city.stateId });
            if (isExists)
            {
                return RedirectToAction("AllCities");
            }
            else
            {
                TempData["cityError"] = "City is Already Exists.";
                return View();
            }
        }
        [HttpGet]
        public ActionResult DeleteCity(int id)
        {
            var flag = homeRepoObj.DeleteEntry("City", id);
            if (!flag)
            {
                TempData["CitiError"] = "Currently in use.";
            }
            return RedirectToAction("AllCities");
        }
        public ActionResult DeleteState(int id)
        {
            var flag = homeRepoObj.DeleteEntry("State", id);
            if (!flag)
            {
                TempData["StateError"] = "Currently in use.";
            }
            return RedirectToAction("AllStates");
        }
        public ActionResult DeleteCountry(int id)
        {
            var flag = homeRepoObj.DeleteEntry("Country", id);
            if (!flag)
            {
                TempData["CountryError"] = "Currently in use.";
            }
            return RedirectToAction("AllCountry");
        }
    }
}