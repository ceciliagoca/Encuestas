/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.sql.Connection;
import java.sql.Date;
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
public class Encuesta {
    List <Preguntas> l;
    private int i=0; //numero de pregunta
    private String idAlumno;
    private int idPractica;
    
    
      private String nombre, tipo, nombreAlumno, semestre;
      int grupo, cal, brigada, id;

    
    public Encuesta(){
     l =  new ArrayList<Preguntas>();
    };
    
    public Encuesta(String alumno,int practica) {
    idAlumno = alumno;
    idPractica = practica;
    l =  new ArrayList<Preguntas>();
    }
 
  
     public void addPregunta(String opc ,String coment){
         l.add(new Preguntas(i++,Integer.parseInt(opc),coment));
     }
     
      public void addPregunta(int p, int opc ,String coment){
         l.add(new Preguntas(p,opc,coment));
     }
    
     
     
     
     
    public List<Preguntas> getL() {
        return l;
    }

    public void setL(List<Preguntas> l) {
        this.l = l;
    }

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    public String getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(String idAlumno) {
        this.idAlumno = idAlumno;
    }

    public int getIdPractica() {
        return idPractica;
    }

    public void setIdPractica(int idPractica) {
        this.idPractica = idPractica;
    }
    
     public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    Date fecha;

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public int getBrigada() {
        return brigada;
    }

    public void setBrigada(int brigada) {
        this.brigada = brigada;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
   
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getGrupo() {
        return grupo;
    }

    public void setGrupo(int grupo) {
        this.grupo = grupo;
    }
    
  
     public int getCal() {
        return cal;
    }

    public void setCal(int cal) {
        this.cal = cal;
    }
    

    
}
