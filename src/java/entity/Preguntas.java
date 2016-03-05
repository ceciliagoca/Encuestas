package entity;

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
public class Preguntas {

    private int nPregunta;
    private int opcion; // 1 (10 9 8 7 6) 2(si o no)
    private String comentario; //
    
    public Preguntas(){}

    
    public Preguntas(int nPregunta, int opcion, String comentario) {
        this.nPregunta = nPregunta;
        this.opcion = opcion;
        this.comentario = comentario;
    }

     

    public int getnPregunta() {
        return nPregunta;
    }

    public void setnPregunta(int nPregunta) {
        this.nPregunta = nPregunta;
    }

    public int getOpcion() {
        return opcion;
    }

    public void setOpcion(int opcion) {
        this.opcion = opcion;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

 
    
}
