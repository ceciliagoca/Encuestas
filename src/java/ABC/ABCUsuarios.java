/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;
import entity.Alumno;
import entity.Profesor;
import entity.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexion;
import utils.Correo;

/**
 *
 * @author Cecilia
 */
public class ABCUsuarios {
  
  public Usuario usuario;

  
    public ABCUsuarios() {
    }
    
    public String addUsuario(Alumno alumno, String pass, String pass1) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select addvalUserAlumno(?,?,?,?,?)");
              pstmt.setString(1, alumno.getCuenta());
               pstmt.setString(2, pass);
               pstmt.setString(3, pass1);
              pstmt.setInt(4, alumno.getBrigada());
            
                    
            pstmt.setString(5, alumno.getCorreo());
            
           
            ResultSet rs = pstmt.executeQuery();
            
            
            
            if( rs.next())
            return rs.getString(1);
            
            else 
                return "falla";
            
            //int us=0;
            
                    
            } 
    
     public String addUsuario(Profesor profesor, String pass, String pass1) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select addvalUserProfesor(?,?,?,?)");
            pstmt.setString(1, profesor.getRfc());
            pstmt.setString(2, pass);
            pstmt.setString(3, pass1);
            pstmt.setString(4, profesor.getCorreo());
            
           
            ResultSet rs = pstmt.executeQuery();
            
            
            
            if( rs.next())
            return rs.getString(1);
            
            else 
                return "falla";
            
            //int us=0;
            
                    
            } 

  
  public void autenticar(String varname, String pass) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select consultaUser(?,?)");
            pstmt.setString(1, varname);
            pstmt.setString(2, pass);
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
            if(rs.next()){
                System.out.println("usuraio"+rs.getInt(1));
                PreparedStatement pstmtuser;
                pstmtuser = con.prepareStatement("select * from getUser where us = ?");
                if(rs.getInt(1)!=0){
                    pstmtuser.setInt(1, rs.getInt(1));
                    ResultSet rs1 = pstmtuser.executeQuery();
                    usuario = new Usuario();
                    rs1.next();
                    usuario.setTipo(rs1.getString(2).charAt(0));
                    usuario.setId(rs1.getInt(1));
                    usuario.setUser(varname);
               }else{
                    usuario =null;
                }
                
                pstmt.close();
                    
            }
            
            pstmt.close();
            con.close();
                
            
              
            }
  
  
 public String recuperaraContrasenia(String user) throws SQLException{
     Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from recuperarPasswd(?)");
            pstmt.setString(1, user);
           
            ResultSet rs = pstmt.executeQuery();
     
     if(rs.next()){
        String[] recipients = new String[]{rs.getString(1)};  
       // String[] bccRecipients = new String[]{"labautomatizacionindustrial@gmail.com"};  
        String subject = "Recuperacion de contraseña";  
        String messageBody = "Tu contraseña es: "+ rs.getString(2);  
  
        new Correo().sendMail(recipients,  subject, messageBody); 
        return "Se te ha enviado un mensaje a tu correo electronico";
     }else{
      return "Usuario no encontrado";
    }
     
    
 }
                     
}
