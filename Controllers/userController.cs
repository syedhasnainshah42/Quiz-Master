using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NMDCATEtestPreparatory.Controllers
{
    public class userController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();

        // GET: user
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult PasswordReset()
        {
            return View();
        }
        [HttpPost]


        public ActionResult ChangePassword(string OldPassword, string NewPassword, string ConfirmPassword)
        {
            if (string.IsNullOrEmpty(OldPassword) || string.IsNullOrEmpty(NewPassword) || string.IsNullOrEmpty(ConfirmPassword))
            {
                return View("ChangePassword", "All fields are required.");
            }

            var user = db.Users.Where(u => u.userPassword == OldPassword).FirstOrDefault();
            if (user != null)
            {
                // Update the user's password in the database
                user.userPassword = NewPassword;
                db.SaveChanges();
                return RedirectToAction("PasswordReset", "user");
            }
            return View("ChangePassword", "Incorrect current password.");


        }
      



    }
}