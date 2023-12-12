using NMDCATEtestPreparatory.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NMDCATEtestPreparatory.Controllers
{
    public class HomeController : Controller
    {
       
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        private nmdcatGeneral ng = new nmdcatGeneral();


        [Authorize(Roles = "UserR,User")]


        public ActionResult Employee()
        {
            List<User> users = db.Users.ToList();
            ViewBag.Users = users.Select(x => new SelectListItem { Value = x.userId.ToString(), Text = x.ucontrol });

            List<subject> subjects = db.subjects.ToList();
            ViewBag.Subjects = subjects.Select(x => new SelectListItem { Value = x.subjectid.ToString(), Text = x.subjectTitle });

            return View();
        }
        [Authorize(Roles = "UserR,User")]
        public ActionResult EmployeeForm(/*Employee emp*/string employeeName, string employeeFName,
        string Email, int? userId, int? subjectId,string Contact,
        DateTime? DOB,string userName, string userPassword, string ucontrol)
        {
            
            Employee e = new Employee();
            //e.employeeId = emp.employeeId;
            e.employeeName = employeeName;
            e.employeeFName = employeeFName;
            e.DOB  = Convert.ToDateTime(DOB);
            e.Email = Email;
           e.Contact = Contact;
            e.userId = userId;
            //e.subjectId = subjectId;

            db.Employees.Add(e);
            db.SaveChanges();
        // return RedirectToAction("Employee");
            User adduser = new User();
            adduser.userName =userName;
            adduser.userPassword = userPassword;
            adduser.ucontrol = ucontrol;
            db.Users.Add(adduser);
            db.SaveChanges();
          return RedirectToAction("Employee");
        }
        [Authorize(Roles = "UserR,User")]
        public ActionResult EmployeeList()
        {
            var emp = db.Employees.ToList();
            return View(emp);
        }
        [HttpGet]
        [Authorize(Roles = "UserR,User")]
        public ActionResult EmployeeEdit1(int id)
        {
            Employee e = new Employee();
            List<User> users = db.Users.ToList();
            ViewBag.userId = users.Select(x => new SelectListItem { Value = x.userId.ToString(), Text = x.ucontrol });

            List<subject> subjects = db.subjects.ToList();
            ViewBag.subjectId = subjects.Select(x => new SelectListItem { Value = x.subjectid.ToString(), Text = x.subjectTitle });

            var query = db.Employees.Where(x => x.employeeId == id).SingleOrDefault();
            e.employeeId = query.employeeId;
            e.employeeName = query.employeeName;
            e.employeeFName = query.employeeFName;
            e.DOB = query.DOB;
            e.Email = query.Email;
            e.Contact = query.Contact;
            

            return View(e);
        }
        [HttpPost]
        [Authorize(Roles = "UserR,User")]
        public ActionResult EmployeeEdit(Employee emp, string userName, string userPassword, string ucontrol)
        {
            var eid = emp.employeeId;

            var query = db.Employees.Where(y => y.employeeId == eid).SingleOrDefault();
            query.employeeName = emp.employeeName;
            query.employeeFName = emp.employeeFName;
            query.DOB = emp.DOB;
            query.Email = emp.Email;
            query.Contact = emp.Contact;

            db.SaveChanges();
            User adduser = new User();
            adduser.userName = userName;
            adduser.userPassword = userPassword;
            adduser.ucontrol = ucontrol;

            db.Users.Add(adduser);
            db.SaveChanges();
            return RedirectToAction("EmployeeList");
        }
        [Authorize(Roles = "UserR,User")]
        public ActionResult Subject()
        {
            ViewBag.questionClass = ng.getStudentClass();
            return View();
        }
        [Authorize(Roles = "UserR,User")]
        public ActionResult addSubject(string subjectTitle, string questionClass)
        {
            subject subb = new subject();
            subb.subjectTitle = subjectTitle;
            subb.@class = questionClass;
            db.subjects.Add(subb);
            db.SaveChanges();
            return RedirectToAction("Subject");
        }
        [Authorize(Roles = "UserR,User")]
        public ActionResult subjectList()
        {
            var emp = (from s in db.subjects
                      select new subjectlistModel
                      {
                          subjectid = s.subjectid,
                          subjectTitle = s.subjectTitle,
                           Class= s.@class,
                      }).ToList();
                //db.subjects.ToList();
            return View(emp);
        }
        [Authorize(Roles = "UserR,User")]
        public class subjectlistModel
        {
            public long subjectid { get; set; }
            public string subjectTitle { get; set; }
            public string Class { get; set; }
        }
        //public ActionResult JsonView()
        //{
        //    var subj = db.subjects.ToList();
        //    return View(subj);
        //}
        //public JsonResult subjectsData()
        //{
        //    return Json, JsonRequestBehavior.AllowGet);
        //}

        public JsonResult searchByID(int searchby)
        {
            var empRec = (from e in db.Employees
                           where (e.employeeId == searchby)
                           select new
                           {
                               employeeId = e.employeeId,
                               employeeName = e.employeeName,
                               employeeFName = e.employeeFName,
                               email = e.Email,
                               DOB = e.DOB,
                               
                               contact = e.Contact,
                               
                           }).FirstOrDefault();
            if (empRec != null)
            {
                return Json(new { data = empRec }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { data = "" }, JsonRequestBehavior.AllowGet);
            }

        }
    }
       
}