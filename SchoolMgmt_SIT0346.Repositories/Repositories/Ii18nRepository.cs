using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Repositories.Repositories
{
    public interface Ii18nRepository
    {
        List<Country> GetCountries();
        Country GetCountryById(int id);
        void EditCountry(CountryModel country);
        bool AddCountry(Country country);
        List<State> GetStates();
        bool AddState(State country);
        State GetStateById(int id);
        bool EditState(State state);
        List<State> GetStatesByCountryId(int id);
        City GetCityById(int id);
        bool AddCity(City city);
        bool EditCity(City city);
        List<City> GetCities();

    }
}
