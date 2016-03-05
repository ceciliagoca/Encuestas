package entity;

import java.sql.SQLException;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */
public class Profesor {
    
    private String rfc, correo;
    private String titulo, nombre, apeM, apeP;
   private boolean  activo;

    public Profesor() {
    }

  
    public Profesor(String rfc,String titulo, String nombre, String apeP, String apeM,  String correo,  boolean activo){
        this.rfc = rfc;
        this.correo = correo;
        
        this.nombre = nombre;
        this.apeP = apeP;
        this.apeM = apeM;
        
        this.activo = activo;
        this.titulo=titulo;
              
              
    
    }
    
    
    
    public String getTitulo() {
        return titulo;
    }
    

    
    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getNombre() {
        return nombre;
    }

    public boolean getActivo() {
        return activo;
    }
    
    public void serActivo(boolean activo){
    this.activo = activo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApeM() {
        return apeM;
    }

    public void setApeM(String apeM) {
        this.apeM = apeM;
    }

    public String getApeP() {
        return apeP;
    }

    public void setApeP(String apeP) {
        this.apeP = apeP;
    }

 
    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }


    

    
    
    
    
}
