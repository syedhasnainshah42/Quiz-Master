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
    
    public partial class studentAppearTest
    {
        public long studentAppearId { get; set; }
        public Nullable<long> testId { get; set; }
        public Nullable<long> studentId { get; set; }
        public Nullable<long> questionId { get; set; }
        public string correctChoice { get; set; }
    
        public virtual student student { get; set; }
        public virtual test test { get; set; }
        public virtual testQuestionDatabank testQuestionDatabank { get; set; }
    }
}
