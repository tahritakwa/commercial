using Microsoft.Extensions.Options;
using Persistence.UnitOfWork.Interfaces;
using Services.Specific.BToB.interfaces;
using Services.Specific.Inventory.Interfaces;
using Settings.Config;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Utils.Constants;
using Utils.Utilities.DataUtilities;
using ViewModels.DTO.Inventory;
using ViewModels.DTO.Models;

namespace Services.Specific.BToB.Classes
{
    public class ServiceBToBShared : IServiceBToBShared

    {
        private readonly IUnitOfWork _unitOfWork;
        private IOptions<AppSettings> _appSettings;
        private readonly IServiceVehicleBrand _serviceVehicleBrand;
        private readonly IServiceFamily _serviceFamily;
        private readonly IServiceModelOfItem _serviceModelOfItem;
        private readonly IServiceSubModel _serviceSubModel;
        private readonly IServiceSubFamily _serviceSubFamily;
        private readonly IServiceProductItem _serviceProductItem;
        public ServiceBToBShared(IOptions<AppSettings> appSettings, IUnitOfWork unitOfWork, IServiceVehicleBrand serviceVehicleBrand, IServiceFamily serviceFamily,
            IServiceModelOfItem serviceModelOfItem, IServiceSubModel serviceSubModel, IServiceSubFamily serviceSubFamily, IServiceProductItem serviceProductItem)
        {

           
            _unitOfWork = unitOfWork;
            _appSettings = appSettings;
            _serviceVehicleBrand = serviceVehicleBrand;
            _serviceFamily = serviceFamily;
            _serviceModelOfItem = serviceModelOfItem;
            _serviceSubModel = serviceSubModel;
            _serviceSubFamily = serviceSubFamily;
            _serviceProductItem = serviceProductItem;
        }

        /// <summary>
        /// GetVehiculeBrand
        /// </summary>
        /// <returns></returns>
        public IList<VehicleBrandViewModel> GetVehiculeBrand(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<VehicleBrandViewModel> vehicleBrandViews = _serviceVehicleBrand.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.VehicleBrand where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            VehicleBrandViewModel vehiculeBrand = new VehicleBrandViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            vehicleBrandViews.Add(vehiculeBrand);
                        }
                    }
                    conn.Close();
                }
            }
            _unitOfWork.CommitTransaction();
            List<string> brandPicturesUrls = new List<string>();
            foreach (VehicleBrandViewModel vehicleBrandView in vehicleBrandViews)
            {
                if (vehicleBrandView.UrlPicture != null)
                {
                    brandPicturesUrls.Add(vehicleBrandView.UrlPicture);
                }
            }
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = _serviceVehicleBrand.GetFilesContents(brandPicturesUrls);
            foreach (VehicleBrandViewModel brand in vehicleBrandViews)
            {
                {
                    brand.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == brand.UrlPicture).FirstOrDefault();
                }
            }
            return vehicleBrandViews;
        }

        /// <summary>
        /// GetFamilyList
        /// </summary>
        /// <returns></returns>
        public IList<FamilyViewModel> GetFamilyList(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<FamilyViewModel> familyViews = new List<FamilyViewModel>();
            familyViews = _serviceFamily.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.Family where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            FamilyViewModel family = new FamilyViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            familyViews.Add(family);
                        }
                    }
                    conn.Close();
                }

            }
            _unitOfWork.CommitTransaction();
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = GetPictureFileInfo(familyViews);
            foreach (FamilyViewModel family in familyViews)
            {
                {
                    family.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == family.UrlPicture).FirstOrDefault();
                }

            }
            return familyViews;

        }

        public IList<ModelOfItemViewModel> GetModelOfItemList(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<ModelOfItemViewModel> modelOfItemViews = _serviceModelOfItem.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.ModelOfItem where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            ModelOfItemViewModel modelOfItem = new ModelOfItemViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            modelOfItemViews.Add(modelOfItem);
                        }
                    }
                    conn.Close();
                }
            }
            _unitOfWork.CommitTransaction();
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = fileInfoViewModels = GetPictureFileInfo(modelOfItemViews);
            foreach (ModelOfItemViewModel modelOfItem in modelOfItemViews)
            {
                {
                    modelOfItem.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == modelOfItem.UrlPicture).FirstOrDefault();
                }
            }
            return modelOfItemViews;
        }
        public IList<SubModelViewModel> GetSubModelList(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<SubModelViewModel> subModelViews = _serviceSubModel.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.SubModel where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            SubModelViewModel subModel = new SubModelViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            subModelViews.Add(subModel);
                        }
                    }
                    conn.Close();
                }
            }
            _unitOfWork.CommitTransaction();
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = GetPictureFileInfo(subModelViews);
            foreach (SubModelViewModel modelOfItem in subModelViews)
            {
                {
                    modelOfItem.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == modelOfItem.UrlPicture).FirstOrDefault();
                }

            }
            return subModelViews;

        }

        public dynamic GetPictureFileInfo (dynamic models)
        {
            List<string> subModelPicturesUrls = new List<string>();
            foreach (var modelView in models)
            {
                if (modelView.UrlPicture != null)
                {
                    subModelPicturesUrls.Add(modelView.UrlPicture);
                }
            }
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = _serviceSubModel.GetFilesContents(subModelPicturesUrls);
            return fileInfoViewModels;

        }
        /// <summary>
        /// Get SubFamily List
        /// </summary>
        /// <returns></returns>
        public IList<SubFamilyViewModel> GetSubFamilyList(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<SubFamilyViewModel> subFamilyViews = _serviceSubFamily.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.SubFamily where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            SubFamilyViewModel family = new SubFamilyViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            subFamilyViews.Add(family);
                        }
                    }
                    conn.Close();
                }
            }
            _unitOfWork.CommitTransaction();
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = GetPictureFileInfo(subFamilyViews);
            foreach (SubFamilyViewModel family in subFamilyViews)
            {
                {
                    family.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == family.UrlPicture).FirstOrDefault();
                }

            }
            return subFamilyViews;

        }
        public IList<ProductItemViewModel> GetProductItemList(DateTime searchDate, string connectionString)
        {
            _unitOfWork.BeginTransaction(connectionString);
            IList<ProductItemViewModel> productItemViews = _serviceProductItem.GetModelsWithConditionsRelations(x => (x.CreationDate.HasValue && (DateTime.Compare(x.CreationDate.Value, searchDate) > NumberConstant.Zero ||
            (DateTime.Compare(x.CreationDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.CreationDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))) ||
            (x.UpdatedDate.HasValue && (DateTime.Compare(x.UpdatedDate.Value, searchDate) > NumberConstant.Zero || (DateTime.Compare(x.UpdatedDate.Value, searchDate) == NumberConstant.Zero &&
            TimeSpan.Compare(x.UpdatedDate.Value.TimeOfDay, searchDate.TimeOfDay) >= NumberConstant.Zero))));
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(string.Format("Select * from Inventory.ProductItem where IsDeleted=1 AND UpdatedDate > @value ", conn)))
                {
                    cmd.Parameters.AddWithValue("@value", searchDate.Date);
                    cmd.Connection = conn;
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        DateTime date = (DateTime)rdr["UpdatedDate"];
                        if (date.AfterDateAndTimeLimitIncluded(searchDate))
                        {
                            ProductItemViewModel productItem = new ProductItemViewModel
                            {
                                Id = (int)rdr["Id"],
                                IsDeleted = (bool)rdr["IsDeleted"]
                            };
                            productItemViews.Add(productItem);
                        }
                    }
                    conn.Close();
                }
            }
            _unitOfWork.CommitTransaction();
            IList<FileInfoViewModel> fileInfoViewModels = new List<FileInfoViewModel>();
            fileInfoViewModels = GetPictureFileInfo(productItemViews);
            foreach (ProductItemViewModel family in productItemViews)
            {
                {
                    family.PictureFileInfo = fileInfoViewModels.Where(y => y.FulPath == family.UrlPicture).FirstOrDefault();
                }

            }
            return productItemViews;

        }

    }
}
