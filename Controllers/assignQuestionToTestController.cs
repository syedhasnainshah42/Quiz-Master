using NMDCATEtestPreparatory.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace NMDCATEtestPreparatory.Controllers
{
    public class assignQuestionToTestController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        private nmdcatGeneral ng = new nmdcatGeneral();
        [Authorize(Roles = "UserR,User")]
        [HttpPost]
        public ActionResult loadQuestion(long qClass, int chapter, int sSubject, int testId)
        {
            List<long> testQuestionIds = new List<long>();


            var data = (from q in db.testQuestionDatabanks
                        where q.chapter == chapter && q.questionClassId == qClass && q.subjectId == sSubject
                        select new
                        {
                            Questionid = q.questionId,
                            QuestionTitle = q.questionTitle,
                            choiceA = q.choiceA,
                            choiceB = q.choiceB,
                            choiceC = q.choiceC,
                            choiceD = q.choiceD,
                            dup=db.testQuestions.Where(x=>x.questionId==q.questionId && x.testId==testId).Count()


                        }).ToList();
            foreach (var question in data)
            {
                testQuestionIds.Add(question.Questionid);
            }

            return Json(data, JsonRequestBehavior.AllowGet);

        }

        // GET: assignQuestionToTest
        [Authorize(Roles = "UserR,User")]
        [HttpGet]

        public ActionResult Index()
        {
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();
        }
        [Authorize(Roles = "UserR,User")]
        [HttpPost]
   public ActionResult Index(string selectedQuestions, int? studentId, long[] qid, int[] qmarks, string ttest, string questionClass, string sSubject)
        {
            //QuestionId Marks
            string jsonString = selectedQuestions;

            // Deserialize the JSON string into a list of QuestionModel objects
            List<SelectedQuestionData> questionList = JsonConvert.DeserializeObject<List<SelectedQuestionData>>(jsonString);

            //var a = selectedQuestions[0].QuestionId;
            long subjectId = Convert.ToInt64(sSubject);
            long questionClassId = Convert.ToInt64(questionClass);
            long testId = Convert.ToInt64(ttest);
            //    long chapter = Convert.ToInt64(chapter);

            foreach (var item in questionList)
            {
                testQuestion newQuestion = new testQuestion();
                newQuestion.questionId = item.QuestionId;
                newQuestion.marks = item.Marks;
                newQuestion.testId = testId;


                db.testQuestions.Add(newQuestion);
                db.SaveChanges();
            }

            //List<int> fairquestionmarks = new List<int>();
            //for (var j = 0; j < qmarks.Length; j++)
            //{
            //    if (qmarks[j] != 0)
            //    {
            //        fairquestionmarks.Add(qmarks[j]);
            //    }
            //}

            //var duplicateQuestions = new List<string>();
            //for (var i = 0; i < qid.Length; i++)
            //{
            //    long currentQuestionId = qid[i];
            //    bool questionExistsInTest = db.testQuestions.Any(tq => tq.testId == testId && tq.questionId == currentQuestionId);

            //    if (!questionExistsInTest)
            //    {
            //        testQuestion tq = new testQuestion();
            //        tq.questionId = currentQuestionId;
            //        tq.testId = testId;
            //        tq.marks = fairquestionmarks[i];

            //        db.testQuestions.Add(tq);
            //        db.SaveChanges();
            //    }
            //    else
            //    {
            //        duplicateQuestions.Add(currentQuestionId.ToString());
            //    }
            //}
            //var returnquestion = "";
            //foreach (var questionId in duplicateQuestions)
            //{
            //    returnquestion += questionId + ",";
            //}



            //db.testQuestionDatabanks.Add(DB);
            //db.SaveChanges();

            //save the data to test table as well
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            //string message = "Question " + returnquestion + " is already included in the test.";
            //if (returnquestion != "")
            //{
            //    return Content("<script language='javascript' type='text/javascript'>alert('" + message + "');</script>");
            //}
            return View();
        }
    }

    // Create a data model to represent the selected question data
    public class SelectedQuestionData
    {
        
        public int QuestionId { get; set; }
        public int Marks { get; set; }
    }

    public class QuestionEntity
    {
        public int QuestionId { get; set; }
        public int Marks { get; set; }
        // Add other properties for the database table
    }

}   


