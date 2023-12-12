using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace NMDCATEtestPreparatory.Controllers
{

    public class LicenseController : Controller
    {
        private nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();

        // GET: License
        public ActionResult SendKey()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        public ActionResult registration(string key, model_key data)
        {
            ViewBag.Key = key;
            model_key k = new model_key();
            string key1 = key;
            string dencryptedKey = decodetext(key1);
            var keys = dencryptedKey.Replace('#', ',');
            var keysdata = keys.Split(',');
            k.currentDate = DateTime.Parse(keysdata[0]);
            k.currentTime = keysdata[1];
            k.expiryDate = Convert.ToDateTime(keysdata[2]);
            k.gracePeriod = keysdata[3];
            k.uptoDate = DateTime.Parse(keysdata[4]);

            tblAppLlicense table = new tblAppLlicense();

            var activeCheck = db.tblAppLlicenses.Where(x => x.isActive == true).ToList();
            var keyCheck = db.tblAppLlicenses.Where(x => x.licenseKey == key).FirstOrDefault();


            if ((keyCheck == null || activeCheck == null) && k.expiryDate >= k.currentDate)
            {

                if (activeCheck.Count > 0)
                {
                    foreach (var item in activeCheck)
                    {
                        item.isActive = false;
                        db.SaveChanges();
                    }
                }

                table.dateTimeInitiated = DateTime.Parse(k.currentTime);
                table.dateStampPrevious = k.currentDate;
                table.dateTimeLicenseExpire = k.expiryDate;
                table.gracePeriod = int.Parse(k.gracePeriod);
                table.uptoDate = k.uptoDate;
                table.timeStampPrevious = TimeSpan.Parse(k.currentTime);
                table.isActive = true;
                table.licenseKey = key;

                db.tblAppLlicenses.Add(table);
                db.SaveChanges();
            }
            return View();
        }

        [HttpPost]
        public ActionResult extractKey(string currentDate, DateTime? uptoDate, string currentTime, DateTime? expiryDate, string gracePeriod, string key)
        {
            model_key k = new model_key();

            k.currentDate = Convert.ToDateTime(currentDate, System.Globalization.CultureInfo.GetCultureInfo("ur-PK").DateTimeFormat);
            k.uptoDate = uptoDate;
            k.currentTime = currentTime;
            k.expiryDate = expiryDate;
            k.gracePeriod = gracePeriod;

            string date = DateTime.Now.ToString("yyyy-MM-dd");
            var licenseKey = (k.currentDate + "#" + k.currentTime + "#" + k.expiryDate + "#" + k.gracePeriod + "#" + k.uptoDate + "#");
            string encryptedKey = Encodetext(licenseKey);

            ViewBag.encryptedKey = encryptedKey;
            return View(k);

        }
        [HttpGet]
        public ActionResult extractKey()
        {
            model_key data = new model_key();
            ViewBag.encryptedKey = "";
            return View(data);
        }



        public class model_key
        {
            public DateTime? currentDate { get; set; }
            public DateTime? uptoDate { get; set; }
            public string currentTime { get; set; }
            public DateTime? expiryDate { get; set; }
            public string gracePeriod { get; set; }
            public string key { get; set; }
        }
        public static string Encodetext(string text)
        {
            try
            {
                byte[] encData_byte = new byte[text.Length];
                encData_byte = System.Text.Encoding.UTF8.GetBytes(text);
                string encodedData = Convert.ToBase64String(encData_byte);
                return encodedData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error in base64Encode" + ex.Message);
            }
        }
        public string decodetext(string text)
        {
            System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
            System.Text.Decoder utf8Decode = encoder.GetDecoder();
            byte[] todecode_byte = Convert.FromBase64String(text);
            int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            string result = new String(decoded_char);
            return result;
        }


        public ActionResult report()
        {
            var data = (from c in db.tblAppLlicenses
                        select new report_tbl
                        {
                            licienceId = c.licenseId.ToString(),
                            dateTimeInitiated = c.dateTimeInitiated,
                            uptoDate = c.uptoDate

                        }).ToList();
            ViewBag.Datalist = data;
            return View();
        }
        public class report_tbl
        {
            public string licienceId { get; set; }
            public DateTime? dateTimeInitiated { get; set; }
            public DateTime? uptoDate { get; set; }
        }



    }
}
    
