/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;

import entity.Encuesta;
import entity.Horario;
import entity.Practica;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.Conexion;

/**
 *
 * @author cecilia
 */
public class ABCPracticas {

    
    
    
    
    public ABCPracticas() {
    }
    
    
    
    
    public Practica getPractica(int clave)throws SQLException {
       
        Practica practica = new Practica();
        
        
        
           Conexion c = new Conexion();
           Connection  con = c.getConexion();
    
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from practicas where idpractica="+clave);
        
        
            ResultSet rs = pstmt.executeQuery();
        
            if(rs.next()){
               practica = new Practica(rs.getInt(1),rs.getString(2),rs.getString(3).charAt(0));
               
                       
            }
        return practica;
    }
    
    
   
     public List<Practica> listarPracticas() throws SQLException{
      
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
       
       List<Practica>  l_practicas = new ArrayList<Practica>();
     
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from practicas order by 1");
           
           
            ResultSet rs = pstmt.executeQuery();
            
            
            
                while(rs.next()){
                Practica practica = new Practica();
                    practica.setId(rs.getInt(1));
                    practica.setName(rs.getString(2));
                    practica.setTipo(rs.getString(3).charAt(0));
                    
                    l_practicas.add(practica);
                   
                }
                
                pstmt.close();
                    
            
     return l_practicas;
     }
            
    
    
    
    public void nueva(String nombre, String tipo) throws SQLException{
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select agregarPractica(?,?)");
        pstmt.setString(1,nombre);
        pstmt.setString(2,tipo);
        
        pstmt.executeQuery();
        con.close();
    
    }
    
    public void eliminar(int practica) throws SQLException{
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select editarPractica(?)");
        pstmt.setInt(1,practica);
   
        
        pstmt.executeQuery();
        con.close();
    }

    public void editar(int practica, String nombre, String tipo) throws SQLException{
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select editarPractica(?,?,?)");
        pstmt.setInt(1,practica);
        pstmt.setString(2,nombre);
        pstmt.setString(3,tipo);
        
        pstmt.executeQuery();
        con.close();
    }

}
