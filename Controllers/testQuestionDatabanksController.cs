using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using NMDCATEtestPreparatory.Models;

namespace NMDCATEtestPreparatory.Controllers
{
    public class testQuestionDatabanksController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
        private nmdcatGeneral ng = new nmdcatGeneral();
        //GET: testQuestionDatabanks

        [Authorize(Roles = "User")]
        [HttpGet]
        public ActionResult Index()
        {
            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();
        }

        [Authorize(Roles = "User")]
        [ValidateInput(false)]
        [HttpPost]
        public ActionResult Index(string questionTitle, string choiceA, string choiceB,
            string choiceC, string choiceD, string questionClass, string sSubject,
            string correctChoice,string description, int chapter,
            string ttest, string questionType, string correctChoiceForAll)
        {
          long qType = Convert.ToInt64(questionType);
            long subjectId =Convert.ToInt64( sSubject);
        long questionClassId = Convert.ToInt64(questionClass);
            long testId = Convert.ToInt64(ttest);
            testQuestionDatabank DB = new testQuestionDatabank();
            DB.questionTitle = questionTitle;
            DB.choiceA = choiceA;
            DB.choiceB = choiceB;
            DB.choiceC = choiceC;
            DB.choiceD = choiceD;
            DB.subjectId = subjectId;
            DB.questionClassId = questionClassId;
            DB.correctChoice = correctChoice;
            
            DB.description = description;
            DB.chapter = chapter;
            DB.qType = Convert.ToInt32(qType);
            DB.correctChoiceForAll = correctChoiceValue(choiceA, choiceB, choiceC, choiceD, correctChoice);

            db.testQuestionDatabanks.Add(DB);
            db.SaveChanges();

            //save the data to test table as well
            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();

        }
        [Authorize(Roles = "User")]
        public string correctChoiceValue(string A, string B, string C, string D, string correctChoice)
        {
            string strCorrectChoice = "";
            if (correctChoice == "A")
            {
                strCorrectChoice = A;
            }
            else if (correctChoice == "B")
            {
                strCorrectChoice = B;

            }
            else if(correctChoice=="C")
            {
                strCorrectChoice = C;

            }
            else if(correctChoice=="D")
            {
                strCorrectChoice = D;

            }
            return strCorrectChoice;
        }
        [Authorize(Roles = "User")]
        [HttpGet]
        public ActionResult fillBlanks()
        {
            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();
        }
        [Authorize(Roles = "User")]
        [HttpPost]
        public ActionResult fillBlanks(string questionTitle, string questionClass, string sSubject, string correctChoice,string description, 
            int chapter, string ttest, string questionType, string blankChoice, string correctChoiceForAll)
        {
          long qType = Convert.ToInt64(questionType);
            long subjectId = Convert.ToInt64(sSubject);
            long questionClassId = Convert.ToInt64(questionClass);
            long testId = Convert.ToInt64(ttest);
            testQuestionDatabank DB = new testQuestionDatabank();
            DB.questionTitle = questionTitle;
            DB.subjectId = subjectId;
            DB.questionClassId = questionClassId;
            DB.correctChoice = correctChoice;
            DB.description = description;
            DB.chapter = chapter;
            DB.qType = Convert.ToInt32(qType);
            //DB.blankChoice = blankChoice;
        //   DB.correctChoiceForAll = correctChoiceForAll;
            if (qType == 3)
            {
                DB.correctChoiceForAll = blankChoice;
            }
           
            db.testQuestionDatabanks.Add(DB);
            db.SaveChanges();


            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();

          
        }
        [Authorize(Roles = "User")]
        [HttpGet]
        public ActionResult trueFalse()
        {
            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();
        }
        [Authorize(Roles = "User")]
        [HttpPost]
        public ActionResult trueFalse(string questionTitle, string questionClass, string sSubject,
            string correctChoice, string description,
            int chapter, string ttest, string questionType, string correctChoiceForAll, string tfChoice)
        {
            long qType = Convert.ToInt64(questionType);
            long subjectId = Convert.ToInt64(sSubject);
            long questionClassId = Convert.ToInt64(questionClass);
            bool tfChoiceSave;
            long testId = Convert.ToInt64(ttest);
            testQuestionDatabank DB = new testQuestionDatabank();
            DB.questionTitle = questionTitle;
            DB.subjectId = subjectId;
            DB.questionClassId = questionClassId;
            DB.correctChoice = correctChoice;
            DB.description = description;
            DB.chapter = chapter;
            DB.qType = Convert.ToInt32(qType);
            if (tfChoice == "True")
            {
                tfChoiceSave = true;

            }
            else 
            {
                tfChoiceSave = false;
            }
          //  DB.tfChoice = tfChoiceSave;
            if (qType == 2)
            {
                correctChoiceForAll = tfChoiceSave.ToString();
            }
            DB.correctChoiceForAll = correctChoiceForAll;

            db.testQuestionDatabanks.Add(DB);
            db.SaveChanges();

            ViewBag.questionType = ng.getqType();
            ViewBag.questionClass = ng.getStudentClass();
            ViewBag.sSubject = ng.getSubjects();
            ViewBag.ttest = ng.getActivetest();
            return View();
        }
    }

}