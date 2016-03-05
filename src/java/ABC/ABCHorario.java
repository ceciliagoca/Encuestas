/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;
import entity.Horario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.List;
import utils.Conexion;

/**
 *
 * @author Cecilia
 */
public class ABCHorario {
  
    public Horario horario;
    
    
    public ABCHorario() {
    }
    
    
    
    
     public List<Horario> listarHorarios() throws SQLException{
      
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
   
       
       List<Horario>  l_horarios = new ArrayList<Horario>();
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from horarios order by id asc");
           
           
            ResultSet rs = pstmt.executeQuery();
            
            
            
                while(rs.next()){
                    horario  = new Horario();
       
                    horario.setId(rs.getInt(1));
                    horario.setDescripcion(rs.getString(2));
                    l_horarios.add(horario);
                }
                
                pstmt.close();
                    
            
     return l_horarios;
     }

    public Horario getHorario(int id) throws SQLException {
            
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select * from horarios where id="+id);
        
        
            ResultSet rs = pstmt.executeQuery();
        
            if(rs.next()){
               horario = new Horario(rs.getInt(1),rs.getString(2));
                       
            }
        return horario;
    }


   public void eliminar(int id) throws SQLException {
   
                   
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select deletehorario(?)");
        pstmt.setInt(1, id);
        pstmt.executeQuery();
        
        con.close();
   }
   
   public void nuevo(String descripcion) throws SQLException {
   
       
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select addHorario(?)");
        pstmt.setString(1, descripcion);
        
        pstmt.executeQuery();
        
        con.close();
       
   }
   
   public void editar(int id, String descripcion) throws SQLException {
       
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
        PreparedStatement pstmt;
        pstmt = con.prepareStatement("select editHorario(?,?)");
        pstmt.setInt(1, id);
        pstmt.setString(2, descripcion);
        
        pstmt.executeQuery();
        
        con.close();
       
     
   }

}
           

