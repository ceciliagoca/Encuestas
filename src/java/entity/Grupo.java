/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author DIMEI
 */
public class Grupo {
    int id, cal;
    String grupo, profesor;

    public Grupo(int cal, String grupo, String profesor) {
        this.cal = cal;
        this.grupo = grupo;
        this.profesor = profesor;
    }

    public Grupo(int id, int cal, String grupo, String profesor) {
        this.id = id;
        this.cal = cal;
        this.grupo = grupo;
        this.profesor = profesor;
    }

   

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCal() {
        return cal;
    }

    public void setCal(int cal) {
        this.cal = cal;
    }

    public String getGrupo() {
        return grupo;
    }

    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    public String getProfesor() {
        return profesor;
    }

    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }

    
}
