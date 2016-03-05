/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;

import entity.Alumno;
import entity.Buzon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexion;
import utils.Correo;

/**
 *
 * @author DIMEI
 */
public class ABCBuzon {
    Buzon buzon;

    public ABCBuzon(Buzon buzon) {
        
    }
      public ABCBuzon() {
        
    }

    public Buzon getBuzon() {
        return buzon;
    }

    public void setBuzon(Buzon buzon) {
        this.buzon = buzon;
    }
      
    
   public void saveBuzon() throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select addBuzon(?,?,?)");
            pstmt.setString(1, buzon.getAlumno());
            pstmt.setString(2, buzon.getQueja());
            pstmt.setBoolean(3, buzon.isSeguimiento());
            
            
            
            ResultSet rs = pstmt.executeQuery();
            
                    pstmt.close();
                    rs.close();
            }
 
      public String viewBuzonAlumnos(String sem) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from readbuzon(?)");
            pstmt.setString(1, sem);
             StringBuffer a = new StringBuffer();
            
            
            ResultSet rs = pstmt.executeQuery();
           buzon = new Buzon();
            while(rs.next()){
            buzon.setAlumno(rs.getString(8));
            buzon.setName_alumno(rs.getString(5)+" "+ rs.getString(6)+ " "+ rs.getString(7));
            String aux  =  (rs.getInt(1)<10)?"00":(rs.getInt(1)<100)?"0":"";
            buzon.setId_aux( "A" +aux+rs.getInt(1));
            buzon.setId(rs.getInt(1));
            buzon.setQueja(rs.getString(2));
            buzon.setSeguimiento((rs.getString(3).equals("t"))?true:false);
            buzon.setFecha(rs.getDate(4));
            buzon.setRespesta(rs.getString(9));
           
            
            a.append("<tr onclick='showComment("+buzon.getId()+")'><td>" +buzon.getId_aux()  + "</td> <td>" +buzon.getFecha() + "</td> <td>" +buzon.getAlumno() + "</td>  <td>" +buzon.getName_alumno() +"</td>");
            if(buzon.getRespesta()!=null){
            a.append("<td><img src='imgs/check.png' width='15px'></td></tr>");
            }else {a.append( "<td> </td></tr>"); }
            }
            
                    pstmt.close();
                    rs.close();
                    
                    
                    return a.toString();
            }
      
      
       public String viewQueja(String sem,int queja) throws SQLException{
      
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from  readBuzon(?,?);");
            pstmt.setString(1, sem);
            pstmt.setInt(2, queja);
             StringBuffer a = new StringBuffer();
            
            ResultSet rs = pstmt.executeQuery();
           buzon = new Buzon();
           rs.next();
            buzon.setAlumno(rs.getString(8));
            buzon.setName_alumno(rs.getString(5)+" "+ rs.getString(6)+ " "+ rs.getString(7));
            String aux  =  (rs.getInt(1)<10)?"00":(rs.getInt(1)<100)?"0":"";
            buzon.setId_aux( "A" +aux+rs.getInt(1));
            buzon.setId(rs.getInt(1));
            buzon.setQueja(rs.getString(2));
            buzon.setSeguimiento((rs.getString(3).equals("t"))?true:false);
            buzon.setFecha(rs.getDate(4));
            buzon.setRespesta(rs.getString(9));
           
            
            a.append("Buzon:" + buzon.getId_aux()
                    + "Alumno: " + buzon.getAlumno() + "No. Cuenta:"+ buzon.getAlumno() + "<br>"
                    + "Fecha: " + buzon.getFecha()+"<br>"
                    + "Comentario: <br>" + buzon.getQueja());
            
                    pstmt.close();
                    rs.close();
                    
                    
                    return a.toString();
            }
      
      
      
      public void viewBuzonProfesores() throws SQLException{
      
      }
   
   
      
      public void sendRespuesta(int buzon, String respuesta) throws SQLException{
            //save in the data base
            Conexion c = new Conexion();
            Connection  con = c.getConexion();
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select saveAnswerBuzon(?,?)");
            pstmt.setInt(1, buzon);
            pstmt.setString(2, respuesta);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            

            //send correo
            Correo correo =  new Correo();
            
            correo.sendMail(rs.getString(1), "Buzón: Lab. automatización industrial", respuesta);

            rs.close();
            pstmt.close();
            con.close();

         
     
         
      
      }
}

