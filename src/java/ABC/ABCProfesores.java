/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;
import entity.Profesor;
import entity.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexion;

/**
 *
 * @author Cecilia
 */
public class ABCProfesores {
  
  public Usuario usuario;

    public ABCProfesores() {
    }
    
  public Profesor getProfesor(String rfc) throws SQLException{
      
      Conexion c = new Conexion();
          Connection  con = c.getConexion();
     
         
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_profesores where profesor = ?");
            pstmt.setString(1, rfc);
            ResultSet rs = pstmt.executeQuery();
      rs.next();
      
      Profesor profesor = new Profesor(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getBoolean(7));
      
      
      
      return profesor;
  
  }
 
    public List listarProfesores() throws SQLException{
        
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
     
          List<Profesor> profesores = new ArrayList<Profesor>();
          
          
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_profesores");
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
            
            while(rs.next()){
                
               Profesor profesor = new Profesor(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getBoolean(7));
               profesores.add(profesor);
                
                
             
               }
                    pstmt.close();
    
                    return profesores;
    }
    



public void addProfesor(String rfc, String titulo, String nombre, String apeP, String apeM, boolean activo) throws SQLException{
    
      Conexion c = new Conexion();
          Connection  con = c.getConexion();
        
          
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select addProfesor(?,?,?,?,?,?,?)");
            pstmt.setString(1, rfc);
            pstmt.setString(2, titulo);
            pstmt.setString(3, nombre);
            pstmt.setString(4, apeP);
            pstmt.setString(5, apeM);
            pstmt.setString(6, "");
            pstmt.setBoolean(7,activo);
            
            ResultSet rs = pstmt.executeQuery();
            
           pstmt.close();
    
                
}

  public void deleteProfesor(String rfc) throws SQLException{
      
      Conexion c = new Conexion();
      try (Connection con = c.getConexion()) {
          Statement stm;
          stm = con.createStatement();
          
          // PreparedStatement pstmt;
          // pstmt = con.prepareStatement();
          //pstmt.setString(1, rfc);
          try {
       stm.executeQuery("delete from profesor where id = '" + rfc+"'");
          }catch(Exception e){ System.out.println("error en query");}
          //pstmt.close();
          stm.close();
      }
      
      
  }
    public Profesor editProfesor(Profesor profesor) throws SQLException{
      
      Conexion c = new Conexion();
      Connection  con = c.getConexion();
    
         
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select actualizar_profesor(?,?,?,?,?,?,?)");
            pstmt.setString(1, profesor.getRfc());
            pstmt.setString(2, profesor.getTitulo());
            pstmt.setString(3, profesor.getNombre());
            pstmt.setString(4, profesor.getApeP());
            pstmt.setString(5, profesor.getApeM());
            pstmt.setString(6, profesor.getCorreo());
            pstmt.setBoolean(7, profesor.getActivo());
            pstmt.executeQuery();
         
            con.close();
      
      
      
      
      
      return profesor;
  
  }
    
}