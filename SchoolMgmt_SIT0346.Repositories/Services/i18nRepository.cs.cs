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
    public class i18nRepository : Ii18nRepository
    {
        public List<Country> GetCountries()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Configuration.ProxyCreationEnabled = false;
            return db.Countries.ToList();
        }
        public Country GetCountryById(int id)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.Countries.ToList().Find(c => c.Id == id);
        }
        public void EditCountry(CountryModel country)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            Country country1 = new Country()
            {
                Id = country.Id,
                name = country.name
            };
            db.Entry(db.Countries.Find(country.Id)).CurrentValues.SetValues(country1);
            db.SaveChanges();
        }
        public bool AddCountry(Country country)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.Countries.ToList().FindIndex(c => c.name == country.name) == -1)
            {
                db.Countries.Add(country);
                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }
        public List<State> GetStates()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.States.ToList();
        }
        public bool AddState(State state)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.States.ToList().FindIndex(c => c.name == state.name && c.CountryId == state.CountryId) == -1)
            {
                db.States.Add(state);
                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }
        public State GetStateById(int id)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.States.ToList().Find(s => s.Id == id);
        }
        public bool EditState(State state)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.States.ToList().FindIndex(c => c.name == state.name && c.CountryId == state.CountryId) == -1)
            {
                db.Entry(db.States.Find(state.Id)).CurrentValues.SetValues(state);
                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }
        public List<City> GetCities()
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.Cities.ToList();
        }
        public List<State> GetStatesByCountryId(int id)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.States.ToList().FindAll(s => s.CountryId == id);
        }
        public City GetCityById(int id)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.Cities.ToList().Find(s => s.Id == id);
        }
        public bool AddCity(City city)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.Cities.ToList().FindIndex(c => c.name == city.name && c.CountryID == city.CountryID && city.StateID == c.StateID) == -1)
            {
                db.Cities.Add(city);
                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }
        }
        public bool EditCity(City city)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.Cities.ToList().FindIndex(c => c.name == city.name && c.CountryID == city.CountryID && city.StateID == c.StateID) == -1)
            {
                db.Entry(db.Cities.Find(city.Id)).CurrentValues.SetValues(city);
                db.SaveChanges();
                return true;
            }
            else
            {
                return false;
            }

        }
    }
}
