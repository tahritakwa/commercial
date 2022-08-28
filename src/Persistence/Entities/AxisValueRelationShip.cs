﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    /// <summary>
    /// This table defines relationship between axis values
    /// </summary>
    public partial class AxisValueRelationShip
    {
        /// <summary>
        /// AxisRelationShip identifier
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Axis value identifier
        /// </summary>
        public int IdAxisValue { get; set; }
        /// <summary>
        /// Parent identifier
        /// </summary>
        public int IdAxisValueParent { get; set; }
        public int? TransactionUserId { get; set; }
        public bool IsDeleted { get; set; }
        public string DeletedToken { get; set; }

        public virtual AxisValue IdAxisValueNavigation { get; set; }
        public virtual AxisValue IdAxisValueParentNavigation { get; set; }
    }
}