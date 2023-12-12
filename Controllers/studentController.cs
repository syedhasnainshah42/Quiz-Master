using NMDCATEtestPreparatory.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Net.Mail;

namespace NMDCATEtestPreparatory.Controllers
{
    public class studentController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        private nmdcatGeneral ng = new nmdcatGeneral();
        private EmailService emailService = new EmailService();
        // GET: student
        [Authorize(Roles = "User")]
        [HttpGet]

        public ActionResult Index()
        {
            List<universityRanking> rankingu = db.universityRankings.ToList();
            ViewBag.universityRankings = rankingu.Select(x => new SelectListItem { Value = x.universityRankingId.ToString(), Text = x.universityName });

            List<departmentRanking> rankingd = db.departmentRankings.ToList();
            ViewBag.departmentRankings = rankingd.Select(x => new SelectListItem { Value = x.departmentRankingId.ToString(), Text = x.departmentName });

            ViewBag.ttest = ng.getActivetest();
            return View();
        }
        [Authorize(Roles = "User")]
        [HttpPost]
        public ActionResult Index( int? studentId,string studentName, string studentFName, 
            string email, string contact, string DOB, string userName, string password,
            string gender, int? ttest, string testStatus, HttpPostedFileBase img , string departmentRankings)
            {
    //        DateTime dtDOB = Convert.ToDateTime(DOB);
            DateTime dtDOB = DateTime.Parse(DOB);
            
            password = CreateRandomPassword();
            userName = GenerateName();
           


            if (studentId != null)
            {
                //search stud if already exist
                var studRec = db.students.Where(y => y.studentId == studentId).FirstOrDefault();
                if(studRec != null)
                {
                    studRec.studentName = studentName;
                    studRec.studentFName = studentFName;
                    studRec.email = email;
                    studRec.contact = contact;
                    studRec.userName = userName;
                    studRec.password = password;
                    studRec.departmentName = departmentRankings;
                    
                  studRec.DOB = Convert.ToDateTime(dtDOB, System.Globalization.CultureInfo.GetCultureInfo("ur-PK").DateTimeFormat);
                    if (gender == "Male")
                    {
                        studRec.gender = 1;
                    }
                    else if (gender == "Female")
                    {
                        studRec.gender = 2;
                    }
                    else
                    {
                        studRec.gender = 3;
                    }
                    if (img != null)
                    {
                        var fileName = Path.GetFileName(img.FileName);
                        var timestamp = DateTime.Now.ToString("ddMMyyyyHHmmss");
                        var uniqueFilename = $"{timestamp}_{fileName}";
                        var path = Path.Combine(Server.MapPath("~/MyImages"), uniqueFilename);
                        img.SaveAs(path);
                        studRec.studentPicture = uniqueFilename;
                    }
                    

                // studentRegisterForTest studRegForTest = new studentRegisterForTest();
                var studRegForTest = db.studentRegisterForTests.Where(x => x.studentId == studentId).FirstOrDefault();
                    if (studRegForTest != null)
                    {
                        studRegForTest.studentId = studRec.studentId;
                        studRegForTest.testId = ttest;
                        studRegForTest.userName = studRec.userName;
                        studRegForTest.password = studRec.password;
                        studRegForTest.testStatus = Convert.ToBoolean(testStatus);
                        studRegForTest.status = "Not submitted";
                        //db.studentRegisterForTests.Add(studRegForTest);

                        db.SaveChanges();
                    }
                }
              
            }
            else
            {
                
                student std = new student();
                //var ttt = (from td in db.students
                //           join sd in db.studentRegisterForTests on td.studentId equals sd.studentId
                //           where (sd.userName == userName && sd.password == password)
                //           select new
                //           {
                //               userr = td.userName,
                //               pass = td.password,
                //           }).FirstOrDefault();

                password = CreateRandomPassword();
                userName = GenerateName();
                std.studentName = studentName;
                std.studentFName = studentFName;
                std.email = email;
                std.contact = contact;
                std.userName = userName;
                std.password = password;
                std.departmentName = departmentRankings;
              
                std.studentId = Convert.ToInt32(studentId);
                std.DOB = Convert.ToDateTime(DOB, System.Globalization.CultureInfo.GetCultureInfo("ur-PK").DateTimeFormat);
                if (gender == "Male")
                {
                    std.gender = 1;
                }
                else if (gender == "Female")
                {
                    std.gender = 2;
                }
                else
                {
                    std.gender = 3;
                }
                if (img != null)
                {
                    var fileName = Path.GetFileName(img.FileName);
                    var timestamp = DateTime.Now.ToString("ddMMyyyyHHmmss");
                    var uniqueFilename = $"{timestamp}_{fileName}";
                    var path = Path.Combine(Server.MapPath("~/MyImages"), uniqueFilename);
                    img.SaveAs(path);
                    std.studentPicture = uniqueFilename;
                }

                db.students.Add(std);
                db.SaveChanges();
                studentRegisterForTest studRegForTest = new studentRegisterForTest();

                studRegForTest.studentId = std.studentId;
                studRegForTest.testId = ttest;
                studRegForTest.userName = std.userName;
                studRegForTest.password =std.password;
                studRegForTest.testStatus = Convert.ToBoolean(testStatus);
                studRegForTest.status = "Not submitted";
                db.studentRegisterForTests.Add(studRegForTest);
                db.SaveChanges();
            }

            var emailSetupController = new EmailSetupController();
            //from , to, subj, body 
            emailSetupController.SendMail(email,studentName, userName, password);

            return Redirect("Index");

        }
        //private void SendMail(string studentName, string email, string userName, string password)
        // {
        //     throw new NotImplementedException();
        // }

        private static string CreateRandomPassword(int length = 5)
        {
           
            string validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*?_-";
            Random random = new Random();

            char[] chars = new char[length];
            for (int i = 0; i < length; i++)
            {
                chars[i] = validChars[random.Next(0, validChars.Length)];
            }
            return new string(chars);
        }

        public static string GenerateName(int L = 8)
        {
            //Random r = new Random();
            //string[] consonants = { "A", "C", "D", "f", "g", "h", "j", "k", "l", "m", "l", "n", "p", "q", "r", "s", "s", "z", "t", "v", "w", "x" };
            //string[] vowels = { "a", "e", "I", "O", "U", "A", "Y" };
            //string Name = "";
            //Name += consonants[r.Next(consonants.Length)].ToUpper();
            //Name += vowels[r.Next(vowels.Length)];
            //int b = 0; 
            //while (b < L)
            //{
            //    Name += consonants[r.Next(consonants.Length)];
            //    b++;
            //    Name += vowels[r.Next(vowels.Length)];
            //    b++;
            //}

            //return Name;

            string validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            Random random = new Random();

            char[] chars = new char[L];
            for (int i = 0; i < L; i++)
            {
                chars[i] = validChars[random.Next(0, validChars.Length)];
            }
            return new string(chars);

        }
        [Authorize(Roles = "User")]
        [HttpGet]
        public JsonResult searchByContact(string searchby)
        {
            var studRec = (from s in db.students
                           where (s.contact == searchby)
                           select new
                           {
                               studentName = s.studentName,
                               studentFName=s.studentFName,
                               gender=s.gender,
                               email=s.email,
                               DOB=s.DOB,
                               userName= s.userName,
                               password=s.password,
                               contact= s.contact,
                               studentId= s.studentId
                           }).FirstOrDefault();
            if (studRec != null)
            {
                return Json(new { data = studRec }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { data = "" }, JsonRequestBehavior.AllowGet);
            }

        }



        public ActionResult StudentList()
        {
            var stdnt = db.students.ToList();
            return View(stdnt);
        }
        //public ActionResult studentEdit1()
        //{
            
        //    return View();

        //}

        public ActionResult studentEdit1(int id)
        {
            student e = new student();
            //List<student> students = db.students.ToList();
            //ViewBag.studentId = students.Select(x => new SelectListItem { Value = x.studentId.ToString() });

            //List<subject> subjects = db.subjects.ToList();
            //ViewBag.subjectId = subjects.Select(x => new SelectListItem { Value = x.subjectid.ToString(), Text = x.subjectTitle });

            var query = db.students.Where(x => x.studentId == id).SingleOrDefault();
            e.studentId = query.studentId;
            e.studentName = query.studentName;
            e.studentFName = query.studentFName;
            e.gender = query.gender;
            e.DOB = query.DOB;
            e.email = query.email;
            e.contact = query.contact;
            e.studentPicture = query.studentPicture;


            
            return View(e);
           
        }

        public ActionResult StudentEdit(student stdnt)
        {
            var sid = stdnt.studentId;

            var query = db.students.Where(x => x.studentId == sid).SingleOrDefault();
            query.studentId = query.studentId;
            query.studentName = query.studentName;
            query.studentFName = query.studentFName;
            query.gender = query.gender;
            query.DOB = query.DOB;
            query.email = query.email;
            query.contact = query.contact;
            query.studentPicture = query.studentPicture;

            ViewBag.ttest = ng.getActivetest();

            db.SaveChanges();
            return RedirectToAction("StudentList");
        }


        public JsonResult searchByID(int searchby)
        {
            var studentRec = (from e in db.students
                              where (e.studentId == searchby)
                              select new
                              {
                                  studentId = e.studentId,
                                  studentName = e.studentName,
                                  studentFName = e.studentFName,
                                  gender = e.gender,
                                  email = e.email,
                                  DOB = e.DOB,

                                  contact = e.contact,
                                  studentPicture= e.studentPicture,

                              }) .FirstOrDefault();
            if (studentRec != null)
            {
                return Json(new { data = studentRec }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { data = "" }, JsonRequestBehavior.AllowGet);
            }

        }

    }

}
