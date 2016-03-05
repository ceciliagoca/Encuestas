/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Date;

/**
 *
 * @author DIMEI
 */
public class Horario {
    
    int id;
    String descripcion;
    
    

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
        
    }

   
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

   
    public Horario(int id, String descripcion) {
        this.id = id;
        this.descripcion = descripcion;
        
    }

    public Horario() {
    
    }
    
    
}
