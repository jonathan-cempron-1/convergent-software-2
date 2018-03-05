/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package convergentsw2.dao;
import java.sql.*;
import java.util.Vector;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author jonats
 */
public class GenericDao {
    
    
    public GenericDao(String url, String user, String pass){
        this.url = url;
        this.user = user;
        this.pass = pass;
        this.maxRetries = 10;
        this.setConnection();
    }
    
    public GenericDao(String url, String user, String pass, int maxRetries){
        this.url = url;
        this.user = user;
        this.pass = pass;
        this.maxRetries = maxRetries;
        this.setConnection();
    }
    
    public void setConnection(){
        boolean isConnected = true;
        try{
            Class.forName(driverName);
            conn = DriverManager.getConnection(url, user, pass);
            this.attempts = 0;
        }catch(Exception e){
            e.printStackTrace();
            this.attempts += 1;
            isConnected = false;
        }
        if(!isConnected){
            if(this.attempts < this.maxRetries){
                this.setConnection();
            } else{
                // show error dialog
                this.showErrorConnection();
            }
        }
    }
    
    public DefaultTableModel queryTable(String query){
        DefaultTableModel ret = null;
        try{
            ret = buildTableModel(queryDb(query));
        }catch(Exception e){
            e.printStackTrace();
        }
        return ret;
    }
    
    public void updateDb(String query){
        try{
            PreparedStatement ps = conn.prepareStatement(query);
            ps.executeUpdate();
            this.attempts = 0;
        }catch(Exception e){
            e.printStackTrace();
            try{
                conn = DriverManager.getConnection(url, user, pass);
            }catch(Exception a){
                a.printStackTrace();
            }
            this.attempts += 1;
            if(this.attempts < this.maxRetries){
                updateDb(query);
            } else{
                // show error dialog
                this.showErrorConnection();
            }
        }    
    }    

    public int updateDbReturnId(String query){
        int ret = 0;
        try{
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()){
                ret=rs.getInt(1);
            }
            rs.close();
            stmt.close();
            this.attempts = 0;
        }catch(Exception e){
            e.printStackTrace();
            try{
                conn = DriverManager.getConnection(url, user, pass);
            }catch(Exception a){
                a.printStackTrace();
            }
            this.attempts += 1;
            if(this.attempts < this.maxRetries){
                updateDb(query);
            } else{
                // show error dialog
                this.showErrorConnection();
            }
        }
        return ret;
    }  
    
    public ResultSet queryDb(String query){
        ResultSet ret = null;
        try{
            PreparedStatement ps = conn.prepareStatement(query);
            ret = ps.executeQuery();
            this.attempts = 0;
        }catch(Exception e){
            e.printStackTrace();
            //System.out.println("Trying to reconnect");
            try{
                conn = DriverManager.getConnection(url, user, pass);
            }catch(Exception a){
                a.printStackTrace();
            }
            this.attempts += 1;
            if(this.attempts < this.maxRetries){
                ret = queryDb(query);
            } else{
                // show error dialog
                this.showErrorConnection();
            }
        }
        return ret;        
    }
    
    private DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();
        // names of columns
        Vector<String> columnNames = new Vector<String>();
        int columnCount = metaData.getColumnCount();
        for (int column = 1; column <= columnCount; column++) {
            columnNames.add(metaData.getColumnName(column));
        }
        // data of the table
        Vector<Vector<Object>> data = new Vector<Vector<Object>>();
        while (rs.next()) {
            Vector<Object> vector = new Vector<Object>();
            for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
                vector.add(rs.getObject(columnIndex));
            }
            data.add(vector);
        }
        return new DefaultTableModel(data, columnNames);
    }
    
    public void closeConnection(){
        try{
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        
    }
    
    public void showErrorConnection(){
        JOptionPane.showMessageDialog(null, "Cannot connect to Database server after "+ attempts + " retries. Please ensure that the Database Server is currently turned on while this software is in use.", "Something went wrong", JOptionPane.ERROR_MESSAGE);
        System.exit(0);
    }
    
    private String driverName = "com.mysql.jdbc.Driver";
    private String url;
    private String user;
    private String pass;
    private Connection conn;
    private int attempts = 0;
    private int maxRetries = 0;
}
