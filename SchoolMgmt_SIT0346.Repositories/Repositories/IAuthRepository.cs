using SchoolMgmt_SIT0346.Models.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Repositories.Repositories
{
    public interface IAuthRepository
    {
        bool FindUser(User user);
        User GetUser(User user);
    }
}
