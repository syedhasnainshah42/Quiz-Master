using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;

namespace NMDCATEtestPreparatory.Controllers
{
    public class studentLoginController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        // GET: studentLogin
        public ActionResult Index()
        {
            ViewBag.error = "";
            return View();
        }
        [HttpPost]

        public ActionResult Login(string userName, string password)
        {
            if (ModelState.IsValid)
            {
                var data = db.studentRegisterForTests
                        .Where(s => s.userName.Equals(userName) && s.password.Equals(password) & s.testStatus==true)
                        .ToList();

                if (data != null )
                {

                    

                    var test = db.tests.Find(data.FirstOrDefault().testId);
                    if (test != null)
                    {
                      //   var testStartDateTime = DateTime.ParseExact($"{test.testConductionDate.Value.Date} {test.startTime}", "dd/MM/yyyy HH:mm:ss", CultureInfo.CreateSpecificCulture("ur-PK"));
                       ///var testEndDateTime = DateTime.ParseExact($"{test.testConductionDate.Value.Date} {test.endTime}", "dd/MM/yyyy HH:mm:ss", CultureInfo.CreateSpecificCulture("ur-PK"));
                        var testStartDateTimestr = test.testConductionDate.Value.ToShortDateString() + " " + test.startTime;
                        var testStartDateTime = Convert.ToDateTime(testStartDateTimestr);
                        var testEndDateTimestrr = test.testConductionDate.Value.ToShortDateString() + " " + test.endTime;
                        var testEndDateTime = Convert.ToDateTime(testEndDateTimestrr);
                        // current time is within the start and end time of the test
                        if (DateTime.Now < testStartDateTime || DateTime.Now > testEndDateTime)
                        {
                            ViewBag.error = "Test date and time is over or has not started yet.";
                            return RedirectToAction("Login");
                        }

                        //  test has started
                        if (DateTime.Now >= testStartDateTime)
                        {
                            var graceTimeMinutes = Convert.ToDouble(test.graceTime);

                            var graceTime = TimeSpan.FromMinutes(graceTimeMinutes);
                            var testEndGracePeriodDateTime = testEndDateTime + graceTime;

                            // grace period has ended
                            if (DateTime.Now > testEndGracePeriodDateTime)
                            {
                                ViewBag.error = "Grace period for test has ended.";
                                return RedirectToAction("Login");
                            }

                            // Add session
                            Session["userName"] = data.FirstOrDefault().userName;
                            Session["password"] = data.FirstOrDefault().password;
                            Session["studentid"] = data.FirstOrDefault().studentId;
                            Session["testid"] = data.FirstOrDefault().testId;
                            Session["LoginRole"] = "student";
                            return RedirectToAction("testQuestion", "studTest");
                        }
                    }
                }

                ViewBag.error = "Login failed";
                return RedirectToAction("Login");
            }

            return View("Login");
        }



    }
}