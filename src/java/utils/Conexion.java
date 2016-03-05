package utils;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */

import java.sql.*;
public class Conexion {
  
    
    
    public Connection getConexion() {
        Connection  con;
        String driver = "org.postgresql.Driver";
   String connectString = "jdbc:postgresql://localhost:5432/encuestas";
 
        try{
            Class.forName(driver);
     //   con = DriverManager.getConnection(connectString, "postgres" ,"cecilia" );
      con = DriverManager.getConnection(connectString, "cecilia" ,"cecilia" );
            
            //con.close();

            } catch ( Exception e ){
           // System.err.println(e.getMessage());
            
              System.err.println("ERROR CONNECTION");
              
                con=null;
            }
        
        
        
          return con;
    }
  
  
        
}

