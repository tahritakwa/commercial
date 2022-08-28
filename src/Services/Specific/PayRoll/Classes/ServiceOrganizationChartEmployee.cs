using Microsoft.EntityFrameworkCore;
using Persistence.Entities;
using System.Collections.Generic;
using System.Linq;
using Utils.Constants;
using ViewModels.DTO.Models;
using ViewModels.DTO.Utils;

namespace Services.Specific.PayRoll.Classes.ServiceEmployee
{
    public partial class ServiceEmployee
    {
        /// <summary>
        /// Get all organization charts 
        /// </summary>
        /// <returns></returns>
        public List<OrganizationChartViewModel> GetAllEmployeesWithInferiors()
        {
            List<Employee> employeesWithoutHierarchyLevel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => x.IdUpperHierarchy == null)
               .Include(x => x.Team)
               .Include(x => x.InverseIdUpperHierarchyNavigation)
               .ThenInclude(x => x.JobEmployee)
               .Include(x => x.JobEmployee)
               .ToList();
            List<OrganizationChartViewModel> listOfOrganizationChart = new List<OrganizationChartViewModel>();
            employeesWithoutHierarchyLevel.ForEach(employee =>
            {
                OrganizationChartViewModel organizationChart = GetInferiors(employee);
                listOfOrganizationChart.Add(organizationChart);
            });
            listOfOrganizationChart = listOfOrganizationChart.OrderByDescending(x => x.children.Count).ToList();
            return listOfOrganizationChart;
        }

        /// <summary>
        /// Prepare employee as data organization chart
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private DataOrganizationChartViewModel GetDataOrganizationChart (Employee employee)
        {
            DataOrganizationChartViewModel dataOrganizationChartViewModel = new DataOrganizationChartViewModel();
            dataOrganizationChartViewModel.idEmployee = employee.Id;
            dataOrganizationChartViewModel.name = employee.FullName;
            FileInfoViewModel pictureFileInfo = GetFilesContent(employee.Picture).FirstOrDefault();
            if (pictureFileInfo != null)
            {
                dataOrganizationChartViewModel.img = pictureFileInfo.Data;
            }

            if (employee.JobEmployee != null && employee.JobEmployee.Count > NumberConstant.Zero)
            {
                string designation = _serviceJob.GetModelById(employee.JobEmployee.FirstOrDefault().IdJob.Value).Designation;
                dataOrganizationChartViewModel.function = designation;
            }
            if (employee.Team != null && employee.Team.Count > NumberConstant.Zero)
            {
                string team = _repoTeam.GetSingleNotTracked(x => x.Id == employee.Team.FirstOrDefault().Id).Name;
                dataOrganizationChartViewModel.team = team;
            }
            return dataOrganizationChartViewModel;
        }

        /// <summary>
        /// Get employee hierarchical organization chart
        /// </summary>
        /// <param name="employee"></param>
        /// <returns></returns>
        private OrganizationChartViewModel GetInferiors(Employee employee)
        {
            List<OrganizationChartViewModel> listOfOrganizationChart = new List<OrganizationChartViewModel>();
            List<Employee> employeesWithHierarchyLevel = _entityRepo.GetAllWithConditionsRelationsQueryableAsNoTracking(x => employee.Id == x.IdUpperHierarchy)
                .Include(x => x.InverseIdUpperHierarchyNavigation)
                .ThenInclude(x => x.JobEmployee)
                .Include(x => x.JobEmployee)
                .ToList();
           
            employeesWithHierarchyLevel.ForEach(employeeWithLevel =>
            {
                OrganizationChartViewModel organizationChart = new OrganizationChartViewModel
                {
                    data = GetDataOrganizationChart(employeeWithLevel),
                    expanded = true
                };
                if (employeeWithLevel.InverseIdUpperHierarchyNavigation != null && employeeWithLevel.InverseIdUpperHierarchyNavigation.Count > NumberConstant.Zero)
                {
                    organizationChart.hasChildren = true;
                    organizationChart.children = new List<OrganizationChartViewModel>();
                    employeeWithLevel.InverseIdUpperHierarchyNavigation.ToList().ForEach(child =>
                    {
                        OrganizationChartViewModel childChart = GetInferiors(child);
                        organizationChart.children.Add(childChart);
                    });
                }
                listOfOrganizationChart.Add(organizationChart);
            });
            OrganizationChartViewModel employeeChart = new OrganizationChartViewModel
            {
                data = GetDataOrganizationChart(employee),
                expanded = true,
                children = listOfOrganizationChart,
                hasChildren = listOfOrganizationChart.Count > NumberConstant.Zero ? true : false
            };
            return employeeChart;
        }
        
       /// <summary>
       /// Get selected employee organization chart
       /// </summary>
       /// <param name="employeeId"></param>
       /// <returns></returns>
       public OrganizationChartViewModel SelectedEmployeeOrganizationChart(int employeeId)
        {
            Employee employee = _entityRepo.GetSingleWithRelationsNotTracked(x => x.Id == employeeId, x => x.JobEmployee, x => x.Team);
            return GetInferiors(employee);
        }

    }
}
