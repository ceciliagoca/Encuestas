/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;
import entity.Alumno;
import entity.Encuesta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import utils.Conexion;

/**
 *
 * @author Cecilia
 */
public class ABCAlumnos {
  
  public Alumno alumno;

    public ABCAlumnos() {
    }
    
    public ABCAlumnos(String alumno) throws SQLException {
        
        getAlumno(alumno);
        
    }
  
  
  public void getAlumno(String cuenta) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from getAlumno where cuenta = ?");
            pstmt.setString(1, cuenta);
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
            if(rs.next()){
             
                    alumno = new Alumno();
                    
                    alumno.setApeP(rs.getString(1));
                    alumno.setApeM(rs.getString(2));
                    alumno.setNombre(rs.getString(3));
                    alumno.setGrupo(rs.getString(4));
                    alumno.setCuenta(rs.getString(5));
                    alumno.setBrigada(rs.getInt(6));
                    
                    alumno.setCorreo(rs.getString(7));
                    alumno.setSemestre(rs.getString(8));
               }else{
                    alumno =null;
                }
                
                    pstmt.close();
                    
            }
  
   public boolean buscarAlumno(String cuenta) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select buscarAlumnos(?)");
            pstmt.setString(1, cuenta);
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
            rs.next();
           return rs.getBoolean(1);
             
                   
                    
            }
            
            
                
     public List<Encuesta> listarEncuestas() throws SQLException{
      
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
       Encuesta practica= new Encuesta();
       
       List<Encuesta>  encuestas = new ArrayList<Encuesta>();
      
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from p_alumno(?);");
            pstmt.setString(1, alumno.getCuenta());
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
                while(rs.next()){
                 practica = new Encuesta();
                practica.setNombre(rs.getString(2));
                practica.setCal(rs.getInt(3));
                practica.setId(rs.getInt(1));
                practica.setTipo(rs.getString(4));
               
            //    practica.setTipo(rs.getString(2));
             //   practica.setGrupo(rs.getInt(3));
              //  practica.setCal(rs.getInt(4));
              //  System.out.println(rs.getString(2));     
                encuestas.add(practica);
                   
                  
               }
            Iterator itef = encuestas.iterator();
            while(itef.hasNext()){
                Encuesta pra = new Encuesta();
            pra = (Encuesta)itef.next();
                System.out.println(pra.getNombre());
            }
//                while(rs.next()){
//                practica.setNombre(rs.getString(1));
//                practica.setTipo(rs.getString(2));
//                practica.setGrupo(rs.getInt(3));
//                practica.setCal(rs.getInt(4));
//                System.out.println("b"+alumno.getGrupo());        
//                encuestas.add(practica);
//                }
//                
                pstmt.close();
                    
            
     return encuestas;
     }
            
 public void arreglarAlumno() throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
          //  pstmt = con.prepareStatement("select * from alumno  where grupo not in(13,14,15,16)");
      pstmt = con.prepareStatement("select * from alumno  where grupo in(9,10,11,12)");
            ResultSet rs = pstmt.executeQuery();
            
            //int us=0;
            while(rs.next()){
             
                    alumno = new Alumno();
                    alumno.setNombre(rs.getString("apellidop"));
                    alumno.setApeP(rs.getString("nombre"));
                    alumno.setCuenta(rs.getString("id"));
              
            
            
               Statement stm = con.createStatement();
                       stm.execute("update alumno set nombre ='" + alumno.getNombre() + "', apellidop='" + alumno.getApeP()  + "' where id='" + alumno.getCuenta() + "';" );
            
            
            }
                
                    pstmt.close();
                    
            }
 
public List<Alumno> listarAlumnos(int grupo) throws SQLException{

 Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
       
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from getAlumno where  idgrupo = ? order by 2");
            pstmt.setInt(1, grupo);
            ResultSet rs = pstmt.executeQuery();
            
             List<Alumno>  alumnos = new ArrayList<Alumno>();
      
            //int us=0;
            while(rs.next()){
             
                    alumno = new Alumno();
                     alumno.setNombre(rs.getString(1));
                   alumno.setApeP(rs.getString(2));
                    alumno.setApeM(rs.getString(3));
                    
                    alumno.setGrupo(rs.getString(4));
                    alumno.setCuenta(rs.getString(5));
                    alumno.setBrigada(rs.getInt(6));
                    
                    alumno.setCorreo((rs.getString(7)==null)?"":rs.getString(7));
                    alumno.setSemestre(rs.getString(8));
                     alumno.setSemestre(rs.getString(9));
                    alumnos.add(alumno);
               }
                
                    pstmt.close();

return alumnos;
}
}


