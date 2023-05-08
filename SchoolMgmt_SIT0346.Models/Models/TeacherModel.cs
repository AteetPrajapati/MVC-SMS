﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolMgmt_SIT0346.Models.Models
{
    public class TeacherModel
    {
        [Required(ErrorMessage = "Please Provide First Name.")]
        [MinLength(4, ErrorMessage = "Minimum Length 4 is required.")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Please Provide Last Name.")]
        [MinLength(4, ErrorMessage = "Minimum Length 4 is required.")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Please Provide Email.")]
        [EmailAddress(ErrorMessage = "Email is not Valid.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Please Provide MobileNo.")]
        [MinLength(10, ErrorMessage = "Minimum Length 10 is required.")]
        [MaxLength(12, ErrorMessage = "Maximum Length is 12.")]
        public string MobileNo { get; set; }

        [Required(ErrorMessage = "Please Provide Geneder.")]
        public string Geneder { get; set; }

        [Required(ErrorMessage = "Please Provide Password.")]
        [MinLength(6, ErrorMessage = "Minimum Length 6 is required.")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Please Provide Address.")]
        [MinLength(6, ErrorMessage = "Minimum Length 6 is required.")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Please Provide City.")]
        public int CityId { get; set; }

        [Required(ErrorMessage = "Please Provide State.")]
        public int StateId { get; set; }

        [Required(ErrorMessage = "Please Provide Country.")]
        public int CountryId { get; set; }

        [Required(ErrorMessage = "Please Select Subjects.")]
        public List<int> Subjects { get; set; }
        public string SelectedSubjects { get; set; }

        public int Id { get; set; }
        public string FullName { get; set; }
        public TeacherModel()
        {
            FullName = FirstName + " " + LastName;
        }
    }
}
