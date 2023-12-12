using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Globalization;


namespace NMDCATEtestPreparatory.Controllers
{
    public class testController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        // GET: student
        public ActionResult Index()
        {
            return View();
        }
        [Authorize(Roles = "User")]
        [HttpPost]
        public ActionResult Index(string testTitle, string startTime, string  endTime, string testConductionDate, int graceTime )
        {

            test tst = new test();
            tst.testTitle = testTitle;
            tst.startTime = startTime;
            CultureInfo culture = new CultureInfo("ur-PK");
            DateTime testConductionDateTime = DateTime.ParseExact(testConductionDate, "dd/MM/yyyy", culture );
            tst.testConductionDate = testConductionDateTime;
            tst.endTime = endTime;
            tst.graceTime = graceTime;
            db.tests.Add(tst);
           
            db.SaveChanges();
            return View("Index");

        }


    }
}
