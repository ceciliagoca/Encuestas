/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Cecilia
 */
public class Usuario {
    
    String user;
    String pass;
    char tipo; 
    int id;

  
   
    public Usuario(){}; 
    
    
    
    public Usuario(String user, String pass, char tipo, int id) {
        this.user = user;
        this.pass = pass;
        this.tipo = tipo;
        this.id = id;
    }
      public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public char getTipo() {
        return tipo;
    }

    public void setTipo(char tipo) {
        this.tipo = tipo;
    }
    
    
    
}
