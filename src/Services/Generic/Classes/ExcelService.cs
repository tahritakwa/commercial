using ExcelDataReader;
using OfficeOpenXml;
using Services.Generic.Interfaces;
using Settings.Exceptions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using Utils.Constants;
using Utils.Enumerators;
using Utils.Utilities.PredicateUtilities;

namespace Services.Generic.Classes
{
    public abstract partial class GenericService<TModel, TEntity>
    where TEntity : class where TModel : class
    {
        /// <summary>
        /// Name of the column that to compare unicity (of any column) in DB without taking the line of this column
        /// </summary>
        private static string _identificationColumn;

        /// <summary>
        /// Get Model List From Excel file changing the Check Unicity Column Name
        /// </summary>
        /// <param name="excelDataStream"></param>
        /// <param name="service"></param>
        /// <returns></returns>
        public virtual IList<TModel> GetModelListFromExcel(Stream excelDataStream,
            string identificationColumn, List<string> excelColumnsName, int index)
        {
            _identificationColumn = identificationColumn;
            return GetModelListFromExcelOrCSVFile(excelDataStream, false, excelColumnsName, index);
        }
        /// <summary>
        /// Get Model List From Csv file changing the Check Unicity Column Name
        /// </summary>
        /// <param name="excelDataStream"></param>
        /// <param name="service"></param>
        /// <param name="identificationColumn"></param>
        /// <returns></returns>
        public virtual IList<TModel> GetModelListFromCSV(Stream excelDataStream, IService<TModel, TEntity> service,
            string identificationColumn, List<string> excelColumnsName, int index = 0)
        {
            _identificationColumn = identificationColumn;
            return GetModelListFromExcelOrCSVFile(excelDataStream, true, excelColumnsName, index);
        }
        /// <summary>
        /// Get Model List From Excel or Csv file
        /// </summary>
        /// <param name="excelDataStream"></param>
        /// <param name="service"></param>
        /// <param name="isCSV"></param>
        /// <returns></returns>
        public virtual IList<TModel> GetModelListFromExcelOrCSVFile(Stream excelDataStream, bool isCSV, List<string> excelColumnsName, int index)
        {
            List<TModel> tModelList;
            IExcelDataReader excelReader;

            if (isCSV)
            {
                try
                {
                    //  - CSV files
                    excelReader = ExcelReaderFactory.CreateCsvReader(excelDataStream);
                }
                catch
                {
                    // if Not csv file try with excel
                    // Auto-detect format, supports:
                    //  - Binary Excel files (2.0-2003 format; *.xls)
                    //  - OpenXml Excel files (2007 format; *.xlsx)
                    excelReader = ExcelReaderFactory.CreateReader(excelDataStream);
                }
            }
            else
            {
                try
                {
                    // Auto-detect format, supports:
                    //  - Binary Excel files (2.0-2003 format; *.xls)
                    //  - OpenXml Excel files (2007 format; *.xlsx)
                    excelReader = ExcelReaderFactory.CreateReader(excelDataStream);
                }
                catch
                {
                    // if Not excel file try with csv
                    //  - CSV files
                    excelReader = ExcelReaderFactory.CreateCsvReader(excelDataStream);
                }
            }

            // DataSet - Create column names from first row
            var result = excelReader.AsDataSet(new ExcelDataSetConfiguration()
            {
                ConfigureDataTable = (_) => new ExcelDataTableConfiguration()
                {
                    UseHeaderRow = true
                }
            });

            tModelList = DataTableToModelList(result.Tables[index], excelColumnsName);
            return tModelList;

        }
        /// <summary>
        /// DataTable To ModelList
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public virtual List<TModel> DataTableToModelList(DataTable table, List<string> excelColumnsName)
        {
            IList<PropertyInfo> properties = typeof(TModel).GetProperties().ToList();
            properties = properties.Where(x => table.Columns.Contains(x.Name)).ToList();
            List<TModel> result = new List<TModel>();
            table.Rows.RemoveAt(0);
            if (!IsvalidFormat(properties, table))
            {
                throw new CustomException(CustomStatusCode.InvalidExcelFormat);
            }
            int excelRowNumber = ExcelConstants.EXCEL_FIRST_DATA_LINE_NUMBER;
            foreach (var row in table.Rows)
            {
                var item = CreateModelFromDataRow(table, (DataRow)row, properties, excelRowNumber, excelColumnsName);
                result.Add(item);
                excelRowNumber++;
            }

            return result;
        }
        /// <summary>
        /// Verifiy if Is Valid Email
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        private static bool IsValidEmail(string inputEmail)
        {
            string email = inputEmail;
            if (string.IsNullOrWhiteSpace(email))
            {
                return false;
            }
            try
            {
                // Normalize the domain
                email = Regex.Replace(email, @"(@)(.+)$", DomainMapper,
                                      RegexOptions.None, TimeSpan.FromMilliseconds(200));

                // Examines the domain part of the email and normalizes it.
                string DomainMapper(Match match)
                {
                    // Use IdnMapping class to convert Unicode domain names.
                    var idn = new IdnMapping();

                    // Pull out and process domain name (throws ArgumentException on invalid)
                    var domainName = idn.GetAscii(match.Groups[2].Value);

                    return match.Groups[1].Value + domainName;
                }
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
            catch (ArgumentException)
            {
                return false;
            }
            try
            {
                return Regex.IsMatch(email,
                    @"^(?("")("".+?(?<!\\)""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                    @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-0-9a-z]*[0-9a-z]*\.)+[a-z0-9][\-a-z0-9]{0,22}[a-z0-9]))$",
                    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
        }

        /// <summary>
        /// Create Model From DataRow
        /// </summary>
        /// <param name="table"></param>
        /// <param name="row"></param>
        /// <param name="properties"></param>
        /// <param name="excelRowNumber"></param>
        /// <returns></returns>
        public virtual TModel CreateModelFromDataRow(DataTable table, DataRow row, IList<PropertyInfo> properties, int excelRowNumber, List<string> excelColumnsName)
        {
            TModel myModel = (TModel)Activator.CreateInstance(typeof(TModel));
            foreach (var property in properties)
            {
                try
                {
                    if(excelRowNumber == ExcelConstants.EXCEL_FIRST_DATA_LINE_NUMBER)
                    {
                        excelColumnsName.Add(property.Name);
                    }
                    VerifyIsValidEmailIfEmail(row, property, excelRowNumber);
                    VerifyUnicityIfUnique(table, row, property, excelRowNumber);
                    dynamic propretyValue;
                    if (string.IsNullOrWhiteSpace(row[property.Name].ToString()))
                    {
                        row[property.Name] = "";
                        VerifyRequirment(property, excelRowNumber);
                        property.SetValue(myModel, null, null);
                    }
                    else if ((property.PropertyType == typeof(int?)) || (property.PropertyType == typeof(int)))
                    {
                        propretyValue = int.Parse(row[property.Name].ToString());
                        property.SetValue(myModel, propretyValue, null);
                    }
                    else if ((property.PropertyType == typeof(double?)) || (property.PropertyType == typeof(double)))
                    {
                        propretyValue = double.Parse(row[property.Name].ToString());
                        property.SetValue(myModel, propretyValue, null);
                    }
                    else if ((property.PropertyType == typeof(bool?)) || (property.PropertyType == typeof(bool)))
                    {
                        propretyValue = bool.Parse(ReplaceStringByBoolString(row[property.Name].ToString()));
                        property.SetValue(myModel, propretyValue, null);
                    }
                    else if ((property.PropertyType == typeof(DateTime?)) || (property.PropertyType == typeof(DateTime)))
                    {
                        propretyValue = DateTime.Parse(row[property.Name].ToString());
                        property.SetValue(myModel, propretyValue, null);
                    }
                    else
                    {
                        propretyValue = row[property.Name].ToString();
                        property.SetValue(myModel, propretyValue, null);
                    }
                }
                catch (Exception e)
                {
                    if (e is CustomException)
                    {
                        throw;
                    }
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                    {
                        { ExcelConstants.LINE, excelRowNumber },
                        { ExcelConstants.VALUE, row[property.Name] },
                        { ExcelConstants.IDENTIFICATION_COLUMN, row[0] },
                        { ExcelConstants.COLUMN, property.Name }
                    };
                    throw new CustomException(CustomStatusCode.InvalidExcelData, paramtrs, e);
                }
            }
            return myModel;
        }
        /// <summary>
        /// Replace String By Bool String
        /// </summary>
        /// <param name="stringParam"></param>
        /// <returns></returns>
        private static string ReplaceStringByBoolString(string stringParam)
        {
            string myString = stringParam.ToLower((CultureInfo.CurrentCulture));
            List<string> FalseStringList = new List<string>
            {
                ExcelConstants.ZERO,
                ExcelConstants.NO,
                ExcelConstants.NON,
                ExcelConstants.FAUX,
                ExcelConstants.FALSE
            };
            List<string> TrueStringList = new List<string>
            {
                ExcelConstants.ONE,
                ExcelConstants.YES,
                ExcelConstants.OUI,
                ExcelConstants.VRAI,
                ExcelConstants.TRUE
            };

            if (FalseStringList.Contains(myString))
            {
                myString = ExcelConstants.FALSE;
            }
            else if (TrueStringList.Contains(myString))
            {
                myString = ExcelConstants.TRUE;
            }

            return myString;
        }
        /// <summary>
        /// Return if that is excel valid Format
        /// </summary>
        /// <param name="properties"></param>
        /// <param name="table"></param>
        /// <returns></returns>
        private static bool IsvalidFormat(IList<PropertyInfo> properties, DataTable table)
        {
            List<string> propertiesNameList = new List<string>();

            foreach (var myProperty in properties)
            {
                propertiesNameList.Add(myProperty.Name);
            }

            foreach (var myColumn in table.Columns)
            {
                string x = myColumn.ToString();
                if (!propertiesNameList.Contains(x))
                {
                    return false;
                }
            }
            return true;
        }
        /// <summary>
        /// CheckUnicityIn Excel File
        /// </summary>
        /// <param name="table"></param>
        /// <param name="row"></param>
        /// <param name="property"></param>
        /// <returns></returns>
        private static bool CheckUnicityInFile(DataTable table, DataRow row, PropertyInfo property)
        {
            int numberOfOccur = 0;
            foreach (DataRow currentRow in table.Rows)
            {
                if (numberOfOccur > 1)
                {
                    return true;
                }

                if (string.Compare(currentRow[property.Name].ToString(), row[property.Name].ToString(), false, CultureInfo.CurrentCulture) == 0)
                {
                    numberOfOccur++;
                }
            }
            return false;
        }
        /// <summary>
        /// Check if the property Is Annoted by the annotationName
        /// </summary>
        /// <param name="property"></param>
        /// <param name="annotationName"></param>
        /// <returns></returns>
        private static bool IsAnnoted(PropertyInfo property, string annotationName)
        {
            return property.CustomAttributes.Any(atr => atr.AttributeType.Name == annotationName);
        }
        /// <summary>
        /// Verify Unicity of Unique properties
        /// </summary>
        /// <param name="table"></param>
        /// <param name="row"></param>
        /// <param name="property"></param>
        /// <param name="excelRowNumber"></param>
        public virtual void VerifyUnicityIfUnique(DataTable table, DataRow row, PropertyInfo property, int excelRowNumber)
        {
            if (IsAnnoted(property, ExcelConstants.KEY_ATTRIBUTE))
            {
                PredicateFormatViewModel predicate = new PredicateFormatViewModel();
                List<FilterViewModel> filters = new List<FilterViewModel>
                {
                    new FilterViewModel { Prop = property.Name, Operation = Operation.Equals, Value = row[property.Name].ToString() },
                    new FilterViewModel { Prop = _identificationColumn,
                        Operation = Operation.NotEquals, Value = row[_identificationColumn].ToString() }
                };
                predicate.Filter = filters;
                bool isNotUniqueInDB = ExcelCheckUnicity(row, property);
                if (isNotUniqueInDB)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                                {
                                    { ExcelConstants.LINE, excelRowNumber },
                                    { ExcelConstants.VALUE, row[property.Name] },
                                    { ExcelConstants.IDENTIFICATION_COLUMN, row[0] },
                                    { ExcelConstants.COLUMN, property.Name }
                                };
                    throw new CustomException(CustomStatusCode.ExcelUniqueColumnInDB, paramtrs);
                }
                bool isNotUniqueInFile = CheckUnicityInFile(table, row, property);
                if (isNotUniqueInFile)
                {
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                                {
                                    { ExcelConstants.LINE, excelRowNumber },
                                    { ExcelConstants.VALUE, row[property.Name] },
                                    { ExcelConstants.IDENTIFICATION_COLUMN, row[0] },
                                    { ExcelConstants.COLUMN, property.Name }
                                };
                    throw new CustomException(CustomStatusCode.ExcelUniqueColumnInFile, paramtrs);
                }
            }
        }

      
        /// <summary>
        /// Verify Requirment
        /// </summary>
        /// <param name="property"></param>
        /// <param name="excelRowNumber"></param>
        private static void VerifyRequirment(PropertyInfo property, int excelRowNumber)
        {
            if (IsAnnoted(property, ExcelConstants.REQUIRED_ATTRIBUTE))
            {
                IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { ExcelConstants.LINE, excelRowNumber },
                                { ExcelConstants.COLUMN, property.Name }
                            };
                throw new CustomException(CustomStatusCode.ExcelRequiredColumn, paramtrs);
            }
        }
        private static void VerifyIsValidEmailIfEmail(DataRow row, PropertyInfo property, int excelRowNumber)
        {
            if (IsAnnoted(property, ExcelConstants.EMAIL_ADDRESS_ATTRIBUTE))
            {
                bool isValidEmail = true;
                if (!string.IsNullOrEmpty(row[property.Name].ToString()))
                {
                    isValidEmail = IsValidEmail(row[property.Name].ToString());
                }
                if (IsAnnoted(property, ExcelConstants.REQUIRED_ATTRIBUTE) && !isValidEmail || !isValidEmail)
                {
                    if (string.IsNullOrWhiteSpace(row[property.Name].ToString()))
                    {
                        row[property.Name] = "";
                    }
                    IDictionary<string, dynamic> paramtrs = new Dictionary<string, dynamic>
                            {
                                { ExcelConstants.LINE, excelRowNumber },
                                { ExcelConstants.VALUE, row[property.Name] },
                                { ExcelConstants.IDENTIFICATION_COLUMN, row[0] },
                                { ExcelConstants.COLUMN, property.Name }
                            };
                    throw new CustomException(CustomStatusCode.ExcelInvalidEmailColumn, paramtrs);
                }
            }
        }
        protected ExcelWorkbook GetExcelWorkbookByPath(string path, out ExcelPackage excelPackage)
        {
            path = Path.GetFullPath(path);
            FileInfo existingFile = new FileInfo(path);
            excelPackage = new ExcelPackage(existingFile);
            return excelPackage.Workbook;
        }
        protected void FillSheetUsingDataStartingFromStartRow(ExcelWorkbook excelWorkBook, string sheetName, List<dynamic> data, List<string> columlns, int startRow = 2)
        {
            ExcelWorksheet excelWorksheet = excelWorkBook.Worksheets[sheetName];
            if (data.Count > 1)
            {
                excelWorksheet.InsertRow(2, data.Count - 1);
            }
            int numRow = startRow;
            data.ForEach(c =>
            {
                int numCol = 1;
                columlns.ForEach(col =>
                {
                    excelWorksheet.Cells[numRow, numCol].Value = c.GetType().GetProperty(col).GetValue(c);
                    numCol++;
                });
                numRow++;
            });
        }

    }
}
