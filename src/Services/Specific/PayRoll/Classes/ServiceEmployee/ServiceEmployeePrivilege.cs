using Persistence;
using Settings.Config;
using System;
using System.Dynamic;
using System.Linq;
using Utils.Constants;
using Utils.Constants.PayrollConstants;
using Utils.Extensions;
using ViewModels.DTO.PayRoll;
using ViewModels.DTO.Shared;

namespace Services.Specific.PayRoll.Classes.ServiceEmployee
{
    public partial class ServiceEmployee
    {
        /// <summary>
        /// Check if connected user can see payroll characteristics and contracts of selected employee
        /// </summary>
        /// <param name="selectedEmployee"></param>
        /// <param name="userMail"></param>
        public bool CheckConnectedUserHasPrivilege(EmployeeViewModel selectedEmployee, string userMail, string reference)
        {
            EmployeeViewModel connectedEmployee = GetConnectedEmployee(userMail);
            if (connectedEmployee.Id != selectedEmployee.Id)
            {
                int userId = GetUserByUserMail(userMail).Id;
                UserPrivilegeViewModel connectedUserPrivilege = _serviceUserPrivilege.GetModelsWithConditionsRelations(x => x.IdUser == userId
                                            && x.IdPrivilegeNavigation.Reference == reference, x => x.IdPrivilegeNavigation).FirstOrDefault();
                if (connectedUserPrivilege != null)
                {
                    return CheckConnectedEmployeePrivilege(selectedEmployee, connectedEmployee, connectedUserPrivilege);
                }
                else return false;
            }
            else
            {
                return true;
            }
        }


        /// <summary>
        /// Check if connected user has right to see selected employee specific information
        /// </summary>
        /// <param name="selectedEmployee"></param>
        /// <param name="connectedEmployee"></param>
        /// <param name="connectedUserPrivilege"></param>
        private bool CheckConnectedEmployeePrivilege(EmployeeViewModel selectedEmployee, EmployeeViewModel connectedEmployee, UserPrivilegeViewModel connectedUserPrivilege)
        {
            bool hasPrivilege = false;
            if (connectedUserPrivilege.Management.HasValue && connectedUserPrivilege.Management.Value)
            {
                hasPrivilege = true;
            }
            else
            {
                if (connectedUserPrivilege.SubLevel.HasValue && connectedUserPrivilege.SubLevel.Value)
                {
                    hasPrivilege = !hasPrivilege ? IsPartOfHierarchy(connectedEmployee.Id, selectedEmployee.HierarchyLevel) : hasPrivilege;
                }
                if (connectedUserPrivilege.SameLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SameLevelWithoutHierarchy.Value && !hasPrivilege)
                {
                    hasPrivilege = !hasPrivilege ? connectedEmployee.HierarchyLevel == selectedEmployee.HierarchyLevel : hasPrivilege;
                }
                if (connectedUserPrivilege.SameLevelWithHierarchy.HasValue && connectedUserPrivilege.SameLevelWithHierarchy.Value && !hasPrivilege)
                {
                    string connectedLevel = connectedEmployee.HierarchyLevel.NotNullOrEmpty() ||
                        (!connectedEmployee.HierarchyLevel.NotNullOrEmpty() && !selectedEmployee.HierarchyLevel.NotNullOrEmpty()) ? connectedEmployee.HierarchyLevel : connectedEmployee.Id.ToString();
                    hasPrivilege = !hasPrivilege ? CheckPropertyWithHierarchy(connectedLevel, selectedEmployee.HierarchyLevel) : hasPrivilege;
                }
                if (connectedUserPrivilege.SuperiorLevelWithoutHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithoutHierarchy.Value
                    && connectedEmployee.HierarchyLevel.NotNullOrEmpty() && !hasPrivilege)
                {
                    string superiorEmployeeHierarchyLevel = _entityRepo.GetSingleNotTracked(x => connectedEmployee.IdUpperHierarchy.HasValue && x.Id == connectedEmployee.IdUpperHierarchy.Value).HierarchyLevel;
                    hasPrivilege = !hasPrivilege ? superiorEmployeeHierarchyLevel == selectedEmployee.HierarchyLevel : hasPrivilege;
                }
                if (connectedUserPrivilege.SuperiorLevelWithHierarchy.HasValue && connectedUserPrivilege.SuperiorLevelWithHierarchy.Value
                    && connectedEmployee.HierarchyLevel.NotNullOrEmpty() && !hasPrivilege)
                {
                    string superiorEmployeeHierarchyLevel = _entityRepo.GetSingleNotTracked(x => connectedEmployee.IdUpperHierarchy.HasValue && x.Id == connectedEmployee.IdUpperHierarchy.Value).HierarchyLevel;
                    hasPrivilege = !hasPrivilege ? CheckPropertyWithHierarchy(superiorEmployeeHierarchyLevel, selectedEmployee.HierarchyLevel) : hasPrivilege;
                }
            }
            return hasPrivilege;
        }

        /// <summary>
        /// Check hierarchical level with user who has with hierarchy property privilege
        /// </summary>
        /// <param name="connectedLevel"></param>
        /// <param name="selectedLevel"></param>
        /// <returns></returns>
        private bool CheckPropertyWithHierarchy(string connectedLevel, string selectedLevel)
        {
            if (connectedLevel == selectedLevel)
            {
                return true;
            }
            else
            {
                int[] selectedHierarchy = selectedLevel.NotNullOrEmpty() ?
                                            selectedLevel.Split(PayRollConstant.LevelSeparator).Select(int.Parse).ToArray() : null;
                int[] connectedHierarchy = connectedLevel.NotNullOrEmpty() ?
                                            connectedLevel.Split(PayRollConstant.LevelSeparator).Select(int.Parse).ToArray() : null;
                return selectedLevel.NotNullOrEmpty() && connectedLevel.NotNullOrEmpty() ?
                            connectedHierarchy.All(x => selectedHierarchy.Contains(x)) : false;
            }
        }

        /// <summary>
        /// get connected employee privileges
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public dynamic GetConnectedEmployeePrivileges(int id)
        {
            EmployeeViewModel selectedEmployee = base.GetModelById(id);
            string currentUserEmail = ActiveAccountHelper.GetConnectedUserEmail();
            bool hasPayPrivilege = CheckConnectedUserHasPrivilege(selectedEmployee, currentUserEmail, Constants.PAY);
            bool hasContractPrivilege = CheckConnectedUserHasPrivilege(selectedEmployee, currentUserEmail, Constants.CONTRACT);

            dynamic result = new ExpandoObject();
            result.HasPayPrivilege = hasPayPrivilege;
            result.HasContractPrivilege = hasContractPrivilege;
            return result;
        }

    }
}
