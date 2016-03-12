/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;
import entity.Encuesta;
import entity.Grupo;
import entity.Preguntas;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import utils.Conexion;

/**
 *
 * @author Cecilia
 */
public class ABCEncuestas {
  
  public Encuesta practica;
   public Encuesta encuesta;

    public Encuesta getPractica() {
        return practica;
    }

    public void setPractica(Encuesta practica) {
        this.practica = practica;
    }

    public Encuesta getEncuesta() {
        return encuesta;
    }

    public void setEncuesta(Encuesta encuesta) {
        this.encuesta = encuesta;
    }
  

    public ABCEncuestas() {
    }
    
                  
     public List<Encuesta> listarPracticas() throws SQLException{
      
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
   
       
       List<Encuesta>  encuestas = new ArrayList<Encuesta>();
       Encuesta pratica = new Encuesta();
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from listarPracticas");
           
           
            ResultSet rs = pstmt.executeQuery();
            
            
            
                while(rs.next()){
              
                    practica.setId(rs.getInt(1));
                    practica.setNombre(rs.getString(2));
                    encuestas.add(practica);
                }
                
                pstmt.close();
                    
            
     return encuestas;
     }
            
            
     public void gettPracticas(int idp, String alumno) throws SQLException{
                   practica = new Encuesta();
      
       Conexion c = new Conexion();
       Connection  con = c.getConexion();
    
       
     
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from getPractica where id = ? and alumno = ?");
           
           pstmt.setInt(1, idp);
           pstmt.setString(2, alumno);
            ResultSet rs = pstmt.executeQuery();
            
            rs.next();
            practica.setNombre(rs.getString(2));
            practica.setSemestre(rs.getString("semestre"));
            
            
                
     }
            
   
    public String listarEncuestas() throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
          
         
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_grupo");
            ResultSet rs = pstmt.executeQuery();
            
                    salida.append("<UL>");
                while(rs.next()){
              
                    salida.append(" <li> <span id='bt_"+rs.getInt(1)+"' ><img src='imgs/up.png' style='cursor:pointer' onclick='l_alumnosDe(" + rs.getInt(1) +")'></span> Grupo: " + rs.getString(2) + "(" + rs.getString(3) + " " +  rs.getString(6) + " " +  rs.getString(4) + " " +  rs.getString(5) + ") ");
                    salida.append("<div id='g_" + rs.getInt(1) + "'>");
                    
                        
                    
                    
                    salida.append("</div>");
                    salida.append("</li>");
                }
                    salida.append("</UL>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
     
    
    
     public String listarEncuestas(String semestre) throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
          
         
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_gruposxsemestre(?) ");
            pstmt.setString(1, semestre);
            ResultSet rs = pstmt.executeQuery();
            
                    salida.append("<UL>");
                while(rs.next()){
              
                    salida.append(" <li> <span id='bt_"+rs.getInt(1)+"' ><img src='imgs/up.png' style='cursor:pointer' onclick='l_alumnosDe(" + rs.getInt(1) +")'></span> Grupo: " + rs.getString(2) + "(" + rs.getString(3) + " " +  rs.getString(6) + " " +  rs.getString(4) + " " +  rs.getString(5) + ") ");
                    salida.append("<div id='g_" + rs.getInt(1) + "'>");
                    
                        
                    
                    
                    salida.append("</div>");
                    salida.append("</li>");
                }
                    salida.append("</UL>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
     
      public String listarEncuestas(String profesor, String semestre) throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
          
         
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_gruposxsemestre(?) where profesor = ?");
            pstmt.setString(1, semestre);
              pstmt.setString(2, profesor);
            ResultSet rs = pstmt.executeQuery();
            
                    salida.append("<UL>");
                while(rs.next()){
              
                    salida.append(" <li> <span id='bt_"+rs.getInt(1)+"' ><img src='imgs/up.png' style='cursor:pointer' onclick='l_alumnosDe(" + rs.getInt(1) +")'></span> Grupo: " + rs.getString(2) + "(" + rs.getString(3) + " " +  rs.getString(6) + " " +  rs.getString(4) + " " +  rs.getString(5) + ") ");
                    salida.append("<div id='g_" + rs.getInt(1) + "'>");
                    
                        
                    
                    
                    salida.append("</div>");
                    salida.append("</li>");
                }
                    salida.append("</UL>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
     
     
    
  public String listarFaltantes() throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
                  
           PreparedStatement pstmt = con.prepareStatement("select * from l_grupo");
           ResultSet rsGrupo = pstmt.executeQuery();
           
           while(rsGrupo.next()){
               int grupo = rsGrupo.getInt(1);
               PreparedStatement ps_faltantes = con.prepareStatement("select count(*) from l_faltantes(?)");
               ps_faltantes.setInt(1, grupo);
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               rs_faltantes.next();
               
                salida.append(" <li> <span id='bt_"+grupo+"' ><img src='imgs/up.png' style='cursor:pointer' onclick='l_practicasF_De(" + grupo +")'></span> Grupo: " + rsGrupo.getString(2) + "(" + rsGrupo.getString(3) + " " +  rsGrupo.getString(6) + " " +  rsGrupo.getString(4) + " " +  rsGrupo.getString(5) + "("+ rs_faltantes.getInt(1)+")");
                salida.append("<div id='g_" + grupo + "' style=\"display : none\">");
                
               rs_faltantes.close();
               ps_faltantes.close();
               
               ps_faltantes = con.prepareStatement("SELECT COUNT(*) as count_all, practica , p_nombre FROM l_faltantes(?)  GROUP BY practica, p_nombre  order by 2");
               ps_faltantes.setInt(1, grupo);
               rs_faltantes = ps_faltantes.executeQuery();
               salida.append("<ul>");
                    
               while(rs_faltantes.next()){
                    salida.append(" <li> <span id='bt_"+rs_faltantes.getInt(2)+"_"+grupo+"' ><img width='20px' src='imgs/up.png' style='cursor:pointer'  onclick='l_alumnosF(" + rs_faltantes.getInt(2)+","+grupo +")'></span>"+ rs_faltantes.getString(2) +". "+rs_faltantes.getString(3) +" ("+ rs_faltantes.getString(1) + ")");
                    salida.append("<div id='a_"+rs_faltantes.getInt(2)+"_"+grupo+"'></div>");
                    salida.append("</li>");
               }
                    salida.append("</ul>");
                    
                   salida.append("</div>");
               salida.append("</li>");
            
           }
           
             
               rsGrupo.close();
               pstmt.close();
               
           return salida.toString();
          }
    public String listarFaltantes(String profesor) throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
                  
           PreparedStatement pstmt = con.prepareStatement("select * from l_grupo where profe = ?" );
           pstmt.setString(1, profesor);
           ResultSet rsGrupo = pstmt.executeQuery();
           
           while(rsGrupo.next()){
               int grupo = rsGrupo.getInt(1);
               PreparedStatement ps_faltantes = con.prepareStatement("select count(*) from l_faltantes(?)");
               ps_faltantes.setInt(1, grupo);
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               rs_faltantes.next();
               
                salida.append(" <li> <span id='bt_"+grupo+"' ><img src='imgs/up.png' style='cursor:pointer' onclick='l_practicasF_De(" + grupo +")'></span> Grupo: " + rsGrupo.getString(2) + "(" + rsGrupo.getString(3) + " " +  rsGrupo.getString(6) + " " +  rsGrupo.getString(4) + " " +  rsGrupo.getString(5) + "("+ rs_faltantes.getInt(1)+")");
                salida.append("<div id='g_" + grupo + "' style=\"display : none\">");
                
               rs_faltantes.close();
               ps_faltantes.close();
               
               ps_faltantes = con.prepareStatement("SELECT COUNT(*) as count_all, practica , p_nombre FROM l_faltantes(?)  GROUP BY practica, p_nombre  order by 2");
               ps_faltantes.setInt(1, grupo);
               rs_faltantes = ps_faltantes.executeQuery();
               salida.append("<ul>");
                    
               while(rs_faltantes.next()){
                    salida.append(" <li> <span id='bt_"+rs_faltantes.getInt(2)+"_"+grupo+"' ><img width='20px' src='imgs/up.png' style='cursor:pointer'  onclick='l_alumnosF(" + rs_faltantes.getInt(2)+","+grupo +")'></span>"+ rs_faltantes.getString(2) +". "+rs_faltantes.getString(3) +" ("+ rs_faltantes.getString(1) + ")");
                    salida.append("<div id='a_"+rs_faltantes.getInt(2)+"_"+grupo+"'></div>");
                    salida.append("</li>");
               }
                    salida.append("</ul>");
                    
                   salida.append("</div>");
               salida.append("</li>");
            
           }
           
             
               rsGrupo.close();
               pstmt.close();
               
           return salida.toString();
          }
   public String l_Faltantes_alumnosxpractica(int grupo, int practica) throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
           PreparedStatement ps_faltantes = con.prepareStatement("select * from l_faltantes(?) where practica = ?");
               ps_faltantes.setInt(1, grupo);
               ps_faltantes.setInt(2, practica);
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               
               while(rs_faltantes.next()){
                    salida.append(" <li> No. Cuenta "+rs_faltantes.getString(3)+ ". " +rs_faltantes.getString(7)+" "+rs_faltantes.getString(8)+ " "+ rs_faltantes.getString(6)+"</li>");
               }
           
             
      
          
               
           return salida.toString();
          }
   

 
    public String sendMail_Faltantes_alumnosxpractica(int grupo, int practica) throws SQLException{  // by grupo
        
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
           PreparedStatement ps_faltantes = con.prepareStatement("select * from l_faltantes(?) where practica = ?");
               ps_faltantes.setInt(1, grupo);
               ps_faltantes.setInt(2, practica);
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               
               
               salida.append(" <ul>");
               while(rs_faltantes.next()){
                   salida.append(" <li> No. Cuenta "+rs_faltantes.getString(3)+ ". " +rs_faltantes.getString(7)+" "+rs_faltantes.getString(8)+ " "+ rs_faltantes.getString(6)+"</li>");
               }
               
               salida.append("</ul>"); 
             
      
          
               
           return salida.toString();
          }
    
    public String alumnosNoRegistrados() throws SQLException{
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
         PreparedStatement ps_faltantes = con.prepareStatement("select  * from l_alumnosNoRegistrados()");
               
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               
               
              
               String grupo ="";
               while(rs_faltantes.next()){
               
                   if(!grupo.equals(rs_faltantes.getString(5))){
                      
                       grupo = rs_faltantes.getString(5);
                       salida.append("<br> Grupo: "+grupo +"<br>");
                     
                    }
                   
                    salida.append(" <br>  No. Cuenta "+rs_faltantes.getString(1)+ ". " +rs_faltantes.getString(3)+" "+rs_faltantes.getString(4)+ " "+ rs_faltantes.getString(2)+"</li>");
               }
               
               salida.append("</ul>"); 
             
      
          
               
           return salida.toString();
    }
        
        public String alumnosNoRegistrados(String profesor) throws SQLException{
         StringBuffer salida = new StringBuffer();
         Conexion c = new Conexion();
         Connection  con = c.getConexion();
         PreparedStatement ps_faltantes = con.prepareStatement("select  * from l_alumnosNoRegistrados() as l\n" +
"inner join alumno as a on(l.alumno = a.id)\n" +
"inner join grupo as gr on (gr.idgrupo = a.grupo)\n" +
"where profesor = ?");
         
         ps_faltantes.setString(1, profesor);
               
               ResultSet rs_faltantes = ps_faltantes.executeQuery();
               
               
              
               String grupo ="";
               while(rs_faltantes.next()){
               
                   if(!grupo.equals(rs_faltantes.getString(5))){
                      
                       grupo = rs_faltantes.getString(5);
                       salida.append("<br> Grupo: "+grupo +"<br>");
                     
                    }
                   
                    salida.append(" <br>  No. Cuenta "+rs_faltantes.getString(1)+ ". " +rs_faltantes.getString(3)+" "+rs_faltantes.getString(4)+ " "+ rs_faltantes.getString(2)+"</li>");
               }
               
               salida.append("</ul>"); 
             
      
          
               
           return salida.toString();
    }
      
     public String listarAlumnosxgrupo(int grupo) throws SQLException{
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
          
          List<String>  grupos = new ArrayList<String>();
       
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_alumnosxgrupo(?)");
            pstmt.setInt(1, grupo);
            ResultSet rs = pstmt.executeQuery();
            
           
                while(rs.next()){
              
                    salida.append(" <li> <span id='bt_"+rs.getString(1)+"' ><img width='20px' src='imgs/up.png' style='cursor:pointer'  onclick='l_practicasDe(" + rs.getString(1) +")'></span>  No. cuenta: " +rs.getString(1) +" "+ rs.getString(2) + " " + rs.getString(3) + " " +  rs.getString(4) + ". ");
                    salida.append("<div id='a_" + rs.getString(1) + "'>");
                    salida.append("</ul>");
                    salida.append("</li>");
                  
                }
                
                
                   // salida.append("</UL>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
     
     
      public String l_encuestasxalumno(String alumno) throws SQLException{
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
           PreparedStatement pstmt;
            pstmt = con.prepareStatement("select * from l_encuestasxalumno(?)");
            pstmt.setString(1, alumno);
            ResultSet rs = pstmt.executeQuery();
            boolean ban=false;
                while(rs.next()){
              
                    salida.append(" <li> <span onclick=\"showEncuesta(" +rs.getInt(1) +",'"+rs.getString(4)+"')\""+">  <img src='imgs/doc.png' style='cursor:pointer'>  " +  rs.getString(2) + ".  " + rs.getString(3) + "</span> ");
                    salida.append("</li>");
                     ban=true;
                }
                if(!ban) salida.append("<li>El alumno no tiene encuestas contestadas</li>");
                   // salida.append("</UL>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
      
      
       public String l_encuestasxalumno2(String alumno) throws SQLException{
        
         StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
           PreparedStatement pstmt;
            
            
            pstmt = con.prepareStatement(" select * from getalumno where cuenta = ? ");
            
            pstmt.setString(1, alumno);
            ResultSet rs = pstmt.executeQuery();
            
            if(!rs.next()) {   rs.close(); pstmt.close(); return "_cod_0_";}
            String encabezado = "No.Cuenta: " + rs.getString(5) + "  <BR> Alumno: " + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + "<BR>" ;
            rs.close();
            pstmt.close();
            
            pstmt = con.prepareStatement("select * from l_encuestasxalumno(?)");
            pstmt.setString(1, alumno);
            rs = pstmt.executeQuery();
            
             if(!rs.next()) {   rs.close(); pstmt.close(); return "_cod_1_";}             
             
             salida.append(" <div id=\"menuCE\"> \n" +
"            Opciones de busqueda:   \n" +
"            <ul>\n" +
"                <li onclick=\"contenido('contenido','consultas/encuestas/listar.jsp')\">Por grupo </li>\n" +
"                <li>buscar alumno <input id=\"txt_ncuenta\" type=\"text\" onclick=\"searchByAlumn(this)\"> </li>\n" +
"            <li>Alumnos que no han contestado por encuesta  </li>\n" +
"            <li>ver semestres anteriores  </li>\n" +
"           </ul>\n" +
"          \n" +
"           </div>  " );//menu
             
             
              salida.append("<H1>"+encabezado+"</H1>  <div id=\"listCE\"> ");
             
             
               salida.append(" <li> <span onclick='showEncuesta(" +rs.getInt(1) +")'"+">  <img src='imgs/doc.png' style='cursor:pointer'>  " +  rs.getString(2) + ".  " + rs.getString(3) + "</span> ");
                    salida.append("</li>");
              while(rs.next()){
              
                    salida.append(" <li> <span onclick='showEncuesta(" +rs.getInt(1) +")'"+">  <img src='imgs/doc.png' style='cursor:pointer'>  " +  rs.getString(2) + ".  " + rs.getString(3) + "</span> ");
                    salida.append("</li>");
                }
                   salida.append("</DIV>  <div id=\"showEncuesta\" style=\"display: none\"> </div>");
                rs.close();
                pstmt.close();
                    
            

      
        return salida.toString();
     
      }    
       
       
           
     public void getInfo(int idEncuesta)throws SQLException{
            practica = new Encuesta();
             Conexion c = new Conexion();
             Connection  con = c.getConexion();
             PreparedStatement pstmt  = con.prepareStatement("select * from consultaEncuestaInfo where idencuesta="+idEncuesta);
             ResultSet rs = pstmt.executeQuery();
             if (rs.next()){
               
                  practica.setNombreAlumno(rs.getString(4) + " " + rs.getString(5) + " "+rs.getString(6));
                  practica.setGrupo(rs.getInt(7));
                  practica.setBrigada(rs.getInt(8));
                  practica.setNombre(rs.getString(3));
                  practica.setId(idEncuesta);
                  practica.setSemestre(rs.getString(10));
                  practica.setFecha(rs.getDate(9));
             }else{
                 System.out.println("error: ABCPracticas --> no existe la encuesta");
             }
                     
          getEncuesta(idEncuesta);
       }
    
     public void getEncuesta(int idEncuesta) throws SQLException{
         
             encuesta = new Encuesta();
             Conexion c = new Conexion();
             Connection  con = c.getConexion();
             PreparedStatement pstmt  = con.prepareStatement("select * from consultaEncuesta where a="+idEncuesta);
             ResultSet rs = pstmt.executeQuery();
             while(rs.next()){
                   encuesta.addPregunta(rs.getInt(2),rs.getInt(3),rs.getString(4));
             }
  }
    
     public void registrarEncuesta() throws SQLException {

       Conexion c = new Conexion();
       Connection con = c.getConexion();
        Preguntas lp[] = new Preguntas[18];
        
       if(encuesta.getL().size() == 18){
           Iterator it = encuesta.getL().iterator();
          for(int j =0; j<lp.length;j++)    
              lp[j] = (Preguntas)it.next();
          
         // lp = (Preguntas[])l.toArray();
       PreparedStatement pstmt;
       pstmt = con.prepareStatement("select savePoll(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
       int j=0;
       
       for(int i=0; i<lp.length; i++){
       j++;
       pstmt.setInt(j, lp[i].getOpcion());
       System.err.println(j+" int "+ lp[i].getOpcion());
       j++;
       pstmt.setString(j, lp[i].getComentario());
          
           System.err.println(j+" string "+ lp[i].getComentario());
        
       }
       System.err.println(encuesta.getIdPractica()+" "+encuesta.getIdAlumno());
       pstmt.setInt(37, encuesta.getIdPractica());
      pstmt.setString(38, encuesta.getIdAlumno());
       
       ResultSet rs = pstmt.executeQuery();
        rs.next();
        
       pstmt.close();
        con.close();
       }
       else{
           System.err.println("Algo malo ocurrio");
       }
    }
     
     public String registrarEncuestaServicio() throws SQLException {
String r="good";
       Conexion c = new Conexion();
       Connection con = c.getConexion();
        Preguntas lp[] = new Preguntas[14];
       if(encuesta.getL().size() == 14){
           System.out.println("good"+encuesta.getL().size());
           Iterator it = encuesta.getL().iterator();
          for(int j =0; j<lp.length;j++)    
              lp[j] = (Preguntas)it.next();
          
         // lp = (Preguntas[])l.toArray();
       PreparedStatement pstmt;
       pstmt = con.prepareStatement("select saveEncServ(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
       int j=0;
       
       for(int i=0; i<lp.length; i++){
       j++;
       pstmt.setInt(j, lp[i].getOpcion());
       System.err.println(j+" int "+ lp[i].getOpcion());
       j++;
       pstmt.setString(j, lp[i].getComentario());
          
           System.err.println(j+" string "+ lp[i].getComentario());
        
       }
       System.err.println(encuesta.getIdPractica()+" "+encuesta.getIdAlumno());
       pstmt.setInt(29, encuesta.getIdPractica());
      pstmt.setString(30, encuesta.getIdAlumno());
       
       ResultSet rs = pstmt.executeQuery();
        rs.next();
        
       pstmt.close();
        con.close();
       }
       else{
           r = "Algo malo ocurrio" + encuesta.getL().size();
       }
       
       return r;
    }
     
}