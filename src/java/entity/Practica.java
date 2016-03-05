package entity;

import java.sql.Date;
import java.sql.SQLException;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Cecilia
 */
public class Practica {
  
   int id;
   String name;
   char tipo;

    public Practica() {
    }

    public Practica(int id, String name, char tipo) {
        this.id = id;
        this.name = name;
        this.tipo=tipo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }
   
   
    

 
    
    
}
