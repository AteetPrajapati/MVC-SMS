using SchoolMgmt_SIT0346.Repositories.Repositories;
using SchoolMgmt_SIT0346.Repositories.Services;
using System.Web.Mvc;
using Unity;
using Unity.Mvc5;

namespace SchoolMgmt_SIT0346
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
            var container = new UnityContainer();
            container.RegisterType<IStudentRepository, StudentRepository>();
            container.RegisterType<ITeacherRepository, TeacherRepository>();
            container.RegisterType<Ii18nRepository, i18nRepository>();
            container.RegisterType<IAuthRepository, AuthRepository>();
            container.RegisterType<IHomeRepository, HomeRepository>();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}