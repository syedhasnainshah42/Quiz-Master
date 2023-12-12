using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace NMDCATEtestPreparatory.Controllers
{
    [AllowAnonymous]
    public class staffLoginController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        // GET: staffLogin
        public ActionResult Index()
        {

            return View();
        }
        [HttpPost]
        
        public ActionResult Login(string userName, string userPassword)
        {
            if (ModelState.IsValid)
            {

                var data = db.Users.Where(s => s.userName.Equals(userName) && s.userPassword.Equals(userPassword)).ToList();
                if (data.Count() > 0)
                {
                    //add session
                   

                    Session["userName"] = data.FirstOrDefault().userName;
                    Session["password"] = data.FirstOrDefault().userPassword;
                    Session["userid"] = data.FirstOrDefault().userId;
                    Session["LoginRole"] = "Staff";

                    FormsAuthentication.SetAuthCookie(data.FirstOrDefault().userName, false);
                    return RedirectToAction("Employee", "Home");
                }
                else
                {
                    ViewBag.error = "Login failed";
                    return RedirectToAction("Login");
                }
            }
            return View("Login");

        }
        public ActionResult Logout()
        {
            Session.Clear();//remove session
            return RedirectToAction("Login");
        }
    }
}