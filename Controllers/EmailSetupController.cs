using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NMDCATEtestPreparatory.Models;
using System.Net;
using System.Net.Mail;

namespace NMDCATEtestPreparatory.Controllers
{
    public class EmailSetupController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        // GET: EmailSetup
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [Obsolete]
        public ActionResult Index(NMDCATEtestPreparatory.Models.gmail model)
        {
            SendMail("Student", model.To);
            return View();
        }

        private void SendMail(string v, string to)
        {
            throw new NotImplementedException();
        }
        #region Email
        [Obsolete]
        public void SendMail(string email, string studentName, string userName, string password)
        {

            String mail = "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "  <head>\n" +
                "    <meta charset=\"UTF-8\" />\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n" +
                "    <title>Your Website - Contact Us</title>\n" +
                "    <style>\n" +
                "      /* Add your CSS styles here */\n" +
                "      * {\n" +
                "        box-sizing: border-box;\n" +
                "      }\n" +
                "      body {\n" +
                "        font-family: Arial, Helvetica, sans-serif;\n" +
                "        margin: 0;\n" +
                "        padding: 0;\n" +
                "      }\n" +
                "      .container {\n" +
                "        max-width: 600px;\n" +
                "        margin: 0 auto;\n" +
                "        background-color: #ffffff;\n" +
                "        border-radius: 10px;\n" +
                "        overflow: hidden;\n" +
                "        box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.1);\n" +
                "      }\n" +
                "      .header {\n" +
                "        background-color: #f5f5f5;\n" +
                "        padding: 20px;\n" +
                "        text-align: center;\n" +
                "      }\n" +
                "      .header h1 {\n" +
                "        font-size: 32px;\n" +
                "        margin: 0;\n" +
                "      }\n" +
                "      .main {\n" +
                "        padding: 20px;\n" +
                "      }\n" +
                "      .main p {\n" +
                "        font-size: 16px;\n" +
                "        line-height: 1.5;\n" +
                "        margin-bottom: 20px;\n" +
                "      }\n" +
                "      .main a {\n" +
                "        background-color: #00bfff;\n" +
                "        border-radius: 5px;\n" +
                "        color: #ffffff;\n" +
                "        display: inline-block;\n" +
                "        font-size: 18px;\n" +
                "        padding: 10px 20px;\n" +
                "        text-decoration: none;\n" +
                "      }\n" +
                "      .main a:hover {\n" +
                "        background-color: #0080ff;\n" +
                "      }\n" +
                "      .footer {\n" +
                "        background-color: #f5f5f5;\n" +
                "        color: #999999;\n" +
                "        font-size: 14px;\n" +
                "        padding: 20px;\n" +
                "        text-align: center;\n" +
                "      }\n" +
                "    </style>\n" +
                "  </head>\n" +
                "  <body>\n" +
                "    <div class=\"container\">\n" +
               "<div class=\"header\">\n" +
             "  <h1>Contact Us</h1>\n" +
             "</div>\n" +
             "<div class=\"main\">\n" +
             "  <p>Dear " + studentName + ",</p>\n" +
             "  <p>Your UserName : " + userName + "</p>\n" +
             "  <p>Your Password : " + password + "</p>\n" +
             "  <p>Thank you for contacting us. We have received your inquiry and will do our best to assist you as soon as possible.</p>\n" +
             "  <p>If you have any further questions, please do not hesitate to contact us by +923069881188</p>\n" +
             //"  <p><a href=\"#\">Contact Us</a></p>\n" +
             "</div>\n" +
             "<div class=\"footer\">\n" +
             "  <p>This email was sent to you from Your Website. To unsubscribe from our emails, please click <a href=\"#\">here</a>.</p>\n" +
             "</div>\n" +
             "</div>\n" +
             "</body>\n" +
             "</html>";
            //from,to,subject,body
            MailMessage mymail = new MailMessage("knain9292@gmail.com", email, "Quiz Master", mail);
            mymail.IsBodyHtml = true;
            string EmailProvider = "smtp.gmail.com";
            var client = new SmtpClient(EmailProvider, 587)
            {
                Credentials = new NetworkCredential("knain9292@gmail.com", "dcsglanqyeefkpun"),
                EnableSsl = true,
            };
            try
            {
                //client.UseDefaultCredentials = true;
                client.Send(mymail);
                TempData["msg"] = "send";
            }
            catch (Exception ex)
            {
                Response.Write(ex);
                TempData["msg"] = ex.Message.ToString();
            }
        }

        #endregion
    }
}