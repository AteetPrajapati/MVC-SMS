using SchoolMgmt_SIT0346.Models.Context;
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
    }
}
