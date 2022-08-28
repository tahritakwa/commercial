using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.Collections.Generic;

namespace Persistence.Audit
{
    public class TracabilityUtility
    {
        public static IList<AuditValues> OnBeforeSaveChanges(IList<EntityEntry> entitiesList)
        {
            IList<AuditValues> auditEntries = new List<AuditValues>();
            foreach (EntityEntry entityEntry in entitiesList)
            {
                if (entityEntry.State != EntityState.Unchanged)
                {
                    AuditValues auditEntry = new AuditValues
                    {
                        ServiceName = "COMMERCIAL",
                        TableName = entityEntry.Metadata.GetTableName()
                    };
                    bool softDelete = false;
                    if ((entityEntry.Metadata.FindProperty("IsDeleted") != null) && ((bool)entityEntry.CurrentValues["IsDeleted"]))
                        softDelete = true;

                    switch (entityEntry.State)
                    {
                        case EntityState.Added:
                            auditEntry.RequestType = "ADD";
                            break;
                        case EntityState.Modified:
                            {
                                if (softDelete)
                                    auditEntry.RequestType = "DELETE";
                                else
                                    auditEntry.RequestType = "UPDATE";
                                break;
                            }
                        case EntityState.Deleted:
                            auditEntry.RequestType = "DELETE";
                            break;
                        default:
                            auditEntry.RequestType = "";
                            break;
                    }

                    if (auditEntry.TableName == "Item")
                    {
                        MangeUpdateItem(entityEntry);
                    }
                    foreach (var property in entityEntry.Properties)
                    {
                        if (property.IsTemporary)
                        {
                            auditEntry.TemporaryProperties.Add(property);
                            continue;
                        }
                        if (property.Metadata.IsPrimaryKey())
                        {
                            auditEntry.KeyValues[property.Metadata.Name] = property.CurrentValue;
                        }
                        else
                        {
                            auditEntry.Values[property.Metadata.Name] = property.CurrentValue;
                        }
                    }
                    auditEntries.Add(auditEntry);
                }
            }
            return auditEntries;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="auditEntry"></param>
        public static void SetTemporaryProperties(AuditEntry auditEntry)
        {
            foreach (var auditValue in auditEntry.AuditValues)
            {
                foreach (var prop in auditValue.TemporaryProperties)
                {
                    if (prop.Metadata.IsPrimaryKey())
                    {
                        auditValue.KeyValues[prop.Metadata.Name] = prop.CurrentValue;
                    }
                    else
                    {
                        auditValue.Values[prop.Metadata.Name] = prop.CurrentValue;
                    }
                }
                auditValue.TemporaryProperties = null;
            }            
        }


        /// <summary>
        /// MangeUpdateItem for ecommerce
        /// </summary>
        /// <param name="entry"></param>
        private static void MangeUpdateItem(EntityEntry entry)
        {
            var now = DateTime.UtcNow;
            if (entry.State == EntityState.Modified)
            {
                bool isupdated = false;
                List<string> updatedProperty = new List<string> { "UnitHtsalePrice", "Description", "Code", "IsDeleted", "IsEcommerce", "TecDocId", "Oem" };
                foreach (var property in entry.Properties)
                {
                    string propertyName = property.Metadata.Name;
                    if (!Equals(property.CurrentValue, property.OriginalValue) && updatedProperty.Contains(propertyName))
                    {
                        isupdated = true;
                        break;
                    }

                    if (propertyName == "LastUpdateEcommerce" && entry.CurrentValues["LastUpdateEcommerce"] != null)
                    {
                        entry.CurrentValues["LastUpdateEcommerce"] = property.OriginalValue;
                    }
                }
                if (isupdated)
                {
                    entry.CurrentValues["LastUpdateEcommerce"] = now;
                }

            }
        }
    }
}
