﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Persistence.Entities
{
    public partial class StockDocumentLine
    {
        public StockDocumentLine()
        {
            StockMovement = new HashSet<StockMovement>();
        }

        public int Id { get; set; }
        public int IdStockDocument { get; set; }
        public double? ActualQuantity { get; set; }
        public double? ForecastQuantity { get; set; }
        public int IdItem { get; set; }
        public bool IsDeleted { get; set; }
        public int TransactionUserId { get; set; }
        public string DeletedToken { get; set; }
        public int? IdWarehouse { get; set; }
        public string Shelf { get; set; }
        public string Storage { get; set; }
        public double? ForecastQuantity2 { get; set; }

        public virtual Item IdItemNavigation { get; set; }
        public virtual StockDocument IdStockDocumentNavigation { get; set; }
        public virtual Warehouse IdWarehouseNavigation { get; set; }
        public virtual ICollection<StockMovement> StockMovement { get; set; }
    }
}