using SchoolMgmt_SIT0346.Models.Context;
using SchoolMgmt_SIT0346.Models.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Helpers
{
    public class ModelConvertor
    {
        public static Student ConvertToDataObj(StudentModel stu)
        {
            return new Student
            {
                Id = stu.Id,
                FirstName = stu.FirstName,
                LastName = stu.LastName,
                Email = stu.Email,
                MobileNo = stu.MobileNo,
                Password = stu.Password,
                Address = stu.Address,
                City = stu.CityId,
                State = stu.StateId,
                Country = stu.CountryId,
                CreatedBy = 8
            };
        }
        public static StudentModel ConvertToStudentModel(Student stu)
        {
            return new StudentModel
            {
                FirstName = stu.FirstName,
                LastName = stu.LastName,
                Email = stu.Email,
                MobileNo = stu.MobileNo,
                Password = stu.Password,
                Address = stu.Address,
                CityId = stu.City,
                StateId = stu.State,
                CountryId = stu.Country
            };
        }
        public static Teacher BindTeacherModel(TeacherModel tech)
        {
            return new Teacher
            {
                Id = tech.Id,
                FirstName = tech.FirstName,
                LastName = tech.LastName,
                Email = tech.Email,
                Geneder = tech.Geneder,
                MobileNo = tech.MobileNo,
                Address = tech.Address,
                City = tech.CityId,
                State = tech.StateId,
                Country = tech.CountryId
            };
        }
        public static TeacherModel BindTeacher(Teacher tech)
        {
            return new TeacherModel
            {
                FirstName = tech.FirstName,
                LastName = tech.LastName,
                Email = tech.Email,
                Geneder = tech.Geneder,
                MobileNo = tech.MobileNo,
                Address = tech.Address,
                CityId = tech.City,
                StateId = tech.State,
                CountryId = tech.Country
            };
        }
    }
}
