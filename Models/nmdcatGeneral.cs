using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
namespace NMDCATEtestPreparatory.Models
{
    public class nmdcatGeneral
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();

        public List<SelectListItem> getStudentClass()
        {
            List<SelectListItem> qclass = new List<SelectListItem>();
            var studclass = (from c in db.classDomains
                            select new
                            {
                              c.classid,
                              c.classTitle
                            }).ToList();
            qclass = studclass.Select(z => new SelectListItem
            {
                Value = z.classid.ToString(),
                Text = z.classTitle
         

            }).ToList();
            return qclass;
        }

        public List<SelectListItem> getSubjects()
        {
            List<SelectListItem> sub = new List<SelectListItem>();
            var studSubj = (from s in db.subjects
                   select new
                   {
                       s.subjectid,
                       s.subjectTitle,
                      
                   }).ToList();
            sub = studSubj.Select(x => new SelectListItem
            {
                Value = x.subjectid.ToString(),
                Text = x.subjectTitle 
            }).ToList();

            return sub;
        }
        public List<SelectListItem> getActivetest()
        {
           
            List<SelectListItem> Atest = new List<SelectListItem>();
            var currentdate = System.DateTime.Now.Date;
          
            
            var studAddT = (from t in db.tests
                            where(t.testConductionDate>= currentdate)
                            select new
                            {
                                t.testId,
                                t.testTitle,
                            }).ToList();
                            
            
            Atest = studAddT.Select(y => new SelectListItem
            {
                Value = y.testId.ToString(),
                Text = y.testTitle,
            }).ToList();

            return Atest;
           
        }
        public List<SelectListItem> getqType()
        {
            List<SelectListItem> type = new List<SelectListItem>();
            var studqtype = (from q in db.questionTypeDomains
                             select new
                             {
                                 q.qType,
                                 q.typeTitle

                             }).ToList();
            type = studqtype.Select(q => new SelectListItem
            {
                Value = q.qType.ToString(),
                Text = q.typeTitle
            }).ToList();

            return type;
        }
    }
}