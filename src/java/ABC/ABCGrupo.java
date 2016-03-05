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
public class ABCGrupo {
    
    Grupo grupo;

    public ABCGrupo(Grupo grupo) {
        this.grupo = grupo;
    }
    
     public ABCGrupo(String grupo, String profesor, int cal) {
        this.grupo = new Grupo(cal,grupo,profesor);
        
    }
    
    public void saveGrupo() throws SQLException{
         Conexion c = new Conexion();
       Connection  con = c.getConexion();
     
            PreparedStatement pstmt;
            pstmt = con.prepareStatement("select addGrupo(?,?,?)");
            pstmt.setString(1, grupo.getGrupo());
            pstmt.setString(2, grupo.getProfesor());
            pstmt.setInt(3, grupo.getCal());
            
            
            ResultSet rs = pstmt.executeQuery();
            
    }
    
    
}
