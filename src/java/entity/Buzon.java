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
public class Buzon {
    
    int id;
    String id_aux;
    String queja;
    String alumno;
    String name_alumno;
    boolean seguimiento;
    java.sql.Date fecha;
    String respesta;

    public String getName_alumno() {
        return name_alumno;
    }

    public void setName_alumno(String name_alumno) {
        this.name_alumno = name_alumno;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
    public String getId_aux() {
        return id_aux;
    }

    public void setId_aux(String id) {
        this.id_aux = id;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQueja() {
        return queja;
    }

    public void setQueja(String queja) {
        this.queja = queja;
    }

    public String getAlumno() {
        return alumno;
    }

    public void setAlumno(String alumno) {
        this.alumno = alumno;
    }

    public boolean isSeguimiento() {
        return seguimiento;
    }

    public void setSeguimiento(boolean seguimiento) {
        this.seguimiento = seguimiento;
    }

    public String getRespesta() {
        return respesta;
    }

    public void setRespesta(String respesta) {
        this.respesta = respesta;
    }

    public Buzon(int id, String queja, String alumno, boolean seguimiento) {
        this.id = id;
        this.queja = queja;
        this.alumno = alumno;
        this.seguimiento = seguimiento;
    }

    public Buzon() {
    }
    
    
}
