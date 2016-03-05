package entity;




import java.sql.Connection;
import java.sql.Date;
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
public class Calendarizacion {
    private int idCuestinario;
    private int idPractica;
    private Date inicio; //inicio y fin de practica
    private Date fin;

    public int getIdCuestinario() {
        return idCuestinario;
    }

    public void setIdCuestinario(int idCuestinario) {
        this.idCuestinario = idCuestinario;
    }

    public int getIdPractica() {
        return idPractica;
    }

    public void setIdPractica(int idPractica) {
        this.idPractica = idPractica;
    }

    public Date getInicio() {
        return inicio;
    }

    public void setInicio(Date inicio) {
        this.inicio = inicio;
    }

    public Date getFin() {
        return fin;
    }

    public void setFin(Date fin) {
        this.fin = fin;
    }

    public int getGrupo() {
        return grupo;
    }

    public void setGrupo(int grupo) {
        this.grupo = grupo;
    }
    private int grupo;
    
    public Calendarizacion(){}

    
}
