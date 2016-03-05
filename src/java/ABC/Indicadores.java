package ABC;




import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexion;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */
public class Indicadores {
   
    private String semestre;

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }
    
    
    
    //general
    public String iservicio(int ind)throws SQLException{
            String res="";
    
            Conexion c = new Conexion();
            Connection  con = c.getConexion();
            
            PreparedStatement pstmt;
            String query;
            switch(ind){
              
                case 1: query = "select round ( cast( 100 * cast (count(*) as float) / (select count(*)  from q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' )  as float)::numeric,2) from  q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' and opcion in(10,8)" ; break;
                    
                    
                case 2: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'B' and npregunta in(4,5,6,7)"  ; break;
                     
                case 6: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 13"  ; break;
                    
               
                case 10: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 1"; break;
                    
               // case 11: query=""; break;
                    
                case 12: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 10"; break;
                    
                case 13: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 11"; break;
                    
                case 14: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 9" ;break;
                
                case 15: query = "select round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"' and tipo = 'B' and npregunta = 12" ; break;
                    
                    
                    
                    
                default: query = null;
                       
            }
            
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while(rs.next()) {
           
            res = rs.getString(1);
             //System.out.println(res);
            }
            
            
            pstmt.close();
            con.close();
            
            return res;
    }
    
     public String promedioPracticas(int ind)throws SQLException{
            String res="";
    
            Conexion c = new Conexion();
            Connection  con = c.getConexion();
            
            PreparedStatement pstmt;
            String query;
            switch(ind){
              
             /*   case 1: query = "select round ( cast( 100 * cast (count(*) as float) / (select count(*)  from q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' )  as float)::numeric,2) from  q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' and opcion in(10,8)" ; break;
               */     
                    
                case 1: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(1)"  ; break;
                    
                    case 2: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(2)"  ; break;
                     
                        
                        case 3: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(3)"  ; break;
                     
                            
                            case 4: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(4)"  ; break;
                     
                                
                                case 5: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(5)"  ; break;
                     
                                    
                                    case 6: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(6)"  ; break;
                     
                                        
                                        case 7: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(7)"  ; break;
                     
                                            
                                            case 8: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(8)"  ; break;
                     
                                                
                                                case 9: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(9)"  ; break;
                                                    
                                                    
                                                                case 10: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(10)"  ; break;
                                                                                case 13: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(17)"  ; break;
                     
                    
                default: query = null;
                       
            }
            
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while(rs.next()) {
           
            res = rs.getString(1);
             System.out.println(res);
            }
            
            
            pstmt.close();
            con.close();
            
            return res;
    }


  public String promedioPracticas(int ind, int grupo)throws SQLException{
            String res="";
    
            Conexion c = new Conexion();
            Connection  con = c.getConexion();
            
            PreparedStatement pstmt;
            String query;
            switch(ind){
              
             /*   case 1: query = "select round ( cast( 100 * cast (count(*) as float) / (select count(*)  from q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' )  as float)::numeric,2) from  q_encuestas \n" +
                        "where semestre = '" + semestre+"' and tipo = 'B' and opcion in(10,8)" ; break;
               */     
                    
                case 1: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(1) and idgrupo = " + grupo  ; break;
                    
                    case 2: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(2) and idgrupo = " + grupo  ; break;
                     
                        
                        case 3: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(3) and idgrupo = " + grupo   ; break;
                     
                            
                            case 4: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(4) and idgrupo = " + grupo  ; break;
                     
                                
                                case 5: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(5) and idgrupo = " + grupo   ; break;
                     
                                    
                                    case 6: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(6) and idgrupo = " + grupo   ; break;
                     
                                        
                                        case 7: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(7) and idgrupo = " + grupo   ; break;
                     
                                            
                                            case 8: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(8) and idgrupo = " + grupo   ; break;
                     
                                                
                                                case 9: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(9)  and idgrupo = " + grupo  ; break;
                              
                                                                case 10: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(10)"  ; break;
                           case 13: query = "select  round(10*avg(opcion)::numeric,2) from q_encuestas_profesor \n" +
                            "where semestre = '" + semestre+"'and tipo = 'A' and npregunta in(17)  and idgrupo = " + grupo  ; break;
                     
                    
                default: query = null;
                       
            }
            
            pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
        
            while(rs.next()) {
           
            res = rs.getString(1);
             System.out.println(res);
            }
            
            
            pstmt.close();
            con.close();
            
            return res;
    }
}

