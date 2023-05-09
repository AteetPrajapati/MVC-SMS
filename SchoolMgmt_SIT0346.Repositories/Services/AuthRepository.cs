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
    public class AuthRepository : IAuthRepository
    {
        public bool FindUser(User user)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            var count = db.Users.ToList().FindIndex(u => u.Username == user.Username && u.Password == user.Password);
            if (count != -1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public User GetUser(User user)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            return db.Users.ToList().Find(u => u.Username == user.Username && u.Password == user.Password);
        }

        public bool CheckUsername(string username)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            if (db.Users.ToList().FindIndex(u => u.Username == username) == -1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public void SignupUser(SignupModel signupModel)
        {
            AP351AteetPrajapatiEntities db = new AP351AteetPrajapatiEntities();
            db.Users.Add(new User()
            {
                FirstName = signupModel.FirstName,
                Email = signupModel.Email,
                LastName = signupModel.LastName,
                Password = signupModel.Password,
                Username = signupModel.Username
            });
            db.SaveChanges();
        }
    }
}
