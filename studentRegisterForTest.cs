//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace NMDCATEtestPreparatory
{
    using System;
    using System.Collections.Generic;
    
    public partial class studentRegisterForTest
    {
        public long srTestId { get; set; }
        public Nullable<long> studentId { get; set; }
        public Nullable<long> testId { get; set; }
        public string userName { get; set; }
        public string password { get; set; }
        public Nullable<bool> testStatus { get; set; }
        public string status { get; set; }
    
        public virtual student student { get; set; }
        public virtual test test { get; set; }
    }
}
