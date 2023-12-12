using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace NMDCATEtestPreparatory.providerRole
{
    public class MyRoleProvider:RoleProvider
    {

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {
            nMDCATPrepTestEntities db = new nMDCATPrepTestEntities();
            long uid=1;
            //select if powerful user so assign all the roles
            //select user through campus and assign that campus roles
            var userID = (from u in db.Users
                          where u.userName == username
                          select u.userId).FirstOrDefault();
            uid = userID;
            
            var getRoleForPowerUser = (from pu in db.userPowers
                                  where pu.userId == uid
                                  select pu
                                     ).ToList();

            string[] roleTit={};
            if (getRoleForPowerUser.Count > 0)
            {
                var y = db.Roles.Select(x => x.roleTitle).OrderBy(x => x).ToArray();
                roleTit = y;
            }
            else
            {
                var getRoleForCommonUser = (from userRole in db.UserRolePrivileges
                                            join role in db.Roles on userRole.roleId equals role.roleId
                                            join RW in db.Privileges on userRole.privilegeId equals RW.privilegeId
                                            where userRole.userId == userID
                                            select new
                                            {
                                                role.roleTitle,
                                                RW.privilegeTitle,
                                            }).ToArray();
                roleTit = getRoleForCommonUser.Select(h=>h.roleTitle+h.privilegeTitle).ToArray();
            }

            return roleTit;
            
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}