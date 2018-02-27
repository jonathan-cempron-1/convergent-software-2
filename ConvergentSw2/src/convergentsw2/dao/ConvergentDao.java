/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package convergentsw2.dao;
import convergentsw2.starter.*;
import convergentsw2.gui.*;

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
    
}
