using System.Web;
using System.Web.Mvc;

namespace SchoolMgmt_SIT0346
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
