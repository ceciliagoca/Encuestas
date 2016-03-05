/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ABC;

import entity.Grupo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexion;

/**
 *
 * @author DIMEI
 */
public class ABCComentarios {
             
    
    private String pregPracticas[] = new String[14];
    private String pregServicio[] = new String[14];
    
    
    private void encuestaPractica(){
        
        pregPracticas[0]="1.- ¿Se te entregó el material necesario y suficiente para la realización de la práctica?";
        pregPracticas[1]="2.- La disponibilidad del material y equipo para realizar la práctica fue: ";
        pregPracticas[2]="3.- ¿El profesor dio a conocer el objetivo al inicio de la práctica? ";
        pregPracticas[3]="4.- El funcionamiento del equipo para realizar la práctica fue ";
        pregPracticas[4]="5.- La explicación de los conceptos previos a la páctica fue ";
        pregPracticas[5]="6.- Las indicaciones para el desarrollo de la práctica fueron ";
        pregPracticas[6]="7.- La aclaracion de dudas durante la práctica fue: ";
        pregPracticas[7]="8.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de la práctica? ";
        pregPracticas[8]="9.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue  ";
        pregPracticas[9]="10.- Considera que la iluminación, aislamiento de ruido y condiciones de seguridad fueron ";
        pregPracticas[10]="11a. En caso de haberse presentado fallas, indica si fue oportuna su atención para cada uno de los siguientes equipos: ";
        pregPracticas[11]="12.- ¿Consideras que se cumplió el objetivo de la práctica? ";
        pregPracticas[12]="13.- Tu satisfacción respecto al servicio proporcionado por el laboratorio fue ";
        pregPracticas[13]="COMENTARIOS Y/O SUGERENCIAS: ";
        
    }
    
    private void encuestaServico(){
        
        pregServicio[0] ="1.- ¿Se te entregó el material necesario y suficiente para la realización de las prácticas?";
        pregServicio[1] ="2.- La disponibilidad del equipo fue";
        pregServicio[2] ="3.- La disponibilidad del material fue";
        pregServicio[3] ="4a.- El funcionamiento del equipo de control (PLC) para realizar las prácticas fue";
        pregServicio[4] ="4b.- El funcionamiento del equipo neumático para realizar las prácticas fue";
        pregServicio[5] ="4c.- El funcionamiento del equipo de cómputo (Software) para realizar las prácticas fue";
        pregServicio[6] ="4d.- El funcionamiento del equipo de cómputo (Hardware) para realizar las prácticas fue";
        pregServicio[7] ="5.- La disponibilidad del manual de prácticas fue";
        pregServicio[8] ="6.- ¿Se cuenta con las mesas y sillas adecuadas para la realización de las prácticas?";
        pregServicio[9] ="7.- La funcionalidad de las instalaciones (eléctricas, neumática y de iluminación) fue:";
        pregServicio[10] ="8.- Consideras que la ventilación, aislamiento de ruido y condiciones de seguridad fueron: ";
        pregServicio[11] ="9.- ¿El laboratorio cumplió con tus expectativas iniciales en cuanto a los conocimientos y habilidades adquiridas?";
        pregServicio[12] ="10.- Tu satisfacción general con respecto al servicio proporcionado por el laboratorio fue:";
        pregServicio[13] ="COMENTARIOS Y/O SUGERENCIAS:";
       
    }
    
    
   
       
    public String l_comentariosPracticaxSemestre(String semestre) throws SQLException{
          encuestaPractica();
          StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
         
          //  semestre = "2015-1";
            for(int i=0; i<pregPracticas.length ;i++){
                
                int p= (i>10) ? i+5 :  i+1;
                
                        PreparedStatement pstmt = con.prepareStatement("select count(*) from l_comentarios where semestre = ? and pregunta = ? and tipo='A' ");
                        pstmt.setString(1, semestre);
                        pstmt.setInt(2, p);
                        
                        ResultSet rs = pstmt.executeQuery();
                        if(rs.next()) {
                                
                            int count =  rs.getInt(1) ;
                            if(count > 0)
                            {
                                salida.append("<h3>"+ pregPracticas[i] +" ("+ count+ ")</h3> <div><p id=\"p_"  +p +"\">"); 
                                          String query= "select  distinct c.idgrupo, g.grupo, g.p_titulo, g.p_nombre , g.p_apep, g.p_apem  from\n" +
"l_comentarios  as c  full outer join l_gruposxsemestre(?) as g  on (c.idgrupo = g.idg ) where c.semestre = ?  and pregunta =? and tipo='A' order by 2;";
                                          PreparedStatement pstmt_grupo = con.prepareStatement(query);
                                          pstmt_grupo.setString(1, semestre); pstmt_grupo.setString(2, semestre); pstmt_grupo.setInt(3, p);
                                          ResultSet rs_grupo = pstmt_grupo.executeQuery();
                                           
                                             while(rs_grupo.next()){
             
                                                    Grupo grupo = new Grupo(rs_grupo.getInt(1),0,rs_grupo.getString(2),rs_grupo.getString(3) +  " " + rs_grupo.getString(6) + " " + rs_grupo.getString(4) +" " + rs_grupo.getString(5)); 
                                                       salida.append(" <ul>");
                                                       salida.append("<li>");

                                                        salida.append("<span id='bt_"+grupo.getId()+"_"+p+"'> <img src='imgs/up.png' width='20px' onclick=\"chargeComments("+grupo.getId()+","+p+",'A')\"  style='cursor:pointer'> </span>");
                                                       salida.append(" Grupo: " + grupo.getGrupo() +" (" + grupo.getProfesor() + ") <div id=\"g_" + grupo.getId() +"_" +p+ "\"> </div></li>");



                                                       salida.append("</ul>" );
                        
                 
                                                } 
                                             
                                             rs_grupo.close();
                                
                            }else{
                            
                              salida.append("<h3>"+ pregPracticas[i] +" (0)</h3> <div><p id=\"p_"  +p +"\">"); 
                            
                            }
                        }
                        
                        
                         salida.append(" </p></div>");
             rs.close();
             pstmt.close();
                         
            }
                          
               /*if(rs)         
             
            
            
            }
            
           
            
          */
            
            
            return salida.toString();
    }
       
    
    
       
    public String l_comentariosPracticaxSemestre(String semestre,int grupo_) throws SQLException{
          encuestaPractica();
          StringBuffer salida = new StringBuffer();
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
         
          //  semestre = "2015-1";
            for(int i=0; i<pregPracticas.length ;i++){
                
                int p= (i>10) ? i+5 :  i+1;
                
                        PreparedStatement pstmt = con.prepareStatement("select count(*) from l_comentarios where semestre = ? and pregunta = ? and tipo='A' and idgrupo="+grupo_);
                        pstmt.setString(1, semestre);
                        pstmt.setInt(2, p);
                        
                        ResultSet rs = pstmt.executeQuery();
                        if(rs.next()) {
                                
                            int count =  rs.getInt(1) ;
                            if(count > 0)
                            {
                                salida.append("<h3>"+ pregPracticas[i] +" ("+ count+ ")</h3> <div><p id=\"p_"  +p +"\">"); 
                                          String query= "select  distinct c.idgrupo, g.grupo, g.p_titulo, g.p_nombre , g.p_apep, g.p_apem  from\n" +
"l_comentarios  as c  full outer join l_gruposxsemestre(?) as g  on (c.idgrupo = g.idg ) where c.semestre = ?  and pregunta =? and tipo='A' and idgrupo="+grupo_ +" order by 2;";
                                          PreparedStatement pstmt_grupo = con.prepareStatement(query);
                                          pstmt_grupo.setString(1, semestre); pstmt_grupo.setString(2, semestre); pstmt_grupo.setInt(3, p);
                                          ResultSet rs_grupo = pstmt_grupo.executeQuery();
                                           
                                             while(rs_grupo.next()){
             
                                                    Grupo grupo = new Grupo(rs_grupo.getInt(1),0,rs_grupo.getString(2),rs_grupo.getString(3) +  " " + rs_grupo.getString(6) + " " + rs_grupo.getString(4) +" " + rs_grupo.getString(5)); 
                                                       salida.append(" <ul>");
                                                       salida.append("<li>");

                                                       salida.append("<span id='bt_"+grupo.getId()+"_"+p+"'> <img src='imgs/up.png' width='20px' onclick=\"chargeComments("+grupo.getId()+","+p+",'A')\"  style='cursor:pointer'> </span>");
                                                       salida.append(" Grupo: " + grupo.getGrupo() +" (" + grupo.getProfesor() + ") <div id=\"g_" + grupo.getId() +"_" +p+ "\"> </div></li>");



                                                       salida.append("</ul>" );
                        
                 
                                                } 
                                             
                                             rs_grupo.close();
                                
                            }else{
                            
                              salida.append("<h3>"+ pregPracticas[i] +" (0)</h3> <div><p id=\"p_"  +p +"\">"); 
                            
                            }
                        }
                        
                         salida.append(" </p></div>");
             rs.close();
             pstmt.close();
                         
            }
                          
               /*if(rs)         
             
            
            
            }
            
           
            
          */
            
            
            return salida.toString();
    }
       
    
    
    
    public String showComentarios(int grupo, int pregunta, int tipo) throws SQLException{
          StringBuffer salida = new StringBuffer();
           
          Conexion c = new Conexion();
          Connection  con = c.getConexion();
         
            PreparedStatement pstmt;
            String t_ = (tipo==1)? "A" : "B";
            pstmt = con.prepareStatement("select * from l_comentarios where idgrupo = "+ grupo + " and pregunta = " + pregunta + " and tipo ='"+t_+"'");
            ResultSet rs = pstmt.executeQuery();
           int practica =0;
            while(rs.next()){
                
                if(rs.getInt(11) != practica){
                   salida.append("<h4> " + rs.getString(7) + "</h4>");
                   practica = rs.getInt(11);
                }
                
                salida.append("<ul>");
                            salida.append("<li>");  
                            salida.append( "Brigada " + rs.getInt(5) + "<br>");
                            salida.append("<img src=\"imgs/icoPuntoAzul.jpg\" width=\"7px\" hspace=\"8px\">" + rs.getString(9) ); 
                            salida.append("</li>");
                            salida.append("</ul>");
            
            }
        
           return salida.toString();
    }
}
