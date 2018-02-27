/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package convergentsw2.starter;
import convergentsw2.dao.*;
import convergentsw2.gui.*;

/**
 *
 * @author jonats
 */
public class RuntimeData {
    
    public int loggedUserId;
    public ConvergentDao dao = new ConvergentDao();
    
    public RuntimeData(){
        new FrmLogin(this);
    }
    
}
