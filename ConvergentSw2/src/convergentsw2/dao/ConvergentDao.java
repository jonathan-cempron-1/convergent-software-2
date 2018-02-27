/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package convergentsw2.dao;
import convergentsw2.starter.*;
import convergentsw2.gui.*;
import java.sql.ResultSet;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jonats
 */
public class ConvergentDao {
    
    String url = "jdbc:mysql://localhost:3306/convergentDb3";
    String pass = "abc123";
    //String url = "jdbc:mysql://192.168.1.5:3306/convergentDb3";
    //String pass = "pkp420";
    String user = "root";
    GenericDao dao = new GenericDao(url, user, pass);
    
    public boolean isValidEmployeeLogin(String username, String password){
        String query = "select idEmployees, username, password from Employees where isActive = 1;";
        ResultSet rs = dao.queryDb(query);
        try{
            while(rs.next()) {
                if(rs.getString("username").equals(username) && rs.getString("password").equals(password))
                    return true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }    
    
    public int getEmployeeId(String username, String password){
        int ret = 0;
        String query = "select * from Employees where username = '"+username+"' and password = '"+password+"';";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getInt("idEmployees");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }    
    
    public String getEmployeeType(int employeeId){
        String ret = "";
        String query = "select type from Employees where idEmployees = "+employeeId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getString("type");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public String getEmployeeName(int employeeId){
        String ret = "";
        String query = "select completeName from Employees where idEmployees = "+employeeId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getString("completeName");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public DefaultTableModel getAgentAssignmentTable(int employeeId){
        String query = "select idAccounts, Banks.name, Banks.branch, make, model, year, color, plateNumber, completeName, contactInfo\n" +
                "from Assignments, Accounts, Banks, Vehicles, AccountsPersons, ContactInfos\n" +
                "where idAccounts = Assignments.Accounts_idAccounts\n" +
                "and Banks_idBanks = idBanks\n" +
                "and idAccounts = Vehicles.Accounts_idAccounts\n" +
                "and idAccounts = AccountsPersons.Accounts_idAccounts\n" +
                "and idAccountsPersons = ContactInfos.idOwner\n" +
                "and isResolved = 0\n" +
                "and Employees_idEmployees = "+employeeId+";";
        return dao.queryTable(query);
    }
    
    public boolean isAccountResolved(int accountId){
        String query = "select * from Accounts where idAccounts = "+accountId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            int resolved = rs.getInt("isResolved");
            if(resolved == 1)
                return true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    
    public String getAccountBankBranch(int accountId){
        String ret = "";
        String query = "select name, branch from Accounts, Banks\n" +
                "where idBanks = Banks_idBanks\n" +
                "and idAccounts = "+accountId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getString("name") +" "+ rs.getString("branch");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public String getAccountVehicleInfo(int accountId){
        String ret = "";
        String query = "select make, model, year, color, plateNumber \n" +
                "from Vehicles\n" +
                "where Accounts_idAccounts = "+accountId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getString("make") +" "+ 
                    rs.getString("model")+" "+ 
                    rs.getString("year")+" "+
                    rs.getString("color")+" "+
                    rs.getString("plateNUmber");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public String getAccountHandlingEmployee(int accountId){
        String ret = "";
        String query = "select completeName\n" +
                "from Assignments, Accounts, Employees\n" +
                "where Assignments.dateEnd is null\n" +
                "and Accounts_idAccounts = idAccounts\n" +
                "and Employees_idEmployees = idEmployees\n" +
                "and idAccounts = "+accountId+";";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret = rs.getString("completeName");
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public DefaultTableModel getAccountStatusTable(int accountId){
        String query = "select * from AccountsStatus where Accounts_idAccounts = "+accountId+" order by dateSaved desc;";
        return dao.queryTable(query);
    }
    
    public DefaultTableModel getAccountPersonsTable(int accountId){
        String query = "select idAccountsPersons, completeName, isPersonInterest, contactInfo, gender, bday\n" +
                "from AccountsPersons, ContactInfos\n" +
                "where idAccountsPersons = idOwner\n" +
                "and AccountsPersons.isActive = 1\n" +
                "and Accounts_idAccounts = "+accountId+";";
        return dao.queryTable(query);
    }
    
    public DefaultTableModel getAccountOtherInfo(int accountId){
        String query = "select idotherInfo, infoTitle, info from otherInfo where Accounts_idAccounts = "+accountId+";";
        return dao.queryTable(query);
    }
    
    public void addAccountsStatus(int accountId, String client, String appliId, String collateral, String socmed, String fieldVisit, String skiptrace, String daily, String remarks, String dateResolved, int employeeId){
        String query = "INSERT INTO `convergentDb3`.`AccountsStatus` (`Accounts_idAccounts`, `ClientStatus`, `AppliIdStatus`, `CollateralStatus`, `SocmedStatus`, `FieldVisitResults`, `SkiptraceResults`, `DailyStatus`, `Remarks`, `DateResolved`, `Employees_idEmployees`) "
                + "VALUES ('"+accountId+"', '"+client+"', '"+appliId+"', '"+collateral+"', '"+socmed+"', '"+fieldVisit+"', '"+skiptrace+"', '"+daily+"', '"+remarks+"', '"+dateResolved+"', '"+employeeId+"');";
        //System.out.println(query);
        dao.updateDb(query);
    }
    
    public void commentAccountStatus(int accountStatusId, String comment){
        String query = "UPDATE `convergentDb3`.`AccountsStatus` \n" +
                "SET `supervisorComment`='"+comment+"' \n" +
                "WHERE `idAccountsStatus`='"+accountStatusId+"';";
        dao.updateDb(query);
    }
}
