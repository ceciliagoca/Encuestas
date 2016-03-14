/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;


import entity.Semestre;
import java.sql.Connection;
import java.sql.Date;
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
public class ABCSemestre {
    
    Semestre semestre;
    String current;

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) throws SQLException {
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
       
        
              PreparedStatement pstmt1  = con.prepareStatement("select * from listarSemestre where id = ?");
              pstmt1.setString(1, current);
              ResultSet    rs1 = pstmt1.executeQuery();
               if(rs1.next()){
               
                   this.current =  (rs1.getString(1)!=null  ) ? current : "";         
               }    else{
               this.current="";
               }   
       
    }
    
    
        public List listarSemestres() throws SQLException{
      
        List<String> semestres= new ArrayList<String>();
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
                pstmt = con.prepareStatement("select * from listarSemestre");
                ResultSet rs = pstmt.executeQuery();
            
            
            
            while( rs.next())
             semestres.add(rs.getString(1));
    
            
            con.close();
            pstmt.close();
            rs.close();
                    
            return semestres;
                    
            } 
        
          public StringBuffer listarSemestresMenu() throws SQLException{
      
              
              
              
              
      StringBuffer tabla = new StringBuffer();
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement  pstmt = con.prepareStatement("select semestre_actual()");
               ResultSet rs = pstmt.executeQuery();
               if (rs.next()){ 
                 
                if(rs.getString(1)!=null){
                      tabla.append("<li><a href='#' onclick=\"cargarSemestre('" + rs.getString(1) + "')\"> Actual </a></li>") ;
                }
             
               }
       
            rs.close();
              pstmt.close();
       
             PreparedStatement pstmt1  = con.prepareStatement("select * from listarSemestre where fin< current_date;");
              ResultSet    rs1 = pstmt1.executeQuery();
                        
            int count =0 ;
            while( rs1.next() && count < 5)
            {
                tabla.append("<li><a href='#' onclick=\"cargarSemestre('" + rs1.getString(1) + "')\">" + rs1.getString(1) + "</a></li>");
                count++;
            }
           
            
           
           
            
            rs1.close();
           
              pstmt1.close();
                 con.close();    
            return tabla;
                    
            } 

  
          
          public String listarSemestresCatalgo() throws SQLException{
          StringBuffer sb = new StringBuffer();
              
          
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
                pstmt = con.prepareStatement("select * from listarSemestre");
                ResultSet rs = pstmt.executeQuery();
            
           
            
            while( rs.next()){
                 String s = rs.getString(1).replaceAll("\\s","");
           sb.append("<tr>  <td> <span style=\"cursor:pointer;\" onclick=\"showCMenu('"+s+"')\">"+ rs.getString(1)  
                   +" </span>   <div id=\"c_menu_"+s+"\" class=\"c_menu\"> \n" +
"            <img src=\"imgs/vermas.png\" onclick=\"contenidoP('con_div_emergente','catalogos/semestres/verMas.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();\"> \n" +
//"            <img src=\"imgs/editar.png\" onclick=\"contenidoP('con_div_emergente','catalogos/profesores/editar.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();\"> \n" +
//"            <img src=\"imgs/eliminar.png\" onclick=\"contenidoP('con_div_emergente','catalogos/profesores/eliminar.jsp','<%=profesor.getRfc()%>'); $('#div_emergente').show();\"> </div>"
                    " </td>   <td> "+ rs.getString(2)  +"  </td>   <td>  "+   rs.getString(3) +" </td></tr>"); 
    
            }
            con.close();
            pstmt.close();
            rs.close();
          
           
              
          return sb.toString();
          }
    public void saveSemestre(String sem, Date de, Date a) throws SQLException{
        
        
         Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
                pstmt = con.prepareStatement("select addSemestre(?,?,?)");
                pstmt.setString(1, sem);
                pstmt.setDate(2, de);
                pstmt.setDate(3,a );                
                ResultSet rs = pstmt.executeQuery();
            
        
            con.close();
            pstmt.close();
            rs.close();
    }
    
    public void  getCurrentSemester() throws SQLException{
      
      current = "";
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
                pstmt = con.prepareStatement("select semestre_actual()");
                ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) current =  (rs.getString(1)!=null)?rs.getString(1):"";
    
            
            con.close();
            pstmt.close();
            rs.close();
          
                    
            } 

   
     public String  consultarSemestreActual() throws SQLException{
      
      String current_ = "";
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
                pstmt = con.prepareStatement("select semestre_actual()");
                ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) current_ =  (rs.getString(1)!=null)?rs.getString(1):"";
    
            
            con.close();
            pstmt.close();
            rs.close();
          
                    return current_;
            } 

    
     public String listarGruposMenu() throws SQLException{
     
      StringBuffer tabla = new StringBuffer();
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement  pstmt = con.prepareStatement("select * from l_gruposxsemestre(?) order by 2;");
            pstmt.setString(1, current);
               ResultSet rs = pstmt.executeQuery();
             
               while( rs.next() )
            {
                  tabla.append("<li class='has-sub'><a href='#'> <center>"+  rs.getString(2) +"  (" + rs.getString(4) +" "+ rs.getString(5) +") </center> </a> ");
                  
                  
                  tabla.append(" <ul>  <li> <a href=\"#\" onclick=\"mostrarAlumnos('" + rs.getInt(1)+ "')\" >  Alumnos </a></li> </ul></li> ");
                          //+ "<a href=\"#\" >buscar encuesta </a><a href=\"#\" > inidcadores </a></li> </ul></li>") ;
               
                      
            }
           
            
           
           
            
            rs.close();
           
              pstmt.close();
                 con.close();    
            return tabla.toString();
     }
     
    
      public String listarGruposMenu(String profesor, String semestre) throws SQLException{
     
      StringBuffer tabla = new StringBuffer();
      Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement  pstmt = con.prepareStatement("select * from l_gruposxsemestre(?) where profesor =  ? ; ");
            pstmt.setString(1, current);
            pstmt.setString(2, profesor);
               ResultSet rs = pstmt.executeQuery();
             
               while( rs.next() )
            {
               tabla.append("<li class='has-sub'><a href='#'> <center> <b> Grupo: "+ rs.getString(2)+"</b> </center> </a> "
                  
                  
               +" <ul>  "
                        + "<li> <a href=\"#\" onclick=\"mostrarAlumnos('" + rs.getInt(1)+ "')\" >   <center> Alumnos  </center>  </a></li> " +
                        
                     " <li class='has-sub'><a href='#'> <center> <b> Encuestas </b> </center>  </a>  " +
                       " <ul>    " +  
                       "<li> <a href=\"#\" onclick=\"contenido('contenido','consultas/encuestas/listarPracticasProfesor.jsp', '"+ profesor+"');\">   <center>  Ver practicas  </center></a>  </li>"+
                                                  "   <li><a href='#' onclick=\"showResumenGrupo('"+ rs.getInt(1) + "')\"> <center>  Resumen de encuestas  </center>  </a>  </li> " +
                   //      "   <li> <a href=\"#\" onclick=\"vistaComentarios('1','<%=semestre.getCurrent()%>')\">   V\"</a>  </li>\n" 
                    " <li><a href='#' onclick=\"vistaComentariosGrupo('1','"+semestre+"', '" + rs.getInt(1) +"')\"> <center> Ver comentarios de practicas  </center>  </a>  </li> " +
                        
                         " </ul> </li> "
                       
            + "</ul></li>");
                    
            }
           
            
           
           
            
            rs.close();
           
              pstmt.close();
                 con.close();    
            return tabla.toString();
     }
     
    public boolean incioSemestre() throws SQLException{
     
        boolean inicio = false;
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
         PreparedStatement pstmt;
                pstmt = con.prepareStatement("select * from findemestre");
                ResultSet rs = pstmt.executeQuery();
                
                rs.next();
                
java.util.Date date = new java.util.Date();
//java.sql.Date sqlDate = new java.sql.Date( date.getTime() );
                
               inicio = (rs.getDate(1).before(date) )?true:false;
               
               System.out.println("fechas " + rs.getDate(1) +" " + date + " inici " + inicio );
        return inicio;
    }

    public Semestre getSemestre() {
        return semestre;
    }

    public void setSemestre(Semestre semestre) {
        this.semestre = semestre;
    }
    
   boolean inicio = true;

    public boolean isInicio() {
        return inicio;
    }

    public void setInicio(boolean inicio) {
        this.inicio = inicio;
    }
   
   
   
   
}
