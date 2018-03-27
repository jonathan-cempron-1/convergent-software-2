/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package convergentsw2.dao;
import convergentsw2.starter.*;
import convergentsw2.gui.*;
import java.sql.ResultSet;
import java.util.LinkedList;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author jonats
 */
public class ConvergentDao {
    
    String url = "jdbc:mysql://localhost:3306/convergentDb3";
    String pass = "abc123";
    //String url = "jdbc:mysql://192.168.1.5:3306/convergentDb3";
    //tring pass = "pkp420";
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
    
    public void addEmployee(String uname, String pword, String fullName, String gender, String bday, String type){
        String query = "INSERT INTO `convergentDb3`.`Employees` (`username`, `password`, `completeName`, `gender`, `bday`, `isActive`, `type`) "
                + "VALUES ('"+uname+"', '"+pword+"', '"+fullName+"', '"+gender+"', '"+bday+"', '1', '"+type+"');";
        dao.updateDb(query);
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
    
    public LinkedList<String> getEmployeeList(){
        LinkedList<String> ret = new LinkedList<String>();
        String query = "select * from Employees;";
        ResultSet rs = dao.queryDb(query);
        try{
            while(rs.next())
                ret.add(rs.getInt("idEmployees")+"_"+rs.getString("completeName"));
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
    
    public DefaultTableModel getEmployeeAllTable(){
        String query = "select * from Employees;";
        return dao.queryTable(query);
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
    
    public DefaultTableModel getAgentSearchTable(int eid, String field, String search){
        String query = "select distinct idAccounts, Banks.name, Banks.branch, make, model, year, color, plateNumber, completeName, contactInfo\n" +
                "from Assignments, Accounts, Banks, Vehicles, AccountsPersons, ContactInfos, AccountsStatus\n" +
                "where idAccounts = Assignments.Accounts_idAccounts\n" +
                "and idAccounts = AccountsStatus.Accounts_idAccounts\n" +
                "and Banks_idBanks = idBanks\n" +
                "and idAccounts = Vehicles.Accounts_idAccounts\n" +
                "and idAccounts = AccountsPersons.Accounts_idAccounts\n" +
                "and idAccountsPersons = ContactInfos.idOwner\n" +
                "and isResolved = 0\n" +
                "and Assignments.Employees_idEmployees = "+eid+"\n" +
                "and AccountsStatus."+field+" like \""+search+"\";";
        return dao.queryTable(query);
    }

    public DefaultTableModel getSupervisorSearchTable(String field, String search){
        String query = "select distinct idAccounts, Banks.name, Banks.branch, make, model, year, color, plateNumber, completeName, contactInfo\n" +
                "from Assignments, Accounts, Banks, Vehicles, AccountsPersons, ContactInfos, AccountsStatus\n" +
                "where idAccounts = Assignments.Accounts_idAccounts\n" +
                "and idAccounts = AccountsStatus.Accounts_idAccounts\n" +
                "and Banks_idBanks = idBanks\n" +
                "and idAccounts = Vehicles.Accounts_idAccounts\n" +
                "and idAccounts = AccountsPersons.Accounts_idAccounts\n" +
                "and idAccountsPersons = ContactInfos.idOwner\n" +
                "and isResolved = 0\n" +
                "and AccountsStatus."+field+" like \""+search+"\";";
        return dao.queryTable(query);
    }
    
    public DefaultTableModel getSupervisorTable(){
        String query = "select idAccounts, Banks.name, Banks.branch, make, model, year, color, plateNumber, AccountsPersons.completeName, contactInfo, Employees.completeName\n" +
                "from Assignments, Accounts, Banks, Vehicles, AccountsPersons, ContactInfos, Employees\n" +
                "where idAccounts = Assignments.Accounts_idAccounts\n" +
                "and Banks_idBanks = idBanks\n" +
                "and Employees_idEmployees = idEmployees\n" +
                "and idAccounts = Vehicles.Accounts_idAccounts\n" +
                "and idAccounts = AccountsPersons.Accounts_idAccounts\n" +
                "and idAccountsPersons = ContactInfos.idOwner\n" +
                "and isResolved = 0;";
        return dao.queryTable(query);
    }
    
    public DefaultTableModel getAllAccountsTable(){
        String query = "select idAccounts, isResolved dateStart, Banks.name, branch, year, make, model, color, plateNumber, completeName, contactInfo\n" +
                "from Accounts, Banks, Vehicles, AccountsPersons, ContactInfos\n" +
                "where Accounts.Banks_idBanks = idBanks\n" +
                "and idAccounts = Vehicles.Accounts_idAccounts\n" +
                "and idAccounts = AccountsPersons.Accounts_idAccounts\n" +
                "and idAccountsPersons = ContactInfos.idOwner";
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
    
    public String[] getLatestAccountStatus(int accountId){
        String[] ret = {"","","","","","","","",""};
        String query = "select * from AccountsStatus where Accounts_idAccounts = "+accountId+" order by dateSaved desc;";
        ResultSet rs = dao.queryDb(query);
        try{
            rs.next();
            ret[0] = rs.getString("ClientStatus");
            ret[1] = rs.getString("AppliIdStatus");
            ret[2] = rs.getString("CollateralStatus");
            ret[3] = rs.getString("SocmedStatus");
            ret[4] = rs.getString("FieldVisitResults");
            ret[5] = rs.getString("SkiptraceResults");
            ret[6] = rs.getString("DailyStatus");
            ret[7] = rs.getString("Remarks");
            //ret[8] = rs.getString("");//date here
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
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
    
    public DefaultTableModel getLocationsAllTable(){
        String query = "select * from Locations;";
        return dao.queryTable(query);
    }  
   
    public void addLocation(String location, String longitude, String latitude){
        String query = "INSERT INTO `convergentDb3`.`Locations` (`longitude`, `latitude`, `name`) VALUES ('"+longitude+"', '"+latitude+"', '"+location+"');";
        dao.updateDb(query);
    }
    
    public LinkedList<String> getLocationsNames(){
        LinkedList<String> ret = new LinkedList<String>();
        String query = "select name from Locations";
        ResultSet rs = dao.queryDb(query);
        try{
            while(rs.next()) {
                ret.add(rs.getString("name"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }

    public Double getLocationLongitude(String name){
        Double ret = 0.0;
        String query = "select * from Locations where name like '"+name+"';";
        ResultSet rs = dao.queryDb(query);
        try{
           rs.next();
           ret = rs.getDouble("longitude");
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }

    public Double getLocationLatitude(String name){
        Double ret = 0.0;
        String query = "select * from Locations where name like '"+name+"';";
        ResultSet rs = dao.queryDb(query);
        try{
           rs.next();
           ret = rs.getDouble("latitude");
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }
    
    public int getLocationId(String name, Double longitude, Double latitude){
        int ret = 0;
        String query = "select * from Locations\n" +
                "where name like '"+name+"'\n" +
                "and longitude = "+longitude+"\n" +
                "and latitude = "+latitude+";";
        ResultSet rs = dao.queryDb(query);
        try{
           rs.next();
           ret = rs.getInt("idLocations");
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }
    
    public void addContactInfos(String type, String info, int idOwner){
        String query = "INSERT INTO `convergentDb3`.`ContactInfos` (`type`, `contactInfo`, `isActive`, `idOwner`) "
                + "VALUES ('"+type+"', '"+info+"', '1', '"+idOwner+"');";
        dao.updateDb(query);
    }
    
    public DefaultTableModel getContactsTable(int idOwner){
        String query = "select * from ContactInfos where idOwner = "+idOwner+";";
        return dao.queryTable(query);
    }
    
    public DefaultTableModel getAddressTable(int idOwner){
        String query = "select * from Address where idOwner = "+idOwner+";";
        return dao.queryTable(query);
    }
    
    public void addAddressComplete(String fulladdr, String zipcode, int idLocations, int idOwner){
        String query = "INSERT INTO `convergentDb3`.`Address` (`completeAddress`, `zipcode`, `isActive`, `Locations_idLocations`, `idOwner`) "
                + "VALUES ('"+fulladdr+"', '"+zipcode+"', '1', '"+idLocations+"', '"+idOwner+"');";
        dao.updateDb(query);
    }
    
    public void addAddressIncomplete(String fulladdr, String zipcode, int idOwner){
        String query = "INSERT INTO `convergentDb3`.`Address` (`completeAddress`, `zipcode`, `isActive`, `idOwner`) "
                + "VALUES ('"+fulladdr+"', '"+zipcode+"', '1', '"+idOwner+"');";
        dao.updateDb(query);
    }
    
    public DefaultTableModel getBanksTable(){
        String query = "select * from Banks;";
        return dao.queryTable(query);
    }
    
    public void addBank(String name, String branch){
        String query = "INSERT INTO `convergentDb3`.`Banks` (`name`, `branch`) "
                + "VALUES ('"+name+"', '"+branch+"');";
        dao.updateDb(query);
    }
    
    public int getBankId(String name, String branch){
        int ret = 0;
        String query = "select * from Banks "
                + "where name like '"+name+"' "
                + "and branch like '"+branch+"';";
        ResultSet rs = dao.queryDb(query);
        try{
           rs.next();
           ret = rs.getInt("idBanks");
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }
    
    public LinkedList<String> getBankList(){
        LinkedList<String> ret = new LinkedList<String>();
        String query = "select * from Banks;";
        ResultSet rs = dao.queryDb(query);
        try{
           while(rs.next())
               ret.add(rs.getInt("idBanks")+"_"+rs.getString("name")+"_"+rs.getString("branch"));
        }catch(Exception e){
            e.printStackTrace();
        }        
        return ret;
    }
    
    public int addAccountReturnId(int bankid){
        String query = "INSERT INTO `convergentDb3`.`Accounts` (`Banks_idBanks`) VALUES ('"+bankid+"');";
        return dao.updateDbReturnId(query);
    }
    
    public void addVehicle(String make, String model, String year, String color, String plnum, String chnum, String ennum, int accountId){
        String query = "INSERT INTO `convergentDb3`.`Vehicles` (`make`, `model`, `year`, `color`, `plateNumber`, `chassisNumber`, `engineNumber`, `Accounts_idAccounts`) VALUES "
                + "('"+make+"', '"+model+"', '"+year+"', '"+color+"', '"+plnum+"', '"+chnum+"', '"+ennum+"', '"+accountId+"');";
        dao.updateDb(query);
    }
    
    public int addAccountPersonReturnId(String name, String gender, String bday, int isPersonInterest, int accountId, String otherInfo){
        String query = "INSERT INTO `convergentDb3`.`AccountsPersons` (`completeName`, `gender`, `bday`, `isPersonInterest`, `Accounts_idAccounts`, `otherInfo`, `isActive`) "
                + "VALUES ('"+name+"', '"+gender+"', '"+bday+"', '"+isPersonInterest+"', '"+accountId+"', '"+otherInfo+"', '1');";
        return dao.updateDbReturnId(query);
    }
    
    public DefaultTableModel getAccountPersonTable(int accountId){
        String query = "select * from AccountsPersons where Accounts_idAccounts = "+accountId+";";
        return dao.queryTable(query);
    }
    
    public void addAssignment(int employeeId, int accountId){
        String query = "INSERT INTO `convergentDb3`.`Assignments` (`Employees_idEmployees`, `Accounts_idAccounts`) "
                + "VALUES ('"+employeeId+"', '"+accountId+"');";
        dao.updateDb(query);
    }
}
