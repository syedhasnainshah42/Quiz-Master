using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using static System.Net.Mime.MediaTypeNames;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Rotativa;
using Rotativa.Options;
using System.IO;
using iTextSharp.text.html.simpleparser;
using System.Net;
using System.Net.Mail;



namespace NMDCATEtestPreparatory.Controllers
{

    public class studTestController : Controller
    {

        // public static long studentid = Convert.ToInt64(Session["studentid"].ToString());
        // public static long testid = 1;

        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        private EmailService emailService = new EmailService();

        public studTestController()
        {
            db.Configuration.ProxyCreationEnabled = false;
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult testQuestion()
        {
            var studentid = Convert.ToInt64(Session["studentid"].ToString());
            var testId = Convert.ToInt32(Session["testid"].ToString());
            ViewBag.studentid = studentid;
            ViewBag.testId =testId;
            var teststatus = db.studentRegisterForTests.Where(x => x.studentId == studentid && x.testId == testId&& x.status=="Submitted").FirstOrDefault();
            if (teststatus != null)
            {
                return Redirect("resultview");
            }
                return View();
        }


        [HttpGet]
        public ActionResult allQuestions()
        {
            var result = db.testQuestionDatabanks.Select(x => x.questionId).ToList();

            if (result.Count() > 0)
            {
                return Json(result, JsonRequestBehavior.AllowGet);

            }
            else
            {
                return Json("end", JsonRequestBehavior.AllowGet);

            }
        }




        [HttpGet]

        public ActionResult loadFirstQuestion()
        {
            long studID = Convert.ToInt64(Session["studentid"].ToString());
            long testID = Convert.ToInt32(Session["testid"].ToString());

            try
            {
                //var result = db.testQuestionDatabanks.FirstOrDefault();
                //var allQid = db.testQuestionDatabanks.Select(x => x.questionId).Where(x.).ToList();

                var studentid = Convert.ToInt64(Session["studentid"].ToString());
                var onlyQuestion = (from st in db.studentRegisterForTests
                                    join tq in db.testQuestions on st.testId equals tq.testId
                                    join td in db.testQuestionDatabanks on tq.questionId equals td.questionId
                                    where (tq.testId == testID && st.studentId == studentid)
                                    select new
                                    {
                                        qid = td.questionId,
                                        title = td.questionTitle,
                                        markChoices = td.correctChoice,
                                        cA = td.choiceA,
                                        cB = td.choiceB,
                                        cC = td.choiceC,
                                        cD = td.choiceD,
                                    }).ToList();
                var allQid = onlyQuestion.Select(x => x.qid).ToList();
                var firstQ = allQid.FirstOrDefault();

                if (onlyQuestion != null)
                {
                    return Json(new { onlyQuestion, allQid }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { data = "Error" }, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception)
            {
                return Json("end", JsonRequestBehavior.AllowGet);
            }
        }



        [HttpPost]
        public ActionResult questionById(int? qid, string radioChoice, int nextQ)
        {
            int t = Convert.ToInt32(Session["testid"].ToString());
            var studentid = Convert.ToInt64(Session["studentid"].ToString());

            #region Question Save/Update
            var studAlreadyRec = db.studentAppearTests.Where(x => x.testId == t && x.studentId == studentid && x.questionId == qid).FirstOrDefault();
            if (studAlreadyRec != null)
            {

                studAlreadyRec.testId = Convert.ToInt32(Session["testid"].ToString());
                studAlreadyRec.studentId = studentid;
                studAlreadyRec.questionId = qid;
                studAlreadyRec.correctChoice = radioChoice;

                db.SaveChanges();


            }
            else
            {

                if (radioChoice != "")
                {
                    //save
                    studentAppearTest student = new studentAppearTest();
                    student.testId = Convert.ToInt32(Session["testid"].ToString());
                    student.studentId = studentid;
                    student.questionId = qid;
                    student.correctChoice = radioChoice;

                    db.studentAppearTests.Add(student);
                    db.SaveChanges();

                }
            }
            #endregion

            #region load new Question

            var onlyQuestion = (from td in db.testQuestionDatabanks
                                join sd in db.studentAppearTests on td.questionId equals sd.questionId
                                where (sd.questionId == nextQ && sd.testId == t && sd.studentId == studentid)
                                select new
                                {
                                    qid = td.questionId,
                                    title = td.questionTitle,
                                    markChoices = sd.correctChoice,
                                    cA = td.choiceA,
                                    cB = td.choiceB,
                                    cC = td.choiceC,
                                    cD = td.choiceD,
                                }).FirstOrDefault();

            if (onlyQuestion != null)
            {
                return Json(new { data = onlyQuestion }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                onlyQuestion = (from td in db.testQuestionDatabanks
                                where (td.questionId == nextQ)
                                select new
                                {
                                    qid = td.questionId,
                                    title = td.questionTitle,
                                    markChoices = "",
                                    cA = td.choiceA,
                                    cB = td.choiceB,
                                    cC = td.choiceC,
                                    cD = td.choiceD,
                                }).FirstOrDefault();
                return Json(new { data = onlyQuestion }, JsonRequestBehavior.AllowGet);
            }

            #endregion
        }


        [HttpGet]
        public ActionResult questionDropdown(int? qid, int nextQ)
        {
            var DropData = db.testQuestionDatabanks.Where(x => x.questionId == qid).FirstOrDefault();
            var studentid = Convert.ToInt64(Session["studentid"].ToString());

            int t = Convert.ToInt32(Session["testid"].ToString());

            var DropDownQues = (from td in db.testQuestionDatabanks
                                join sd in db.studentAppearTests on td.questionId equals sd.questionId
                                where (sd.questionId == nextQ && sd.testId == t && sd.studentId == studentid)
                                select new
                                {
                                    qid = td.questionId,
                                    title = td.questionTitle,
                                    markChoices = sd.correctChoice,
                                    cA = td.choiceA,
                                    cB = td.choiceB,
                                    cC = td.choiceC,
                                    cD = td.choiceD,
                                }).FirstOrDefault();

            if (DropDownQues != null)
            {
                return Json(new { data = DropDownQues }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                DropDownQues = (from td in db.testQuestionDatabanks
                                where (td.questionId == nextQ)
                                select new
                                {
                                    qid = td.questionId,
                                    title = td.questionTitle,
                                    markChoices = "",
                                    cA = td.choiceA,
                                    cB = td.choiceB,
                                    cC = td.choiceC,
                                    cD = td.choiceD,
                                }).FirstOrDefault();

                return Json(new { data = DropDownQues }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public ActionResult questionSkip(int qid)
        {
            var QuesData = db.testQuestionDatabanks.Where(x => x.questionId == qid).FirstOrDefault();

            if (QuesData != null)
            {
                return Json(new
                {
                    allQuestion = QuesData,
                }, JsonRequestBehavior.AllowGet);

            }
            else
            {
                return Json("end", JsonRequestBehavior.AllowGet);

            }
        }


        [HttpGet]
        public ActionResult resultview()
        {

            var studentid = Convert.ToInt64(Session["studentid"].ToString());

            int tId = Convert.ToInt32(Session["testid"].ToString());
            int sId = Convert.ToInt32(studentid);

            var studentInfo = db.students.FirstOrDefault(s => s.studentId == studentid);

            model_StndData studentData = new model_StndData
            {
                studentId = studentInfo.studentId,
                studentName = studentInfo.studentName,
                studentFName = studentInfo.studentFName,
                DOB = studentInfo.DOB,
                email = studentInfo.email,
                contact = studentInfo.contact,
                gender = studentInfo.gender.ToString(),
                studentPicture = studentInfo.studentPicture,

            };
            int obtMarks = 0;
            int totlMarks = 0;
            int numberOfAttempQuestion = 0;
            var resultData = (from sa in db.studentAppearTests
                              join tq in db.testQuestions on sa.questionId equals tq.questionId
                              join tqDB in db.testQuestionDatabanks on sa.questionId equals tqDB.questionId
                              where (sa.testId == tId && sa.studentId == sId && sa.correctChoice != null)
                              select new
                              {
                                  qid = sa.questionId,
                                  studCorrectChoice = sa.correctChoice,
                                  questionMarks = tq.marks,
                                  orgCorrectChoice = tqDB.correctChoice,
                              }).Distinct().ToList();

            if (resultData != null)
            {
                numberOfAttempQuestion = resultData.Count();

                foreach (var i in resultData)
                {
                    totlMarks = totlMarks + Convert.ToInt16(i.questionMarks);

                    if (i.studCorrectChoice == i.orgCorrectChoice)
                    {
                        obtMarks = obtMarks + Convert.ToInt16(i.questionMarks);
                        totlMarks = totlMarks + Convert.ToInt16(i.questionMarks);
                    }
                }
            }
            // var obtmarks= 
            //ViewBag.numberOfAttempQuestion = numberOfAttempQuestion;
            var totalQuestion = db.testQuestions.Where(x => x.testId == tId).Count();
            ViewBag.numberOfAttempQuestion = totalQuestion;
            var PerQuestionmarks = db.testQuestions.Where(x => x.testId == tId).FirstOrDefault().marks;
            ViewBag.obtMarks = obtMarks;
            ViewBag.totlMarks = totalQuestion * PerQuestionmarks;

            return View(studentData);
        }

        public class model_StndData
        {
            public long studentId { get; set; }
            public string studentName { get; set; }
            public string studentFName { get; set; }
            public string gender { get; set; }
            public DateTime? DOB { get; set; }
            public string email { get; set; }
            public string contact { get; set; }
            public string studentPicture { get; set; }
        }

        [HttpGet]
        public ActionResult result()
        {
            var studentid = Convert.ToInt64(Session["studentid"].ToString());

            int tId = Convert.ToInt32(Session["testid"].ToString());
            var teststatus = db.studentRegisterForTests.Where(x => x.studentId == studentid && x.testId == tId).FirstOrDefault();
            if (teststatus != null)
            {
                teststatus.status = "Submitted";
                db.SaveChanges();
            }
            int sId = Convert.ToInt32(studentid);
            int obtMarks = 0;
            int totlMarks = 0;
            int numberOfAttempQuestion = 0;
            var resultData = (
                                from sa in db.studentAppearTests
                                join tq in db.testQuestions on sa.questionId equals tq.questionId
                                join tqDB in db.testQuestionDatabanks on sa.questionId equals tqDB.questionId
                                where (sa.testId == tId && sa.studentId == sId && sa.correctChoice != null)

                                select new
                                {
                                    qid = sa.questionId,
                                    studCorrectChoice = sa.correctChoice,
                                    questionMarks = tq.marks,
                                    orgCorrectChoice = tqDB.correctChoice,
                                }).ToList();

            if (resultData != null)
            {
                numberOfAttempQuestion = resultData.Count();
                foreach (var i in resultData)
                {
                    totlMarks = totlMarks + Convert.ToInt16(i.questionMarks);

                    if (i.studCorrectChoice == i.orgCorrectChoice)
                    {
                        obtMarks = obtMarks + Convert.ToInt16(i.questionMarks);
                        // totlMarks = totlMarks + Convert.ToInt16(i.questionMarks);
                    }
                }
            }



            return Json(new { numberOfAttempQuestion, obtMarks, totlMarks }, JsonRequestBehavior.AllowGet);
        }

        private string RenderRazorViewToString(string viewName, object model)
        {
            ViewData.Model = model;
            using (var sw = new StringWriter())
            {
                var viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                var viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);
                viewResult.ViewEngine.ReleaseView(ControllerContext, viewResult.View);
                return sw.GetStringBuilder().ToString();
            }
        }
        public ActionResult GeneratePdf(int obtMarks, int numberOfAttempQuestion, int totlMarks)
        {
            // Create a new document
            Document document = new Document();
            MemoryStream memoryStream = new MemoryStream();
            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

            // Open the document for writing
            document.Open();
            var studentid = Convert.ToInt64(Session["studentid"].ToString());
            // Retrieve student data
            model_StndData studentData = GetStudentData(studentid); // Define a method to retrieve student data

            // Add content to the PDF
            Paragraph title = new Paragraph("Test Result");
            title.Alignment = Element.ALIGN_CENTER;
            document.Add(title);

            // Add student information
            Paragraph studentInfo = new Paragraph($"Student Name: {studentData.studentName}");
            studentInfo.SpacingBefore = 10f;
            document.Add(studentInfo);

            Paragraph studentFName = new Paragraph($"Father's Name: {studentData.studentFName}");
            studentFName.SpacingBefore = 10f;
            document.Add(studentFName);

            Paragraph dob = new Paragraph($"Date of Birth: {studentData.DOB.ToString()}");
            dob.SpacingBefore = 10f;
            document.Add(dob);

            Paragraph email = new Paragraph($"Email: {studentData.email}");
            email.SpacingBefore = 10f;
            document.Add(email);

            Paragraph contact = new Paragraph($"Contact: {studentData.contact}");
            contact.SpacingBefore = 10f;
            document.Add(contact);

            string genderText = studentData.gender == "1" ? "Male" : "Female";
            Paragraph gender = new Paragraph($"Gender: {genderText}");
            gender.SpacingBefore = 10f;
            document.Add(gender);

            // Assuming studentData.studentPicture is a byte array containing the image data
          //  if (studentData.studentPicture != null && studentData.studentPicture.Length > 0)
          //  {
          //      // Create an iTextSharp Image object
          ////      iTextSharp.text.Image studentImage = iTextSharp.text.Image.GetInstance(studentData.studentPicture);
          //      float x = 100f; // Adjust the value for the horizontal position
          //      float y = 500f; // Adjust the value for the vertical position

          //      // Set the width and height of the image
          //      float width = 200f; // Adjust the width as needed
          //      float height = 150f; // Adjust the height as needed

          //      // Set the position, width, and height of the image
          //      studentImage.SetAbsolutePosition(x, y); // Set the coordinates (x, y) where you want the image
          //      studentImage.ScaleAbsolute(width, height); // Set the width and height of the image

          //      // Add the image to the document
          //      document.Add(studentImage);
          //  }


            Paragraph resultInfo = new Paragraph($"Obtained Marks: {obtMarks}");
            document.Add(resultInfo);

            Paragraph attemptedQuestionsInfo = new Paragraph($"Attempted Questions: {numberOfAttempQuestion}");
            document.Add(attemptedQuestionsInfo);

            Paragraph totalMarksInfo = new Paragraph($"Total Marks: {totlMarks}");
            document.Add(totalMarksInfo);


            // ... Add other content as needed ...

            // Close the document
            document.Close();

            // Set the content type and file name
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=TestResult.pdf");

            // Write the PDF data to the response
            Response.OutputStream.Write(memoryStream.GetBuffer(), 0, memoryStream.GetBuffer().Length);
            Response.OutputStream.Flush();
            Response.OutputStream.Close();

           SendMail(studentData.email, studentData.studentName, "knain9292@gmail.com", "dcsglanqyeefkpun");
            return new EmptyResult();
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
            MailMessage mymail = new MailMessage("knain9292@gmail.com", email, "Cr", mail);
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

        private model_StndData GetStudentData(long  studentid)
        {


            var studentInfo = db.students.FirstOrDefault(s => s.studentId==studentid);


            model_StndData studentData = new model_StndData
            {
                studentId = studentInfo.studentId,
                studentName = studentInfo.studentName,
                studentFName = studentInfo.studentFName,
                DOB = studentInfo.DOB,
                email = studentInfo.email,
                contact = studentInfo.contact,
                gender = studentInfo.gender.ToString(),
                studentPicture = studentInfo.studentPicture,
            };

            return studentData;
        }

        private object GetResultData()
        {
            // Query the database to retrieve result data
            var studentid = Convert.ToInt64(Session["studentid"].ToString());
            int tId = Convert.ToInt32(Session["testid"].ToString());
            int sId = Convert.ToInt32(studentid);

            var resultData = (
                from sa in db.studentAppearTests
                join tq in db.testQuestions on sa.questionId equals tq.questionId
                join tqDB in db.testQuestionDatabanks on sa.questionId equals tqDB.questionId
                where (sa.testId == tId && sa.studentId == sId && sa.correctChoice != null)
                select new
                {
                    qid = sa.questionId,
                    studCorrectChoice = sa.correctChoice,
                    questionMarks = tq.marks,
                    orgCorrectChoice = tqDB.correctChoice,
                }).ToList();

            int numberOfAttempQuestion = resultData.Count();
            int obtMarks = 0;
            int totlMarks = 0;

            foreach (var i in resultData)
            {
                totlMarks = totlMarks + Convert.ToInt16(i.questionMarks);

                if (i.studCorrectChoice == i.orgCorrectChoice)
                {
                    obtMarks = obtMarks + Convert.ToInt16(i.questionMarks);
                }
            }

            // Create an object to store the result data
            var resultDataObject = new
            {
                numberOfAttempQuestion,
                obtMarks,
                totlMarks
            };

            return resultDataObject;
        }
    }
}

